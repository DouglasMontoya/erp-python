from sqlalchemy.orm import Session
from fastapi import APIRouter, Depends, status

from app.core.V1.security import verify_token_internal
from app.core.V1.sessions import get_db
from app.models.V1.user_api_model import User
import app.schemas.V1.rol_api_scheme as rol_scheme

import app.services.V1.crud_api as crud_api
import app.services.V1.crud_roles as crud_roles

from app.utils.exeptions import exception_permit_denied, exception_rol, exception_creation


rol_route = APIRouter()


@rol_route.post("/api/{api_id}/rols", status_code=status.HTTP_201_CREATED)
async def create_rol(
    api_id: int,
    data: rol_scheme.Rol,
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    user = verify[0]
    data = data.model_dump()

    # Verificar que rol tiene el usuario
    if user.is_guest:
        raise exception_permit_denied

    # Get the id of the api to which the role belongs either by name or id
    db_api = crud_api.get_apis(db, api_id)
    print("➡ db_api :", db_api)

    if db_api is None:
        raise exception_creation

    if user.is_admin or user.id == db_api.create_user:
        crud_roles.create_rol(db, db_api.id, data)
        return
    
    raise exception_permit_denied


@rol_route.get("/api/{api_id}/rol", status_code=status.HTTP_200_OK, response_model=list[rol_scheme.Rol])
async def get_rols(
    api_id: int,
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    user = verify[0]

    if user.is_guest:
        raise exception_rol

    rols = crud_roles.get_rols_api(db, api_id)

    if rols is None:
        raise exception_rol

    return rols


@rol_route.get("/api/{api_id}/rol/{rol_id}", status_code=status.HTTP_200_OK, response_model=rol_scheme.Rol)
async def get_rol(
    api_id: int,
    rol_id: int,
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    user = verify[0]

    if user.is_guest:
        raise exception_rol

    rol = crud_roles.get_rol_api(db, api_id, rol_id)

    if rol is None:
        raise exception_rol

    return rol


@rol_route.put(
    "/api/{api_id}/rol/{rol_id}",
    status_code=status.HTTP_204_NO_CONTENT,
)
async def edit_rol(
    api_id: int,
    rol_id: int,
    data: rol_scheme.Rol,
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    user = verify[0]

    if user.is_guest:
        raise exception_rol

    rol = crud_roles.get_rol_api(db, api_id, rol_id)

    if not rol:
        raise exception_rol

    db_api = crud_api.get_apis(db, api_id)

    if user.is_admin or user.id == db_api.create_user:
        crud_roles.edit_rol(db, api_id, rol_id, data)
        return
    raise exception_permit_denied


@rol_route.delete("/api/{api_id}/rol/{rol_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_rol(
    api_id: int,
    rol_id: int,
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    user = verify[0]

    if user.is_guest:
        raise exception_rol

    rol = crud_roles.get_rol_api(db, api_id, rol_id)

    if not rol:
        raise exception_rol

    db_api = crud_api.get_apis(db, api_id)

    if user.is_admin or user.id == db_api.create_user:
        crud_roles.del_rol(db, api_id, rol_id)
        return

    raise exception_permit_denied
