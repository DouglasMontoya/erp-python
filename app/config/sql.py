from sqlalchemy import create_engine
from sqlalchemy.orm import declarative_base
from sqlalchemy.orm import sessionmaker

from app.schemas.V1.config_scheme import EnvSettings


################# CONEXIÓN A LA BASE DE DATOS SQL ######################

# Cargar las variables de entorno
settings = EnvSettings()

# Construir la URL de conexión a la base de datos
database_url = (
    f"{settings.TYPE_DATABASE}+{settings.DRIVER}://"
    f"{settings.USERNAME_DB}:{settings.PASSWORD}@"
    f"{settings.HOST}:{settings.PORT}/{settings.DATABASE}"
)

# Configuración del pool de conexiones
pool_size = settings.POOL_SIZE
max_overflow = settings.MAX_OVERFLOW
pool_timeout = settings.POLL_TIMEOUT
pool_recycle = settings.POOL_RECYCLE

# Crear el motor de la base de datos
engine = create_engine(
    database_url,
    pool_size=pool_size,
    max_overflow=max_overflow,
    pool_timeout=pool_timeout,
    pool_recycle=pool_recycle,
)


Base = declarative_base()

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)


##########################################################################
