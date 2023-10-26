from typing import Union
from sqlalchemy.orm import Session
from fastapi import APIRouter, Depends, status

from app.core.V1.security import verify_token_internal
from app.core.V1.sessions import get_db
from app.models.V1.user_api_model import User

import app.services.V1.crud_users as crud_user
import app.schemas.V1.user_scheme as user_scheme
from app.utils.exeptions import exception_user


user_route = APIRouter(prefix="/user")


@user_route.get(
    "/", status_code=status.HTTP_200_OK, response_model=list[user_scheme.UserAdmin]
)
async def get_users(
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    user = verify[0]
    token = verify[1]

    if user.is_admin:
        users_db = crud_user.get_users(db)

        output_users = []
        for user_db in users_db:
            user_data = user_db.__dict__
            print("➡ user_data :", user_data)
            user_data["institution"] = (
                user_db.institutions[0].institution.name
                if len(user_db.institutions) > 0
                else "other"
            )
            output_users.append(user_scheme.UserAdmin(**user_data))
        return output_users

    return []


@user_route.get(
    "/{user_id}",
    status_code=status.HTTP_200_OK,
    response_model=Union[user_scheme.UserAdmin, user_scheme.User],
)
async def get_user(
    user_id: int,
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    user = verify[0]
    token = verify[1]

    try:
        if user.is_admin:
            user_db = crud_user.get_users(db, int(user_id))
            user_data = user_db.__dict__
            user_data["institution"] = (
                user_db.institutions[0].institution.name
                if len(user_db.institutions) > 0
                else "other"
            )
            print(user_db.institutions[0].institution.name)
            return user_scheme.UserAdmin(**user_db.__dict__)
    except:
        raise exception_user

    return user_scheme.User(**user.__dict__)


@user_route.put(
    "/{user_id}", status_code=status.HTTP_200_OK, response_model=user_scheme.User
)
async def edit_user(
    user_id: int,
    data: user_scheme.UserEdit,
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    user = verify[0]
    token = verify[1]

    if user.is_admin:
        user_db = crud_user.edit_users(db, data.model_dump(), int(user_id))
        return user_db


@user_route.delete("/{user_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_user(
    user_id: int,
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    user = verify[0]
    if user.is_admin:
        crud_user.deactivate_users(db, int(user_id))
