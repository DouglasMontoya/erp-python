from sqlalchemy.orm import Session
from fastapi import APIRouter, Depends, status

from app.core.V1.security import verify_token_internal
from app.core.V1.sessions import get_db
from app.models.V1.user_api_model import User

import app.services.V1.crud_api as crud_api
import app.services.V1.crud_permission as crud_permission
import app.schemas.V1.permission_scheme as permission_scheme

from app.utils.exeptions import (
    exception_permit_denied,
    exception_api,
    exception_permission,
    exception_creation,
)


permission_route = APIRouter()


# Permission routes
@permission_route.get(
    "/api/{api_id}/permission",
    status_code=status.HTTP_200_OK,
    response_model=list[permission_scheme.PermissionAdmin],
)
async def get_permissions(
    api_id: int,
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    user = verify[0]

    if user.is_guest:
        raise exception_permit_denied

    api_db = crud_api.get_apis(db, api_id)
    if not api_db:
        raise exception_api

    if api_db.create_user == user.id or user.is_admin:
        permission_db = crud_permission.get_permission(db=db, api_id=api_db)
        return permission_db

    return exception_permission


@permission_route.get(
    "/api/{api_id}/permission/{permission_id}",
    status_code=status.HTTP_200_OK,
    response_model=permission_scheme.PermissionAdmin,
)
async def get_permission(
    api_id: int,
    permission_id: int,
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    user = verify[0]

    if user.is_guest:
        raise exception_permit_denied

    api_db = crud_api.get_apis(db, api_id)
    if not api_db:
        raise exception_api

    if api_db.create_user == user.id or user.is_admin:
        permission_db = crud_permission.get_permission(
            db=db, permission_id=permission_id, api_id=api_id
        )

    if permission_db:
        return permission_db

    raise exception_permission


@permission_route.post("/api/{api_id}/permission/", status_code=status.HTTP_200_OK)
async def create_permission(
    api_id: int,
    data: permission_scheme.PermissionEdit,
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    user = verify[0]
    data = data.model_dump()

    # Check what role the user has
    if user.is_guest:
        raise exception_permit_denied

    # Get the id of the api to which the role belongs either by name or id
    api_db = crud_api.get_apis(db, api_id)
    if not api_db:
        raise exception_api

    # Validates whether the API exists or not.
    crud_permission.valid_permission(db, api_id, data)
    if api_db.create_user == user.id or user.is_admin:
        crud_permission.create_permission(db=db, api_id=api_id, data=data)
        return

    raise exception_creation


@permission_route.put(
    "/api/{api_id}/permission/{permission_id}", status_code=status.HTTP_200_OK
)
async def edit_permission(
    api_id: int,
    permission_id: int,
    data: permission_scheme.PermissionEdit,
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    user = verify[0]
    data = data.model_dump()

    # Check what role the user has
    if user.is_guest:
        raise exception_permit_denied

    # Get the id of the api to which the role belongs either by name or id
    api_db = crud_api.get_apis(db, api_id)
    if not api_db:
        raise exception_api

    permission_db = crud_permission.get_permission(
        db=db, permission_id=permission_id, api_id=api_id
    )
    if not permission_db:
        raise exception_permission

    # Validates whether the API exists or not.
    crud_permission.valid_permission(db, api_id, data)
    if api_db.create_user == user.id or user.is_admin:
        return crud_permission.edit_permission(
            db=db, api_id=api_id, permission_id=permission_id, data=data
        )

    raise exception_creation


@permission_route.delete(
    "/api/{api_id}/permission/{permission_id}", status_code=status.HTTP_204_NO_CONTENT
)
async def remove_permission(
    api_id: int,
    permission_id: int,
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    user = verify[0]

    # Check what role the user has
    if user.is_guest:
        raise exception_permit_denied

    # Get the id of the api to which the role belongs either by name or id
    api_db = crud_api.get_apis(db, api_id)
    if not api_db:
        raise exception_api

    permission_db = crud_permission.get_permission(
        db=db, permission_id=permission_id, api_id=api_id
    )
    if not permission_db:
        raise exception_permission

    if api_db.create_user == user.id or user.is_admin:
        crud_permission.del_permission(
            db=db, api_id=api_id, permission_id=permission_id
        )
    else:
        raise exception_creation
