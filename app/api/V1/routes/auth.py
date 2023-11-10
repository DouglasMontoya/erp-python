import redis
from sqlalchemy.orm import Session
from datetime import datetime, timedelta

from fastapi import APIRouter, Request, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm

from app.models.V1.user_api_model import User, Log_login
from app.config.redis import get_jwt_connection
from app.services.V1.crud_users import create_user, get_user
from app.core.V1.security import create_token, verify_password, encrypt_password, verify_token_internal
from app.core.V1.sessions import get_db

import app.schemas.V1.user_scheme as user_scheme
from app.schemas.V1.config_scheme import EnvSettings
from app.schemas.V1.log_schema import Log_login_schema


auth_route = APIRouter(prefix="/auth")

# Cargar las variables de entorno
settings = EnvSettings()


@auth_route.post("/login", status_code=status.HTTP_200_OK)
async def login_user(
    request: Request,
    db: Session = Depends(get_db),
    redis: redis = Depends(get_jwt_connection),
    form_data: OAuth2PasswordRequestForm = Depends(),
):
    # Intentar encontrar al usuario por correo electrónico o por nombre de usuario

    user = get_user(db, form_data.username)

    # Se verifica que exista el usuario y que no este baneado
    if not user or user.is_banned == True:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="login failed",
            headers={"www-Authenticate": "Bearer"},
        )

    # Verificar si la cuenta está bloqueada
    if user.is_locked:
        # Si la cuenta está bloqueada, verifica si ya ha pasado la fecha de desbloqueo
        if user.unlock_date and user.unlock_date > datetime.utcnow():
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Account locked until {}".format(user.unlock_date),
                headers={"www-Authenticate": "Bearer"},
            )
        else:
            # La cuenta ya ha pasado la fecha de desbloqueo, así que la desbloqueamos
            user.is_locked = False
            user.unlock_date = None
            db.commit()

    # Verificar la contraseña del usuario
    if not verify_password(form_data.password, user.password):
        # Incrementar el contador de intentos fallidos de inicio de sesión del usuario (puedes agregar este campo a la tabla de usuarios)
        user.failed_login_attempts += 1

        # Si el usuario ha alcanzado un límite de intentos fallidos, bloquear la cuenta
        if user.failed_login_attempts >= settings.MAX_FAILED_LOGIN_ATTEMPTS:
            user.is_locked = True
            user.unlock_date = datetime.utcnow() + timedelta(minutes=settings.LOCK_DURATION_MINUTES)

        db.commit()
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="invalid credentials",
            headers={"www-Authenticate": "Bearer"},
        )

    # Si la contraseña es correcta, reiniciar el contador de intentos fallidos
    user.failed_login_attempts: int = 0
    log = Log_login(id_user=user.id, ip_addres=request.client.host)
    db.add(log)
    db.commit()

    payload_content: dict = {"sub": str(user.id), "iss": "IMS", "typ": "Internal"}
    token = create_token(payload_content, settings.ACCESS_TOKEN_EXPIRES)

    redis.set(f"jwt_{token}", f"{token}", ex=settings.TIME_EXPIRATION_TOKEN_JWT * 60)

    return {"access_token": token, "token_type": "bearer"}


@auth_route.post("/signup", status_code=status.HTTP_204_NO_CONTENT)
async def signup_user(data: user_scheme.UserDB, db: Session = Depends(get_db)):
    data = data.model_dump()

    user = get_user(db, data["username"])
    if user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="User already registered.",
            headers={"www-Authenticate": "Bearer"},
        )

    data["password"] = encrypt_password(data["password"])
    print(type(data))

    try:
        create_user(db, data=data)
    except:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Error creating the user.",
        )


@auth_route.post("/logout", status_code=status.HTTP_202_ACCEPTED)
async def logout(
    redis: redis = Depends(get_jwt_connection),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    token = verify[1]

    try:
        r = redis.delete(f"jwt_{token}")

    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="non-existent token",
        )
    return {"message": "Account unlogged in."}


@auth_route.patch("/change_password", status_code=status.HTTP_202_ACCEPTED)
async def change_password(
    change_password: user_scheme.ChangePassword,
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    data = change_password.model_dump()
    user_db = verify[0]
    token = verify[1]

    if not user_db:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User not found.",
            headers={"www-Authenticate": "Bearer"},
        )

    if not verify_password(data["current_password"], user_db.password):
        return HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="The current password and the user's password are different.",
            headers={"www-Authenticate": "Bearer"},
        )

    if data["new_password"] == data["current_password"]:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="The new password and the user's password are the same.",
            headers={"www-Authenticate": "Bearer"},
        )

    if data["new_password"] != data["confirm_password"]:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="The new password and the password confirmation are different.",
            headers={"www-Authenticate": "Bearer"},
        )

    user_new_password = encrypt_password(data["new_password"])

    # Create new instance of the user
    user = get_user(db, user_db.id)
    user.password = user_new_password
    db.commit()

    return {"message": "Password has been changed successfully"}


@auth_route.get("/change_password_done", status_code=status.HTTP_202_ACCEPTED)
async def change_password_done():
    return {"message": "Password has been changed successfully."}


@auth_route.post("/reniew", status_code=status.HTTP_201_CREATED)
async def reniew(
    redis: redis = Depends(get_jwt_connection),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    user, token = verify

    # Eliminar la clave de Redis que contiene el token si es = 0 es por que no existe en la base de datos el token
    if redis.delete(f"jwt_{token}") == 0:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Expired session",
            headers={"WWW-Authenticate": "Bearer"},
        )
    # Creamoe el token
    payload_content: dict = {"sub": str(user.id), "iss": "IMS", "typ": "Internal"}
    token = create_token(payload_content, settings.ACCESS_TOKEN_EXPIRES)

    # Guaramos el token en redis
    redis.set(f"jwt_{token}", f"{token}", ex=settings.TIME_EXPIRATION_TOKEN_JWT * 60)
    return {"access_token": token, "token_type": "bearer"}


@auth_route.get("/logs", status_code=status.HTTP_202_ACCEPTED, response_model=list[Log_login_schema])
async def log_login(
    db: Session = Depends(get_db),
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    user = verify[0]
    log = db.query(Log_login).filter(Log_login.id_user == user.id).all()

    if log is not None:
        return log

    return []


@auth_route.post("/verify_intenal_token", status_code=status.HTTP_202_ACCEPTED)
async def verify_internal_token(
    verify: tuple[User, str] = Depends(verify_token_internal),
):
    if verify:
        return True
    return False
