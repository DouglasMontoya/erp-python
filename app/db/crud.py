from fastapi import HTTPException, status
from sqlalchemy.orm import Session
import typing as t

from . import models, schemas
from app.core.security import get_password_hash


def get_user(db: Session, user_id: int):
    user = db.query(models.User).filter(models.User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user


def get_user_by_email(db: Session, email: str) -> schemas.UserBase:
    return db.query(models.User).filter(models.User.email == email).first()


def get_users(db: Session, skip: int = 0,
              limit: int = 100) -> t.List[schemas.UserOut]:
    return db.query(models.User).offset(skip).limit(limit).all()


def create_user(db: Session, user: schemas.UserCreate):
    hashed_password = get_password_hash(user.password)
    db_user = models.User(
        first_name=user.first_name,
        last_name=user.last_name,
        email=user.email,
        is_active=user.is_active,
        is_superuser=user.is_superuser,
        hashed_password=hashed_password,
    )
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user


def delete_user(db: Session, user_id: int):
    user = get_user(db, user_id)
    if not user:
        raise HTTPException(status.HTTP_404_NOT_FOUND, detail="User not found")
    db.delete(user)
    db.commit()
    return user


def edit_user(db: Session, user_id: int,
              user: schemas.UserEdit) -> schemas.User:
    db_user = get_user(db, user_id)
    if not db_user:
        raise HTTPException(status.HTTP_404_NOT_FOUND, detail="User not found")
    update_data = user.dict(exclude_unset=True)

    if "password" in update_data:
        update_data["hashed_password"] = get_password_hash(user.password)
        del update_data["password"]

    for key, value in update_data.items():
        setattr(db_user, key, value)

    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user


def account_create(db: Session, data):

    if len(data['step1']['clientType']) == 1:
        customer_type = data['step1']['clientType'][0]
        if customer_type == 'business-client':
            # CREATE CUSTOMER
            tradename = data['step1']['commercialName']
            email_db = data['step1']["email"]
            legal_repres = data['step1']["represent"]

            # Create a new Customer instance
            customer = models.Customer(
                email=email_db,
                tradename=tradename,
                is_customer=customer_type,
                legal_representative=legal_repres


                # Add any other fields as necessary
            )

            # Add the new customer to the session and commit
            db.add(customer)
            db.commit()

            # Get customer id
            customer_id = customer.id

            # ADD ADDRESSES

            # Main address
            address_1 = {
                "customer_id": customer_id,
                "company": data['step1']['fiscalName'],
                "nif": data['step1']['nif'],
                "address_1": data['step1']['address'],
                "postal_code": data['step1']['postalCode'],
                "province": data['step1']['province'],
                "city": data['step1']['city'],
                "first_name": data['step1']['peopleContact'],
                "phone": data['step1']['phone'],
                "company_activity": data['step1']['companyActivity'],
                "cnae": data['step1']['cnae'],
                "opening_days": data['step1']['daysOpened'],
                "horary": data['step1']['hours'],
                "tags": data['step1']['tags'],
            }

            # Optional address
            new_address = models.Address(
                customer_id=address_1["customer_id"],
                company=address_1["company"],
                nif=address_1["nif"],
                address_1=address_1["address_1"],
                postal_code=address_1["postal_code"],
                province=address_1["province"],
                city=address_1["city"],
                first_name=address_1["first_name"],
                phone=address_1["phone"],
                company_activity=address_1["company_activity"],
                cnae=address_1["cnae"],
                opening_days=address_1["opening_days"],
                horary=address_1["horary"],
                tags=address_1["tags"],
            )

            db.add(new_address)
            db.commit()

            for item in data['step2']:
                new_address_data = {
                    "customer_id": customer_id,
                    "company": item['fiscalName'],
                    "nif": item['nif'],
                    "address_2": item['address'],
                    "postal_code": item['postalCode'],
                    "province": item['province'],
                    "city": item['city'],
                    "first_name": item['peopleContact'],
                    "phone": item['phone'],
                    "company_activity": data['step1']['companyActivity'],
                    "cnae": data['step1']['cnae'],
                    "opening_days": item['daysOpened'],
                    "horary": item['hours'],
                }
                new_address = models.Address(**new_address_data)
                db.add(new_address)
                db.commit()

            # ADD PAYMENT METHOD
            payment_method_object = {}
            if data['step3']['payMethod'] == 'bank':
                payment_method_object = {
                    "customer_id": customer_id,
                    "iban": data['step3']['iban'],
                    "swift": data['step3']['bicSwift'],
                    "currency_code": data['step3']['currency'],
                    "bank_country": data['step3']['countryBankId'],
                    "payment_method": data['step3']['payMethod']
                }
            else:
                pass

            payment_method = models.CustomerPayment(**payment_method_object)

            db.add(payment_method)
            db.commit()

            # ADD CONTACTS
            for item in data['step4']:
                object_contact = {
                    "customer_id": customer_id,
                    "note": item['comments'],
                    "email_notification": item['emailNotifications'],
                    "email": item['email'],
                    "phone": item['phone'],
                    "city": item['city'],
                    "address": item['address'],
                    "job": item['job'],
                    "dni": item['dni'],
                    "name": item['nameAndLastName'],
                }
                contacts = models.Contacts(**object_contact)
                db.add(contacts)
                db.commit()

            return {"message": "Usuario creado exitosamente", "data": "ok"}
            # return {"message": "Usuario creado exitosamente", "data": customer}
        else:
            raise HTTPException(status_code=400, detail="Invalid client type")
    else:
        raise HTTPException(status_code=400, detail="Invalid data")
