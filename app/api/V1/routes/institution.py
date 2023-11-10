from sqlalchemy.orm import Session
from fastapi import APIRouter, Depends, status

from app.core.V1.security import verify_token_internal
from app.core.V1.sessions import get_db
from app.models.V1.user_api_model import User

import app.services.V1.crud_institution as crud_institution
import app.schemas.V1.user_scheme as user_scheme

from app.utils.exeptions import exception_permit_denied, exception_creation, exception_institution


institution_route = APIRouter(prefix="/institution")


# Permission routes
@institution_route.get("/", status_code=status.HTTP_200_OK)
async def get_institutions(db: Session = Depends(get_db)):
    institution_db = crud_institution.get_institution(db)
    return institution_db


@institution_route.get("/{institution_id}", status_code=status.HTTP_200_OK)
async def get_institution(
    institution_id: int,
    db: Session = Depends(get_db),
):
    institution_db = crud_institution.get_institution(db, institution_id)
    if not institution_db:
        raise exception_institution

    return institution_db


@institution_route.post("/", status_code=status.HTTP_200_OK)
async def create_institution(
    data: user_scheme.Institution,
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    user = verify[0]
    data = data.model_dump()

    # Check what role the user has
    if user.is_guest:
        raise exception_permit_denied

    # Validates whether the API exists or not.
    crud_institution.valid_institution(db, data)
    if user.is_admin:
        crud_institution.create_institution(db=db, data=data)
        return

    raise exception_creation


@institution_route.put("/{institution_id}", status_code=status.HTTP_200_OK)
async def edit_institution(
    institution_id: int,
    data: user_scheme.Institution,
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    user = verify[0]
    data = data.model_dump()

    # Check what role the user has
    if user.is_guest:
        raise exception_permit_denied

    institution_db = crud_institution.get_institution(db=db, institution_id=institution_id)
    if not institution_db:
        raise exception_institution

    # Validates whether the API exists or not.
    crud_institution.valid_institution(db, data)
    if user.is_admin:
        return crud_institution.edit_institution(db=db, institution_id=institution_id, data=data)

    raise exception_creation


@institution_route.delete("/{institution_id}", status_code=status.HTTP_204_NO_CONTENT)
async def remove_institution(
    institution_id: int,
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    user = verify[0]

    # Check what role the user has
    if user.is_guest:
        raise exception_permit_denied

    institution_db = crud_institution.get_institution(db=db, institution_id=institution_id)
    if not institution_db:
        raise exception_institution

    if user.is_admin:
        crud_institution.del_institution(db=db, institution_id=institution_id)
    else:
        raise exception_creation
