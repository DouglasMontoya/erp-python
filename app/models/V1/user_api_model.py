import enum

from typing import List
from sqlalchemy import Integer, String, Boolean, DateTime, Enum, ForeignKey
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.config.sql import Base, engine

from .mixins import Timestamp


# User Models
class UserRole(enum.Enum):
    ADMIN: int = 1
    ADMINISTRATOR: int = 2
    GUEST: int = 3


class User(Timestamp, Base):
    __tablename__ = "user"

    id: Mapped[int] = mapped_column(primary_key=True)
    rol_system: Mapped[Enum] = mapped_column(Enum(UserRole), default=UserRole.GUEST)

    firt_name: Mapped[str] = mapped_column(String(50))
    last_name: Mapped[str] = mapped_column(String(50))
    username: Mapped[str] = mapped_column(String(50), unique=True)
    email: Mapped[str] = mapped_column(String(50), unique=True)

    password: Mapped[str]
    token_email_change_password: Mapped[str] = mapped_column(String(50), nullable=True)

    is_banned: Mapped[bool] = mapped_column(Boolean, default=False)
    is_locked: Mapped[bool] = mapped_column(Boolean, default=False)

    failed_login_attempts: Mapped[int] = mapped_column(Integer, default=0)

    unlock_date: Mapped[DateTime] = mapped_column(DateTime, nullable=True)

    log: Mapped[List["Log_login"]] = relationship()
    api: Mapped[List["Api"]] = relationship()

    institutions: Mapped[List["Assosiation_institutions_user"]] = relationship(
        back_populates="user"
    )

    user_apis: Mapped[List["Association_User_Api_Rol"]] = relationship(
        back_populates="user_api"
    )

    @property
    def is_admin(self):
        return self.rol_system.name == UserRole.ADMIN.name

    @property
    def is_administrator(self):
        return self.rol_system.name == UserRole.ADMINISTRATOR.name

    @property
    def is_guest(self):
        return self.rol_system.name == UserRole.GUEST.name


class Institution(Timestamp, Base):
    __tablename__ = "institution"
    __table_args__ = {"extend_existing": True}

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(50), unique=True)

    users: Mapped[List["Assosiation_institutions_user"]] = relationship(
        back_populates="institution"
    )


class Assosiation_institutions_user(Timestamp, Base):
    __tablename__ = "association_institutions_user_table"

    user_id: Mapped[int] = mapped_column(ForeignKey("user.id"), primary_key=True)
    institution_id: Mapped[int] = mapped_column(
        ForeignKey("institution.id"), primary_key=True
    )

    user: Mapped[List["User"]] = relationship(back_populates="institutions")
    institution: Mapped[List["Institution"]] = relationship(back_populates="users")


class Log_login(Timestamp, Base):
    __tablename__ = "log_login"
    __table_args__ = {"extend_existing": True}

    id: Mapped[int] = mapped_column(primary_key=True)
    id_user: Mapped["User"] = mapped_column(ForeignKey("user.id"))
    ip_addres: Mapped[str] = mapped_column(String(20))


# API Models
class Api(Timestamp, Base):
    __tablename__ = "api"
    __table_args__ = {"extend_existing": True}

    id: Mapped[int] = mapped_column(primary_key=True)
    create_user: Mapped[int] = mapped_column(ForeignKey("user.id"))

    name_api: Mapped[str] = mapped_column(String, unique=True)
    description: Mapped[str]
    url_path: Mapped[str] = mapped_column(String, unique=True)

    is_active: Mapped[bool] = mapped_column(Boolean, default=False)

    permission: Mapped[List["Permission"]] = relationship()
    rols: Mapped[List["Association_Api_Rol"]] = relationship(back_populates="rol")


class Rol(Timestamp, Base):
    __tablename__ = "rol"
    __table_args__ = {"extend_existing": True}

    id: Mapped[int] = mapped_column(primary_key=True)
    api_id: Mapped[int] = mapped_column(ForeignKey("api.id"), nullable=True)

    name: Mapped[str] = mapped_column(String, unique=True)
    description: Mapped[str]

    apis: Mapped[List["Association_Api_Rol"]] = relationship(back_populates="api")
    permissions: Mapped[List["Association_Rol_Permission"]] = relationship(
        back_populates="rol"
    )


class Permission(Timestamp, Base):
    __tablename__ = "permission"
    __table_args__ = {"extend_existing": True}

    id: Mapped[int] = mapped_column(primary_key=True)
    api_id: Mapped[int] = mapped_column(ForeignKey("api.id"), nullable=True)

    name: Mapped[str]
    description: Mapped[str]

    rols: Mapped[List["Association_Rol_Permission"]] = relationship(
        back_populates="permission"
    )


class Association_Rol_Permission(Timestamp, Base):
    __tablename__ = "association_rol_permission_table"
    __table_args__ = {"extend_existing": True}

    id: Mapped[int] = mapped_column(primary_key=True)

    rol_id: Mapped[int] = mapped_column(ForeignKey("rol.id", ondelete="CASCADE"))
    permission_id: Mapped[int] = mapped_column(
        ForeignKey("permission.id", ondelete="CASCADE")
    )

    rol: Mapped[List["Rol"]] = relationship(back_populates="permissions")
    permission: Mapped[List["Permission"]] = relationship(back_populates="rols")


class Association_Api_Rol(Timestamp, Base):
    __tablename__ = "association_api_rol_table"
    __table_args__ = {"extend_existing": True}

    id: Mapped[int] = mapped_column(primary_key=True)

    api_id: Mapped[int] = mapped_column(ForeignKey("api.id", ondelete="CASCADE"))
    rol_id: Mapped[int] = mapped_column(ForeignKey("rol.id", ondelete="CASCADE"))

    api: Mapped[List["Rol"]] = relationship(back_populates="apis")
    rol: Mapped[List["Api"]] = relationship(back_populates="rols")

    api_rols: Mapped[List["Association_User_Api_Rol"]] = relationship(
        back_populates="api_rol"
    )


class Association_User_Api_Rol(Timestamp, Base):
    __tablename__ = "association_user_api_rol_table"
    __table_args__ = {"extend_existing": True}

    user_id: Mapped[int] = mapped_column(ForeignKey("user.id"), primary_key=True)
    api_rol_id: Mapped[int] = mapped_column(
        ForeignKey("association_api_rol_table.id"), primary_key=True
    )

    user_api: Mapped[List["User"]] = relationship(back_populates="user_apis")
    api_rol: Mapped[List["Association_Api_Rol"]] = relationship(
        back_populates="api_rols"
    )


Base.metadata.create_all(bind=engine)
