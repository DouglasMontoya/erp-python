from fastapi import APIRouter, Depends
from typing import Dict, Any
from app.db.crud import account_create

from app.db.session import get_db

router = r = APIRouter()

@r.post("/accounts/create")
async def create_account(data: Dict[str, Any], db=Depends(get_db)):

    return account_create(db, data)