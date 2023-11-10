from pydantic import ConfigDict, BaseModel


class RolBase(BaseModel):
    name: str
    description: str


class Rol(RolBase):
    model_config = ConfigDict(
        json_schema_extra={
            "example": {
                "name": "api_1",
                "description": "permission read",
            }
        },
        from_attributes=True,
    )
