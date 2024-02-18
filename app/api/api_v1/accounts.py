from fastapi import APIRouter, Depends
from typing import Dict, Any
from app.db.crud import account_create, get_customers

from app.db.session import get_db

router = r = APIRouter()

@r.post("/accounts/create")
async def create_account(data: Dict[str, Any], db=Depends(get_db)):

    return account_create(db, data)

@r.get("/accounts/get-customers/{customer_type}")
def customer_list(customer_type: str, db=Depends(get_db)):
    
    if customer_type == "business-client":
        
        results = get_customers(db)
        
        lista_dict = [dict(row._mapping) for row in results]
        
        data = [{
            "status": "ok",
            "data": lista_dict
        }]
        
        return data
    
    return {"message": "Opcion no valida"}

@r.get("/accounts/get-customers")
def customer_list(db=Depends(get_db)):
    results = get_customers(db)
    lista_dict = [dict(row._mapping) for row in results ]
    data = [{
            "status": "ok",
            "data": lista_dict
    }]
    return data