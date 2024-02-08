from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from sqlalchemy_utils import create_database, database_exists
from sqlalchemy.exc import OperationalError
from sqlalchemy import text

from app.core import config

# Create an engine that stores data in the local directory's
# sqlalchemy_example.db file.
engine = create_engine(
    config.SQLALCHEMY_DATABASE_URI,
)

# Create a configured "Session" class
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Create a base class for declarative models
Base = declarative_base()

# Try to establish a connection and execute a dummy query
try:
    with engine.connect() as connection:
        connection.execute(text("SELECT 1"))
    print("")
    print("✅ Connection to the successful database.")
    print("")
except OperationalError as e:
    print("")
    print("❌ Error: It could not be connected to the database. Make sure the data is correct.")
    print("")
    print(e)

# Function to get a new SQLAlchemy session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Function to validate if the database exists
def validate_database():
    if not database_exists(engine.url):
        create_database(engine.url)
