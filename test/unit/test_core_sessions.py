import pytest

from sqlalchemy import text
from sqlalchemy.orm import Session

from app import sessions, crud_institution
from fixtures import db, institution_data, user_data


def test_core_database_code_existence():
    """Ensure that variables and functions exist and are accessible"""

    assert callable(sessions.get_db)


def test_get_db():
    """Verify that the variable db is an instance of Session"""
    db = next(sessions.get_db())

    assert isinstance(db, Session)
    assert True


def test_database_connection():
    """this function proves that the sessions are obtained in a correct way"""
    try:
        db = next(sessions.get_db())

        db.execute(text("SELECT 1"))

        assert True
    except Exception as e:
        pytest.fail(f"Error connecting to the database: {e}")
