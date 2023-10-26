# Fixture para proporcionar la sesión de la base de datos
import os
import pytest

from sqlalchemy.orm.session import Session

from app import config_scheme, user_scheme, sql

################# CONEXIÓN A LA BASE DE DATOS SQL ######################

# Cargar las variables de entorno
settings = config_scheme.EnvSettings()

# Fixture para proporcionar la sesión de la base de datos


@pytest.fixture
def db() -> Session:
    # Implementa la lógica para crear una sesión de prueba

    from sqlalchemy import create_engine
    from sqlalchemy.orm import sessionmaker
    from sqlalchemy.exc import SQLAlchemyError

    try:
        engine = create_engine("sqlite:///test/test.db")
        sql.Base.metadata.create_all(bind=engine)

        SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
        session = SessionLocal()

        yield session

        session.close()

        os.remove("./test/test.db")

    except SQLAlchemyError as e:
        print(f"Error al crear el motor de base de datos: {e}")


@pytest.fixture
def institution_data():
    return {
        "name": "Institucion.ca",
    }


@pytest.fixture
def institution_data_alt():
    return {
        "name": "Institucion.alt",
    }

@pytest.fixture
def user_data():
    return {
        "id":1,
        "firt_name": "John",
        "last_name": "Doe",
        "username": "johndoenoinoinoinonnoino89",
        "email": "johndoe@example.com",
        "password": "secret",
    }


@pytest.fixture
def api_data():
    return {
        "name_api":"API 1",
        "description":"Using API 1",
        "url_path":"https://api.example.com/",
        "create_user":1
    }
