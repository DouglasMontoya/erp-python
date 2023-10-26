import pytest

from sqlalchemy import text
from sqlalchemy.orm import Session
from fastapi import HTTPException, status

from app import crud_api, user_api_model, api_scheme
from fixtures import db, api_data


def test_crud_api_code_existence():
    """Ensure that variables and functions exist and are accessible"""

    assert hasattr(crud_api, "exception_api")
    assert callable(crud_api.valid_api)
    assert callable(crud_api.get_apis)
    assert callable(crud_api.create_api)
    assert callable(crud_api.edit_api)
    assert callable(crud_api.deactivate_api)


def test_create_api(db, api_data):
    api = crud_api.create_api(db, api_data)

    assert isinstance(api, crud_api.Api)
    assert api.name_api == "API 1"
    assert api.description == "Using API 1"
    assert str(api.url_path) == "https://api.example.com/"
    assert api.create_user == 1


def test_get_apis(db):
    api1 = user_api_model.Api(name_api="API 1", create_user=1, description="Using API 1", url_path="https://api.example1.com/")

    api2 = user_api_model.Api(name_api="API 2", create_user=1, description="Using API 2", url_path="https://api.example2.com/")

    db.add_all([api1, api2])
    db.commit()
    db.refresh(api2)

    api_id = api1.id
    result = crud_api.get_apis(db, api_id)
    assert result == api1

    # Caso de prueba sin api_id especificado
    result = crud_api.get_apis(db)
    assert isinstance(result, list)
    assert len(result) == 2
    assert api1 in result
    assert api2 in result


def test_valid_api(db):
    api1 = crud_api.Api(name_api="API 1", create_user=1, description="Using API 1", url_path="https://api.example1.com/")
    api2 = crud_api.Api(name_api="API 2", create_user=1, description="Using API 2", url_path="https://api.example2.com/")

    db.add_all([api1, api2])
    db.commit()
    db.refresh(api2)

    data_duplicate_name = api_scheme.APIDB(name_api="API 1", description="Using API 2", url_path="https://api.example.com/")
    try:
        crud_api.valid_api(db, dict(data_duplicate_name))
        assert False
    except HTTPException as e:
        assert e.status_code == status.HTTP_400_BAD_REQUEST
        assert e.detail == "The api name is already in use."

    data_duplicate_url = api_scheme.APIDB(name_api="API 2", description="Using API 2", url_path="https://api.example.com/")
    try:
        crud_api.valid_api(db, dict(data_duplicate_url))
        assert False  # La excepción no fue lanzada
    except HTTPException as e:
        assert e.status_code == status.HTTP_400_BAD_REQUEST

    data_valid = api_scheme.APIDB(name_api="API 3", description="Using API 3", url_path="https://api.example.com")
    try:
        crud_api.valid_api(db, dict(data_valid))
    except HTTPException as e:
        assert False


def test_deactivate_api(db):
    api = crud_api.Api(name_api="API 1", create_user=1, description="Using API 1", url_path="https://api.example1.com/")

    db.add(api)
    db.commit()
    db.refresh(api)

    api_id = api.id
    crud_api.deactivate_api(db, api_id)
    deactivated_api = db.query(user_api_model.Api).filter_by(id=api_id).first()
    assert deactivated_api.is_active is False

    invalid_api_id = "invalid"
    with pytest.raises(Exception):
        crud_api.deactivate_api(db, invalid_api_id)

    non_existent_api_id = 9999
    with pytest.raises(Exception):
        crud_api.deactivate_api(db, non_existent_api_id)
