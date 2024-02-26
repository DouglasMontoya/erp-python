from uuid import uuid4
from sqlalchemy import JSON, BigInteger, Boolean, Column, DateTime, ForeignKey, Integer, SmallInteger, String
import sqlalchemy
from sqlalchemy.orm import relationship
from sqlalchemy.dialects.postgresql import UUID, JSONB
from sqlalchemy.sql import text

from .session import Base


class User(Base):
    __tablename__ = "user"

    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, index=True, nullable=False)
    first_name = Column(String)
    last_name = Column(String)
    hashed_password = Column(String, nullable=False)
    is_active = Column(Boolean, default=True)
    is_superuser = Column(Boolean, default=False)

class Customer(Base):
    __tablename__ = "customer"

    id = Column(String, primary_key=True, index=True, default=lambda: str(uuid4()))
    email = Column(String, unique=True, index=True)
    first_name = Column(String, index=True)
    last_name = Column(String, index=True)
    billing_address_id = Column(String)
    password_hash = Column(String)
    phone = Column(String)
    has_account = Column(Boolean, default=False)
    created_at = Column(DateTime, server_default=sqlalchemy.sql.func.now())
    updated_at = Column(DateTime, server_default=sqlalchemy.sql.func.now())
    deleted_at = Column(DateTime(timezone=True))
    metadata_data = Column("metadata", JSON)
    account_customer = Column(BigInteger)
    account_debtor = Column(BigInteger)
    is_particular = Column(Boolean)
    shipping_address_id = Column(String)
    note = Column(String)
    legal_representative = Column(String)
    is_customer = Column(String)
    tradename = Column(String)
    re = Column(String)

class Address(Base):
    __tablename__ = "address"

    id = Column(String, primary_key=True, index=True, default=lambda: str(uuid4()))
    customer_id = Column(String, ForeignKey("customer.id"))
    company = Column(String)
    first_name = Column(String)
    last_name = Column(String)
    address_1 = Column(String)
    address_2 = Column(String)
    city = Column(String)
    country_code = Column(String)
    province = Column(String)
    postal_code = Column(String)
    phone = Column(String)
    created_at = Column(DateTime, server_default=text("(now())"))
    updated_at = Column(DateTime, server_default=text("(now())"))
    deleted_at = Column(DateTime)
    metadata_data = Column("metadata", JSONB)
    fees_id = Column(SmallInteger)
    opening_days = Column(String)
    horary = Column(String)
    delivery_note_info = Column(String)
    invoice_info = Column(String)
    leads_info = Column(String)
    nif = Column(String)
    company_activity = Column(String)
    cnae = Column(String)
    tags = Column(String)
    email = Column(String)

    customer = relationship("Customer", back_populates="addresses")

Customer.addresses = relationship("Address", order_by=Address.id, back_populates="customer")

class CustomerPayment(Base):
    __tablename__ = "customer_payment"

    id = Column(String, primary_key=True, index=True, default=lambda: str(uuid4()))
    customer_id = Column(String)
    payment_method = Column(String)
    payday = Column(String)
    bank_country = Column(String)
    currency_code = Column(String)
    iban = Column(String)
    swift = Column(String)
    payday_adjustment = Column(String)

class Contacts(Base):
    __tablename__ = "contacts"

    id = Column(String, primary_key=True, index=True, default=lambda: str(uuid4()))
    name = Column(String)
    dni = Column(String)
    profession = Column(String)
    address = Column(String)
    province = Column(String)
    city = Column(String)
    phone = Column(String)
    email = Column(String)
    email_notification = Column(String)
    note = Column(String)
    customer_id = Column(String)
    job = Column(String)

class Provider(Base):
    __tablename__ = "provider"

    id = Column(String, primary_key=True, index=True, default=lambda: str(uuid4()))
    provider_payment_id = Column(String)
    customer_id = Column(String)
    account_iva = Column(String)
    account_irpf = Column(String)
    account_provider = Column(String)
    account_creditor = Column(String)
    operation_field_id = Column(BigInteger)
    operation_type_id = Column(BigInteger)

class ProviderPayment(Base):
    __tablename__ = 'provider_payment'

    id = Column(String, primary_key=True, index=True, default=lambda: str(uuid4()))
    provider_id = Column(String)
    payment_method = Column(String)
    payday = Column(String)
    bank_country = Column(String)
    currency_code = Column(String)
    iban = Column(String)
    swift = Column(String)
    payday_adjustment = Column(String)