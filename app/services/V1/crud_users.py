from typing import Union, Optional
from sqlalchemy.orm import Session

from app.models.V1.user_api_model import (
    Institution,
    User,
    Assosiation_institutions_user,
)
import app.schemas.V1.user_scheme as user_scheme
import app.services.V1.crud_institution as crud_institution

from app.utils.exeptions import exception_user, exception_institution


def create_user(db: Session, data: user_scheme.UserDB) -> User:
    db_user = User(
        firt_name=data["firt_name"],
        last_name=data["last_name"],
        username=data["username"],
        email=data["email"],
        password=data["password"],
    )

    db.add(db_user)
    db.commit()
    db.refresh(db_user)

    return db_user


def get_user(db: Session, user_id_or_name: Union[int, str]) -> Optional[User]:
    if isinstance(user_id_or_name, int):
        return db.query(User).filter(User.id == user_id_or_name).first()
    else:
        return (
            db.query(User)
            .filter(
                (User.username == user_id_or_name) | (User.email == user_id_or_name)
            )
            .first()
        )


def get_users(db: Session, user_id: Union[int, None] = None):
    if isinstance(user_id, int):
        return db.query(User).filter(User.id == user_id).first()
    else:
        return db.query(User).all()


def edit_users(db: Session, data: user_scheme.UserBase, user_id: int):
    if not isinstance(user_id, int):
        raise exception_user

    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise exception_user

    user.firt_name = data["firt_name"]
    user.last_name = data["last_name"]
    db.add(user)
    db.commit()

    institution = db.query(Institution).filter_by(name=data["institution"]).first()
    if not institution:
        raise exception_institution

    print("➡ user.id :", user.id)
    print("➡ institution.id :", institution.id)
    ais = Assosiation_institutions_user(user_id=user.id, institution_id=institution.id)
    db.add(ais)
    db.commit()

    db.refresh(ais)
    db.refresh(user)
    return user


def deactivate_users(db: Session, user_id: int):
    if not isinstance(user_id, int):
        raise exception_user

    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise exception_user

    user.is_banned = True
    db.commit()
    db.refresh(user)
