from datetime import datetime
from pydantic import ConfigDict, BaseModel


class Log_login_schema(BaseModel):
    id: int
    id_user: int
    ip_addres: str
    update_at: datetime
    create_at: datetime

    model_config = ConfigDict(from_attributes=True)
