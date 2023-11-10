from pydantic_settings import BaseSettings, SettingsConfigDict


class EnvSettings(BaseSettings):
    TYPE_DATABASE: str = "postgresql"
    DRIVER: str = "psycopg2"
    USERNAME_DB: str = "admin"
    PASSWORD: str = "admin"
    HOST: str = "localhost"
    PORT: str = "5435"
    DATABASE: str = "postgres"

    POOL_SIZE: int = 10
    MAX_OVERFLOW: int = 5
    POLL_TIMEOUT: int = 30
    POOL_RECYCLE: int = 3600

    HOST_REDIS: str = "localhost"
    PORT_REDIS: int = 6379
    PASSWORD_REDIS: str = ""

    MAX_FAILED_LOGIN_ATTEMPTS: int = 5
    LOCK_DURATION_MINUTES: int = 5
    TIME_EXPIRATION_TOKEN_JWT: int = 30

    SECRET_KEY: str = "You, secret key"
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRES: int = 15

    API_HOST: str = "127.0.0.1"
    API_PORT: int = 8000
    API_DEBUG: bool = True

    model_config = SettingsConfigDict(env_file=".env")
