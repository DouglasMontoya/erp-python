import pytest

import redis as re

from app import redis, sql
from app.schemas.V1.config_scheme import EnvSettings


def test_database_sql_code_existence():
    """Ensure that variables and functions exist and are accessible"""
    assert isinstance(sql.database_url, str)
    assert isinstance(sql.pool_size, int)
    assert isinstance(sql.max_overflow, int)
    assert isinstance(sql.pool_timeout, int)
    assert isinstance(sql.pool_recycle, int)
    assert sql.engine is not None
    assert sql.Base is not None
    assert callable(sql.SessionLocal)


def test_database_redis_code_existence():
    assert redis.settings is not None
    assert isinstance(redis.settings, EnvSettings)


def test_get_connection_jwt_redis():
    r = redis.get_jwt_connection()

    r.set("test_redis_connection_82319k", "test_connection_jwt_in_redis", 30)

    result = r.get("test_redis_connection_82319k").decode("utf-8")

    assert callable(redis.get_jwt_connection)
    assert isinstance(r, re.Redis)

    assert result is not None
    assert result == "test_connection_jwt_in_redis"

    r.delete("test_redis_connection_82319k")
    result = r.get("test_redis_connection_82319k")

    assert result == None


def test_get_cache_connection():
    r = redis.get_cache_connection()

    r.set("test_conection_92981739812jjoiojoj0-", "test_cache_redis", 30)

    result = r.get("test_conection_92981739812jjoiojoj0-").decode("utf-8")

    assert callable(redis.get_jwt_connection)
    assert isinstance(r, re.Redis)

    assert result is not None
    assert result == "test_cache_redis"

    r.delete("test_conection_92981739812jjoiojoj0-")
    result = r.get("test_cache_redis")

    assert result == None
