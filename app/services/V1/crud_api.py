from typing import Optional, Union
from sqlalchemy.orm import Session
from fastapi import HTTPException, status

from app.models.V1.user_api_model import User, Api

import app.schemas.V1.api_scheme as api_scheme

from app.utils.exeptions import exception_api


def create_api(db: Session, data: api_scheme.APIDB) -> Api:
    db_api = Api(
        name_api=data["name_api"],
        description=data["description"],
        url_path=str(data["url_path"]),
        create_user=data["create_user"],
    )

    db.add(db_api)
    db.commit()
    db.refresh(db_api)
    return db_api


def get_apis(db: Session, api_id: Union[int, None] = None):
    if isinstance(api_id, int):
        return db.query(Api).filter(Api.id == api_id).first()
    else:
        return db.query(Api).all()


def edit_api(db: Session, data: api_scheme.APIEdit, api_id: int):
    print("➡ data :", data)
    if not isinstance(api_id, int):
        raise exception_api

    api = db.query(Api).filter_by(id=api_id).first()
    if not api:
        raise exception_api

    api.name_api = data["name_api"]
    api.description = data["description"]
    api.url_path = str(data["url_path"])

    # Se debe ajutar cuando se tengan los roles y permisos creados
    # api.rol = data["rol"]
    # api.permission = data["permission"]

    db.commit()
    db.refresh(api)
    return api


def valid_api(db: Session, data: api_scheme.APIDB) -> None:
    if db.query(Api).filter_by(name_api=data["name_api"]).first():
        raise HTTPException(
            detail="The api name is already in use.",
            status_code=status.HTTP_400_BAD_REQUEST,
        )
    print("➡ if : No existe por nombre")

    if db.query(Api).filter_by(url_path=str(data["url_path"])).first():
        raise HTTPException(
            detail="The api URL is already in use.",
            status_code=status.HTTP_400_BAD_REQUEST,
        )
    print("➡ if : No existe por url")


def deactivate_api(db: Session, api_id: int) -> None:
    if not isinstance(api_id, int):
        raise exception

    api = db.query(Api).filter_by(id=api_id).first()
    if not api:
        raise exception

    api.is_active = False
    db.commit()
    db.refresh(api)
