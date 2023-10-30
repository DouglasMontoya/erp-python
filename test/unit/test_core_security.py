import pytest
import redis
from datetime import datetime, timedelta
from unittest.mock import Mock, patch

from jose import jwt
from passlib.context import CryptContext

from fastapi.security import OAuth2PasswordBearer

from app import security, user_api_model
from app.schemas.V1.config_scheme import EnvSettings

settings = EnvSettings()


def test_security_code_existence():
    # Asegurar que las variables y funciones existan y sean accesibles
    assert security.oauth2_scheme is not None
    assert security.pwd_context is not None
    assert security.settings is not None

    assert isinstance(security.oauth2_scheme, OAuth2PasswordBearer)
    assert isinstance(security.pwd_context, CryptContext)
    assert isinstance(security.settings, EnvSettings)

    assert callable(security.encrypt_password)
    assert callable(security.verify_password)
    assert callable(security.create_token)
    assert callable(security.create_token)
    assert callable(security.decode_token)
    assert callable(security.verify_token_redis)
    assert callable(security.Verify_token)
    assert callable(security.Verify_token)
    assert callable(security.verify_token_internal)


def test_encrypt_password():
    # Prueba básica
    password: str = "password123"
    encrypted_password = security.encrypt_password(password)
    assert encrypted_password != password

    # Prueba de comparación
    password1: str = "password123"
    password2: str = "password123"
    encrypted_password1 = security.encrypt_password(password1)
    encrypted_password2 = security.encrypt_password(password2)
    assert encrypted_password1 != encrypted_password2

    # Prueba de contraseñas diferentes
    password3: str = "differentpassword"
    encrypted_password3 = security.encrypt_password(password3)
    assert encrypted_password1 != encrypted_password3

    # Prueba de contraseñas vacías o nulas
    empty_password = ""
    null_password = None
    encrypted_empty_password = security.encrypt_password(empty_password)

    try:
        encrypted_null_password = security.encrypt_password(null_password)
    except Exception:
        encrypted_null_password = None

    assert encrypted_null_password is None
    assert encrypted_empty_password != empty_password


def test_verify_password():
    password1: str = "password123"
    passworld_encrypt: str = security.pwd_context.hash(password1)
    passworld_decode: str = security.verify_password(password1, passworld_encrypt)

    assert password1 != passworld_encrypt
    assert passworld_decode

    passworld_decode_null: str = security.verify_password(password1, None)

    assert passworld_decode_null == False


def test_create_token():
    data = {"user_id": 1, "username": "example"}
    token = security.create_token(data)
    decoded_token = security.jwt.decode(
        token, security.settings.SECRET_KEY, security.settings.ALGORITHM
    )

    assert decoded_token["user_id"] == 1
    assert decoded_token["username"] == "example"

    data1 = {"user_id": 2, "username": "example"}
    data2 = {"user_id": 3, "username": "another"}

    token1 = security.create_token(data1)
    token2 = security.create_token(data2)

    assert token1 != token2

    data = {"user_id": 4, "username": "example"}
    time_expire = 30

    token = security.create_token(data, time_expire)
    decoded_token = security.jwt.decode(
        token, security.settings.SECRET_KEY, security.settings.ALGORITHM
    )

    assert decoded_token["exp"] is not None


def test_decode_token():
    data = {"user_id": 1, "username": "example"}
    token_jwt = security.jwt.encode(data, settings.SECRET_KEY, settings.ALGORITHM)

    decoded = security.decode_token(token_jwt)

    assert decoded is not None
    assert isinstance(decoded, dict)


def test_verify_token_redis():
    data = {"user_id": 1, "username": "example", "iat": 1691697012, "exp": 1691698212}
    data1 = {"user_id": 2, "username": "example", "iat": 1691697012, "exp": 1691698212}

    r = redis.Redis(
        host=security.settings.HOST_REDIS,
        port=security.settings.PORT_REDIS,
        db=0,
        password=security.settings.PASSWORD_REDIS,
    )

    token_real = jwt.encode(data, settings.SECRET_KEY, settings.ALGORITHM)
    fake_token = jwt.encode(data1, settings.SECRET_KEY, settings.ALGORITHM)

    save_token = r.set(f"jwt_{token_real}", f"jwt_{token_real}", 30)

    verify = security.verify_token_redis(token_real)
    verify_fake = security.verify_token_redis(fake_token)

    assert save_token is not None
    assert save_token == True

    assert verify is not None
    assert verify == True
    assert verify_fake == False


@patch("app.core.V1.security.decode_token")
@patch("app.core.V1.security.get_db")
@patch("app.core.V1.security.get_user")
def test_Verify_token_valid(mock_get_user, mock_get_db, mock_decode_token):
    mock_user = Mock(spec=user_api_model.User)
    mock_user.id = 123  # Set the id attribute to 123
    mock_user.is_banned = False

    mock_decode_token.return_value = {
        "typ": "Internal",
        "sub": 123,  # Change to a valid numeric user ID
        "exp": int((datetime.utcnow() + timedelta(days=1)).timestamp()),
    }
    mock_get_user.return_value = mock_user

    token_data = {}
    result = security.Verify_token(token_data)

    assert result.id == 123
    assert not result.is_banned

    mock_decode_token.assert_called_once_with(token_data)
    mock_get_db.assert_called_once()
    mock_get_user.assert_called_once_with(
        db=mock_get_db().__next__(), user_id_or_name=123
    )  # Change the value here


@patch("app.core.V1.security.verify_token_redis")
@patch("app.core.V1.security.Verify_token")
def test_valid_token_internal(mock_Verify_token, mock_verify_token_redis):
    mock_user = Mock(spec=user_api_model.User)

    mock_verify_token_redis.return_value = True
    mock_Verify_token.return_value = mock_user

    result = security.verify_token_internal(token="your_mocked_token_here")

    assert result == (mock_user, "your_mocked_token_here")

    mock_verify_token_redis.assert_called_once_with("your_mocked_token_here")
    mock_Verify_token.assert_called_once_with("your_mocked_token_here")
