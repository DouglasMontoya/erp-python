import datetime

from sqlalchemy import DateTime

from sqlalchemy.orm import declarative_mixin, Mapped, mapped_column, Mapped, mapped_column


@declarative_mixin
class Timestamp:
    create_at: Mapped[DateTime] = mapped_column(DateTime, default=datetime.datetime.utcnow)
    update_at: Mapped[DateTime] = mapped_column(DateTime, default=datetime.datetime.utcnow, onupdate=datetime.datetime.utcnow)
