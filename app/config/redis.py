import redis
from app.schemas.V1.config_scheme import EnvSettings


# Cargar las variables de entorno
settings = EnvSettings()


# Funcion para octener una coneccion con la base de datos donde se almacena los tokens jwt de autenticacion
def get_jwt_connection() -> redis.Redis:
    pool = redis.ConnectionPool(
        host=settings.HOST_REDIS,
        port=settings.PORT_REDIS,
        db=0,
        password=settings.PASSWORD_REDIS,
    )

    r = redis.Redis(connection_pool=pool, decode_responses=True)
    return r


# Funcion para octener una coneccion con la base de datos donde la cache de la api
def get_cache_connection() -> redis.Redis:
    pool = redis.ConnectionPool(
        host=settings.HOST_REDIS,
        port=settings.PORT_REDIS,
        db=1,
        password=settings.PASSWORD_REDIS,
    )

    r = redis.Redis(connection_pool=pool, decode_responses=True)
    return r
