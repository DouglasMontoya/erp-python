from datetime import datetime

import pytest

from app import mixins
from sqlalchemy.orm import properties


def test_timestamp():
    timestamp = mixins.Timestamp()

    assert timestamp is not None
    assert isinstance(timestamp.create_at, properties.MappedColumn)
    assert isinstance(timestamp.update_at, properties.MappedColumn)
