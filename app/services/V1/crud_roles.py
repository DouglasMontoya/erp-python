from app.models.V1.user_api_model import Rol, Association_Api_Rol
import app.schemas.V1.rol_api_scheme as rol_scheme

from app.utils.exeptions import exception_rol

from fastapi import HTTPException, status

from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError


def create_rol(db: Session, api_id: int, data: rol_scheme.Rol) -> Rol:
    try:
        db_rol = Rol(api_id=api_id, name=data["name"], description=data["description"])
        db.add(db_rol)
        db.commit()

        db_api_rol = Association_Api_Rol(api_id=db_rol.api_id, rol_id=db_rol.id)
        db.add(db_api_rol)
        db.commit()

        db.refresh(db_rol)
        db.refresh(db_api_rol)

    except IntegrityError:
        db.rollback()
        raise HTTPException(detail="Role already exists.", status_code=status.HTTP_409_CONFLICT)


def get_rols_api(db, data: int) -> Rol:
    if isinstance(data, int):
        return db.query(Rol).filter(Rol.api_id == data).all()
    return None


def get_rol_api(db, api_id: int, rol_id: int) -> Rol:
    if isinstance(api_id, int) and isinstance(rol_id, int):
        return db.query(Rol).filter(Rol.api_id == api_id, Rol.id == rol_id).first()
    return None


def edit_rol(db, api_id: int, rol_id: int, data: rol_scheme.RolBase) -> Rol:
    rol = db.query(Rol).filter(Rol.api_id == api_id, Rol.id == rol_id).first()

    if not rol:
        raise exception_rol

    rol.name = data.name
    rol.description = data.description

    db.commit()
    db.refresh(rol)

    return rol


def del_rol(db, api_id: int, rol_id: int) -> None:
    rol = db.query(Rol).filter(Rol.api_id == api_id, Rol.id == rol_id).first()
    association = db.query(Association_Api_Rol).filter(Association_Api_Rol.rol_id == rol_id).first()

    if not rol and not association:
        raise exception_rol

    db.delete(rol)
    db.delete(association)
    db.commit()
