import pytest

from sqlalchemy import text
from sqlalchemy.orm import Session

from app import sessions, crud_users
from fixtures import db, institution_data, user_data


# def test_create_insitution(db, institution_data):
#     institution = crud_institution.create_institution(db, institution_data)

#     assert institution.id is not None
#     assert institution.name == institution_data["name"]

#     db.delete(institution)
#     db.commit()


# def test_create_user(db, user_data):
#     user = crud_institution.create_user(db, user_data)

#     # Assert
#     assert user.id is not None
#     assert user.firt_name == user_data["firt_name"]
#     assert user.last_name == user_data["last_name"]
#     assert user.username == user_data["username"]
#     assert user.email == user_data["email"]

#     # Cleanup (if necessary)
#     db.delete(user)
#     db.commit()
