import pytest

from sqlalchemy import text
from sqlalchemy.orm import Session

from app import sessions, user_api_model, crud_users
from fixtures import db, institution_data, user_data


def test_crud_users_code_existence():
    """Ensure that variables and functions exist and are accessible"""
    
    assert callable(crud_users.create_user)
    assert callable(crud_users.get_user)
    assert callable(crud_users.get_users)
    assert callable(crud_users.edit_users)
    assert callable(crud_users.deactivate_users)


def test_create_user(db, user_data):
    user = crud_users.create_user(db, user_data)

    assert user is not None
    assert isinstance(user, user_api_model.User)


def test_get_user(db, user_data):
    user = user_api_model.User(**user_data)

    assert user is not None

    db.add(user)
    db.commit()
    db.refresh(user)

    result_id = crud_users.get_user(db, user_data["id"])
    result_username = crud_users.get_user(db, user_data["username"])
    result_email = crud_users.get_user(db, user_data["email"])

    assert result_id is not None
    assert result_username is not None
    assert result_email is not None

    assert result_id == user
    assert result_username == user
    assert result_email == user


def test_get_users(db, user_data):
    user = user_api_model.User(**user_data)

    assert user is not None

    db.add(user)
    db.commit()
    db.refresh(user)

    result_id = crud_users.get_users(db, user_data["id"])
    result_all = crud_users.get_users(db)

    assert result_id is not None
    assert result_all is not None

    assert result_id == user
    assert user in result_all


def test_edit_user(db, user_data):
    user = user_api_model.User(**user_data)

    assert user is not None

    db.add(user)
    db.commit()
    db.refresh(user)

    data = {"firt_name": "Carll", "last_name": "Usuamk", "institution": "alt"}

    user_update = crud_users.edit_users(db, data, user_data["id"])

    assert user_update is not None
    assert user_update.firt_name != user_data["firt_name"]
    assert user_update.last_name != user_data["last_name"]

    assert user_update.firt_name == data["firt_name"]
    assert user_update.last_name == data["last_name"]
    assert user_update.institution == data["institution"]


def test_deactivate_user(db, user_data):
    user = user_api_model.User(**user_data)

    assert user is not None

    db.add(user)
    db.commit()
    db.refresh(user)

    crud_users.deactivate_users(db, user.id)

    updated_user = db.query(user_api_model.User).filter(user_api_model.User.id == user.id).first()
    assert updated_user.is_banned is True
