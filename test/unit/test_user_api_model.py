import pytest

from app import user_api_model


def test_user_role():
    assert user_api_model.UserRole.ADMIN.value == 1
    assert user_api_model.UserRole.ADMINISTRATOR.value == 2
    assert user_api_model.UserRole.GUEST.value == 3


def test_user_model():
    user = user_api_model.User(
        id=1,
        rol_system=user_api_model.UserRole.GUEST,
        firt_name="John",
        last_name="Doe",
        username="johndoe",
        email="john@example.com",
        password="password",
        token_email_change_password=None,
        is_banned=False,
        is_locked=False,
        failed_login_attempts=0,
        unlock_date=None,
        log=[],
        api=[],
        institutions=[],
        user_apis=[],
    )

    assert isinstance(user.id, int)
    assert user.rol_system == user_api_model.UserRole.GUEST
    assert isinstance(user.firt_name, str)
    assert isinstance(user.last_name, str)
    assert isinstance(user.username, str)
    assert isinstance(user.email, str)
    assert isinstance(user.password, str)
    assert user.token_email_change_password is None
    assert user.is_banned == False
    assert user.is_locked == False
    assert user.failed_login_attempts == 0
    assert user.unlock_date is None
    assert isinstance(user.log, list)
    assert isinstance(user.api, list)
    assert isinstance(user.institutions, list)
    assert isinstance(user.user_apis, list)


def test_institution_model():
    institution = user_api_model.Institution(id=1, name="Example Institutions")

    assert isinstance(institution.id, int)
    assert isinstance(institution.name, str)
    assert institution.name == "Example Institutions"
    assert isinstance(institution.users, list)


def test_log_login_model():
    log_login = user_api_model.Log_login(
        id=1, id_user=1, ip_addres="192.168.0.1")

    assert isinstance(log_login.id, int)
    assert isinstance(log_login.id_user, int)
    assert isinstance(log_login.ip_addres, str)
    assert log_login.id == 1
    assert log_login.id_user == 1
    assert log_login.ip_addres == "192.168.0.1"


def test_rol_model():
    rol = user_api_model.Rol(
        id=1,
        api_id=1,
        name="Example Rol",
        description="This is an example role")

    assert isinstance(rol.id, int)
    assert isinstance(rol.api_id, int)
    assert isinstance(rol.name, str)
    assert isinstance(rol.description, str)
    assert rol.id == 1
    assert rol.api_id == 1
    assert rol.name == "Example Rol"
    assert rol.description == "This is an example role"
    assert isinstance(rol.apis, list)
    assert isinstance(rol.permissions, list)


def test_permission_model():
    permission = user_api_model.Permission(
        id=1, api_id=1, name="Example", description="Example permission"
    )

    assert isinstance(permission.id, int)
    assert isinstance(permission.api_id, int)
    assert isinstance(permission.name, str)
    assert isinstance(permission.description, str)
    assert permission.id == 1
    assert permission.api_id == 1
    assert permission.name == "Example"
    assert permission.description == "Example permission"
    assert isinstance(permission.rols, list)
