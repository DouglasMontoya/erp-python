from fastapi import FastAPI, Depends
from starlette.requests import Request
import uvicorn

from app.api.api_v1.users import router as users_router
from app.api.api_v1.auth import router as auth_router
from app.core import config
from app.db.session import SessionLocal
from app.core.auth import get_current_active_user

# from app import tasks


app = FastAPI(title=config.PROJECT_NAME,
              docs_url="/api/docs", openapi_url="/api")


@app.middleware("http")
async def db_session_middleware(request: Request, call_next):
    request.state.db = SessionLocal()
    response = await call_next(request)
    request.state.db.close()
    return response


@app.get("/api/v1")
async def root():
    return {"message": "Hello World"}

# Routers
app.include_router(
    users_router,
    prefix="/api/v1",
    tags=["users"],
    dependencies=[Depends(get_current_active_user)],
)
app.include_router(auth_router, prefix="/api", tags=["auth"])

def start():
    uvicorn.run("app.main:app", host="0.0.0.0", reload=True, port=8888)
