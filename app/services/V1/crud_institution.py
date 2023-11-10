from typing import Optional, Union
from fastapi import HTTPException, status
from sqlalchemy.orm import Session

from app.models.V1.user_api_model import Institution

import app.schemas.V1.user_scheme as user_scheme
from app.utils.exeptions import exception_user, exception_institution


def get_institution(db: Session, institution_id: Union[int, None] = None):
    if isinstance(institution_id, int):
        print("➡ institution_id :", institution_id)
        return db.query(Institution).filter_by(id=institution_id).first()

    return db.query(Institution).all()


def create_institution(db: Session, data: user_scheme.Institution):
    db_intitution = Institution(name=data["name"])

    db.add(db_intitution)
    db.commit()
    db.refresh(db_intitution)
    return db_intitution


def edit_institution(db: Session, data: user_scheme.Institution, institution_id: int):
    db_institution = db.query(Institution).filter_by(id=institution_id).first()
    if not db_institution:
        raise exception_institution

    db_institution.name = data["name"]
    db.commit()
    db.refresh(db_institution)
    return db_institution


def valid_institution(db: Session, data: user_scheme.Institution) -> Optional[Institution]:
    institution_db = db.query(Institution).filter_by(name=data["name"]).first()
    if institution_db:
        raise HTTPException(detail="There is already an institution with that name.", status_code=status.HTTP_400_BAD_REQUEST)


def del_institution(db, institution_id: int) -> None:
    institution_db = db.query(Institution).filter_by(id=institution_id).first()
    if not institution_db:
        raise exception_institution

    db.delete(institution_db)
    db.commit()
