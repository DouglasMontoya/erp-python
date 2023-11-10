from datetime import datetime
from typing import Union
from pydantic import ConfigDict, BaseModel, EmailStr


class UserBase(BaseModel):
    firt_name: str
    last_name: str
    username: str
    email: EmailStr
    institution: str | None = None


class Institution(BaseModel):
    name: str


class UserEdit(BaseModel):
    firt_name: str
    last_name: str
    institution: str


class UserDB(UserBase):
    password: str

    model_config = ConfigDict(
        json_schema_extra={
            "example": {
                "firt_name": "Jonh",
                "last_name": "Hammer",
                "username": "username",
                "email": "example@example.com",
                "password": "123456",
            }
        }
    )


class User(UserBase):
    id: int

    model_config = ConfigDict(
        json_schema_extra={
            "example": {
                "id": 1,
                "firt_name": "Jonh",
                "last_name": "Hammer",
                "username": "username",
                "email": "example@example.com",
                "institution": "Prueba C.A",
            }
        },
        from_attributes=True,
    )


class UserAdmin(UserBase):
    id: int
    is_banned: bool
    is_locked: bool
    failed_login_attempts: int
    unlock_date: Union[datetime, None]
    update_at: datetime
    create_at: datetime

    model_config = ConfigDict(from_attributes=True)


class ChangePassword(BaseModel):
    current_password: str
    new_password: str
    confirm_password: str

    model_config = ConfigDict(
        json_schema_extra={
            "example": {
                "current_password": "123456",
                "new_password": "654321",
                "confirm_password": "654321",
            }
        }
    )
