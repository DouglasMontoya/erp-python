from typing import Optional, Union
from fastapi import HTTPException, status

from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError

from app.models.V1.user_api_model import Permission

import app.schemas.V1.permission_scheme as permission_scheme
from app.utils.exeptions import exception_permission


def create_permission(db: Session, api_id: int, data: permission_scheme.PermissionDB) -> Permission:
    try:
        db_permission = Permission(
            api_id=api_id,
            name=data["name"],
            description=data["description"],
        )
        db.add(db_permission)
        db.commit()

        db.refresh(db_permission)
    except IntegrityError:
        db.rollback()
        raise HTTPException(detail="Permission already exists.", status_code=status.HTTP_409_CONFLICT)


def get_permission(db: Session, permission_id: Union[int, None] = None, api_id: Union[int, None] = None):
    if isinstance(api_id, int) and isinstance(permission_id, int):
        query = db.query(Permission).filter(Permission.api_id == api_id, Permission.id == permission_id).first()
        return query

    if isinstance(api_id, int):
        return db.query(Permission).filter_by(api_id=api_id).first()

    return db.query(Permission).all()


def edit_permission(db: Session, data: permission_scheme.PermissionEdit, api_id: int, permission_id: int):
    db_permission = db.query(Permission).filter(Permission.api_id == api_id, Permission.id == permission_id).first()
    if not db_permission:
        raise exception_permission

    db_permission.name = data["name"]
    db_permission.description = data["description"]

    db.commit()
    db.refresh(db_permission)
    return db_permission


def valid_permission(db: Session, api_id: int, data: permission_scheme.PermissionDB) -> Optional[Permission]:
    permission_db = db.query(Permission).filter_by(api_id=api_id).filter_by(name=data["name"]).first()
    if permission_db:
        raise HTTPException(detail="The API already has a permission with that name.", status_code=status.HTTP_400_BAD_REQUEST)


def del_permission(db, api_id: int, permission_id: int) -> None:
    permission_db = db.query(Permission).filter(Permission.api_id == api_id, Permission.id == permission_id).first()

    if not permission_db:
        raise exception_permission

    db.delete(permission_db)
    db.commit()
