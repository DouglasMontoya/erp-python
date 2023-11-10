from datetime import datetime
from pydantic import ConfigDict, BaseModel


class PermissionBase(BaseModel):
    name: str
    description: str


class PermissionEdit(PermissionBase):
    model_config = ConfigDict(
        json_schema_extra={
            "example": {
                "name": "This is a permit.",
                "description": "This is the permission description.",
            }
        },
        from_attributes=True,
    )


class PermissionDB(PermissionBase):
    api_id: int

    model_config = ConfigDict(
        json_schema_extra={
            "example": {
                "api_id": 1,
                "name": "This is a permit.",
                "description": "This is the permission description.",
            }
        }
    )


class PermissionAdmin(PermissionDB):
    id: int
    update_at: datetime
    create_at: datetime

    model_config = ConfigDict(
        from_attributes=True,
    )
