import os
from dotenv import load_dotenv
PROJECT_NAME = "autoges-erp"

SQLALCHEMY_DATABASE_URI = os.getenv("DATABASE_URL")
if SQLALCHEMY_DATABASE_URI is None:
    dotenv_path = os.path.join(os.getcwd(), '.env')
    print(dotenv_path)
    load_dotenv(dotenv_path)
    SQLALCHEMY_DATABASE_URI = ''.join([
        'postgresql://',
        os.getenv("POSTGRES_USER") or 'postgres',
        ':',
        os.getenv("POSTGRES_PASSWORD") or 'postgres',
        '@',
        os.getenv("POSTGRES_HOST") or 'localhost',
        ':',
        os.getenv("POSTGRES_PORT") or '5432',
        '/',
        os.getenv("POSTGRES_NAME") or 'autoges',
        '?sslmode=disable'
    ])
    print(SQLALCHEMY_DATABASE_URI)

API_V1_STR = "/api/v1"
