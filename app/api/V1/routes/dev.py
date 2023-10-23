from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError


from app.services.V1.crud_users import get_user
from app.services.V1.crud_api import get_apis
from app.services.V1.crud_roles import create_rol

from app.core.V1.security import encrypt_password, verify_token_internal
from app.core.V1.sessions import get_db

from typing import Optional, Union
from app.models.V1.user_api_model import User, Api, Rol, Permission

debug_route = APIRouter(prefix="/debug")


# @debug_route.get("/user")
# def other_router(db: Session = Depends(get_db)):
#     return get_user(db, "xd")


# @debug_route.get("/encrypt")
# def encrypt(password):
#     return encrypt_password(password)


# @debug_route.get("/protected")
# async def protected_route(user: User = Depends(verify_token_internal)):
#     return {"message": user}


# @debug_route.post("/create-rol")
# async def create_api_rol(db: Session = Depends(get_db)):
#     rol = Rol(name_roles="Rol1", description="Descripcion")

#     print("➡ rol :", rol)
#     return {}


# @debug_route.post("/create-permision")
# async def create_permision(db: Session = Depends(get_db)):
#     print(db.query(Api_rol).all())
#     return {}


# @debug_route.post("/create-api")
# async def create_api(db: Session = Depends(get_db)):
#     print(db.query(Api_rol).all())
#     return {}


# @debug_route.get("/get-many-to-many")
# async def get_many_to_many(db: Session = Depends(get_db)):
#     print(db.query(Api_rol).all())

#     return {}
