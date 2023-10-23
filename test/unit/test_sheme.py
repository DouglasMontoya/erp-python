import pytest
from datetime import datetime

from app.schemas.V1 import config_scheme, jwt_scheme, user_scheme, api_scheme


def test_env_settings_types():
    settings = config_scheme.EnvSettings()

    assert isinstance(settings.TYPE_DATABASE, str)
    assert isinstance(settings.DRIVER, str)
    assert isinstance(settings.USERNAME_DB, str)
    assert isinstance(settings.PASSWORD, str)
    assert isinstance(settings.HOST, str)
    assert isinstance(settings.PORT, str)
    assert isinstance(settings.DATABASE, str)

    assert isinstance(settings.POOL_SIZE, int)
    assert isinstance(settings.MAX_OVERFLOW, int)
    assert isinstance(settings.POLL_TIMEOUT, int)
    assert isinstance(settings.POOL_RECYCLE, int)

    assert isinstance(settings.HOST_REDIS, str)
    assert isinstance(settings.PORT_REDIS, int)
    assert isinstance(settings.PASSWORD_REDIS, str)

    assert isinstance(settings.MAX_FAILED_LOGIN_ATTEMPTS, int)
    assert isinstance(settings.LOCK_DURATION_MINUTES, int)
    assert isinstance(settings.TIME_EXPIRATION_TOKEN_JWT, int)

    assert isinstance(settings.SECRET_KEY, str)
    assert isinstance(settings.ALGORITHM, str)
    assert isinstance(settings.ACCESS_TOKEN_EXPIRES, int)

    assert isinstance(settings.API_HOST, str)
    assert isinstance(settings.API_PORT, int)
    assert isinstance(settings.API_DEBUG, bool)


def test_token_payload():
    payload = jwt_scheme.TokenPayload(sub="user123", iss="myapp", typ="external")

    assert payload.sub == "user123"
    assert payload.iss == "myapp"
    assert payload.typ == "external"


def test_token_decode():
    decode = jwt_scheme.TokenDecode(sub="user123", iss="myapp", typ="external", iat=1234567890, exp=1234567890)

    assert decode.sub == "user123"
    assert decode.iss == "myapp"
    assert decode.typ == "external"
    assert decode.iat == 1234567890
    assert decode.exp == 1234567890


def test_user_base():
    user = user_scheme.UserBase(firt_name="John", last_name="Doe", username="johndoe", email="johndoe@example.com")

    assert user.firt_name == "John"
    assert user.last_name == "Doe"
    assert user.username == "johndoe"
    assert user.email == "johndoe@example.com"


def test_institution():
    institution = user_scheme.Institution(name="My Institution")

    assert institution.name == "My Institution"


def test_user_edit():
    user_edit = user_scheme.UserEdit(firt_name="John", last_name="Doe", institution="My Institution")

    assert user_edit.firt_name == "John"
    assert user_edit.last_name == "Doe"
    assert user_edit.institution == "My Institution"


def test_user_db():
    user_db = user_scheme.UserDB(firt_name="John", last_name="Doe", username="johndoe", email="johndoe@example.com", password="password123")

    assert user_db.firt_name == "John"
    assert user_db.last_name == "Doe"
    assert user_db.username == "johndoe"
    assert user_db.email == "johndoe@example.com"
    assert user_db.password == "password123"


def test_user():
    user = user_scheme.User(
        id=1,
        firt_name="John",
        last_name="Doe",
        username="johndoe",
        email="johndoe@example.com",
    )

    assert user.id == 1
    assert user.firt_name == "John"
    assert user.last_name == "Doe"
    assert user.username == "johndoe"
    assert user.email == "johndoe@example.com"


def test_user_admin():
    user_admin = user_scheme.UserAdmin(
        firt_name="John",
        last_name="Doe",
        username="johndoe",
        email="johndoe@example.com",
        id=1,
        is_banned=False,
        is_locked=False,
        failed_login_attempts=0,
        unlock_date=None,
        update_at=datetime.now(),
        create_at=datetime.now(),
    )

    assert user_admin.firt_name == "John"
    assert user_admin.last_name == "Doe"
    assert user_admin.username == "johndoe"
    assert user_admin.email == "johndoe@example.com"
    assert user_admin.id == 1
    assert user_admin.is_banned == False
    assert user_admin.is_locked == False
    assert user_admin.failed_login_attempts == 0
    assert user_admin.unlock_date == None
    assert isinstance(user_admin.update_at, datetime)
    assert isinstance(user_admin.create_at, datetime)


def test_change_password():
    change_password = user_scheme.ChangePassword(current_password="password123", new_password="newpassword123", confirm_password="newpassword123")

    assert change_password.current_password == "password123"
    assert change_password.new_password == "newpassword123"
    assert change_password.confirm_password == "newpassword123"


def test_APIBase():
    api = api_scheme.APIBase(name_api="API Test", description="Testing", url_path="https://example.com/")

    assert isinstance(api.name_api, str)
    assert isinstance(api.description, str)

    assert api.name_api == "API Test"
    assert api.description == "Testing"
    assert str(api.url_path) == "https://example.com/"


def test_APIEdit():
    api = api_scheme.APIEdit(name_api="API 1", description="Using API 1", url_path="https://api.example.com", rol=["admin"], permission=["crud"])

    assert api.name_api == "API 1"
    assert api.description == "Using API 1"
    assert str(api.url_path) == "https://api.example.com/"
    assert api.rol == ["admin"]
    assert api.permission == ["crud"]


def test_APIDB():
    api = api_scheme.APIDB(name_api="API 1", description="Using API 1", url_path="https://api.example.com/", create_user=1)

    assert api.name_api == "API 1"
    assert api.description == "Using API 1"
    assert str(api.url_path) == "https://api.example.com/"
    assert api.create_user == 1


def test_API():
    api = api_scheme.API(id=1, name_api="API 1", description="Using API 1", url_path="https://api.example.com/")
    assert api.id == 1
    assert api.name_api == "API 1"
    assert api.description == "Using API 1"
    assert str(api.url_path) == "https://api.example.com/"


def test_APIAdmin():
    # Caso de prueba exitoso
    api = api_scheme.APIAdmin(
        name_api="API 1",
        description="Using API 1",
        url_path="https://api.example.com/",
        create_user=1,
        rol=["string"],
        permission=["string"],
        id=0,
        is_active=True,
 
    )
    assert api.name_api == "API 1"
    assert api.description == "Using API 1"
    assert str(api.url_path) == "https://api.example.com/"
    assert api.create_user == 1
    assert api.rol == ["string"]
    assert api.permission == ["string"]
    assert api.id == 0
    assert api.is_active is True