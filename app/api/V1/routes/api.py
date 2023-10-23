from sqlalchemy.orm import Session
from fastapi import APIRouter, Depends, status

from app.core.V1.security import verify_token_internal
from app.core.V1.sessions import get_db
from app.models.V1.user_api_model import User

import app.services.V1.crud_api as crud_api
import app.schemas.V1.api_scheme as api_scheme


from app.utils.exeptions import exception_permit_denied, exception_api, exception_creation


api_route = APIRouter()


@api_route.get("/api", status_code=status.HTTP_200_OK, response_model=list[api_scheme.APIAdmin])
async def get_apis(
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    user = verify[0]

    # if you are admin it returns all the api
    if user.is_admin:
        return crud_api.get_apis(db)

    # Si eres usuario te devuelve todas las apis que creo el usuario que consulta
    return user.api


@api_route.post("/api", status_code=status.HTTP_201_CREATED)
async def create_api(
    data: api_scheme.APIDB,
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    data = data.model_dump()
    print("➡ data :", data)

    user = verify[0]
    token = verify[1]

    # Check what role the user has
    if user.is_guest:
        raise exception_permit_denied

    # Validates whether the API exists or not.
    crud_api.valid_api(db, data)

    try:
        if not data["create_user"]:
            data["create_user"] = user.id

        crud_api.create_api(db, data)

    except:
        raise exception_creation


@api_route.get("/api/{api_id}", status_code=status.HTTP_200_OK, response_model=api_scheme.APIBase)
async def get_api(
    api_id: int,
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    user = verify[0]

    # if you are admin you can return the api no matter who is the owner
    try:
        if user.is_admin:
            api = crud_api.get_apis(db, api_id)
            # Verify is not none
            api.id
            return api

    except:
        raise exception_api

    # If you are a moderator user, it searches the assigned apis and if it finds it, it returns it to you
    if user.is_administrator:
        for api_user in user.api:
            if api_user.id == api_id:
                return api_user

        raise exception_api


@api_route.put("/api/{api_id}", status_code=status.HTTP_200_OK, response_model=api_scheme.APIEdit)
async def edit_api(
    api_id: int,
    data: api_scheme.APIEdit,
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    user = verify[0]

    data = data.model_dump()

    # if you are admin you can return the api no matter who is the owner
    if user.is_admin:
        api = crud_api.edit_api(db, data, api_id)
        return api

    # If you are a moderator user, it searches the assigned apis and if it finds it, it returns it to you
    if user.is_administrator:
        for api_user in user.api:
            if api_user.id == api_id:
                api = crud_api.edit_api(db, data, api_id)
                return api

        raise exception_api


@api_route.delete("/api/{api_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_user(
    api_id: int,
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    user = verify[0]
    if user.is_admin:
        crud_api.deactivate_api(db, api_id)

    if user.is_administrator:
        for api_user in user.api:
            if api_user.id == api_id:
                api = crud_api.edit_api(db, api_id)
                return api
        raise exception_api
