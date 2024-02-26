from fastapi import HTTPException, status
from sqlalchemy.orm import Session
from sqlalchemy import desc, select
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
            )

            # Add the new customer to the session and commit
            db.add(customer)
            db.commit()

            # Get customer id
            customer_id = customer.id

            # ADD ADDRESS
            add_addresses(db, customer_id, data, customer_type)

            # ADD PAYMENT METHOD
            add_method_payment(db, customer_id, data)

            # ADD CONTACTS
            add_contacts(db, customer_id, data)

            return {"message": "Usuario creado exitosamente", "data": "ok"}
            # return {"message": "Usuario creado exitosamente", "data": customer}
        elif customer_type == 'provider':

            # CREATE CUSTOMER

            object_customer = {
                "tradename": data['step1']['commercialName'],
                "email": data['step1']["email"],
                "legal_representative": data['step1']["represent"],
                "is_customer": customer_type
            }

            new_customer = models.Customer(**object_customer)
            db.add(new_customer)
            db.commit()

            # Get customer id
            customer_id = new_customer.id

            # CREATE PROVIDER

            object_provider = {
                "customer_id": customer_id,
                "operation_type_id": data['step1']['operationType'],
                "operation_field_id": data['step1']['operationScope'],
            }

            new_provider = models.Provider(**object_provider)
            db.add(new_provider)
            db.commit()

            # ADD ADDRESS
            add_addresses(db, customer_id, data, customer_type)

            # ADD PAYMENT METHOD
            add_method_payment(db, customer_id, data)

            # ADD CONTACTS
            add_contacts(db, customer_id, data)

        elif customer_type == 'particular-client':
            
            # CREATE CUSTOMER
            object_customer = {
                "first_name": data['step1']['firstName'],
                "last_name": data['step1']['lastName'],
                "email": data['step1']['email'],
                "legal_representative": data['step1']["represent"],
                "is_customer": customer_type
            }

            # Create a new Customer instance
            new_customer = models.Customer(**object_customer)

            # Add the new customer to the session and commit
            db.add(new_customer)
            db.commit()

            # Get customer id
            customer_id = new_customer.id

            # ADD ADDRESS
            add_addresses(db, customer_id, data, customer_type)

            # ADD PAYMENT METHOD
            add_method_payment(db, customer_id, data)

            # ADD CONTACTS
            add_contacts(db, customer_id, data)
        else:
            raise HTTPException(status_code=400, detail="Invalid client type")
    else:
        raise HTTPException(status_code=400, detail="Invalid data")
    
    return {"message": "Cuenta creada exitosamente", "data": "ok"}

def add_addresses(db: Session, customer_id, data, customer_type):

    # ADD ADDRESSES

    # Main address
    address_1 = {
        "customer_id": customer_id,
        "address_1": data['step1']['address'],
        "postal_code": data['step1']['postalCode'],
        "province": data['step1']['province'],
        "city": data['step1']['city'],
        "phone": data['step1']['phone'],
        "opening_days": data['step1']['daysOpened'],
        "horary": data['step1']['hours'],
        "tags": data['step1']['tags'],
    }

    if customer_type == 'business-client' or customer_type == 'provider':
        address_1['first_name'] = data['step1']['peopleContact']
        address_1['company'] = data['step1']['fiscalName']
        address_1['company_activity'] = data['step1']['companyActivity']
        address_1['nif'] = data['step1']['nif']
    elif customer_type == 'particular-client':
        address_1['nif'] = data['step1']['dni']
    
    if customer_type == 'business-client':
        address_1['cnae'] = data['step1']['cnae']

    # Optional address
    new_address = models.Address(**address_1)

    db.add(new_address)
    db.commit()

    for item in data['step2']:
        new_address_data = {
            "customer_id": customer_id,
            "nif": item['nif'],
            "address_2": item['address'],
            "postal_code": item['postalCode'],
            "province": item['province'],
            "city": item['city'],
            "phone": item['phone'],
            "opening_days": item['daysOpened'],
            "horary": item['hours'],
            "email": item['email'],
        }
        if data['step1']['clientType'] == 'business-client' or data['step1']['clientType'] == 'provider':
            new_address_data['first_name'] = data['step1']['peopleContact']
            new_address_data['company'] = data['step1']['fiscalName']
            new_address_data['company_activity'] = data['step1']['companyActivity']
            new_address_data['nif'] = data['step1']['nif']
        elif data['step1']['clientType'] == 'particular-client':
            new_address_data['nif'] = data['step1']['dni']
        if data['step1']['clientType'] == 'business-client':
            new_address_data['cnae'] = data['step1']['cnae']

        new_address = models.Address(**new_address_data)
        db.add(new_address)
        db.commit()


def add_method_payment(db: Session, customer_id, data):
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

        # Add when the method payment is transfer
        pass

    payment_method = models.CustomerPayment(**payment_method_object)
    db.add(payment_method)
    db.commit()


def add_contacts(db: Session, customer_id, data):
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

def get_customers(db: Session):

    cu = models.Customer
    ad = models.Address
    
    customerByType = select(
        cu.id.label('id_customer'),
        ad.company.label('fiscal_name'),
        cu.tradename.label('commercial_name'),
        ad.nif,
        ad.address_1,
        ad.city,
        ad.province,
        ad.phone,
        cu.email,
        ad.tags
    ).join(ad, cu.id == ad.customer_id
    ).filter(
        (cu.is_customer == 'business-client') &
        (ad.address_1.isnot(None))
    ).order_by(
        desc(cu.updated_at)
    )
       
    return db.execute(customerByType).fetchall()