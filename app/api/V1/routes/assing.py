from sqlalchemy.orm import Session
from fastapi import APIRouter, Depends, status

from app.core.V1.security import verify_token_internal
from app.core.V1.sessions import get_db

from app.models.V1.user_api_model import User

import app.services.V1.crud_assing as crud_assing
import app.services.V1.crud_api as crud_api
import app.services.V1.crud_users as crud_user

from app.utils.exeptions import (
    exception_permit_denied,
    exception_relation_api,
    exception_user,
)

assing_route = APIRouter()


@assing_route.post("/user/{user_id}/api/{api_id}", status_code=status.HTTP_200_OK)
def assing_api_create(
    user_id: int,
    api_id: int,
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    user = verify[0]

    db_user = crud_user.get_user(db, user_id)

    db_api = crud_api.get_apis(db, api_id)

    if user.is_admin or (user.is_administrator and db_user.id == db_api.create_user):
        db_apirol = crud_assing.creando_user_api_rol(db, user_id, api_id)

        return db_apirol

    else:
        raise exception_user


@assing_route.delete("/user/{user_id}/api/{api_id}", status_code=status.HTTP_200_OK)
def assing_api_delete(
    user_id: int,
    api_id: int,
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    user = verify[0]

    db_user = crud_user.get_user(db, user_id)

    db_api = crud_api.get_apis(db, api_id)

    if user.is_admin or (user.is_administrator and db_user.id == db_api.create_user):
        delete_relation = crud_assing.delete_user_api_rol(db, user_id, api_id)

        return delete_relation

    else:
        raise exception_permit_denied


@assing_route.get("/user_api/{user_id}", status_code=status.HTTP_200_OK)
def assing_api_get(
    user_id: int,
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    user = verify[0]

    user_assing = crud_assing.get_user(db, user_id)

    if user.is_admin:
        get_user_api_rol = crud_assing.get_user_api_rol(db, user_id)

        return get_user_api_rol

    elif user_assing.user_id == user.id:
        user_api_rol = crud_assing.get_user_api_rol(db, user_id)
        for x in user_api_rol:
            x.pop("create_at")
            x.pop("update_at")
        return user_api_rol

    else:
        raise exception_user


@assing_route.get("/user_api", status_code=status.HTTP_200_OK)
def assing_api_get(
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    user = verify[0]

    limited_data = []

    all_data = crud_assing.get_user_api(db)

    if user.is_admin:
        return all_data

    for x in all_data:
        id_dict = x.__dict__.get("user_id")

        if id_dict == user.__dict__.get("id"):
            limited_data.append(x)

    if len(limited_data):
        return limited_data

    raise exception_relation_api


@assing_route.get("/api_user/{api_id}", status_code=status.HTTP_200_OK)
def assing_api_get(
    api_id: int,
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    user = verify[0]

    get_user_assing = crud_assing.get_api(db, api_id)

    db_api = crud_api.get_apis(db, api_id)

    if user.is_admin or user.id == db_api.create_user:
        return get_user_assing

    raise exception_permit_denied
