from datetime import datetime
from typing import Union
from pydantic import ConfigDict, BaseModel, HttpUrl


class APIBase(BaseModel):
    name_api: str
    description: str
    url_path: HttpUrl


class APIEdit(APIBase):
    rol: list
    permission: list

    model_config = ConfigDict(
        json_schema_extra={
            "example": {
                "id": 1,
                "name_api": "API 1",
                "description": "Using API 1",
                "url_path": "https://api.example.com",
                "rol": ["admin"],
                "permission": ["crud"],
            }
        },
        from_attributes=True,
    )


class APIDB(APIBase):
    create_user: Union[int, None] = None

    model_config = ConfigDict(
        json_schema_extra={
            "example": {
                "create_user": 1,
                "name_api": "API 1",
                "description": "Using API 1",
                "url_path": "https://api.example.com",
            }
        }
    )


class API(APIBase):
    id: int

    model_config = ConfigDict(
        json_schema_extra={
            "example": {
                "id": 1,
                "name_api": "API 1",
                "description": "Using API 1",
                "url_path": "https://api.example.com",
            }
        },
        from_attributes=True,
    )


class APIAdmin(APIDB):
    rol: list = []
    permission: list
    id: int
    is_active: bool

    model_config = ConfigDict(
        from_attributes=True,
        json_schema_extra={
            "create_user": 1,
            "name_api": "API 1",
            "description": "Using API 1",
            "url_path": "https://api.example.com",
            "rol": ["string"],
            "permission": ["string"],
            "id": 0,
            "is_active": True,
            "update_at": "2023-08-11T15:30:15.326Z",
            "create_at": "2023-08-11T15:30:15.326Z",
        },
    )
