from datetime import datetime, timedelta
from typing import Optional

from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from jose import jwt, JWTError
from passlib.context import CryptContext

from app.config.redis import get_jwt_connection
from app.services.V1.crud_users import get_user
from app.core.V1.sessions import get_db
from app.models.V1.user_api_model import User
from app.schemas.V1.config_scheme import EnvSettings
from app.schemas.V1.jwt_scheme import TokenPayload, TokenDecode


oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/api/v1/auth/login")
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

settings = EnvSettings()


# Encripta la contrasena
def encrypt_password(password: str) -> str:
    return pwd_context.hash(password)


# Verifica la contrasena
def verify_password(plane_password: str, hashed_password: str) -> bool:
    return pwd_context.verify(plane_password, hashed_password)


# Crea un nuevo token
def create_token(data: TokenPayload, time_expire: Optional[int] = 20) -> str:
    timestamp = datetime.utcnow()

    expires = timestamp + timedelta(minutes=time_expire)
    data.update({"iat": timestamp, "exp": expires})

    token_jwt = jwt.encode(data, settings.SECRET_KEY, settings.ALGORITHM)
    return token_jwt


# Decodifica el Token
def decode_token(token: str) -> Optional[dict]:
    try:
        # Decodificamos el token JWT y verificamos su firma
        decode_token: TokenDecode = jwt.decode(token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM])
        return decode_token

    except JWTError as e:
        print("➡ Error al decodificar el token:", e)
        return None


# Verifica Que el Token Exista en redis
def verify_token_redis(token: str) -> bool:
    r = get_jwt_connection()
    if r.get(f"jwt_{token}") is None:
        return False

    return True


# Verificar el token
def Verify_token(token: dict, type: str = "Internal") -> User:
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )

    # Decodificamos el token JWT y verificamos su firma
    data_token = decode_token(token)

    # Extraemos los datos del token que vamos a usar
    type_token = data_token.get("typ")
    id_user = data_token.get("sub")
    exp_token = data_token.get("exp")

    # Hacemos las verificaciones pertinentes

    # Comprobamos si el tipo de token existe y su tipo
    if type_token is None or type_token != type:
        raise credentials_exception

    # Comprobacion jwt contenga en el sub el id del usuario
    if id_user is None:
        raise credentials_exception

    # Comprobamos el tiempo de expiracion del token
    exp_datetime = datetime.utcfromtimestamp(exp_token)
    if datetime.utcnow() > exp_datetime:
        raise credentials_exception

    db = next(get_db())
    # Comprobacion en la base de datos que el id exista para un usuario
    user = get_user(db=db, user_id_or_name=int(id_user))

    if user is None:
        raise credentials_exception

    # Comprobacion comprobacion de cuenta baneada
    if user.is_banned:
        raise credentials_exception

    return user


def verify_token_internal(
    token: str = Depends(oauth2_scheme),
) -> tuple[User, str]:
    if not verify_token_redis(token):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Expired session",
            headers={"WWW-Authenticate": "Bearer"},
        )

    user = Verify_token(token)

    return user, token
