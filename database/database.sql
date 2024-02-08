--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1 (Debian 16.1-1.pgdg120+1)
-- Dumped by pg_dump version 16.1 (Debian 16.1-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: PAYMENT_COLLECTION_STATUS_ENUM; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."PAYMENT_COLLECTION_STATUS_ENUM" AS ENUM (
    'not_paid',
    'awaiting',
    'authorized',
    'partially_authorized',
    'canceled'
);


ALTER TYPE public."PAYMENT_COLLECTION_STATUS_ENUM" OWNER TO postgres;

--
-- Name: PAYMENT_COLLECTION_TYPE_ENUM; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."PAYMENT_COLLECTION_TYPE_ENUM" AS ENUM (
    'order_edit'
);


ALTER TYPE public."PAYMENT_COLLECTION_TYPE_ENUM" OWNER TO postgres;

--
-- Name: cart_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.cart_type_enum AS ENUM (
    'default',
    'swap',
    'draft_order',
    'payment_link',
    'claim'
);


ALTER TYPE public.cart_type_enum OWNER TO postgres;

--
-- Name: claim_item_reason_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.claim_item_reason_enum AS ENUM (
    'missing_item',
    'wrong_item',
    'production_failure',
    'other'
);


ALTER TYPE public.claim_item_reason_enum OWNER TO postgres;

--
-- Name: claim_order_fulfillment_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.claim_order_fulfillment_status_enum AS ENUM (
    'not_fulfilled',
    'partially_fulfilled',
    'fulfilled',
    'partially_shipped',
    'shipped',
    'partially_returned',
    'returned',
    'canceled',
    'requires_action'
);


ALTER TYPE public.claim_order_fulfillment_status_enum OWNER TO postgres;

--
-- Name: claim_order_payment_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.claim_order_payment_status_enum AS ENUM (
    'na',
    'not_refunded',
    'refunded'
);


ALTER TYPE public.claim_order_payment_status_enum OWNER TO postgres;

--
-- Name: claim_order_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.claim_order_type_enum AS ENUM (
    'refund',
    'replace'
);


ALTER TYPE public.claim_order_type_enum OWNER TO postgres;

--
-- Name: discount_condition_operator_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.discount_condition_operator_enum AS ENUM (
    'in',
    'not_in'
);


ALTER TYPE public.discount_condition_operator_enum OWNER TO postgres;

--
-- Name: discount_condition_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.discount_condition_type_enum AS ENUM (
    'products',
    'product_types',
    'product_collections',
    'product_tags',
    'customer_groups'
);


ALTER TYPE public.discount_condition_type_enum OWNER TO postgres;

--
-- Name: discount_rule_allocation_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.discount_rule_allocation_enum AS ENUM (
    'total',
    'item'
);


ALTER TYPE public.discount_rule_allocation_enum OWNER TO postgres;

--
-- Name: discount_rule_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.discount_rule_type_enum AS ENUM (
    'fixed',
    'percentage',
    'free_shipping'
);


ALTER TYPE public.discount_rule_type_enum OWNER TO postgres;

--
-- Name: draft_order_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.draft_order_status_enum AS ENUM (
    'open',
    'completed'
);


ALTER TYPE public.draft_order_status_enum OWNER TO postgres;

--
-- Name: invite_role_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.invite_role_enum AS ENUM (
    'admin',
    'member',
    'developer'
);


ALTER TYPE public.invite_role_enum OWNER TO postgres;

--
-- Name: order_fulfillment_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.order_fulfillment_status_enum AS ENUM (
    'not_fulfilled',
    'partially_fulfilled',
    'fulfilled',
    'partially_shipped',
    'shipped',
    'partially_returned',
    'returned',
    'canceled',
    'requires_action'
);


ALTER TYPE public.order_fulfillment_status_enum OWNER TO postgres;

--
-- Name: order_item_change_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.order_item_change_type_enum AS ENUM (
    'item_add',
    'item_remove',
    'item_update'
);


ALTER TYPE public.order_item_change_type_enum OWNER TO postgres;

--
-- Name: order_payment_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.order_payment_status_enum AS ENUM (
    'not_paid',
    'awaiting',
    'captured',
    'partially_refunded',
    'refunded',
    'canceled',
    'requires_action'
);


ALTER TYPE public.order_payment_status_enum OWNER TO postgres;

--
-- Name: order_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.order_status_enum AS ENUM (
    'pending',
    'completed',
    'archived',
    'canceled',
    'requires_action'
);


ALTER TYPE public.order_status_enum OWNER TO postgres;

--
-- Name: payment_session_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.payment_session_status_enum AS ENUM (
    'authorized',
    'pending',
    'requires_more',
    'error',
    'canceled'
);


ALTER TYPE public.payment_session_status_enum OWNER TO postgres;

--
-- Name: price_list_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.price_list_status_enum AS ENUM (
    'active',
    'draft'
);


ALTER TYPE public.price_list_status_enum OWNER TO postgres;

--
-- Name: price_list_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.price_list_type_enum AS ENUM (
    'sale',
    'override'
);


ALTER TYPE public.price_list_type_enum OWNER TO postgres;

--
-- Name: product_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.product_status_enum AS ENUM (
    'draft',
    'proposed',
    'published',
    'rejected'
);


ALTER TYPE public.product_status_enum OWNER TO postgres;

--
-- Name: refund_reason_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.refund_reason_enum AS ENUM (
    'discount',
    'return',
    'swap',
    'claim',
    'other'
);


ALTER TYPE public.refund_reason_enum OWNER TO postgres;

--
-- Name: return_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.return_status_enum AS ENUM (
    'requested',
    'received',
    'requires_action',
    'canceled'
);


ALTER TYPE public.return_status_enum OWNER TO postgres;

--
-- Name: shipping_option_price_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.shipping_option_price_type_enum AS ENUM (
    'flat_rate',
    'calculated'
);


ALTER TYPE public.shipping_option_price_type_enum OWNER TO postgres;

--
-- Name: shipping_option_requirement_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.shipping_option_requirement_type_enum AS ENUM (
    'min_subtotal',
    'max_subtotal'
);


ALTER TYPE public.shipping_option_requirement_type_enum OWNER TO postgres;

--
-- Name: shipping_profile_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.shipping_profile_type_enum AS ENUM (
    'default',
    'gift_card',
    'custom'
);


ALTER TYPE public.shipping_profile_type_enum OWNER TO postgres;

--
-- Name: swap_fulfillment_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.swap_fulfillment_status_enum AS ENUM (
    'not_fulfilled',
    'fulfilled',
    'shipped',
    'partially_shipped',
    'canceled',
    'requires_action'
);


ALTER TYPE public.swap_fulfillment_status_enum OWNER TO postgres;

--
-- Name: swap_payment_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.swap_payment_status_enum AS ENUM (
    'not_paid',
    'awaiting',
    'captured',
    'confirmed',
    'canceled',
    'difference_refunded',
    'partially_refunded',
    'refunded',
    'requires_action'
);


ALTER TYPE public.swap_payment_status_enum OWNER TO postgres;

--
-- Name: user_role_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_role_enum AS ENUM (
    'admin',
    'member',
    'developer'
);


ALTER TYPE public.user_role_enum OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.address (
    id character varying NOT NULL,
    customer_id character varying,
    company character varying,
    first_name character varying,
    last_name character varying,
    address_1 character varying,
    address_2 character varying,
    city character varying,
    country_code character varying,
    province character varying,
    postal_code character varying,
    phone character varying,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb,
    fees_id smallint,
    opening_days character varying,
    horary character varying,
    delivery_note_info character varying,
    invoice_info character varying,
    leads_info character varying,
    nif character varying,
    assigne character varying,
    company_activity character varying,
    cnae character varying,
    tags character varying,
    tradename character varying
);


ALTER TABLE public.address OWNER TO postgres;

--
-- Name: TABLE address; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.address IS 'NOMBRE Y APELLIDOS sale solo cuando es particular y cuando es empresa saldra NOMBRE FISCAL y se meterá en campo COMPANY';


--
-- Name: COLUMN address.fees_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.address.fees_id IS 'CUOTAS_ID';


--
-- Name: COLUMN address.delivery_note_info; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.address.delivery_note_info IS 'COMENTARIOS PREALBARAN';


--
-- Name: COLUMN address.invoice_info; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.address.invoice_info IS 'COMENTARIOS FACTURA';


--
-- Name: COLUMN address.leads_info; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.address.leads_info IS 'COMENTARIO AVISOS';


--
-- Name: analytics_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.analytics_config (
    id character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    user_id character varying NOT NULL,
    opt_out boolean DEFAULT false NOT NULL,
    anonymize boolean DEFAULT false NOT NULL
);


ALTER TABLE public.analytics_config OWNER TO postgres;

--
-- Name: batch_job; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.batch_job (
    id character varying NOT NULL,
    type text NOT NULL,
    created_by character varying,
    context jsonb,
    result jsonb,
    dry_run boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    pre_processed_at timestamp with time zone,
    confirmed_at timestamp with time zone,
    processing_at timestamp with time zone,
    completed_at timestamp with time zone,
    failed_at timestamp with time zone,
    canceled_at timestamp with time zone,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.batch_job OWNER TO postgres;

--
-- Name: cart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart (
    id character varying NOT NULL,
    email character varying,
    billing_address_id character varying,
    shipping_address_id character varying,
    region_id character varying NOT NULL,
    customer_id character varying,
    payment_id character varying,
    type public.cart_type_enum DEFAULT 'default'::public.cart_type_enum NOT NULL,
    completed_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb,
    idempotency_key character varying,
    context jsonb,
    payment_authorized_at timestamp with time zone,
    sales_channel_id character varying
);


ALTER TABLE public.cart OWNER TO postgres;

--
-- Name: cart_discounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_discounts (
    cart_id character varying NOT NULL,
    discount_id character varying NOT NULL
);


ALTER TABLE public.cart_discounts OWNER TO postgres;

--
-- Name: cart_gift_cards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_gift_cards (
    cart_id character varying NOT NULL,
    gift_card_id character varying NOT NULL
);


ALTER TABLE public.cart_gift_cards OWNER TO postgres;

--
-- Name: claim_image; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.claim_image (
    id character varying NOT NULL,
    claim_item_id character varying NOT NULL,
    url character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb
);


ALTER TABLE public.claim_image OWNER TO postgres;

--
-- Name: claim_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.claim_item (
    id character varying NOT NULL,
    claim_order_id character varying NOT NULL,
    item_id character varying NOT NULL,
    variant_id character varying NOT NULL,
    reason public.claim_item_reason_enum NOT NULL,
    note character varying,
    quantity integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb
);


ALTER TABLE public.claim_item OWNER TO postgres;

--
-- Name: claim_item_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.claim_item_tags (
    item_id character varying NOT NULL,
    tag_id character varying NOT NULL
);


ALTER TABLE public.claim_item_tags OWNER TO postgres;

--
-- Name: claim_order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.claim_order (
    id character varying NOT NULL,
    payment_status public.claim_order_payment_status_enum DEFAULT 'na'::public.claim_order_payment_status_enum NOT NULL,
    fulfillment_status public.claim_order_fulfillment_status_enum DEFAULT 'not_fulfilled'::public.claim_order_fulfillment_status_enum NOT NULL,
    type public.claim_order_type_enum NOT NULL,
    order_id character varying NOT NULL,
    shipping_address_id character varying,
    refund_amount integer,
    canceled_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb,
    idempotency_key character varying,
    no_notification boolean
);


ALTER TABLE public.claim_order OWNER TO postgres;

--
-- Name: claim_tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.claim_tag (
    id character varying NOT NULL,
    value character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb
);


ALTER TABLE public.claim_tag OWNER TO postgres;

--
-- Name: contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contacts (
    id smallint NOT NULL,
    name character varying,
    dni character varying,
    proffesion character varying,
    adress character varying,
    province character varying,
    city character varying,
    phone bigint,
    email character varying,
    email_notification character varying,
    note character varying
);


ALTER TABLE public.contacts OWNER TO postgres;

--
-- Name: TABLE contacts; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.contacts IS 'Hay una tabla NOTE. Ver para que sirve y usarla si es buena opcion';


--
-- Name: country; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.country (
    id integer NOT NULL,
    iso_2 character varying NOT NULL,
    iso_3 character varying NOT NULL,
    num_code integer NOT NULL,
    name character varying NOT NULL,
    display_name character varying NOT NULL,
    region_id character varying
);


ALTER TABLE public.country OWNER TO postgres;

--
-- Name: country_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.country_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.country_id_seq OWNER TO postgres;

--
-- Name: country_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.country_id_seq OWNED BY public.country.id;


--
-- Name: currency; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.currency (
    code character varying NOT NULL,
    symbol character varying NOT NULL,
    symbol_native character varying NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.currency OWNER TO postgres;

--
-- Name: custom_shipping_option; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.custom_shipping_option (
    id character varying NOT NULL,
    price integer NOT NULL,
    shipping_option_id character varying NOT NULL,
    cart_id character varying,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb
);


ALTER TABLE public.custom_shipping_option OWNER TO postgres;

--
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer (
    id character varying NOT NULL,
    email character varying NOT NULL,
    first_name character varying,
    last_name character varying,
    billing_address_id character varying,
    password_hash character varying,
    phone character varying,
    has_account boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb,
    re smallint,
    account_customer bigint,
    account_debtor bigint,
    is_company boolean,
    shipping_address_id character varying,
    note character varying
);


ALTER TABLE public.customer OWNER TO postgres;

--
-- Name: COLUMN customer.account_customer; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.customer.account_customer IS 'CUENTA CONTABLE CLIENTE';


--
-- Name: COLUMN customer.account_debtor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.customer.account_debtor IS 'CUENTA CONTABLE DEUDOR';


--
-- Name: COLUMN customer.is_company; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.customer.is_company IS 'marcado EMPRESA, desmarcado CLIENTE';


--
-- Name: COLUMN customer.shipping_address_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.customer.shipping_address_id IS 'No se si hace falta, ante la duda lo pongo';


--
-- Name: customer_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_group (
    id character varying NOT NULL,
    name character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb
);


ALTER TABLE public.customer_group OWNER TO postgres;

--
-- Name: customer_group_customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_group_customers (
    customer_group_id character varying NOT NULL,
    customer_id character varying NOT NULL
);


ALTER TABLE public.customer_group_customers OWNER TO postgres;

--
-- Name: customer_payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_payment (
    id character varying NOT NULL,
    customer_id character varying,
    payment_method character varying,
    payday character varying,
    bank_name character varying,
    bank_country character varying,
    currency_code character varying,
    iban character varying,
    swift character varying
);


ALTER TABLE public.customer_payment OWNER TO postgres;

--
-- Name: discount; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discount (
    id character varying NOT NULL,
    code character varying NOT NULL,
    is_dynamic boolean NOT NULL,
    rule_id character varying,
    is_disabled boolean NOT NULL,
    parent_discount_id character varying,
    starts_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ends_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb,
    usage_limit integer,
    usage_count integer DEFAULT 0 NOT NULL,
    valid_duration character varying
);


ALTER TABLE public.discount OWNER TO postgres;

--
-- Name: discount_condition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discount_condition (
    id character varying NOT NULL,
    type public.discount_condition_type_enum NOT NULL,
    operator public.discount_condition_operator_enum NOT NULL,
    discount_rule_id character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb
);


ALTER TABLE public.discount_condition OWNER TO postgres;

--
-- Name: discount_condition_customer_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discount_condition_customer_group (
    customer_group_id character varying NOT NULL,
    condition_id character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    metadata jsonb
);


ALTER TABLE public.discount_condition_customer_group OWNER TO postgres;

--
-- Name: discount_condition_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discount_condition_product (
    product_id character varying NOT NULL,
    condition_id character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    metadata jsonb
);


ALTER TABLE public.discount_condition_product OWNER TO postgres;

--
-- Name: discount_condition_product_collection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discount_condition_product_collection (
    product_collection_id character varying NOT NULL,
    condition_id character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    metadata jsonb
);


ALTER TABLE public.discount_condition_product_collection OWNER TO postgres;

--
-- Name: discount_condition_product_tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discount_condition_product_tag (
    product_tag_id character varying NOT NULL,
    condition_id character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    metadata jsonb
);


ALTER TABLE public.discount_condition_product_tag OWNER TO postgres;

--
-- Name: discount_condition_product_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discount_condition_product_type (
    product_type_id character varying NOT NULL,
    condition_id character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    metadata jsonb
);


ALTER TABLE public.discount_condition_product_type OWNER TO postgres;

--
-- Name: discount_regions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discount_regions (
    discount_id character varying NOT NULL,
    region_id character varying NOT NULL
);


ALTER TABLE public.discount_regions OWNER TO postgres;

--
-- Name: discount_rule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discount_rule (
    id character varying NOT NULL,
    description character varying,
    type public.discount_rule_type_enum NOT NULL,
    value integer NOT NULL,
    allocation public.discount_rule_allocation_enum,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb
);


ALTER TABLE public.discount_rule OWNER TO postgres;

--
-- Name: discount_rule_products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discount_rule_products (
    discount_rule_id character varying NOT NULL,
    product_id character varying NOT NULL
);


ALTER TABLE public.discount_rule_products OWNER TO postgres;

--
-- Name: draft_order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.draft_order (
    id character varying NOT NULL,
    status public.draft_order_status_enum DEFAULT 'open'::public.draft_order_status_enum NOT NULL,
    display_id integer NOT NULL,
    cart_id character varying,
    order_id character varying,
    canceled_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    completed_at timestamp with time zone,
    metadata jsonb,
    idempotency_key character varying,
    no_notification_order boolean
);


ALTER TABLE public.draft_order OWNER TO postgres;

--
-- Name: draft_order_display_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.draft_order_display_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.draft_order_display_id_seq OWNER TO postgres;

--
-- Name: draft_order_display_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.draft_order_display_id_seq OWNED BY public.draft_order.display_id;


--
-- Name: fulfillment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fulfillment (
    id character varying NOT NULL,
    swap_id character varying,
    order_id character varying,
    tracking_numbers jsonb DEFAULT '[]'::jsonb NOT NULL,
    data jsonb NOT NULL,
    shipped_at timestamp with time zone,
    canceled_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    metadata jsonb,
    idempotency_key character varying,
    provider_id character varying,
    claim_order_id character varying,
    no_notification boolean,
    location_id character varying
);


ALTER TABLE public.fulfillment OWNER TO postgres;

--
-- Name: fulfillment_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fulfillment_item (
    fulfillment_id character varying NOT NULL,
    item_id character varying NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public.fulfillment_item OWNER TO postgres;

--
-- Name: fulfillment_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fulfillment_provider (
    id character varying NOT NULL,
    is_installed boolean DEFAULT true NOT NULL
);


ALTER TABLE public.fulfillment_provider OWNER TO postgres;

--
-- Name: gift_card; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gift_card (
    id character varying NOT NULL,
    code character varying NOT NULL,
    value integer NOT NULL,
    balance integer NOT NULL,
    region_id character varying NOT NULL,
    order_id character varying,
    is_disabled boolean DEFAULT false NOT NULL,
    ends_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb,
    tax_rate real
);


ALTER TABLE public.gift_card OWNER TO postgres;

--
-- Name: gift_card_transaction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gift_card_transaction (
    id character varying NOT NULL,
    gift_card_id character varying NOT NULL,
    order_id character varying NOT NULL,
    amount integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    is_taxable boolean,
    tax_rate real
);


ALTER TABLE public.gift_card_transaction OWNER TO postgres;

--
-- Name: idempotency_key; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idempotency_key (
    id character varying NOT NULL,
    idempotency_key character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    locked_at timestamp with time zone,
    request_method character varying,
    request_params jsonb,
    request_path character varying,
    response_code integer,
    response_body jsonb,
    recovery_point character varying DEFAULT 'started'::character varying NOT NULL
);


ALTER TABLE public.idempotency_key OWNER TO postgres;

--
-- Name: image; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.image (
    id character varying NOT NULL,
    url character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb
);


ALTER TABLE public.image OWNER TO postgres;

--
-- Name: invite; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invite (
    id character varying NOT NULL,
    user_email character varying NOT NULL,
    role public.invite_role_enum DEFAULT 'member'::public.invite_role_enum,
    accepted boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb,
    token character varying NOT NULL,
    expires_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.invite OWNER TO postgres;

--
-- Name: line_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.line_item (
    id character varying NOT NULL,
    cart_id character varying,
    order_id character varying,
    swap_id character varying,
    title character varying NOT NULL,
    description character varying,
    thumbnail character varying,
    is_giftcard boolean DEFAULT false NOT NULL,
    should_merge boolean DEFAULT true NOT NULL,
    allow_discounts boolean DEFAULT true NOT NULL,
    has_shipping boolean,
    unit_price integer NOT NULL,
    variant_id character varying,
    quantity integer NOT NULL,
    fulfilled_quantity integer,
    returned_quantity integer,
    shipped_quantity integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    metadata jsonb,
    claim_order_id character varying,
    is_return boolean DEFAULT false NOT NULL,
    original_item_id character varying,
    order_edit_id character varying,
    CONSTRAINT "CHK_0cd85e15610d11b553d5e8fda6" CHECK ((shipped_quantity <= fulfilled_quantity)),
    CONSTRAINT "CHK_64eef00a5064887634f1680866" CHECK ((quantity > 0)),
    CONSTRAINT "CHK_91f40396d847f6ecfd9f752bf8" CHECK ((returned_quantity <= quantity)),
    CONSTRAINT "CHK_c61716c68f5ad5de2834c827d3" CHECK ((fulfilled_quantity <= quantity))
);


ALTER TABLE public.line_item OWNER TO postgres;

--
-- Name: line_item_adjustment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.line_item_adjustment (
    id character varying NOT NULL,
    item_id character varying NOT NULL,
    description character varying NOT NULL,
    discount_id character varying,
    amount numeric NOT NULL,
    metadata jsonb
);


ALTER TABLE public.line_item_adjustment OWNER TO postgres;

--
-- Name: line_item_tax_line; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.line_item_tax_line (
    id character varying NOT NULL,
    rate real NOT NULL,
    name character varying NOT NULL,
    code character varying,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    metadata jsonb,
    item_id character varying NOT NULL
);


ALTER TABLE public.line_item_tax_line OWNER TO postgres;

--
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    "timestamp" bigint NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: money_amount; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.money_amount (
    id character varying NOT NULL,
    currency_code character varying NOT NULL,
    amount integer NOT NULL,
    region_id character varying,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    min_quantity integer,
    max_quantity integer,
    price_list_id character varying
);


ALTER TABLE public.money_amount OWNER TO postgres;

--
-- Name: note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.note (
    id character varying NOT NULL,
    value character varying NOT NULL,
    resource_type character varying NOT NULL,
    resource_id character varying NOT NULL,
    author_id character varying,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb
);


ALTER TABLE public.note OWNER TO postgres;

--
-- Name: notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification (
    id character varying NOT NULL,
    event_name character varying,
    resource_type character varying NOT NULL,
    resource_id character varying NOT NULL,
    customer_id character varying,
    "to" character varying NOT NULL,
    data jsonb NOT NULL,
    parent_id character varying,
    provider_id character varying,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.notification OWNER TO postgres;

--
-- Name: notification_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification_provider (
    id character varying NOT NULL,
    is_installed boolean DEFAULT true NOT NULL
);


ALTER TABLE public.notification_provider OWNER TO postgres;

--
-- Name: oauth; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth (
    id character varying NOT NULL,
    display_name character varying NOT NULL,
    application_name character varying NOT NULL,
    install_url character varying,
    uninstall_url character varying,
    data jsonb
);


ALTER TABLE public.oauth OWNER TO postgres;

--
-- Name: order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."order" (
    id character varying NOT NULL,
    status public.order_status_enum DEFAULT 'pending'::public.order_status_enum NOT NULL,
    fulfillment_status public.order_fulfillment_status_enum DEFAULT 'not_fulfilled'::public.order_fulfillment_status_enum NOT NULL,
    payment_status public.order_payment_status_enum DEFAULT 'not_paid'::public.order_payment_status_enum NOT NULL,
    display_id integer NOT NULL,
    cart_id character varying,
    customer_id character varying NOT NULL,
    email character varying NOT NULL,
    billing_address_id character varying,
    shipping_address_id character varying,
    region_id character varying NOT NULL,
    currency_code character varying NOT NULL,
    tax_rate real,
    canceled_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    metadata jsonb,
    idempotency_key character varying,
    draft_order_id character varying,
    no_notification boolean,
    external_id character varying,
    sales_channel_id character varying
);


ALTER TABLE public."order" OWNER TO postgres;

--
-- Name: order_discounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_discounts (
    order_id character varying NOT NULL,
    discount_id character varying NOT NULL
);


ALTER TABLE public.order_discounts OWNER TO postgres;

--
-- Name: order_display_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_display_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_display_id_seq OWNER TO postgres;

--
-- Name: order_display_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_display_id_seq OWNED BY public."order".display_id;


--
-- Name: order_edit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_edit (
    id character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    order_id character varying NOT NULL,
    internal_note character varying,
    created_by character varying NOT NULL,
    requested_by character varying,
    requested_at timestamp with time zone,
    confirmed_by character varying,
    confirmed_at timestamp with time zone,
    declined_by character varying,
    declined_reason character varying,
    declined_at timestamp with time zone,
    canceled_by character varying,
    canceled_at timestamp with time zone,
    payment_collection_id character varying
);


ALTER TABLE public.order_edit OWNER TO postgres;

--
-- Name: order_gift_cards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_gift_cards (
    order_id character varying NOT NULL,
    gift_card_id character varying NOT NULL
);


ALTER TABLE public.order_gift_cards OWNER TO postgres;

--
-- Name: order_item_change; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_item_change (
    id character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    type public.order_item_change_type_enum NOT NULL,
    order_edit_id character varying NOT NULL,
    original_line_item_id character varying,
    line_item_id character varying
);


ALTER TABLE public.order_item_change OWNER TO postgres;

--
-- Name: payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment (
    id character varying NOT NULL,
    swap_id character varying,
    cart_id character varying,
    order_id character varying,
    amount integer NOT NULL,
    currency_code character varying NOT NULL,
    amount_refunded integer DEFAULT 0 NOT NULL,
    provider_id character varying NOT NULL,
    data jsonb NOT NULL,
    captured_at timestamp with time zone,
    canceled_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    metadata jsonb,
    idempotency_key character varying
);


ALTER TABLE public.payment OWNER TO postgres;

--
-- Name: payment_collection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_collection (
    id character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    type public."PAYMENT_COLLECTION_TYPE_ENUM" NOT NULL,
    status public."PAYMENT_COLLECTION_STATUS_ENUM" NOT NULL,
    description text,
    amount integer NOT NULL,
    authorized_amount integer,
    region_id character varying NOT NULL,
    currency_code character varying NOT NULL,
    metadata jsonb,
    created_by character varying NOT NULL
);


ALTER TABLE public.payment_collection OWNER TO postgres;

--
-- Name: payment_collection_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_collection_payments (
    payment_collection_id character varying NOT NULL,
    payment_id character varying NOT NULL
);


ALTER TABLE public.payment_collection_payments OWNER TO postgres;

--
-- Name: payment_collection_sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_collection_sessions (
    payment_collection_id character varying NOT NULL,
    payment_session_id character varying NOT NULL
);


ALTER TABLE public.payment_collection_sessions OWNER TO postgres;

--
-- Name: payment_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_provider (
    id character varying NOT NULL,
    is_installed boolean DEFAULT true NOT NULL
);


ALTER TABLE public.payment_provider OWNER TO postgres;

--
-- Name: payment_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_session (
    id character varying NOT NULL,
    cart_id character varying,
    provider_id character varying NOT NULL,
    is_selected boolean,
    status public.payment_session_status_enum NOT NULL,
    data jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    idempotency_key character varying,
    payment_authorized_at timestamp with time zone,
    amount integer,
    is_initiated boolean DEFAULT false NOT NULL
);


ALTER TABLE public.payment_session OWNER TO postgres;

--
-- Name: price_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.price_list (
    id character varying NOT NULL,
    name character varying NOT NULL,
    description character varying NOT NULL,
    type public.price_list_type_enum DEFAULT 'sale'::public.price_list_type_enum NOT NULL,
    status public.price_list_status_enum DEFAULT 'draft'::public.price_list_status_enum NOT NULL,
    starts_at timestamp with time zone,
    ends_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.price_list OWNER TO postgres;

--
-- Name: price_list_customer_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.price_list_customer_groups (
    price_list_id character varying NOT NULL,
    customer_group_id character varying NOT NULL
);


ALTER TABLE public.price_list_customer_groups OWNER TO postgres;

--
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    id character varying NOT NULL,
    title character varying NOT NULL,
    subtitle character varying,
    description character varying,
    handle character varying,
    is_giftcard boolean DEFAULT false NOT NULL,
    thumbnail character varying,
    weight integer,
    length integer,
    height integer,
    width integer,
    hs_code character varying,
    origin_country character varying,
    mid_code character varying,
    material character varying,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb,
    collection_id character varying,
    type_id character varying,
    discountable boolean DEFAULT true NOT NULL,
    status public.product_status_enum DEFAULT 'draft'::public.product_status_enum NOT NULL,
    external_id character varying
);


ALTER TABLE public.product OWNER TO postgres;

--
-- Name: product_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_category (
    id character varying NOT NULL,
    name text NOT NULL,
    handle text NOT NULL,
    parent_category_id character varying,
    mpath text,
    is_active boolean DEFAULT false,
    is_internal boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    rank integer DEFAULT 0 NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    metadata jsonb,
    CONSTRAINT product_category_rank_check CHECK ((rank >= 0))
);


ALTER TABLE public.product_category OWNER TO postgres;

--
-- Name: product_category_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_category_product (
    product_category_id character varying NOT NULL,
    product_id character varying NOT NULL
);


ALTER TABLE public.product_category_product OWNER TO postgres;

--
-- Name: product_collection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_collection (
    id character varying NOT NULL,
    title character varying NOT NULL,
    handle character varying,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb
);


ALTER TABLE public.product_collection OWNER TO postgres;

--
-- Name: product_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_images (
    product_id character varying NOT NULL,
    image_id character varying NOT NULL
);


ALTER TABLE public.product_images OWNER TO postgres;

--
-- Name: product_option; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_option (
    id character varying NOT NULL,
    title character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb,
    product_id character varying
);


ALTER TABLE public.product_option OWNER TO postgres;

--
-- Name: product_option_value; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_option_value (
    id character varying NOT NULL,
    value character varying NOT NULL,
    option_id character varying NOT NULL,
    variant_id character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb
);


ALTER TABLE public.product_option_value OWNER TO postgres;

--
-- Name: product_sales_channel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_sales_channel (
    product_id character varying NOT NULL,
    sales_channel_id character varying NOT NULL
);


ALTER TABLE public.product_sales_channel OWNER TO postgres;

--
-- Name: product_shipping_profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_shipping_profile (
    profile_id text NOT NULL,
    product_id text NOT NULL
);


ALTER TABLE public.product_shipping_profile OWNER TO postgres;

--
-- Name: product_tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_tag (
    id character varying NOT NULL,
    value character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb
);


ALTER TABLE public.product_tag OWNER TO postgres;

--
-- Name: product_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_tags (
    product_id character varying NOT NULL,
    product_tag_id character varying NOT NULL
);


ALTER TABLE public.product_tags OWNER TO postgres;

--
-- Name: product_tax_rate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_tax_rate (
    product_id character varying NOT NULL,
    rate_id character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    metadata jsonb
);


ALTER TABLE public.product_tax_rate OWNER TO postgres;

--
-- Name: product_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_type (
    id character varying NOT NULL,
    value character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb
);


ALTER TABLE public.product_type OWNER TO postgres;

--
-- Name: product_type_tax_rate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_type_tax_rate (
    product_type_id character varying NOT NULL,
    rate_id character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    metadata jsonb
);


ALTER TABLE public.product_type_tax_rate OWNER TO postgres;

--
-- Name: product_variant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_variant (
    id character varying NOT NULL,
    title character varying NOT NULL,
    product_id character varying NOT NULL,
    sku character varying,
    barcode character varying,
    ean character varying,
    upc character varying,
    inventory_quantity integer NOT NULL,
    allow_backorder boolean DEFAULT false NOT NULL,
    manage_inventory boolean DEFAULT true NOT NULL,
    hs_code character varying,
    origin_country character varying,
    mid_code character varying,
    material character varying,
    weight integer,
    length integer,
    height integer,
    width integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb,
    variant_rank integer DEFAULT 0
);


ALTER TABLE public.product_variant OWNER TO postgres;

--
-- Name: product_variant_inventory_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_variant_inventory_item (
    id character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    inventory_item_id text NOT NULL,
    variant_id text NOT NULL,
    required_quantity integer DEFAULT 1 NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.product_variant_inventory_item OWNER TO postgres;

--
-- Name: product_variant_money_amount; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_variant_money_amount (
    id character varying NOT NULL,
    money_amount_id text NOT NULL,
    variant_id text NOT NULL,
    deleted_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.product_variant_money_amount OWNER TO postgres;

--
-- Name: provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provider (
    id bigint NOT NULL,
    provider_payment_id character varying,
    customer_id character varying,
    ambit_operations_id character varying,
    account_iva character varying,
    account_irpf character varying,
    account_provider character varying,
    account_creditor character varying
);


ALTER TABLE public.provider OWNER TO postgres;

--
-- Name: TABLE provider; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.provider IS 'account_creditor es cuenta contable acreedor (puesto mal en la que yo hice diseño, puse deudor)';


--
-- Name: provider_payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provider_payment (
    id character varying NOT NULL,
    provider_id character varying,
    payment_method character varying,
    payday character varying,
    bank_name character varying,
    bank_country character varying,
    currency_code character varying,
    iban character varying,
    swift character varying
);


ALTER TABLE public.provider_payment OWNER TO postgres;

--
-- Name: publishable_api_key; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.publishable_api_key (
    id character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by character varying,
    revoked_by character varying,
    revoked_at timestamp with time zone,
    title character varying NOT NULL
);


ALTER TABLE public.publishable_api_key OWNER TO postgres;

--
-- Name: publishable_api_key_sales_channel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.publishable_api_key_sales_channel (
    sales_channel_id character varying NOT NULL,
    publishable_key_id character varying NOT NULL
);


ALTER TABLE public.publishable_api_key_sales_channel OWNER TO postgres;

--
-- Name: refund; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.refund (
    id character varying NOT NULL,
    order_id character varying,
    amount integer NOT NULL,
    note character varying,
    reason public.refund_reason_enum NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    metadata jsonb,
    idempotency_key character varying,
    payment_id character varying
);


ALTER TABLE public.refund OWNER TO postgres;

--
-- Name: region; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.region (
    id character varying NOT NULL,
    name character varying NOT NULL,
    currency_code character varying NOT NULL,
    tax_rate real NOT NULL,
    tax_code character varying,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb,
    gift_cards_taxable boolean DEFAULT true NOT NULL,
    automatic_taxes boolean DEFAULT true NOT NULL,
    tax_provider_id character varying
);


ALTER TABLE public.region OWNER TO postgres;

--
-- Name: region_fulfillment_providers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.region_fulfillment_providers (
    region_id character varying NOT NULL,
    provider_id character varying NOT NULL
);


ALTER TABLE public.region_fulfillment_providers OWNER TO postgres;

--
-- Name: region_payment_providers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.region_payment_providers (
    region_id character varying NOT NULL,
    provider_id character varying NOT NULL
);


ALTER TABLE public.region_payment_providers OWNER TO postgres;

--
-- Name: return; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.return (
    id character varying NOT NULL,
    status public.return_status_enum DEFAULT 'requested'::public.return_status_enum NOT NULL,
    swap_id character varying,
    order_id character varying,
    shipping_data jsonb,
    refund_amount integer NOT NULL,
    received_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    metadata jsonb,
    idempotency_key character varying,
    claim_order_id character varying,
    no_notification boolean,
    location_id character varying
);


ALTER TABLE public.return OWNER TO postgres;

--
-- Name: return_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.return_item (
    return_id character varying NOT NULL,
    item_id character varying NOT NULL,
    quantity integer NOT NULL,
    is_requested boolean DEFAULT true NOT NULL,
    requested_quantity integer,
    received_quantity integer,
    metadata jsonb,
    reason_id character varying,
    note character varying
);


ALTER TABLE public.return_item OWNER TO postgres;

--
-- Name: return_reason; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.return_reason (
    id character varying NOT NULL,
    value character varying NOT NULL,
    label character varying NOT NULL,
    description character varying,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb,
    parent_return_reason_id character varying
);


ALTER TABLE public.return_reason OWNER TO postgres;

--
-- Name: sales_channel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales_channel (
    id character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    name character varying NOT NULL,
    description character varying,
    is_disabled boolean DEFAULT false NOT NULL,
    metadata jsonb
);


ALTER TABLE public.sales_channel OWNER TO postgres;

--
-- Name: sales_channel_location; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales_channel_location (
    id character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    sales_channel_id text NOT NULL,
    location_id text NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.sales_channel_location OWNER TO postgres;

--
-- Name: shipping_method; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipping_method (
    id character varying NOT NULL,
    shipping_option_id character varying NOT NULL,
    order_id character varying,
    cart_id character varying,
    swap_id character varying,
    return_id character varying,
    price integer NOT NULL,
    data jsonb NOT NULL,
    claim_order_id character varying,
    CONSTRAINT "CHK_64c6812fe7815be30d688df513" CHECK ((price >= 0)),
    CONSTRAINT "CHK_a7020b08665bbd64d84a6641cf" CHECK (((claim_order_id IS NOT NULL) OR (order_id IS NOT NULL) OR (cart_id IS NOT NULL) OR (swap_id IS NOT NULL) OR (return_id IS NOT NULL)))
);


ALTER TABLE public.shipping_method OWNER TO postgres;

--
-- Name: shipping_method_tax_line; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipping_method_tax_line (
    id character varying NOT NULL,
    rate real NOT NULL,
    name character varying NOT NULL,
    code character varying,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    metadata jsonb,
    shipping_method_id character varying NOT NULL
);


ALTER TABLE public.shipping_method_tax_line OWNER TO postgres;

--
-- Name: shipping_option; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipping_option (
    id character varying NOT NULL,
    name character varying NOT NULL,
    region_id character varying NOT NULL,
    profile_id character varying NOT NULL,
    provider_id character varying NOT NULL,
    price_type public.shipping_option_price_type_enum NOT NULL,
    amount integer,
    is_return boolean DEFAULT false NOT NULL,
    data jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb,
    admin_only boolean DEFAULT false NOT NULL,
    CONSTRAINT "CHK_7a367f5901ae0a5b0df75aee38" CHECK ((amount >= 0))
);


ALTER TABLE public.shipping_option OWNER TO postgres;

--
-- Name: shipping_option_requirement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipping_option_requirement (
    id character varying NOT NULL,
    shipping_option_id character varying NOT NULL,
    type public.shipping_option_requirement_type_enum NOT NULL,
    amount integer NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.shipping_option_requirement OWNER TO postgres;

--
-- Name: shipping_profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipping_profile (
    id character varying NOT NULL,
    name character varying NOT NULL,
    type public.shipping_profile_type_enum NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb
);


ALTER TABLE public.shipping_profile OWNER TO postgres;

--
-- Name: shipping_tax_rate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipping_tax_rate (
    shipping_option_id character varying NOT NULL,
    rate_id character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    metadata jsonb
);


ALTER TABLE public.shipping_tax_rate OWNER TO postgres;

--
-- Name: staged_job; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.staged_job (
    id character varying NOT NULL,
    event_name character varying NOT NULL,
    data jsonb NOT NULL,
    options jsonb DEFAULT '{}'::jsonb NOT NULL
);


ALTER TABLE public.staged_job OWNER TO postgres;

--
-- Name: store; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store (
    id character varying NOT NULL,
    name character varying DEFAULT 'Medusa Store'::character varying NOT NULL,
    default_currency_code character varying DEFAULT 'usd'::character varying NOT NULL,
    swap_link_template character varying,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    metadata jsonb,
    payment_link_template character varying,
    invite_link_template character varying,
    default_sales_channel_id character varying,
    default_location_id character varying
);


ALTER TABLE public.store OWNER TO postgres;

--
-- Name: store_currencies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_currencies (
    store_id character varying NOT NULL,
    currency_code character varying NOT NULL
);


ALTER TABLE public.store_currencies OWNER TO postgres;

--
-- Name: swap; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.swap (
    id character varying NOT NULL,
    fulfillment_status public.swap_fulfillment_status_enum NOT NULL,
    payment_status public.swap_payment_status_enum NOT NULL,
    order_id character varying NOT NULL,
    difference_due integer,
    shipping_address_id character varying,
    cart_id character varying,
    confirmed_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb,
    idempotency_key character varying,
    no_notification boolean,
    canceled_at timestamp with time zone,
    allow_backorder boolean DEFAULT false NOT NULL
);


ALTER TABLE public.swap OWNER TO postgres;

--
-- Name: tax_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tax_provider (
    id character varying NOT NULL,
    is_installed boolean DEFAULT true NOT NULL
);


ALTER TABLE public.tax_provider OWNER TO postgres;

--
-- Name: tax_rate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tax_rate (
    id character varying NOT NULL,
    rate real,
    code character varying,
    name character varying NOT NULL,
    region_id character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    metadata jsonb
);


ALTER TABLE public.tax_rate OWNER TO postgres;

--
-- Name: tracking_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tracking_link (
    id character varying NOT NULL,
    url character varying,
    tracking_number character varying NOT NULL,
    fulfillment_id character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb,
    idempotency_key character varying
);


ALTER TABLE public.tracking_link OWNER TO postgres;

--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id character varying NOT NULL,
    email character varying NOT NULL,
    first_name character varying,
    last_name character varying,
    password_hash character varying,
    api_token character varying,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    metadata jsonb,
    role public.user_role_enum DEFAULT 'member'::public.user_role_enum
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: country id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country ALTER COLUMN id SET DEFAULT nextval('public.country_id_seq'::regclass);


--
-- Name: draft_order display_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.draft_order ALTER COLUMN display_id SET DEFAULT nextval('public.draft_order_display_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: order display_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order" ALTER COLUMN display_id SET DEFAULT nextval('public.order_display_id_seq'::regclass);


--
-- Data for Name: address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.address (id, customer_id, company, first_name, last_name, address_1, address_2, city, country_code, province, postal_code, phone, created_at, updated_at, deleted_at, metadata, fees_id, opening_days, horary, delivery_note_info, invoice_info, leads_info, nif, assigne, company_activity, cnae, tags, tradename) FROM stdin;
addr_01HKEGDKZA9255B9KFMTQWACF9	\N		Douglas	Montoya	Vidalguia ll		Valle de la pascua	es	Guárico	2350	\N	2024-01-06 04:27:40.388179+00	2024-01-06 04:27:40.388179+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
addr_01HKEEXM20VE433YHRTKT9QQQ2	\N		Douglas	Montoya	Vidalguia ll		Valle de la pascua	us	Guárico	2350		2024-01-06 04:01:27.571212+00	2024-01-06 04:28:26.934851+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
addr_01HKEGF1FZR4MJFBJ7GS2P84MD	\N		Douglas	Montoya	Vidalguia ll		Valle de la pascua	us	Guárico	2350		2024-01-06 04:28:26.934851+00	2024-01-06 04:28:26.934851+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
addr_01HMW49E72FA6SNQSA419ZQKZ7	cus_01HMW47S2TZFRTFAS9Q37XY7XK	Nombre Empresa	cli 1	ap 1	dir 1		Elch	es	Ali	03001	67544223	2024-01-23 21:40:44.373824+00	2024-01-23 21:40:44.373824+00	\N	{}	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
addr_01HMW4AVN26N1BESDH2TW291MY	cus_01HMW47S2TZFRTFAS9Q37XY7XK	empr 1 segund dir	cli 1	ap1	di1 segun		Jav	es	Val	05422	645566	2024-01-23 21:41:30.906552+00	2024-01-23 21:41:30.906552+00	\N	{}	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
addr_01HMW4BT8MCXZX691BPFHZ9KYT	\N	empr 1 segund dir	cli 1	ap1	kkkkk	\N	Jav	es	Val	05421	645566	2024-01-23 21:42:02.193502+00	2024-01-31 10:27:50.514643+00	\N	{}	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
addr_01HMW4BT8N0KS5SZ10XCZZ5ATK	\N	empr 1 segund dir222	cli 1	ap1	di1 segun	\N	Jav	es	Val	05422	645566	2024-01-23 21:42:02.193502+00	2024-01-31 10:27:55.977049+00	\N	{}	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
addr_01HNFMPR5BMKEJ8YH9JQDJXB1A	\N		dsds	dsds	dsdsds		aaaa	es	aaaa	03001		2024-01-31 11:33:11.91918+00	2024-01-31 11:33:11.91918+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
addr_01HNFMPR5BC7K9JFZZHF91DB3E	\N		dsds	dsds	dsdsds		aaaa	es	aaaa	03001		2024-01-31 11:33:11.91918+00	2024-01-31 11:33:11.91918+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
addr_01HNFV9ZYSDCZXP7NY5SV1K4MY	\N		ass	wee	adresssss		aas	it		03001		2024-01-31 13:28:33.943662+00	2024-01-31 13:28:33.943662+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
addr_01HNFV9ZYT651QTZV9TQ7T76Y0	\N		ass	wee	adresssss		aas	it		03001		2024-01-31 13:28:33.943662+00	2024-01-31 13:28:33.943662+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
addr_01HNFVGP6PCR5MFB7CM108Z0DV	cus_01HNFV8Q3BCE5MM80HQJ8AKAZC	gf	c	gfgf	gfffg		ffddf	se		34444		2024-01-31 13:32:13.392688+00	2024-01-31 13:32:13.392688+00	\N	{}	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
addr_01HNFVH37Z4A1KF333WHJ5PDE8	cus_01HNFV8Q3BCE5MM80HQJ8AKAZC		df	dfdf	dfdfdf		sss	de		3333		2024-01-31 13:32:26.745826+00	2024-01-31 13:32:26.745826+00	\N	{}	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: analytics_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.analytics_config (id, created_at, updated_at, deleted_at, user_id, opt_out, anonymize) FROM stdin;
acfg_01HJQ66K9KECYYNXEP1TD4XY5V	2023-12-28 03:06:32.62622+00	2023-12-28 03:06:32.62622+00	\N	usr_01HJQ657D3JKGCCVVCE4ZG170M	f	f
\.


--
-- Data for Name: batch_job; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.batch_job (id, type, created_by, context, result, dry_run, created_at, pre_processed_at, confirmed_at, processing_at, completed_at, failed_at, canceled_at, updated_at, deleted_at) FROM stdin;
batch_01HMW3RSSCXWX58CEZQN0KR560	product-export	usr_01HJQ657D3JKGCCVVCE4ZG170M	{"shape": {"prices": [{"region": null, "currency_code": "eur"}, {"region": null, "currency_code": "usd"}], "dynamicImageColumnCount": 4, "dynamicOptionColumnCount": 2, "dynamicSalesChannelsColumnCount": 1, "dynamicProductCategoriesColumnCount": 0}, "list_config": {"skip": 0, "take": 50, "order": {"created_at": "DESC"}, "relations": ["collection", "images", "options", "profiles", "sales_channels", "sales_channels", "tags", "type", "variants", "variants.options", "variants.prices", "variants.prices.region"]}}	{"errors": [{"err": {"date": "2024-01-23T21:31:42.799Z", "type": "unexpected_state", "message": "Private bucket is not configured"}, "code": "unknown", "message": "Private bucket is not configured"}, "Private bucket is not configured"], "stat_descriptors": [{"key": "product-export-count", "name": "Product count to export", "message": "There will be 8 products exported by this action"}]}	f	2024-01-23 21:31:39.174458+00	2024-01-23 21:31:39.849+00	2024-01-23 21:31:39.854+00	\N	\N	2024-01-23 21:31:42.818+00	\N	2024-01-23 21:31:42.814214+00	\N
batch_01HMW3T6Y74KS3C7D25R02MDCV	product-export	usr_01HJQ657D3JKGCCVVCE4ZG170M	{"shape": {"prices": [{"region": null, "currency_code": "eur"}, {"region": null, "currency_code": "usd"}], "dynamicImageColumnCount": 4, "dynamicOptionColumnCount": 2, "dynamicSalesChannelsColumnCount": 1, "dynamicProductCategoriesColumnCount": 0}, "list_config": {"skip": 0, "take": 50, "order": {"created_at": "DESC"}, "relations": ["collection", "images", "options", "profiles", "sales_channels", "sales_channels", "tags", "type", "variants", "variants.options", "variants.prices", "variants.prices.region"]}}	{"errors": [{"err": {"date": "2024-01-23T21:32:30.877Z", "type": "unexpected_state", "message": "Private bucket is not configured"}, "code": "unknown", "message": "Private bucket is not configured"}, "Private bucket is not configured"], "stat_descriptors": [{"key": "product-export-count", "name": "Product count to export", "message": "There will be 8 products exported by this action"}]}	f	2024-01-23 21:32:25.414758+00	2024-01-23 21:32:27.925+00	2024-01-23 21:32:27.93+00	\N	\N	2024-01-23 21:32:30.893+00	\N	2024-01-23 21:32:30.889098+00	\N
batch_01HMW3SFRCSSK2DTNX8NC0ESAD	product-export	usr_01HJQ657D3JKGCCVVCE4ZG170M	{"shape": {"prices": [{"region": null, "currency_code": "eur"}, {"region": null, "currency_code": "usd"}], "dynamicImageColumnCount": 4, "dynamicOptionColumnCount": 2, "dynamicSalesChannelsColumnCount": 1, "dynamicProductCategoriesColumnCount": 0}, "list_config": {"skip": 0, "take": 50, "order": {"created_at": "DESC"}, "relations": ["collection", "images", "options", "profiles", "sales_channels", "sales_channels", "tags", "type", "variants", "variants.options", "variants.prices", "variants.prices.region"]}}	{"errors": [{"err": {"date": "2024-01-23T21:32:06.843Z", "type": "unexpected_state", "message": "Private bucket is not configured"}, "code": "unknown", "message": "Private bucket is not configured"}, "Private bucket is not configured"], "stat_descriptors": [{"key": "product-export-count", "name": "Product count to export", "message": "There will be 8 products exported by this action"}]}	f	2024-01-23 21:32:01.674905+00	2024-01-23 21:32:03.877+00	2024-01-23 21:32:03.881+00	\N	\N	2024-01-23 21:32:06.862+00	\N	2024-01-23 21:32:06.856263+00	\N
batch_01HMW3TMWVC4C9A5CTRV3X0QA4	product-export	usr_01HJQ657D3JKGCCVVCE4ZG170M	{"shape": {"prices": [{"region": null, "currency_code": "eur"}, {"region": null, "currency_code": "usd"}], "dynamicImageColumnCount": 4, "dynamicOptionColumnCount": 2, "dynamicSalesChannelsColumnCount": 1, "dynamicProductCategoriesColumnCount": 0}, "list_config": {"skip": 0, "take": 50, "order": {"created_at": "DESC"}, "relations": ["collection", "images", "options", "profiles", "sales_channels", "sales_channels", "tags", "type", "variants", "variants.options", "variants.prices", "variants.prices.region"]}}	{"errors": [{"err": {"date": "2024-01-23T21:32:42.913Z", "type": "unexpected_state", "message": "Private bucket is not configured"}, "code": "unknown", "message": "Private bucket is not configured"}, "Private bucket is not configured"], "stat_descriptors": [{"key": "product-export-count", "name": "Product count to export", "message": "There will be 8 products exported by this action"}]}	f	2024-01-23 21:32:39.706258+00	2024-01-23 21:32:40.008+00	2024-01-23 21:32:40.011+00	\N	\N	2024-01-23 21:32:42.929+00	\N	2024-01-23 21:32:42.925263+00	\N
\.


--
-- Data for Name: cart; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart (id, email, billing_address_id, shipping_address_id, region_id, customer_id, payment_id, type, completed_at, created_at, updated_at, deleted_at, metadata, idempotency_key, context, payment_authorized_at, sales_channel_id) FROM stdin;
cart_01HJQ68AZCAH2CV4ZJ0Y21S5XC	\N	\N	\N	reg_01HJQ62FHQEHVFQQK69CA8PK41	\N	\N	default	\N	2023-12-28 03:07:29.633923+00	2023-12-28 03:07:29.633923+00	\N	\N	\N	{"ip": "190.120.249.240", "user_agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36"}	\N	sc_01HJQ62F3H1V5R0YME9AZ7PMMG
cart_01HMW455PM9KPMQ188CTN3BEPD	cliente1@gmail.com	addr_01HMW4BT8MCXZX691BPFHZ9KYT	addr_01HMW4BT8N0KS5SZ10XCZZ5ATK	reg_01HJQ62FHQEHVFQQK69CA8PK41	cus_01HMW47S2TZFRTFAS9Q37XY7XK	pay_01HMW4C490GPPAXZ5Y5S0R0BJ0	default	2024-01-23 21:42:12.617+00	2024-01-23 21:38:24.586734+00	2024-01-23 21:42:12.527487+00	\N	\N	\N	{"ip": "193.177.211.16", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"}	2024-01-23 21:42:12.516+00	sc_01HJQ62F3H1V5R0YME9AZ7PMMG
cart_01HMW4C4KCVYTF9NMX3Z0DZ6V2	cliente1@gmail.com	\N	\N	reg_01HJQ62FHQEHVFQQK69CA8PK41	cus_01HMW47S2TZFRTFAS9Q37XY7XK	\N	default	\N	2024-01-23 21:42:12.832779+00	2024-01-23 21:42:12.832779+00	\N	\N	\N	{"ip": "193.177.211.16", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"}	\N	sc_01HJQ62F3H1V5R0YME9AZ7PMMG
cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5	ejemplo1065@gmail.com	addr_01HKEGF1FZR4MJFBJ7GS2P84MD	addr_01HKEEXM20VE433YHRTKT9QQQ2	reg_01HJQ62FKBJHFRR89DWYF1XVAM	cus_01HKEGBS7NS9MWK5ZYX4N07VM8	pay_01HKEGFFB2TGHBT39RB6S3J03K	default	2024-01-06 04:28:41.383+00	2023-12-30 12:01:04.296377+00	2024-01-06 04:28:41.256921+00	\N	\N	\N	{"ip": "190.120.249.240", "user_agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36"}	2024-01-06 04:28:41.213+00	sc_01HJQ62F3H1V5R0YME9AZ7PMMG
cart_01HKEGFG06BKTE7SRJ0Z3C92D7	ejemplo1065@gmail.com	\N	\N	reg_01HJQ62FKBJHFRR89DWYF1XVAM	cus_01HKEGBS7NS9MWK5ZYX4N07VM8	\N	default	\N	2024-01-06 04:28:41.854268+00	2024-01-06 04:33:49.223293+00	\N	\N	\N	{"ip": "190.120.249.240", "user_agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36"}	\N	sc_01HJQ62F3H1V5R0YME9AZ7PMMG
cart_01HM6THN376FNFK12TTTPYR2KH	aaa@ee.es	addr_01HNFMPR5BMKEJ8YH9JQDJXB1A	addr_01HNFMPR5BC7K9JFZZHF91DB3E	reg_01HJQ62FHQEHVFQQK69CA8PK41	cus_01HNFMPR4RMWGS1WEK4E73MV96	pay_01HNFMR13HNXPFSAAKKA2XVKJB	default	2024-01-31 11:33:54.046+00	2024-01-15 15:06:24.729983+00	2024-01-31 11:33:53.924934+00	\N	\N	\N	{"ip": "85.59.11.41", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"}	2024-01-31 11:33:53.909+00	sc_01HJQ62F3H1V5R0YME9AZ7PMMG
cart_01HNFMR1GPDJT3T39WAWWYHJRX	yo@yo.es	addr_01HNFV9ZYSDCZXP7NY5SV1K4MY	addr_01HNFV9ZYT651QTZV9TQ7T76Y0	reg_01HJQ62FHQEHVFQQK69CA8PK41	cus_01HNFV8Q3BCE5MM80HQJ8AKAZC	pay_01HNFVA6KM1R51RTH9PW4YGSYA	default	2024-01-31 13:28:40.939+00	2024-01-31 11:33:54.302761+00	2024-01-31 13:28:40.836463+00	\N	\N	\N	{"ip": "85.59.11.41", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"}	2024-01-31 13:28:40.823+00	sc_01HJQ62F3H1V5R0YME9AZ7PMMG
cart_01HNFVA6ZREPT6BJ0X0N1DE5PK	yo@yo.es	\N	\N	reg_01HJQ62FHQEHVFQQK69CA8PK41	cus_01HNFV8Q3BCE5MM80HQJ8AKAZC	\N	default	\N	2024-01-31 13:28:41.182025+00	2024-02-02 14:28:00.622082+00	\N	\N	\N	{"ip": "85.59.11.41", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"}	\N	sc_01HJQ62F3H1V5R0YME9AZ7PMMG
\.


--
-- Data for Name: cart_discounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart_discounts (cart_id, discount_id) FROM stdin;
cart_01HM6THN376FNFK12TTTPYR2KH	disc_01HM6VJ61272P6R31QVVYQQR83
cart_01HNFMR1GPDJT3T39WAWWYHJRX	disc_01HM6VJ61272P6R31QVVYQQR83
\.


--
-- Data for Name: cart_gift_cards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart_gift_cards (cart_id, gift_card_id) FROM stdin;
\.


--
-- Data for Name: claim_image; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.claim_image (id, claim_item_id, url, created_at, updated_at, deleted_at, metadata) FROM stdin;
\.


--
-- Data for Name: claim_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.claim_item (id, claim_order_id, item_id, variant_id, reason, note, quantity, created_at, updated_at, deleted_at, metadata) FROM stdin;
\.


--
-- Data for Name: claim_item_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.claim_item_tags (item_id, tag_id) FROM stdin;
\.


--
-- Data for Name: claim_order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.claim_order (id, payment_status, fulfillment_status, type, order_id, shipping_address_id, refund_amount, canceled_at, created_at, updated_at, deleted_at, metadata, idempotency_key, no_notification) FROM stdin;
\.


--
-- Data for Name: claim_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.claim_tag (id, value, created_at, updated_at, deleted_at, metadata) FROM stdin;
\.


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contacts (id, name, dni, proffesion, adress, province, city, phone, email, email_notification, note) FROM stdin;
\.


--
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.country (id, iso_2, iso_3, num_code, name, display_name, region_id) FROM stdin;
1	af	afg	4	AFGHANISTAN	Afghanistan	\N
2	al	alb	8	ALBANIA	Albania	\N
3	dz	dza	12	ALGERIA	Algeria	\N
4	as	asm	16	AMERICAN SAMOA	American Samoa	\N
5	ad	and	20	ANDORRA	Andorra	\N
6	ao	ago	24	ANGOLA	Angola	\N
7	ai	aia	660	ANGUILLA	Anguilla	\N
8	aq	ata	10	ANTARCTICA	Antarctica	\N
9	ag	atg	28	ANTIGUA AND BARBUDA	Antigua and Barbuda	\N
10	ar	arg	32	ARGENTINA	Argentina	\N
11	am	arm	51	ARMENIA	Armenia	\N
12	aw	abw	533	ARUBA	Aruba	\N
13	au	aus	36	AUSTRALIA	Australia	\N
14	at	aut	40	AUSTRIA	Austria	\N
15	az	aze	31	AZERBAIJAN	Azerbaijan	\N
16	bs	bhs	44	BAHAMAS	Bahamas	\N
17	bh	bhr	48	BAHRAIN	Bahrain	\N
18	bd	bgd	50	BANGLADESH	Bangladesh	\N
19	bb	brb	52	BARBADOS	Barbados	\N
20	by	blr	112	BELARUS	Belarus	\N
21	be	bel	56	BELGIUM	Belgium	\N
22	bz	blz	84	BELIZE	Belize	\N
23	bj	ben	204	BENIN	Benin	\N
24	bm	bmu	60	BERMUDA	Bermuda	\N
25	bt	btn	64	BHUTAN	Bhutan	\N
26	bo	bol	68	BOLIVIA	Bolivia	\N
27	bq	bes	535	BONAIRE, SINT EUSTATIUS AND SABA	Bonaire, Sint Eustatius and Saba	\N
28	ba	bih	70	BOSNIA AND HERZEGOVINA	Bosnia and Herzegovina	\N
29	bw	bwa	72	BOTSWANA	Botswana	\N
30	bv	bvd	74	BOUVET ISLAND	Bouvet Island	\N
31	br	bra	76	BRAZIL	Brazil	\N
32	io	iot	86	BRITISH INDIAN OCEAN TERRITORY	British Indian Ocean Territory	\N
33	bn	brn	96	BRUNEI DARUSSALAM	Brunei Darussalam	\N
34	bg	bgr	100	BULGARIA	Bulgaria	\N
35	bf	bfa	854	BURKINA FASO	Burkina Faso	\N
36	bi	bdi	108	BURUNDI	Burundi	\N
37	kh	khm	116	CAMBODIA	Cambodia	\N
38	cm	cmr	120	CAMEROON	Cameroon	\N
40	cv	cpv	132	CAPE VERDE	Cape Verde	\N
41	ky	cym	136	CAYMAN ISLANDS	Cayman Islands	\N
42	cf	caf	140	CENTRAL AFRICAN REPUBLIC	Central African Republic	\N
43	td	tcd	148	CHAD	Chad	\N
44	cl	chl	152	CHILE	Chile	\N
45	cn	chn	156	CHINA	China	\N
46	cx	cxr	162	CHRISTMAS ISLAND	Christmas Island	\N
47	cc	cck	166	COCOS (KEELING) ISLANDS	Cocos (Keeling) Islands	\N
48	co	col	170	COLOMBIA	Colombia	\N
49	km	com	174	COMOROS	Comoros	\N
50	cg	cog	178	CONGO	Congo	\N
51	cd	cod	180	CONGO, THE DEMOCRATIC REPUBLIC OF THE	Congo, the Democratic Republic of the	\N
52	ck	cok	184	COOK ISLANDS	Cook Islands	\N
53	cr	cri	188	COSTA RICA	Costa Rica	\N
54	ci	civ	384	COTE D'IVOIRE	Cote D'Ivoire	\N
55	hr	hrv	191	CROATIA	Croatia	\N
56	cu	cub	192	CUBA	Cuba	\N
57	cw	cuw	531	CURAÇAO	Curaçao	\N
58	cy	cyp	196	CYPRUS	Cyprus	\N
59	cz	cze	203	CZECH REPUBLIC	Czech Republic	\N
61	dj	dji	262	DJIBOUTI	Djibouti	\N
62	dm	dma	212	DOMINICA	Dominica	\N
63	do	dom	214	DOMINICAN REPUBLIC	Dominican Republic	\N
64	ec	ecu	218	ECUADOR	Ecuador	\N
65	eg	egy	818	EGYPT	Egypt	\N
66	sv	slv	222	EL SALVADOR	El Salvador	\N
67	gq	gnq	226	EQUATORIAL GUINEA	Equatorial Guinea	\N
68	er	eri	232	ERITREA	Eritrea	\N
69	ee	est	233	ESTONIA	Estonia	\N
70	et	eth	231	ETHIOPIA	Ethiopia	\N
71	fk	flk	238	FALKLAND ISLANDS (MALVINAS)	Falkland Islands (Malvinas)	\N
72	fo	fro	234	FAROE ISLANDS	Faroe Islands	\N
73	fj	fji	242	FIJI	Fiji	\N
74	fi	fin	246	FINLAND	Finland	\N
76	gf	guf	254	FRENCH GUIANA	French Guiana	\N
77	pf	pyf	258	FRENCH POLYNESIA	French Polynesia	\N
78	tf	atf	260	FRENCH SOUTHERN TERRITORIES	French Southern Territories	\N
79	ga	gab	266	GABON	Gabon	\N
80	gm	gmb	270	GAMBIA	Gambia	\N
81	ge	geo	268	GEORGIA	Georgia	\N
83	gh	gha	288	GHANA	Ghana	\N
84	gi	gib	292	GIBRALTAR	Gibraltar	\N
85	gr	grc	300	GREECE	Greece	\N
86	gl	grl	304	GREENLAND	Greenland	\N
87	gd	grd	308	GRENADA	Grenada	\N
88	gp	glp	312	GUADELOUPE	Guadeloupe	\N
89	gu	gum	316	GUAM	Guam	\N
90	gt	gtm	320	GUATEMALA	Guatemala	\N
91	gg	ggy	831	GUERNSEY	Guernsey	\N
92	gn	gin	324	GUINEA	Guinea	\N
93	gw	gnb	624	GUINEA-BISSAU	Guinea-Bissau	\N
94	gy	guy	328	GUYANA	Guyana	\N
95	ht	hti	332	HAITI	Haiti	\N
96	hm	hmd	334	HEARD ISLAND AND MCDONALD ISLANDS	Heard Island And Mcdonald Islands	\N
97	va	vat	336	HOLY SEE (VATICAN CITY STATE)	Holy See (Vatican City State)	\N
98	hn	hnd	340	HONDURAS	Honduras	\N
99	hk	hkg	344	HONG KONG	Hong Kong	\N
100	hu	hun	348	HUNGARY	Hungary	\N
101	is	isl	352	ICELAND	Iceland	\N
102	in	ind	356	INDIA	India	\N
103	id	idn	360	INDONESIA	Indonesia	\N
104	ir	irn	364	IRAN, ISLAMIC REPUBLIC OF	Iran, Islamic Republic of	\N
105	iq	irq	368	IRAQ	Iraq	\N
106	ie	irl	372	IRELAND	Ireland	\N
107	im	imn	833	ISLE OF MAN	Isle Of Man	\N
108	il	isr	376	ISRAEL	Israel	\N
110	jm	jam	388	JAMAICA	Jamaica	\N
111	jp	jpn	392	JAPAN	Japan	\N
112	je	jey	832	JERSEY	Jersey	\N
113	jo	jor	400	JORDAN	Jordan	\N
114	kz	kaz	398	KAZAKHSTAN	Kazakhstan	\N
115	ke	ken	404	KENYA	Kenya	\N
116	ki	kir	296	KIRIBATI	Kiribati	\N
117	kp	prk	408	KOREA, DEMOCRATIC PEOPLE'S REPUBLIC OF	Korea, Democratic People's Republic of	\N
118	kr	kor	410	KOREA, REPUBLIC OF	Korea, Republic of	\N
119	xk	xkx	900	KOSOVO	Kosovo	\N
120	kw	kwt	414	KUWAIT	Kuwait	\N
121	kg	kgz	417	KYRGYZSTAN	Kyrgyzstan	\N
122	la	lao	418	LAO PEOPLE'S DEMOCRATIC REPUBLIC	Lao People's Democratic Republic	\N
123	lv	lva	428	LATVIA	Latvia	\N
124	lb	lbn	422	LEBANON	Lebanon	\N
125	ls	lso	426	LESOTHO	Lesotho	\N
126	lr	lbr	430	LIBERIA	Liberia	\N
127	ly	lby	434	LIBYAN ARAB JAMAHIRIYA	Libyan Arab Jamahiriya	\N
128	li	lie	438	LIECHTENSTEIN	Liechtenstein	\N
129	lt	ltu	440	LITHUANIA	Lithuania	\N
130	lu	lux	442	LUXEMBOURG	Luxembourg	\N
131	mo	mac	446	MACAO	Macao	\N
132	mk	mkd	807	MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF	Macedonia, the Former Yugoslav Republic of	\N
133	mg	mdg	450	MADAGASCAR	Madagascar	\N
134	mw	mwi	454	MALAWI	Malawi	\N
135	my	mys	458	MALAYSIA	Malaysia	\N
136	mv	mdv	462	MALDIVES	Maldives	\N
137	ml	mli	466	MALI	Mali	\N
138	mt	mlt	470	MALTA	Malta	\N
139	mh	mhl	584	MARSHALL ISLANDS	Marshall Islands	\N
140	mq	mtq	474	MARTINIQUE	Martinique	\N
141	mr	mrt	478	MAURITANIA	Mauritania	\N
142	mu	mus	480	MAURITIUS	Mauritius	\N
143	yt	myt	175	MAYOTTE	Mayotte	\N
144	mx	mex	484	MEXICO	Mexico	\N
145	fm	fsm	583	MICRONESIA, FEDERATED STATES OF	Micronesia, Federated States of	\N
146	md	mda	498	MOLDOVA, REPUBLIC OF	Moldova, Republic of	\N
147	mc	mco	492	MONACO	Monaco	\N
148	mn	mng	496	MONGOLIA	Mongolia	\N
149	me	mne	499	MONTENEGRO	Montenegro	\N
150	ms	msr	500	MONTSERRAT	Montserrat	\N
151	ma	mar	504	MOROCCO	Morocco	\N
152	mz	moz	508	MOZAMBIQUE	Mozambique	\N
153	mm	mmr	104	MYANMAR	Myanmar	\N
154	na	nam	516	NAMIBIA	Namibia	\N
155	nr	nru	520	NAURU	Nauru	\N
156	np	npl	524	NEPAL	Nepal	\N
157	nl	nld	528	NETHERLANDS	Netherlands	\N
158	nc	ncl	540	NEW CALEDONIA	New Caledonia	\N
159	nz	nzl	554	NEW ZEALAND	New Zealand	\N
160	ni	nic	558	NICARAGUA	Nicaragua	\N
161	ne	ner	562	NIGER	Niger	\N
162	ng	nga	566	NIGERIA	Nigeria	\N
163	nu	niu	570	NIUE	Niue	\N
164	nf	nfk	574	NORFOLK ISLAND	Norfolk Island	\N
165	mp	mnp	580	NORTHERN MARIANA ISLANDS	Northern Mariana Islands	\N
166	no	nor	578	NORWAY	Norway	\N
167	om	omn	512	OMAN	Oman	\N
168	pk	pak	586	PAKISTAN	Pakistan	\N
169	pw	plw	585	PALAU	Palau	\N
170	ps	pse	275	PALESTINIAN TERRITORY, OCCUPIED	Palestinian Territory, Occupied	\N
171	pa	pan	591	PANAMA	Panama	\N
172	pg	png	598	PAPUA NEW GUINEA	Papua New Guinea	\N
173	py	pry	600	PARAGUAY	Paraguay	\N
174	pe	per	604	PERU	Peru	\N
175	ph	phl	608	PHILIPPINES	Philippines	\N
176	pn	pcn	612	PITCAIRN	Pitcairn	\N
177	pl	pol	616	POLAND	Poland	\N
178	pt	prt	620	PORTUGAL	Portugal	\N
179	pr	pri	630	PUERTO RICO	Puerto Rico	\N
180	qa	qat	634	QATAR	Qatar	\N
181	re	reu	638	REUNION	Reunion	\N
182	ro	rom	642	ROMANIA	Romania	\N
183	ru	rus	643	RUSSIAN FEDERATION	Russian Federation	\N
184	rw	rwa	646	RWANDA	Rwanda	\N
185	bl	blm	652	SAINT BARTHÉLEMY	Saint Barthélemy	\N
186	sh	shn	654	SAINT HELENA	Saint Helena	\N
187	kn	kna	659	SAINT KITTS AND NEVIS	Saint Kitts and Nevis	\N
188	lc	lca	662	SAINT LUCIA	Saint Lucia	\N
189	mf	maf	663	SAINT MARTIN (FRENCH PART)	Saint Martin (French part)	\N
190	pm	spm	666	SAINT PIERRE AND MIQUELON	Saint Pierre and Miquelon	\N
191	vc	vct	670	SAINT VINCENT AND THE GRENADINES	Saint Vincent and the Grenadines	\N
192	ws	wsm	882	SAMOA	Samoa	\N
193	sm	smr	674	SAN MARINO	San Marino	\N
194	st	stp	678	SAO TOME AND PRINCIPE	Sao Tome and Principe	\N
195	sa	sau	682	SAUDI ARABIA	Saudi Arabia	\N
196	sn	sen	686	SENEGAL	Senegal	\N
197	rs	srb	688	SERBIA	Serbia	\N
198	sc	syc	690	SEYCHELLES	Seychelles	\N
199	sl	sle	694	SIERRA LEONE	Sierra Leone	\N
200	sg	sgp	702	SINGAPORE	Singapore	\N
201	sx	sxm	534	SINT MAARTEN	Sint Maarten	\N
202	sk	svk	703	SLOVAKIA	Slovakia	\N
203	si	svn	705	SLOVENIA	Slovenia	\N
204	sb	slb	90	SOLOMON ISLANDS	Solomon Islands	\N
205	so	som	706	SOMALIA	Somalia	\N
206	za	zaf	710	SOUTH AFRICA	South Africa	\N
207	gs	sgs	239	SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS	South Georgia and the South Sandwich Islands	\N
208	ss	ssd	728	SOUTH SUDAN	South Sudan	\N
210	lk	lka	144	SRI LANKA	Sri Lanka	\N
211	sd	sdn	729	SUDAN	Sudan	\N
212	sr	sur	740	SURINAME	Suriname	\N
213	sj	sjm	744	SVALBARD AND JAN MAYEN	Svalbard and Jan Mayen	\N
214	sz	swz	748	SWAZILAND	Swaziland	\N
216	ch	che	756	SWITZERLAND	Switzerland	\N
217	sy	syr	760	SYRIAN ARAB REPUBLIC	Syrian Arab Republic	\N
218	tw	twn	158	TAIWAN, PROVINCE OF CHINA	Taiwan, Province of China	\N
219	tj	tjk	762	TAJIKISTAN	Tajikistan	\N
220	tz	tza	834	TANZANIA, UNITED REPUBLIC OF	Tanzania, United Republic of	\N
221	th	tha	764	THAILAND	Thailand	\N
222	tl	tls	626	TIMOR LESTE	Timor Leste	\N
223	tg	tgo	768	TOGO	Togo	\N
224	tk	tkl	772	TOKELAU	Tokelau	\N
225	to	ton	776	TONGA	Tonga	\N
226	tt	tto	780	TRINIDAD AND TOBAGO	Trinidad and Tobago	\N
227	tn	tun	788	TUNISIA	Tunisia	\N
228	tr	tur	792	TURKEY	Turkey	\N
229	tm	tkm	795	TURKMENISTAN	Turkmenistan	\N
215	se	swe	752	SWEDEN	Sweden	reg_01HJQ62FHQEHVFQQK69CA8PK41
230	tc	tca	796	TURKS AND CAICOS ISLANDS	Turks and Caicos Islands	\N
231	tv	tuv	798	TUVALU	Tuvalu	\N
232	ug	uga	800	UGANDA	Uganda	\N
233	ua	ukr	804	UKRAINE	Ukraine	\N
234	ae	are	784	UNITED ARAB EMIRATES	United Arab Emirates	\N
237	um	umi	581	UNITED STATES MINOR OUTLYING ISLANDS	United States Minor Outlying Islands	\N
238	uy	ury	858	URUGUAY	Uruguay	\N
239	uz	uzb	860	UZBEKISTAN	Uzbekistan	\N
240	vu	vut	548	VANUATU	Vanuatu	\N
241	ve	ven	862	VENEZUELA	Venezuela	\N
242	vn	vnm	704	VIET NAM	Viet Nam	\N
243	vg	vgb	92	VIRGIN ISLANDS, BRITISH	Virgin Islands, British	\N
244	vi	vir	850	VIRGIN ISLANDS, U.S.	Virgin Islands, U.S.	\N
245	wf	wlf	876	WALLIS AND FUTUNA	Wallis and Futuna	\N
246	eh	esh	732	WESTERN SAHARA	Western Sahara	\N
247	ye	yem	887	YEMEN	Yemen	\N
248	zm	zmb	894	ZAMBIA	Zambia	\N
249	zw	zwe	716	ZIMBABWE	Zimbabwe	\N
250	ax	ala	248	ÅLAND ISLANDS	Åland Islands	\N
235	gb	gbr	826	UNITED KINGDOM	United Kingdom	reg_01HJQ62FHQEHVFQQK69CA8PK41
82	de	deu	276	GERMANY	Germany	reg_01HJQ62FHQEHVFQQK69CA8PK41
60	dk	dnk	208	DENMARK	Denmark	reg_01HJQ62FHQEHVFQQK69CA8PK41
75	fr	fra	250	FRANCE	France	reg_01HJQ62FHQEHVFQQK69CA8PK41
209	es	esp	724	SPAIN	Spain	reg_01HJQ62FHQEHVFQQK69CA8PK41
109	it	ita	380	ITALY	Italy	reg_01HJQ62FHQEHVFQQK69CA8PK41
236	us	usa	840	UNITED STATES	United States	reg_01HJQ62FKBJHFRR89DWYF1XVAM
39	ca	can	124	CANADA	Canada	reg_01HJQ62FKBJHFRR89DWYF1XVAM
\.


--
-- Data for Name: currency; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.currency (code, symbol, symbol_native, name) FROM stdin;
usd	$	$	US Dollar
cad	CA$	$	Canadian Dollar
eur	€	€	Euro
aed	AED	د.إ.‏	United Arab Emirates Dirham
afn	Af	؋	Afghan Afghani
all	ALL	Lek	Albanian Lek
amd	AMD	դր.	Armenian Dram
ars	AR$	$	Argentine Peso
aud	AU$	$	Australian Dollar
azn	man.	ман.	Azerbaijani Manat
bam	KM	KM	Bosnia-Herzegovina Convertible Mark
bdt	Tk	৳	Bangladeshi Taka
bgn	BGN	лв.	Bulgarian Lev
bhd	BD	د.ب.‏	Bahraini Dinar
bif	FBu	FBu	Burundian Franc
bnd	BN$	$	Brunei Dollar
bob	Bs	Bs	Bolivian Boliviano
brl	R$	R$	Brazilian Real
bwp	BWP	P	Botswanan Pula
byn	Br	руб.	Belarusian Ruble
bzd	BZ$	$	Belize Dollar
cdf	CDF	FrCD	Congolese Franc
chf	CHF	CHF	Swiss Franc
clp	CL$	$	Chilean Peso
cny	CN¥	CN¥	Chinese Yuan
cop	CO$	$	Colombian Peso
crc	₡	₡	Costa Rican Colón
cve	CV$	CV$	Cape Verdean Escudo
czk	Kč	Kč	Czech Republic Koruna
djf	Fdj	Fdj	Djiboutian Franc
dkk	Dkr	kr	Danish Krone
dop	RD$	RD$	Dominican Peso
dzd	DA	د.ج.‏	Algerian Dinar
eek	Ekr	kr	Estonian Kroon
egp	EGP	ج.م.‏	Egyptian Pound
ern	Nfk	Nfk	Eritrean Nakfa
etb	Br	Br	Ethiopian Birr
gbp	£	£	British Pound Sterling
gel	GEL	GEL	Georgian Lari
ghs	GH₵	GH₵	Ghanaian Cedi
gnf	FG	FG	Guinean Franc
gtq	GTQ	Q	Guatemalan Quetzal
hkd	HK$	$	Hong Kong Dollar
hnl	HNL	L	Honduran Lempira
hrk	kn	kn	Croatian Kuna
huf	Ft	Ft	Hungarian Forint
idr	Rp	Rp	Indonesian Rupiah
ils	₪	₪	Israeli New Sheqel
inr	Rs	টকা	Indian Rupee
iqd	IQD	د.ع.‏	Iraqi Dinar
irr	IRR	﷼	Iranian Rial
isk	Ikr	kr	Icelandic Króna
jmd	J$	$	Jamaican Dollar
jod	JD	د.أ.‏	Jordanian Dinar
jpy	¥	￥	Japanese Yen
kes	Ksh	Ksh	Kenyan Shilling
khr	KHR	៛	Cambodian Riel
kmf	CF	FC	Comorian Franc
krw	₩	₩	South Korean Won
kwd	KD	د.ك.‏	Kuwaiti Dinar
kzt	KZT	тңг.	Kazakhstani Tenge
lbp	LB£	ل.ل.‏	Lebanese Pound
lkr	SLRs	SL Re	Sri Lankan Rupee
ltl	Lt	Lt	Lithuanian Litas
lvl	Ls	Ls	Latvian Lats
lyd	LD	د.ل.‏	Libyan Dinar
mad	MAD	د.م.‏	Moroccan Dirham
mdl	MDL	MDL	Moldovan Leu
mga	MGA	MGA	Malagasy Ariary
mkd	MKD	MKD	Macedonian Denar
mmk	MMK	K	Myanma Kyat
mnt	MNT	₮	Mongolian Tugrig
mop	MOP$	MOP$	Macanese Pataca
mur	MURs	MURs	Mauritian Rupee
mxn	MX$	$	Mexican Peso
myr	RM	RM	Malaysian Ringgit
mzn	MTn	MTn	Mozambican Metical
nad	N$	N$	Namibian Dollar
ngn	₦	₦	Nigerian Naira
nio	C$	C$	Nicaraguan Córdoba
nok	Nkr	kr	Norwegian Krone
npr	NPRs	नेरू	Nepalese Rupee
nzd	NZ$	$	New Zealand Dollar
omr	OMR	ر.ع.‏	Omani Rial
pab	B/.	B/.	Panamanian Balboa
pen	S/.	S/.	Peruvian Nuevo Sol
php	₱	₱	Philippine Peso
pkr	PKRs	₨	Pakistani Rupee
pln	zł	zł	Polish Zloty
pyg	₲	₲	Paraguayan Guarani
qar	QR	ر.ق.‏	Qatari Rial
ron	RON	RON	Romanian Leu
rsd	din.	дин.	Serbian Dinar
rub	RUB	₽.	Russian Ruble
rwf	RWF	FR	Rwandan Franc
sar	SR	ر.س.‏	Saudi Riyal
sdg	SDG	SDG	Sudanese Pound
sek	Skr	kr	Swedish Krona
sgd	S$	$	Singapore Dollar
sos	Ssh	Ssh	Somali Shilling
syp	SY£	ل.س.‏	Syrian Pound
thb	฿	฿	Thai Baht
tnd	DT	د.ت.‏	Tunisian Dinar
top	T$	T$	Tongan Paʻanga
try	TL	TL	Turkish Lira
ttd	TT$	$	Trinidad and Tobago Dollar
twd	NT$	NT$	New Taiwan Dollar
tzs	TSh	TSh	Tanzanian Shilling
uah	₴	₴	Ukrainian Hryvnia
ugx	USh	USh	Ugandan Shilling
uyu	$U	$	Uruguayan Peso
uzs	UZS	UZS	Uzbekistan Som
vef	Bs.F.	Bs.F.	Venezuelan Bolívar
vnd	₫	₫	Vietnamese Dong
xaf	FCFA	FCFA	CFA Franc BEAC
xof	CFA	CFA	CFA Franc BCEAO
yer	YR	ر.ي.‏	Yemeni Rial
zar	R	R	South African Rand
zmk	ZK	ZK	Zambian Kwacha
zwl	ZWL$	ZWL$	Zimbabwean Dollar
\.


--
-- Data for Name: custom_shipping_option; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.custom_shipping_option (id, price, shipping_option_id, cart_id, created_at, updated_at, deleted_at, metadata) FROM stdin;
\.


--
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer (id, email, first_name, last_name, billing_address_id, password_hash, phone, has_account, created_at, updated_at, deleted_at, metadata, re, account_customer, account_debtor, is_company, shipping_address_id, note) FROM stdin;
cus_01HKEGBS7NS9MWK5ZYX4N07VM8	ejemplo1065@gmail.com	Douglas	Montoya	addr_01HKEGDKZA9255B9KFMTQWACF9	c2NyeXB0AAEAAAABAAAAAQqsy+nEgyHFLA9PsMhSVtQb2R3TjIkQRbxVSb9KFJ0/btfxnU3LbRj2LImj7fstxLBpQPEe3oPAJTBu2DcYqo57cH0eMR8imQ8pEacshe9V	0414-335-0517	t	2024-01-06 04:26:40.238573+00	2024-01-06 04:27:40.388179+00	\N	\N	\N	\N	\N	\N	\N	\N
cus_01HMW47S2TZFRTFAS9Q37XY7XK	cliente1@gmail.com	cliente 1	apellido 1	\N	c2NyeXB0AAEAAAABAAAAATvP/cN7S+QRrZUpsr241KhcQBg1wx1fw0nBjB8sccE6XbqQimiYtKCE8OZmIe+ycgGvnG60jvj/R/d+AmUaHS6zkACCoAUijxG74e8tzkvi	67597445	t	2024-01-23 21:39:49.971962+00	2024-01-23 21:39:49.971962+00	\N	\N	\N	\N	\N	\N	\N	\N
cus_01HNFMPR4RMWGS1WEK4E73MV96	aaa@ee.es	\N	\N	\N	\N	\N	f	2024-01-31 11:33:11.91918+00	2024-01-31 11:33:11.91918+00	\N	\N	\N	\N	\N	\N	\N	\N
cus_01HNFV8Q3BCE5MM80HQJ8AKAZC	yo@yo.es	al	alo	\N	c2NyeXB0AAEAAAABAAAAAazWq2IiRF+SaGTJxeM7f/ZuzMZuwzzM9zutykwNWnfhAk3OpovGxQxMbMUujHUWgLQvx3i4R1a5vCg2of7MN7DcHZQb2Jbv6B3JlR2Donvs	675874455	t	2024-01-31 13:27:52.163771+00	2024-01-31 13:27:52.163771+00	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: customer_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_group (id, name, created_at, updated_at, deleted_at, metadata) FROM stdin;
cgrp_01HM6VAZZ100Y6JG82Y1WQK8GB	grupo grandes empresas	2024-01-15 15:20:15.071805+00	2024-01-15 15:20:15.071805+00	\N	{"GE": "GE"}
cgrp_01HNFM9W4MTQBNZWVN84B2JS1V	grupos empresas pequeñas	2024-01-31 11:26:10.067319+00	2024-01-31 11:26:10.067319+00	\N	{}
\.


--
-- Data for Name: customer_group_customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_group_customers (customer_group_id, customer_id) FROM stdin;
cgrp_01HM6VAZZ100Y6JG82Y1WQK8GB	cus_01HKEGBS7NS9MWK5ZYX4N07VM8
\.


--
-- Data for Name: customer_payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_payment (id, customer_id, payment_method, payday, bank_name, bank_country, currency_code, iban, swift) FROM stdin;
\.


--
-- Data for Name: discount; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discount (id, code, is_dynamic, rule_id, is_disabled, parent_discount_id, starts_at, ends_at, created_at, updated_at, deleted_at, metadata, usage_limit, usage_count, valid_duration) FROM stdin;
disc_01HM6VHFSE2DQ962C5YKSS9ZJ7	1	t	dru_01HM6VHFS77VC7P3NN7NHJWVFP	f	\N	2024-01-14 15:23:20.66+00	\N	2024-01-15 15:23:47.872742+00	2024-01-15 15:23:47.872742+00	\N	{}	\N	0	\N
disc_01HM6VJ61272P6R31QVVYQQR83	VERANO	f	dru_01HM6VJ60XTZ24R9H4C22ZD68M	f	\N	2024-01-15 15:23:48.06+00	\N	2024-01-15 15:24:10.650184+00	2024-01-31 13:28:43.940808+00	\N	{}	\N	2	\N
\.


--
-- Data for Name: discount_condition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discount_condition (id, type, operator, discount_rule_id, created_at, updated_at, deleted_at, metadata) FROM stdin;
discon_01HM6VHFSP7D4EAPKBQAP1CRT5	products	in	dru_01HM6VHFS77VC7P3NN7NHJWVFP	2024-01-15 15:23:47.872742+00	2024-01-15 15:23:47.872742+00	\N	\N
discon_01HMW405Z9A9Q2KV9M00RM1P6Z	products	in	dru_01HM6VJ60XTZ24R9H4C22ZD68M	2024-01-23 21:35:41.025114+00	2024-01-23 21:35:41.025114+00	\N	\N
\.


--
-- Data for Name: discount_condition_customer_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discount_condition_customer_group (customer_group_id, condition_id, created_at, updated_at, metadata) FROM stdin;
\.


--
-- Data for Name: discount_condition_product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discount_condition_product (product_id, condition_id, created_at, updated_at, metadata) FROM stdin;
prod_01HKEG5EJAJ169G595EB6HHQ7A	discon_01HM6VHFSP7D4EAPKBQAP1CRT5	2024-01-15 15:23:47.872742+00	2024-01-15 15:23:47.872742+00	\N
prod_01HJQ62H1V8MN0MKYKZ6M6DWGB	discon_01HM6VHFSP7D4EAPKBQAP1CRT5	2024-01-15 15:23:47.872742+00	2024-01-15 15:23:47.872742+00	\N
prod_01HJQ62GQGCQ64V8BMRHT1VAT7	discon_01HM6VHFSP7D4EAPKBQAP1CRT5	2024-01-15 15:23:47.872742+00	2024-01-15 15:23:47.872742+00	\N
prod_01HJQ62GX0MCBE9YBZ7YWTJCHR	discon_01HM6VHFSP7D4EAPKBQAP1CRT5	2024-01-15 15:23:47.872742+00	2024-01-15 15:23:47.872742+00	\N
prod_01HJQ62GEQ1EPNN20XP5FFHZ2H	discon_01HM6VHFSP7D4EAPKBQAP1CRT5	2024-01-15 15:23:47.872742+00	2024-01-15 15:23:47.872742+00	\N
prod_01HJQ62G9KVHQMFK2HY40X4M2P	discon_01HM6VHFSP7D4EAPKBQAP1CRT5	2024-01-15 15:23:47.872742+00	2024-01-15 15:23:47.872742+00	\N
prod_01HJQ62FWPA7FSQZ2B176YBX1D	discon_01HM6VHFSP7D4EAPKBQAP1CRT5	2024-01-15 15:23:47.872742+00	2024-01-15 15:23:47.872742+00	\N
prod_01HMW3TYF02KCWWFMMQ429DK9B	discon_01HMW405Z9A9Q2KV9M00RM1P6Z	2024-01-23 21:35:41.025114+00	2024-01-23 21:35:41.025114+00	\N
prod_01HJQ62GX0MCBE9YBZ7YWTJCHR	discon_01HMW405Z9A9Q2KV9M00RM1P6Z	2024-01-23 21:35:41.025114+00	2024-01-23 21:35:41.025114+00	\N
prod_01HJQ62GQGCQ64V8BMRHT1VAT7	discon_01HMW405Z9A9Q2KV9M00RM1P6Z	2024-01-23 21:35:59.140426+00	2024-01-23 21:35:59.140426+00	\N
prod_01HJQ62G9KVHQMFK2HY40X4M2P	discon_01HMW405Z9A9Q2KV9M00RM1P6Z	2024-01-31 11:30:14.210691+00	2024-01-31 11:30:14.210691+00	\N
\.


--
-- Data for Name: discount_condition_product_collection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discount_condition_product_collection (product_collection_id, condition_id, created_at, updated_at, metadata) FROM stdin;
\.


--
-- Data for Name: discount_condition_product_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discount_condition_product_tag (product_tag_id, condition_id, created_at, updated_at, metadata) FROM stdin;
\.


--
-- Data for Name: discount_condition_product_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discount_condition_product_type (product_type_id, condition_id, created_at, updated_at, metadata) FROM stdin;
\.


--
-- Data for Name: discount_regions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discount_regions (discount_id, region_id) FROM stdin;
disc_01HM6VHFSE2DQ962C5YKSS9ZJ7	reg_01HJQ62FHQEHVFQQK69CA8PK41
disc_01HM6VJ61272P6R31QVVYQQR83	reg_01HJQ62FHQEHVFQQK69CA8PK41
\.


--
-- Data for Name: discount_rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discount_rule (id, description, type, value, allocation, created_at, updated_at, deleted_at, metadata) FROM stdin;
dru_01HM6VHFS77VC7P3NN7NHJWVFP	descuento prueba	percentage	33	total	2024-01-15 15:23:47.872742+00	2024-01-15 15:23:47.872742+00	\N	\N
dru_01HM6VJ60XTZ24R9H4C22ZD68M	verano22 222222	percentage	44	total	2024-01-15 15:24:10.650184+00	2024-01-15 15:24:10.650184+00	\N	\N
\.


--
-- Data for Name: discount_rule_products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discount_rule_products (discount_rule_id, product_id) FROM stdin;
\.


--
-- Data for Name: draft_order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.draft_order (id, status, display_id, cart_id, order_id, canceled_at, created_at, updated_at, completed_at, metadata, idempotency_key, no_notification_order) FROM stdin;
\.


--
-- Data for Name: fulfillment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fulfillment (id, swap_id, order_id, tracking_numbers, data, shipped_at, canceled_at, created_at, updated_at, metadata, idempotency_key, provider_id, claim_order_id, no_notification, location_id) FROM stdin;
ful_01HKEGJF51KYW502D1P9QW3S06	\N	order_01HKEGFFG7P3NFDAE7WV6DTQAH	[]	{}	2024-01-06 04:31:03.189+00	\N	2024-01-06 04:30:19.242041+00	2024-01-06 04:31:03.178177+00	{}	\N	manual	\N	f	\N
ful_01HNFVD6CG8GHENMHBY8F81RR2	\N	order_01HNFVA6PA3X641SN5K2QQNHTM	[]	{}	2024-01-31 13:30:39.015+00	\N	2024-01-31 13:30:18.805129+00	2024-01-31 13:30:38.997001+00	{}	\N	manual	\N	f	\N
\.


--
-- Data for Name: fulfillment_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fulfillment_item (fulfillment_id, item_id, quantity) FROM stdin;
ful_01HKEGJF51KYW502D1P9QW3S06	item_01HKEG8SRDW5SRXES29QJT11TG	3
ful_01HKEGJF51KYW502D1P9QW3S06	item_01HKEG9E7NCNQRM18Q5J7D023Q	2
ful_01HKEGJF51KYW502D1P9QW3S06	item_01HKEG9WNT60N7BF1WFP74FYEJ	1
ful_01HNFVD6CG8GHENMHBY8F81RR2	item_01HNFMT3NPK4RMG17Y35VXMBQW	1
ful_01HNFVD6CG8GHENMHBY8F81RR2	item_01HNFV6RF46X9VNYSBNNH2PFYZ	1
\.


--
-- Data for Name: fulfillment_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fulfillment_provider (id, is_installed) FROM stdin;
manual	t
\.


--
-- Data for Name: gift_card; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gift_card (id, code, value, balance, region_id, order_id, is_disabled, ends_at, created_at, updated_at, deleted_at, metadata, tax_rate) FROM stdin;
\.


--
-- Data for Name: gift_card_transaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gift_card_transaction (id, gift_card_id, order_id, amount, created_at, is_taxable, tax_rate) FROM stdin;
\.


--
-- Data for Name: idempotency_key; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.idempotency_key (id, idempotency_key, created_at, locked_at, request_method, request_params, request_path, response_code, response_body, recovery_point) FROM stdin;
ikey_01HNDCBH5R92EW4K5TRDKMXZ3H	30346dce-5300-4231-bd73-7c63c8adb927	2024-01-30 14:28:46.904451+00	\N	POST	{"id": "cart_01HM6THN376FNFK12TTTPYR2KH"}	/cart_01HM6THN376FNFK12TTTPYR2KH/line-items	200	{"cart": {"id": "cart_01HM6THN376FNFK12TTTPYR2KH", "type": "default", "email": null, "items": [{"id": "item_01HNDCBH76E0T3YMYY4Q22GEFF", "title": "Franela Negra con un Logo", "total": 3629, "cart_id": "cart_01HM6THN376FNFK12TTTPYR2KH", "swap_id": null, "variant": {"id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "ean": null, "sku": null, "upc": null, "title": "XL", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "product": {"id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "title": "Franela Negra con un Logo", "width": null, "handle": "franela-negra-con-un-logo", "height": null, "length": null, "status": "published", "weight": null, "hs_code": null, "profile": {"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}, "type_id": null, "material": null, "metadata": null, "mid_code": null, "profiles": [{"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}], "subtitle": null, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "profile_id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "updated_at": "2024-01-06T04:23:12.699Z", "description": null, "external_id": null, "is_giftcard": false, "discountable": true, "collection_id": null, "origin_country": null}, "material": null, "metadata": null, "mid_code": null, "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "product_id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "updated_at": "2024-01-23T21:42:12.527Z", "variant_rank": 0, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 6}, "metadata": {}, "order_id": null, "quantity": 1, "subtotal": 2999, "is_return": false, "tax_lines": [{"code": "21", "name": "21% iva", "rate": 21, "item_id": "item_01HNDCBH76E0T3YMYY4Q22GEFF"}], "tax_total": 630, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-30T14:28:46.924Z", "unit_price": 2999, "updated_at": "2024-01-30T14:28:46.924Z", "variant_id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "adjustments": [], "description": "XL", "is_giftcard": false, "has_shipping": false, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 3629, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 630, "raw_discount_total": 0}], "total": 3629, "object": "cart", "region": {"id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "name": "EU", "metadata": null, "tax_code": null, "tax_rate": 0, "countries": [{"id": 109, "name": "ITALY", "iso_2": "it", "iso_3": "ita", "num_code": 380, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Italy"}, {"id": 209, "name": "SPAIN", "iso_2": "es", "iso_3": "esp", "num_code": 724, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Spain"}, {"id": 75, "name": "FRANCE", "iso_2": "fr", "iso_3": "fra", "num_code": 250, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "France"}, {"id": 60, "name": "DENMARK", "iso_2": "dk", "iso_3": "dnk", "num_code": 208, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Denmark"}, {"id": 82, "name": "GERMANY", "iso_2": "de", "iso_3": "deu", "num_code": 276, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Germany"}, {"id": 235, "name": "UNITED KINGDOM", "iso_2": "gb", "iso_3": "gbr", "num_code": 826, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "United Kingdom"}, {"id": 215, "name": "SWEDEN", "iso_2": "se", "iso_3": "swe", "num_code": 752, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Sweden"}], "tax_rates": [{"id": "txr_01HM6VF955JXB29T12X4ZEDBKG", "code": "21", "name": "21% iva", "rate": 21, "metadata": null, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "created_at": "2024-01-15T15:22:35.555Z", "updated_at": "2024-01-15T15:22:35.555Z"}], "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:17.482Z", "currency_code": "eur", "automatic_taxes": true, "tax_provider_id": null, "payment_providers": [{"id": "manual", "is_installed": true}], "gift_cards_taxable": true}, "context": {"ip": "85.59.11.41", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"}, "payment": null, "customer": null, "metadata": null, "subtotal": 2999, "discounts": [], "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "tax_total": 630, "created_at": "2024-01-15T15:06:24.729Z", "deleted_at": null, "gift_cards": [], "payment_id": null, "updated_at": "2024-01-15T15:06:24.729Z", "customer_id": null, "completed_at": null, "sales_channel": {"id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "name": "Default Sales Channel", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z", "description": "Created by Medusa", "is_disabled": false}, "discount_total": 0, "item_tax_total": 630, "shipping_total": 0, "billing_address": null, "gift_card_total": 0, "idempotency_key": null, "payment_sessions": [], "sales_channel_id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "shipping_address": null, "shipping_methods": [], "billing_address_id": null, "raw_discount_total": 0, "shipping_tax_total": 0, "gift_card_tax_total": 0, "shipping_address_id": null, "payment_authorized_at": null}}	finished
ikey_01HKEG8SPSEK6JQ9K761GJZCE6	8ba382ff-7245-4a32-a1d9-03b14fbee655	2024-01-06 04:25:02.425121+00	\N	POST	{"id": "cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5"}	/cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5/line-items	200	{"cart": {"id": "cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5", "type": "default", "email": null, "items": [{"id": "item_01HKEG8SRDW5SRXES29QJT11TG", "title": "Franela Negra con un Logo", "total": 3299, "cart_id": "cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5", "swap_id": null, "variant": {"id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "ean": null, "sku": null, "upc": null, "title": "XL", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "product": {"id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "title": "Franela Negra con un Logo", "width": null, "handle": "franela-negra-con-un-logo", "height": null, "length": null, "status": "published", "weight": null, "hs_code": null, "profile": {"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}, "type_id": null, "material": null, "metadata": null, "mid_code": null, "profiles": [{"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}], "subtitle": null, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "profile_id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "updated_at": "2024-01-06T04:23:12.699Z", "description": null, "external_id": null, "is_giftcard": false, "discountable": true, "collection_id": null, "origin_country": null}, "material": null, "metadata": null, "mid_code": null, "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "product_id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "updated_at": "2024-01-06T04:23:12.699Z", "variant_rank": 0, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 10}, "metadata": {}, "order_id": null, "quantity": 1, "subtotal": 3299, "is_return": false, "tax_lines": [{"code": "default", "name": "default", "rate": 0, "item_id": "item_01HKEG8SRDW5SRXES29QJT11TG"}], "tax_total": 0, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-06T04:25:02.458Z", "unit_price": 3299, "updated_at": "2024-01-06T04:25:02.458Z", "variant_id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "adjustments": [], "description": "XL", "is_giftcard": false, "has_shipping": false, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 3299, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 0, "raw_discount_total": 0}], "total": 3299, "object": "cart", "region": {"id": "reg_01HJQ62FKBJHFRR89DWYF1XVAM", "name": "NA", "metadata": null, "tax_code": null, "tax_rate": 0, "countries": [{"id": 39, "name": "CANADA", "iso_2": "ca", "iso_3": "can", "num_code": 124, "region_id": "reg_01HJQ62FKBJHFRR89DWYF1XVAM", "display_name": "Canada"}, {"id": 236, "name": "UNITED STATES", "iso_2": "us", "iso_3": "usa", "num_code": 840, "region_id": "reg_01HJQ62FKBJHFRR89DWYF1XVAM", "display_name": "United States"}], "tax_rates": [], "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:17.482Z", "currency_code": "usd", "automatic_taxes": true, "tax_provider_id": null, "payment_providers": [{"id": "manual", "is_installed": true}], "gift_cards_taxable": true}, "context": {"ip": "190.120.249.240", "user_agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36"}, "payment": null, "customer": null, "metadata": null, "subtotal": 3299, "discounts": [], "region_id": "reg_01HJQ62FKBJHFRR89DWYF1XVAM", "tax_total": 0, "created_at": "2023-12-30T12:01:04.296Z", "deleted_at": null, "gift_cards": [], "payment_id": null, "updated_at": "2024-01-06T04:16:00.476Z", "customer_id": null, "completed_at": null, "sales_channel": {"id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "name": "Default Sales Channel", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z", "description": "Created by Medusa", "is_disabled": false}, "discount_total": 0, "item_tax_total": 0, "shipping_total": 0, "billing_address": null, "gift_card_total": 0, "idempotency_key": null, "payment_sessions": [], "sales_channel_id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "shipping_address": {"id": "addr_01HKEEXM20VE433YHRTKT9QQQ2", "city": null, "phone": null, "company": null, "metadata": null, "province": null, "address_1": null, "address_2": null, "last_name": null, "created_at": "2024-01-06T04:01:27.571Z", "deleted_at": null, "first_name": null, "updated_at": "2024-01-06T04:01:27.571Z", "customer_id": null, "postal_code": null, "country_code": null}, "shipping_methods": [], "billing_address_id": null, "raw_discount_total": 0, "shipping_tax_total": 0, "gift_card_tax_total": 0, "shipping_address_id": "addr_01HKEEXM20VE433YHRTKT9QQQ2", "payment_authorized_at": null}}	finished
ikey_01HKEG9E6BQA0VM0XS9QFSY08C	df203094-5c00-4242-bca3-05dd64ce5f65	2024-01-06 04:25:23.403434+00	\N	POST	{"id": "cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5"}	/cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5/line-items	200	{"cart": {"id": "cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5", "type": "default", "email": null, "items": [{"id": "item_01HKEG8SRDW5SRXES29QJT11TG", "title": "Franela Negra con un Logo", "total": 3299, "cart_id": "cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5", "swap_id": null, "variant": {"id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "ean": null, "sku": null, "upc": null, "title": "XL", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "product": {"id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "title": "Franela Negra con un Logo", "width": null, "handle": "franela-negra-con-un-logo", "height": null, "length": null, "status": "published", "weight": null, "hs_code": null, "profile": {"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}, "type_id": null, "material": null, "metadata": null, "mid_code": null, "profiles": [{"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}], "subtitle": null, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "profile_id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "updated_at": "2024-01-06T04:23:12.699Z", "description": null, "external_id": null, "is_giftcard": false, "discountable": true, "collection_id": null, "origin_country": null}, "material": null, "metadata": null, "mid_code": null, "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "product_id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "updated_at": "2024-01-06T04:23:12.699Z", "variant_rank": 0, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 10}, "metadata": {}, "order_id": null, "quantity": 1, "subtotal": 3299, "is_return": false, "tax_lines": [{"code": "default", "name": "default", "rate": 0, "item_id": "item_01HKEG8SRDW5SRXES29QJT11TG"}], "tax_total": 0, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-06T04:25:02.458Z", "unit_price": 3299, "updated_at": "2024-01-06T04:25:02.458Z", "variant_id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "adjustments": [], "description": "XL", "is_giftcard": false, "has_shipping": false, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 3299, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 0, "raw_discount_total": 0}, {"id": "item_01HKEG9E7NCNQRM18Q5J7D023Q", "title": "Medusa Sweatpants", "total": 3350, "cart_id": "cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5", "swap_id": null, "variant": {"id": "variant_01HJQ62GGFHCX6NG3JH63SJRR5", "ean": null, "sku": null, "upc": null, "title": "M", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "product": {"id": "prod_01HJQ62GEQ1EPNN20XP5FFHZ2H", "title": "Medusa Sweatpants", "width": null, "handle": "sweatpants", "height": null, "length": null, "status": "published", "weight": 400, "hs_code": null, "profile": {"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}, "type_id": null, "material": null, "metadata": null, "mid_code": null, "profiles": [{"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}], "subtitle": null, "thumbnail": "https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatpants-gray-front.png", "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "profile_id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "updated_at": "2023-12-28T03:04:17.482Z", "description": "Reimagine the feeling of classic sweatpants. With our cotton sweatpants, everyday essentials no longer have to be ordinary.", "external_id": null, "is_giftcard": false, "discountable": true, "collection_id": null, "origin_country": null}, "material": null, "metadata": null, "mid_code": null, "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "product_id": "prod_01HJQ62GEQ1EPNN20XP5FFHZ2H", "updated_at": "2023-12-28T03:04:17.482Z", "variant_rank": 1, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 100}, "metadata": {}, "order_id": null, "quantity": 1, "subtotal": 3350, "is_return": false, "tax_lines": [{"code": "default", "name": "default", "rate": 0, "item_id": "item_01HKEG9E7NCNQRM18Q5J7D023Q"}], "tax_total": 0, "thumbnail": "https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatpants-gray-front.png", "created_at": "2024-01-06T04:25:23.427Z", "unit_price": 3350, "updated_at": "2024-01-06T04:25:23.427Z", "variant_id": "variant_01HJQ62GGFHCX6NG3JH63SJRR5", "adjustments": [], "description": "M", "is_giftcard": false, "has_shipping": false, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 3350, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 0, "raw_discount_total": 0}], "total": 6649, "object": "cart", "region": {"id": "reg_01HJQ62FKBJHFRR89DWYF1XVAM", "name": "NA", "metadata": null, "tax_code": null, "tax_rate": 0, "countries": [{"id": 39, "name": "CANADA", "iso_2": "ca", "iso_3": "can", "num_code": 124, "region_id": "reg_01HJQ62FKBJHFRR89DWYF1XVAM", "display_name": "Canada"}, {"id": 236, "name": "UNITED STATES", "iso_2": "us", "iso_3": "usa", "num_code": 840, "region_id": "reg_01HJQ62FKBJHFRR89DWYF1XVAM", "display_name": "United States"}], "tax_rates": [], "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:17.482Z", "currency_code": "usd", "automatic_taxes": true, "tax_provider_id": null, "payment_providers": [{"id": "manual", "is_installed": true}], "gift_cards_taxable": true}, "context": {"ip": "190.120.249.240", "user_agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36"}, "payment": null, "customer": null, "metadata": null, "subtotal": 6649, "discounts": [], "region_id": "reg_01HJQ62FKBJHFRR89DWYF1XVAM", "tax_total": 0, "created_at": "2023-12-30T12:01:04.296Z", "deleted_at": null, "gift_cards": [], "payment_id": null, "updated_at": "2024-01-06T04:16:00.476Z", "customer_id": null, "completed_at": null, "sales_channel": {"id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "name": "Default Sales Channel", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z", "description": "Created by Medusa", "is_disabled": false}, "discount_total": 0, "item_tax_total": 0, "shipping_total": 0, "billing_address": null, "gift_card_total": 0, "idempotency_key": null, "payment_sessions": [], "sales_channel_id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "shipping_address": {"id": "addr_01HKEEXM20VE433YHRTKT9QQQ2", "city": null, "phone": null, "company": null, "metadata": null, "province": null, "address_1": null, "address_2": null, "last_name": null, "created_at": "2024-01-06T04:01:27.571Z", "deleted_at": null, "first_name": null, "updated_at": "2024-01-06T04:01:27.571Z", "customer_id": null, "postal_code": null, "country_code": null}, "shipping_methods": [], "billing_address_id": null, "raw_discount_total": 0, "shipping_tax_total": 0, "gift_card_tax_total": 0, "shipping_address_id": "addr_01HKEEXM20VE433YHRTKT9QQQ2", "payment_authorized_at": null}}	finished
ikey_01HNDCBRM2ZRTS8DZ0BXV9MT30	adc40913-9c26-4c96-b6a7-6425466bdc16	2024-01-30 14:28:54.527707+00	\N	POST	{"id": "cart_01HM6THN376FNFK12TTTPYR2KH"}	/cart_01HM6THN376FNFK12TTTPYR2KH/payment-sessions	200	{"cart": {"id": "cart_01HM6THN376FNFK12TTTPYR2KH", "type": "default", "email": null, "items": [{"id": "item_01HNDCBH76E0T3YMYY4Q22GEFF", "title": "Franela Negra con un Logo", "total": 3629, "cart_id": "cart_01HM6THN376FNFK12TTTPYR2KH", "swap_id": null, "variant": {"id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "ean": null, "sku": null, "upc": null, "title": "XL", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "product": {"id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "title": "Franela Negra con un Logo", "width": null, "handle": "franela-negra-con-un-logo", "height": null, "length": null, "status": "published", "weight": null, "hs_code": null, "profile": {"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}, "type_id": null, "material": null, "metadata": null, "mid_code": null, "profiles": [{"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}], "subtitle": null, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "profile_id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "updated_at": "2024-01-06T04:23:12.699Z", "description": null, "external_id": null, "is_giftcard": false, "discountable": true, "collection_id": null, "origin_country": null}, "material": null, "metadata": null, "mid_code": null, "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "product_id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "updated_at": "2024-01-23T21:42:12.527Z", "variant_rank": 0, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 6}, "metadata": {}, "order_id": null, "quantity": 1, "subtotal": 2999, "is_return": false, "tax_lines": [{"code": "21", "name": "21% iva", "rate": 21, "item_id": "item_01HNDCBH76E0T3YMYY4Q22GEFF"}], "tax_total": 630, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-30T14:28:46.924Z", "unit_price": 2999, "updated_at": "2024-01-30T14:28:46.924Z", "variant_id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "adjustments": [], "description": "XL", "is_giftcard": false, "has_shipping": false, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 3629, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 630, "raw_discount_total": 0}], "total": 3629, "object": "cart", "region": {"id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "name": "EU", "metadata": null, "tax_code": null, "tax_rate": 0, "countries": [{"id": 109, "name": "ITALY", "iso_2": "it", "iso_3": "ita", "num_code": 380, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Italy"}, {"id": 209, "name": "SPAIN", "iso_2": "es", "iso_3": "esp", "num_code": 724, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Spain"}, {"id": 75, "name": "FRANCE", "iso_2": "fr", "iso_3": "fra", "num_code": 250, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "France"}, {"id": 60, "name": "DENMARK", "iso_2": "dk", "iso_3": "dnk", "num_code": 208, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Denmark"}, {"id": 82, "name": "GERMANY", "iso_2": "de", "iso_3": "deu", "num_code": 276, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Germany"}, {"id": 235, "name": "UNITED KINGDOM", "iso_2": "gb", "iso_3": "gbr", "num_code": 826, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "United Kingdom"}, {"id": 215, "name": "SWEDEN", "iso_2": "se", "iso_3": "swe", "num_code": 752, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Sweden"}], "tax_rates": [{"id": "txr_01HM6VF955JXB29T12X4ZEDBKG", "code": "21", "name": "21% iva", "rate": 21, "metadata": null, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "created_at": "2024-01-15T15:22:35.555Z", "updated_at": "2024-01-15T15:22:35.555Z"}], "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:17.482Z", "currency_code": "eur", "automatic_taxes": true, "tax_provider_id": null, "payment_providers": [{"id": "manual", "is_installed": true}], "gift_cards_taxable": true}, "context": {"ip": "85.59.11.41", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"}, "payment": null, "metadata": null, "subtotal": 2999, "discounts": [], "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "tax_total": 630, "created_at": "2024-01-15T15:06:24.729Z", "deleted_at": null, "gift_cards": [], "payment_id": null, "updated_at": "2024-01-15T15:06:24.729Z", "customer_id": null, "completed_at": null, "sales_channel": {"id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "name": "Default Sales Channel", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z", "description": "Created by Medusa", "is_disabled": false}, "discount_total": 0, "item_tax_total": 630, "shipping_total": 0, "billing_address": null, "gift_card_total": 0, "idempotency_key": null, "payment_session": {"id": "ps_01HNDCBRN5JAWR89VQ60HF51EK", "data": {"status": "pending"}, "amount": 3629, "status": "pending", "cart_id": "cart_01HM6THN376FNFK12TTTPYR2KH", "created_at": "2024-01-30T14:28:54.533Z", "updated_at": "2024-01-30T14:28:54.533Z", "is_selected": true, "provider_id": "manual", "is_initiated": true, "idempotency_key": null, "payment_authorized_at": null}, "payment_sessions": [{"id": "ps_01HNDCBRN5JAWR89VQ60HF51EK", "data": {"status": "pending"}, "amount": 3629, "status": "pending", "cart_id": "cart_01HM6THN376FNFK12TTTPYR2KH", "created_at": "2024-01-30T14:28:54.533Z", "updated_at": "2024-01-30T14:28:54.533Z", "is_selected": true, "provider_id": "manual", "is_initiated": true, "idempotency_key": null, "payment_authorized_at": null}], "sales_channel_id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "shipping_address": null, "shipping_methods": [], "billing_address_id": null, "raw_discount_total": 0, "shipping_tax_total": 0, "gift_card_tax_total": 0, "shipping_address_id": null, "payment_authorized_at": null}}	finished
ikey_01HKEG9WMNJD624BP42NDHHXDB	6a434884-9c8e-457f-8a2a-c12c8505c076	2024-01-06 04:25:38.197271+00	\N	POST	{"id": "cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5"}	/cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5/line-items	200	{"cart": {"id": "cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5", "type": "default", "email": null, "items": [{"id": "item_01HKEG8SRDW5SRXES29QJT11TG", "title": "Franela Negra con un Logo", "total": 3299, "cart_id": "cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5", "swap_id": null, "variant": {"id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "ean": null, "sku": null, "upc": null, "title": "XL", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "product": {"id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "title": "Franela Negra con un Logo", "width": null, "handle": "franela-negra-con-un-logo", "height": null, "length": null, "status": "published", "weight": null, "hs_code": null, "profile": {"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}, "type_id": null, "material": null, "metadata": null, "mid_code": null, "profiles": [{"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}], "subtitle": null, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "profile_id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "updated_at": "2024-01-06T04:23:12.699Z", "description": null, "external_id": null, "is_giftcard": false, "discountable": true, "collection_id": null, "origin_country": null}, "material": null, "metadata": null, "mid_code": null, "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "product_id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "updated_at": "2024-01-06T04:23:12.699Z", "variant_rank": 0, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 10}, "metadata": {}, "order_id": null, "quantity": 1, "subtotal": 3299, "is_return": false, "tax_lines": [{"code": "default", "name": "default", "rate": 0, "item_id": "item_01HKEG8SRDW5SRXES29QJT11TG"}], "tax_total": 0, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-06T04:25:02.458Z", "unit_price": 3299, "updated_at": "2024-01-06T04:25:02.458Z", "variant_id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "adjustments": [], "description": "XL", "is_giftcard": false, "has_shipping": false, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 3299, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 0, "raw_discount_total": 0}, {"id": "item_01HKEG9E7NCNQRM18Q5J7D023Q", "title": "Medusa Sweatpants", "total": 3350, "cart_id": "cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5", "swap_id": null, "variant": {"id": "variant_01HJQ62GGFHCX6NG3JH63SJRR5", "ean": null, "sku": null, "upc": null, "title": "M", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "product": {"id": "prod_01HJQ62GEQ1EPNN20XP5FFHZ2H", "title": "Medusa Sweatpants", "width": null, "handle": "sweatpants", "height": null, "length": null, "status": "published", "weight": 400, "hs_code": null, "profile": {"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}, "type_id": null, "material": null, "metadata": null, "mid_code": null, "profiles": [{"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}], "subtitle": null, "thumbnail": "https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatpants-gray-front.png", "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "profile_id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "updated_at": "2023-12-28T03:04:17.482Z", "description": "Reimagine the feeling of classic sweatpants. With our cotton sweatpants, everyday essentials no longer have to be ordinary.", "external_id": null, "is_giftcard": false, "discountable": true, "collection_id": null, "origin_country": null}, "material": null, "metadata": null, "mid_code": null, "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "product_id": "prod_01HJQ62GEQ1EPNN20XP5FFHZ2H", "updated_at": "2023-12-28T03:04:17.482Z", "variant_rank": 1, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 100}, "metadata": {}, "order_id": null, "quantity": 1, "subtotal": 3350, "is_return": false, "tax_lines": [{"code": "default", "name": "default", "rate": 0, "item_id": "item_01HKEG9E7NCNQRM18Q5J7D023Q"}], "tax_total": 0, "thumbnail": "https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatpants-gray-front.png", "created_at": "2024-01-06T04:25:23.427Z", "unit_price": 3350, "updated_at": "2024-01-06T04:25:23.427Z", "variant_id": "variant_01HJQ62GGFHCX6NG3JH63SJRR5", "adjustments": [], "description": "M", "is_giftcard": false, "has_shipping": false, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 3350, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 0, "raw_discount_total": 0}, {"id": "item_01HKEG9WNT60N7BF1WFP74FYEJ", "title": "Medusa Hoodie", "total": 4150, "cart_id": "cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5", "swap_id": null, "variant": {"id": "variant_01HJQ62GSGSKX7ZPXBKBMJRP28", "ean": null, "sku": null, "upc": null, "title": "M", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "product": {"id": "prod_01HJQ62GQGCQ64V8BMRHT1VAT7", "title": "Medusa Hoodie", "width": null, "handle": "hoodie", "height": null, "length": null, "status": "published", "weight": 400, "hs_code": null, "profile": {"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}, "type_id": null, "material": null, "metadata": null, "mid_code": null, "profiles": [{"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}], "subtitle": null, "thumbnail": "https://medusa-public-images.s3.eu-west-1.amazonaws.com/black_hoodie_front.png", "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "profile_id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "updated_at": "2023-12-28T03:04:17.482Z", "description": "Reimagine the feeling of a classic hoodie. With our cotton hoodie, everyday essentials no longer have to be ordinary.", "external_id": null, "is_giftcard": false, "discountable": true, "collection_id": null, "origin_country": null}, "material": null, "metadata": null, "mid_code": null, "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "product_id": "prod_01HJQ62GQGCQ64V8BMRHT1VAT7", "updated_at": "2023-12-28T03:04:17.482Z", "variant_rank": 1, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 100}, "metadata": {}, "order_id": null, "quantity": 1, "subtotal": 4150, "is_return": false, "tax_lines": [{"code": "default", "name": "default", "rate": 0, "item_id": "item_01HKEG9WNT60N7BF1WFP74FYEJ"}], "tax_total": 0, "thumbnail": "https://medusa-public-images.s3.eu-west-1.amazonaws.com/black_hoodie_front.png", "created_at": "2024-01-06T04:25:38.217Z", "unit_price": 4150, "updated_at": "2024-01-06T04:25:38.217Z", "variant_id": "variant_01HJQ62GSGSKX7ZPXBKBMJRP28", "adjustments": [], "description": "M", "is_giftcard": false, "has_shipping": false, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 4150, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 0, "raw_discount_total": 0}], "total": 10799, "object": "cart", "region": {"id": "reg_01HJQ62FKBJHFRR89DWYF1XVAM", "name": "NA", "metadata": null, "tax_code": null, "tax_rate": 0, "countries": [{"id": 39, "name": "CANADA", "iso_2": "ca", "iso_3": "can", "num_code": 124, "region_id": "reg_01HJQ62FKBJHFRR89DWYF1XVAM", "display_name": "Canada"}, {"id": 236, "name": "UNITED STATES", "iso_2": "us", "iso_3": "usa", "num_code": 840, "region_id": "reg_01HJQ62FKBJHFRR89DWYF1XVAM", "display_name": "United States"}], "tax_rates": [], "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:17.482Z", "currency_code": "usd", "automatic_taxes": true, "tax_provider_id": null, "payment_providers": [{"id": "manual", "is_installed": true}], "gift_cards_taxable": true}, "context": {"ip": "190.120.249.240", "user_agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36"}, "payment": null, "customer": null, "metadata": null, "subtotal": 10799, "discounts": [], "region_id": "reg_01HJQ62FKBJHFRR89DWYF1XVAM", "tax_total": 0, "created_at": "2023-12-30T12:01:04.296Z", "deleted_at": null, "gift_cards": [], "payment_id": null, "updated_at": "2024-01-06T04:16:00.476Z", "customer_id": null, "completed_at": null, "sales_channel": {"id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "name": "Default Sales Channel", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z", "description": "Created by Medusa", "is_disabled": false}, "discount_total": 0, "item_tax_total": 0, "shipping_total": 0, "billing_address": null, "gift_card_total": 0, "idempotency_key": null, "payment_sessions": [], "sales_channel_id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "shipping_address": {"id": "addr_01HKEEXM20VE433YHRTKT9QQQ2", "city": null, "phone": null, "company": null, "metadata": null, "province": null, "address_1": null, "address_2": null, "last_name": null, "created_at": "2024-01-06T04:01:27.571Z", "deleted_at": null, "first_name": null, "updated_at": "2024-01-06T04:01:27.571Z", "customer_id": null, "postal_code": null, "country_code": null}, "shipping_methods": [], "billing_address_id": null, "raw_discount_total": 0, "shipping_tax_total": 0, "gift_card_tax_total": 0, "shipping_address_id": "addr_01HKEEXM20VE433YHRTKT9QQQ2", "payment_authorized_at": null}}	finished
ikey_01HKEGEDV7QHHKBHT1YRADY2K7	2e705e85-bcf6-4f4e-8e9f-b77c30b9e353	2024-01-06 04:28:06.884055+00	\N	POST	{"id": "cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5"}	/cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5/payment-sessions	200	{"cart": {"id": "cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5", "type": "default", "email": null, "items": [{"id": "item_01HKEG8SRDW5SRXES29QJT11TG", "title": "Franela Negra con un Logo", "total": 9897, "cart_id": "cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5", "swap_id": null, "variant": {"id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "ean": null, "sku": null, "upc": null, "title": "XL", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "product": {"id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "title": "Franela Negra con un Logo", "width": null, "handle": "franela-negra-con-un-logo", "height": null, "length": null, "status": "published", "weight": null, "hs_code": null, "profile": {"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}, "type_id": null, "material": null, "metadata": null, "mid_code": null, "profiles": [{"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}], "subtitle": null, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "profile_id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "updated_at": "2024-01-06T04:23:12.699Z", "description": null, "external_id": null, "is_giftcard": false, "discountable": true, "collection_id": null, "origin_country": null}, "material": null, "metadata": null, "mid_code": null, "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "product_id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "updated_at": "2024-01-06T04:23:12.699Z", "variant_rank": 0, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 10}, "metadata": {}, "order_id": null, "quantity": 3, "subtotal": 9897, "is_return": false, "tax_lines": [{"code": "default", "name": "default", "rate": 0, "item_id": "item_01HKEG8SRDW5SRXES29QJT11TG"}], "tax_total": 0, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-06T04:25:02.458Z", "unit_price": 3299, "updated_at": "2024-01-06T04:26:02.887Z", "variant_id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "adjustments": [], "description": "XL", "is_giftcard": false, "has_shipping": false, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 9897, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 0, "raw_discount_total": 0}, {"id": "item_01HKEG9E7NCNQRM18Q5J7D023Q", "title": "Medusa Sweatpants", "total": 6700, "cart_id": "cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5", "swap_id": null, "variant": {"id": "variant_01HJQ62GGFHCX6NG3JH63SJRR5", "ean": null, "sku": null, "upc": null, "title": "M", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "product": {"id": "prod_01HJQ62GEQ1EPNN20XP5FFHZ2H", "title": "Medusa Sweatpants", "width": null, "handle": "sweatpants", "height": null, "length": null, "status": "published", "weight": 400, "hs_code": null, "profile": {"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}, "type_id": null, "material": null, "metadata": null, "mid_code": null, "profiles": [{"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}], "subtitle": null, "thumbnail": "https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatpants-gray-front.png", "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "profile_id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "updated_at": "2023-12-28T03:04:17.482Z", "description": "Reimagine the feeling of classic sweatpants. With our cotton sweatpants, everyday essentials no longer have to be ordinary.", "external_id": null, "is_giftcard": false, "discountable": true, "collection_id": null, "origin_country": null}, "material": null, "metadata": null, "mid_code": null, "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "product_id": "prod_01HJQ62GEQ1EPNN20XP5FFHZ2H", "updated_at": "2023-12-28T03:04:17.482Z", "variant_rank": 1, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 100}, "metadata": {}, "order_id": null, "quantity": 2, "subtotal": 6700, "is_return": false, "tax_lines": [{"code": "default", "name": "default", "rate": 0, "item_id": "item_01HKEG9E7NCNQRM18Q5J7D023Q"}], "tax_total": 0, "thumbnail": "https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatpants-gray-front.png", "created_at": "2024-01-06T04:25:23.427Z", "unit_price": 3350, "updated_at": "2024-01-06T04:26:04.553Z", "variant_id": "variant_01HJQ62GGFHCX6NG3JH63SJRR5", "adjustments": [], "description": "M", "is_giftcard": false, "has_shipping": false, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 6700, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 0, "raw_discount_total": 0}, {"id": "item_01HKEG9WNT60N7BF1WFP74FYEJ", "title": "Medusa Hoodie", "total": 4150, "cart_id": "cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5", "swap_id": null, "variant": {"id": "variant_01HJQ62GSGSKX7ZPXBKBMJRP28", "ean": null, "sku": null, "upc": null, "title": "M", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "product": {"id": "prod_01HJQ62GQGCQ64V8BMRHT1VAT7", "title": "Medusa Hoodie", "width": null, "handle": "hoodie", "height": null, "length": null, "status": "published", "weight": 400, "hs_code": null, "profile": {"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}, "type_id": null, "material": null, "metadata": null, "mid_code": null, "profiles": [{"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}], "subtitle": null, "thumbnail": "https://medusa-public-images.s3.eu-west-1.amazonaws.com/black_hoodie_front.png", "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "profile_id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "updated_at": "2023-12-28T03:04:17.482Z", "description": "Reimagine the feeling of a classic hoodie. With our cotton hoodie, everyday essentials no longer have to be ordinary.", "external_id": null, "is_giftcard": false, "discountable": true, "collection_id": null, "origin_country": null}, "material": null, "metadata": null, "mid_code": null, "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "product_id": "prod_01HJQ62GQGCQ64V8BMRHT1VAT7", "updated_at": "2023-12-28T03:04:17.482Z", "variant_rank": 1, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 100}, "metadata": {}, "order_id": null, "quantity": 1, "subtotal": 4150, "is_return": false, "tax_lines": [{"code": "default", "name": "default", "rate": 0, "item_id": "item_01HKEG9WNT60N7BF1WFP74FYEJ"}], "tax_total": 0, "thumbnail": "https://medusa-public-images.s3.eu-west-1.amazonaws.com/black_hoodie_front.png", "created_at": "2024-01-06T04:25:38.217Z", "unit_price": 4150, "updated_at": "2024-01-06T04:25:38.217Z", "variant_id": "variant_01HJQ62GSGSKX7ZPXBKBMJRP28", "adjustments": [], "description": "M", "is_giftcard": false, "has_shipping": false, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 4150, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 0, "raw_discount_total": 0}], "total": 20747, "object": "cart", "region": {"id": "reg_01HJQ62FKBJHFRR89DWYF1XVAM", "name": "NA", "metadata": null, "tax_code": null, "tax_rate": 0, "countries": [{"id": 39, "name": "CANADA", "iso_2": "ca", "iso_3": "can", "num_code": 124, "region_id": "reg_01HJQ62FKBJHFRR89DWYF1XVAM", "display_name": "Canada"}, {"id": 236, "name": "UNITED STATES", "iso_2": "us", "iso_3": "usa", "num_code": 840, "region_id": "reg_01HJQ62FKBJHFRR89DWYF1XVAM", "display_name": "United States"}], "tax_rates": [], "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:17.482Z", "currency_code": "usd", "automatic_taxes": true, "tax_provider_id": null, "payment_providers": [{"id": "manual", "is_installed": true}], "gift_cards_taxable": true}, "context": {"ip": "190.120.249.240", "user_agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36"}, "payment": null, "metadata": null, "subtotal": 20747, "discounts": [], "region_id": "reg_01HJQ62FKBJHFRR89DWYF1XVAM", "tax_total": 0, "created_at": "2023-12-30T12:01:04.296Z", "deleted_at": null, "gift_cards": [], "payment_id": null, "updated_at": "2024-01-06T04:16:00.476Z", "customer_id": null, "completed_at": null, "sales_channel": {"id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "name": "Default Sales Channel", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z", "description": "Created by Medusa", "is_disabled": false}, "discount_total": 0, "item_tax_total": 0, "shipping_total": 0, "billing_address": null, "gift_card_total": 0, "idempotency_key": null, "payment_session": {"id": "ps_01HKEGEDWK2TJK7T9XXHSVQS06", "data": {"status": "pending"}, "amount": 20747, "status": "pending", "cart_id": "cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5", "created_at": "2024-01-06T04:28:06.891Z", "updated_at": "2024-01-06T04:28:06.891Z", "is_selected": true, "provider_id": "manual", "is_initiated": true, "idempotency_key": null, "payment_authorized_at": null}, "payment_sessions": [{"id": "ps_01HKEGEDWK2TJK7T9XXHSVQS06", "data": {"status": "pending"}, "amount": 20747, "status": "pending", "cart_id": "cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5", "created_at": "2024-01-06T04:28:06.891Z", "updated_at": "2024-01-06T04:28:06.891Z", "is_selected": true, "provider_id": "manual", "is_initiated": true, "idempotency_key": null, "payment_authorized_at": null}], "sales_channel_id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "shipping_address": {"id": "addr_01HKEEXM20VE433YHRTKT9QQQ2", "city": null, "phone": null, "company": null, "metadata": null, "province": null, "address_1": null, "address_2": null, "last_name": null, "created_at": "2024-01-06T04:01:27.571Z", "deleted_at": null, "first_name": null, "updated_at": "2024-01-06T04:01:27.571Z", "customer_id": null, "postal_code": null, "country_code": null}, "shipping_methods": [], "billing_address_id": null, "raw_discount_total": 0, "shipping_tax_total": 0, "gift_card_tax_total": 0, "shipping_address_id": "addr_01HKEEXM20VE433YHRTKT9QQQ2", "payment_authorized_at": null}}	finished
ikey_01HKEGFF6NK3A5XP0RZ6ESYEE9	69b05c1e-c130-4e65-85eb-b57a90c37aed	2024-01-06 04:28:41.042851+00	\N	POST	{"id": "cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5"}	/cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5/complete	200	{"data": {"id": "order_01HKEGFFG7P3NFDAE7WV6DTQAH", "email": "ejemplo1065@gmail.com", "items": [{"id": "item_01HKEG8SRDW5SRXES29QJT11TG", "title": "Franela Negra con un Logo", "total": 9897, "cart_id": "cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5", "swap_id": null, "variant": {"id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "ean": null, "sku": null, "upc": null, "title": "XL", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "material": null, "metadata": null, "mid_code": null, "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "product_id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "updated_at": "2024-01-06T04:28:41.256Z", "variant_rank": 0, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 7}, "metadata": {}, "order_id": "order_01HKEGFFG7P3NFDAE7WV6DTQAH", "quantity": 3, "subtotal": 9897, "is_return": false, "tax_lines": [{"id": "litl_01HKEGFF7RNESRM1CCFB9Y1AEM", "code": "default", "name": "default", "rate": 0, "item_id": "item_01HKEG8SRDW5SRXES29QJT11TG", "metadata": null, "created_at": "2024-01-06T04:28:41.049Z", "updated_at": "2024-01-06T04:28:41.256Z"}], "tax_total": 0, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-06T04:25:02.458Z", "refundable": 9897, "unit_price": 3299, "updated_at": "2024-01-06T04:28:41.256Z", "variant_id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "adjustments": [], "description": "XL", "is_giftcard": false, "has_shipping": true, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 9897, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 0, "raw_discount_total": 0}, {"id": "item_01HKEG9E7NCNQRM18Q5J7D023Q", "title": "Medusa Sweatpants", "total": 6700, "cart_id": "cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5", "swap_id": null, "variant": {"id": "variant_01HJQ62GGFHCX6NG3JH63SJRR5", "ean": null, "sku": null, "upc": null, "title": "M", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "material": null, "metadata": null, "mid_code": null, "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "product_id": "prod_01HJQ62GEQ1EPNN20XP5FFHZ2H", "updated_at": "2024-01-06T04:28:41.256Z", "variant_rank": 1, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 98}, "metadata": {}, "order_id": "order_01HKEGFFG7P3NFDAE7WV6DTQAH", "quantity": 2, "subtotal": 6700, "is_return": false, "tax_lines": [{"id": "litl_01HKEGFF7R88ZRSW8ASP4NDAZX", "code": "default", "name": "default", "rate": 0, "item_id": "item_01HKEG9E7NCNQRM18Q5J7D023Q", "metadata": null, "created_at": "2024-01-06T04:28:41.049Z", "updated_at": "2024-01-06T04:28:41.256Z"}], "tax_total": 0, "thumbnail": "https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatpants-gray-front.png", "created_at": "2024-01-06T04:25:23.427Z", "refundable": 6700, "unit_price": 3350, "updated_at": "2024-01-06T04:28:41.256Z", "variant_id": "variant_01HJQ62GGFHCX6NG3JH63SJRR5", "adjustments": [], "description": "M", "is_giftcard": false, "has_shipping": true, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 6700, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 0, "raw_discount_total": 0}, {"id": "item_01HKEG9WNT60N7BF1WFP74FYEJ", "title": "Medusa Hoodie", "total": 4150, "cart_id": "cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5", "swap_id": null, "variant": {"id": "variant_01HJQ62GSGSKX7ZPXBKBMJRP28", "ean": null, "sku": null, "upc": null, "title": "M", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "material": null, "metadata": null, "mid_code": null, "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "product_id": "prod_01HJQ62GQGCQ64V8BMRHT1VAT7", "updated_at": "2024-01-06T04:28:41.256Z", "variant_rank": 1, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 99}, "metadata": {}, "order_id": "order_01HKEGFFG7P3NFDAE7WV6DTQAH", "quantity": 1, "subtotal": 4150, "is_return": false, "tax_lines": [{"id": "litl_01HKEGFF7RMT4KNFYFYVJ2HK41", "code": "default", "name": "default", "rate": 0, "item_id": "item_01HKEG9WNT60N7BF1WFP74FYEJ", "metadata": null, "created_at": "2024-01-06T04:28:41.049Z", "updated_at": "2024-01-06T04:28:41.256Z"}], "tax_total": 0, "thumbnail": "https://medusa-public-images.s3.eu-west-1.amazonaws.com/black_hoodie_front.png", "created_at": "2024-01-06T04:25:38.217Z", "refundable": 4150, "unit_price": 4150, "updated_at": "2024-01-06T04:28:41.256Z", "variant_id": "variant_01HJQ62GSGSKX7ZPXBKBMJRP28", "adjustments": [], "description": "M", "is_giftcard": false, "has_shipping": true, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 4150, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 0, "raw_discount_total": 0}], "swaps": [], "total": 21547, "claims": [], "object": "order", "region": {"id": "reg_01HJQ62FKBJHFRR89DWYF1XVAM", "name": "NA", "metadata": null, "tax_code": null, "tax_rate": 0, "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:17.482Z", "currency_code": "usd", "automatic_taxes": true, "tax_provider_id": null, "gift_cards_taxable": true}, "status": "pending", "cart_id": "cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5", "refunds": [], "metadata": {}, "payments": [{"id": "pay_01HKEGFFB2TGHBT39RB6S3J03K", "data": {"status": "authorized"}, "amount": 21547, "cart_id": "cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5", "swap_id": null, "metadata": null, "order_id": "order_01HKEGFFG7P3NFDAE7WV6DTQAH", "created_at": "2024-01-06T04:28:41.091Z", "updated_at": "2024-01-06T04:28:41.256Z", "canceled_at": null, "captured_at": null, "provider_id": "manual", "currency_code": "usd", "amount_refunded": 0, "idempotency_key": null}], "subtotal": 20747, "tax_rate": null, "discounts": [], "region_id": "reg_01HJQ62FKBJHFRR89DWYF1XVAM", "tax_total": 0, "created_at": "2024-01-06T04:28:41.256Z", "display_id": 1, "gift_cards": [], "paid_total": 21547, "updated_at": "2024-01-06T04:28:41.256Z", "canceled_at": null, "customer_id": "cus_01HKEGBS7NS9MWK5ZYX4N07VM8", "external_id": null, "currency_code": "usd", "discount_total": 0, "draft_order_id": null, "item_tax_total": 0, "payment_status": "awaiting", "refunded_total": 0, "shipping_total": 800, "gift_card_total": 0, "idempotency_key": null, "no_notification": null, "sales_channel_id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "shipping_address": {"id": "addr_01HKEEXM20VE433YHRTKT9QQQ2", "city": "Valle de la pascua", "phone": "", "company": "", "metadata": null, "province": "Guárico", "address_1": "Vidalguia ll", "address_2": "", "last_name": "Montoya", "created_at": "2024-01-06T04:01:27.571Z", "deleted_at": null, "first_name": "Douglas", "updated_at": "2024-01-06T04:28:26.934Z", "customer_id": null, "postal_code": "2350", "country_code": "us"}, "shipping_methods": [{"id": "sm_01HKEGF77FDNGNQCWRFKFB1SV0", "data": {}, "price": 800, "total": 800, "cart_id": "cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5", "swap_id": null, "order_id": "order_01HKEGFFG7P3NFDAE7WV6DTQAH", "subtotal": 800, "return_id": null, "tax_lines": [{"id": "smtl_01HKEGFF7SZF095GNZ54F6CVNF", "code": "default", "name": "default", "rate": 0, "metadata": null, "created_at": "2024-01-06T04:28:41.049Z", "updated_at": "2024-01-06T04:28:41.256Z", "shipping_method_id": "sm_01HKEGF77FDNGNQCWRFKFB1SV0"}], "tax_total": 0, "claim_order_id": null, "original_total": 800, "original_tax_total": 0, "shipping_option_id": "so_01HJQ62FPSXPFFEC9HWHZKED5B"}], "refundable_amount": 21547, "billing_address_id": "addr_01HKEGF1FZR4MJFBJ7GS2P84MD", "fulfillment_status": "not_fulfilled", "raw_discount_total": 0, "shipping_tax_total": 0, "gift_card_tax_total": 0, "shipping_address_id": "addr_01HKEEXM20VE433YHRTKT9QQQ2", "gift_card_transactions": []}, "type": "order"}	finished
ikey_01HNFMJE2X71T6TCYDM43Q699V	0792eaa1-0d59-413e-8011-931b8fbbdbff	2024-01-31 11:30:50.588636+00	\N	POST	{"id": "cart_01HM6THN376FNFK12TTTPYR2KH"}	/cart_01HM6THN376FNFK12TTTPYR2KH/line-items	200	{"cart": {"id": "cart_01HM6THN376FNFK12TTTPYR2KH", "type": "default", "email": null, "items": [{"id": "item_01HNDCBH76E0T3YMYY4Q22GEFF", "title": "Franela Negra con un Logo", "total": 7258, "cart_id": "cart_01HM6THN376FNFK12TTTPYR2KH", "swap_id": null, "variant": {"id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "ean": null, "sku": null, "upc": null, "title": "XL", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "product": {"id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "title": "Franela Negra con un Logo", "width": null, "handle": "franela-negra-con-un-logo", "height": null, "length": null, "status": "published", "weight": null, "hs_code": null, "profile": {"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}, "type_id": null, "material": null, "metadata": null, "mid_code": null, "profiles": [{"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}], "subtitle": null, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "profile_id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "updated_at": "2024-01-06T04:23:12.699Z", "description": null, "external_id": null, "is_giftcard": false, "discountable": true, "collection_id": null, "origin_country": null}, "material": null, "metadata": null, "mid_code": null, "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "product_id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "updated_at": "2024-01-23T21:42:12.527Z", "variant_rank": 0, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 6}, "metadata": {}, "order_id": null, "quantity": 2, "subtotal": 5998, "is_return": false, "tax_lines": [{"code": "21", "name": "21% iva", "rate": 21, "item_id": "item_01HNDCBH76E0T3YMYY4Q22GEFF"}], "tax_total": 1260, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-30T14:28:46.924Z", "unit_price": 2999, "updated_at": "2024-01-31T11:30:50.615Z", "variant_id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "adjustments": [], "description": "XL", "is_giftcard": false, "has_shipping": false, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 7258, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 1260, "raw_discount_total": 0}], "total": 7258, "object": "cart", "region": {"id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "name": "EU", "metadata": null, "tax_code": null, "tax_rate": 0, "countries": [{"id": 109, "name": "ITALY", "iso_2": "it", "iso_3": "ita", "num_code": 380, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Italy"}, {"id": 209, "name": "SPAIN", "iso_2": "es", "iso_3": "esp", "num_code": 724, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Spain"}, {"id": 75, "name": "FRANCE", "iso_2": "fr", "iso_3": "fra", "num_code": 250, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "France"}, {"id": 60, "name": "DENMARK", "iso_2": "dk", "iso_3": "dnk", "num_code": 208, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Denmark"}, {"id": 82, "name": "GERMANY", "iso_2": "de", "iso_3": "deu", "num_code": 276, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Germany"}, {"id": 235, "name": "UNITED KINGDOM", "iso_2": "gb", "iso_3": "gbr", "num_code": 826, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "United Kingdom"}, {"id": 215, "name": "SWEDEN", "iso_2": "se", "iso_3": "swe", "num_code": 752, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Sweden"}], "tax_rates": [{"id": "txr_01HM6VF955JXB29T12X4ZEDBKG", "code": "21", "name": "21% iva", "rate": 21, "metadata": null, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "created_at": "2024-01-15T15:22:35.555Z", "updated_at": "2024-01-15T15:22:35.555Z"}], "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:17.482Z", "currency_code": "eur", "automatic_taxes": true, "tax_provider_id": null, "payment_providers": [{"id": "manual", "is_installed": true}], "gift_cards_taxable": true}, "context": {"ip": "85.59.11.41", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"}, "payment": null, "customer": null, "metadata": null, "subtotal": 5998, "discounts": [], "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "tax_total": 1260, "created_at": "2024-01-15T15:06:24.729Z", "deleted_at": null, "gift_cards": [], "payment_id": null, "updated_at": "2024-01-15T15:06:24.729Z", "customer_id": null, "completed_at": null, "sales_channel": {"id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "name": "Default Sales Channel", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z", "description": "Created by Medusa", "is_disabled": false}, "discount_total": 0, "item_tax_total": 1260, "shipping_total": 0, "billing_address": null, "gift_card_total": 0, "idempotency_key": null, "payment_session": {"id": "ps_01HNDCBRN5JAWR89VQ60HF51EK", "data": {"status": "pending"}, "amount": 3629, "status": "pending", "cart_id": "cart_01HM6THN376FNFK12TTTPYR2KH", "created_at": "2024-01-30T14:28:54.533Z", "updated_at": "2024-01-30T14:28:54.533Z", "is_selected": true, "provider_id": "manual", "is_initiated": true, "idempotency_key": null, "payment_authorized_at": null}, "payment_sessions": [{"id": "ps_01HNDCBRN5JAWR89VQ60HF51EK", "data": {"status": "pending"}, "amount": 3629, "status": "pending", "cart_id": "cart_01HM6THN376FNFK12TTTPYR2KH", "created_at": "2024-01-30T14:28:54.533Z", "updated_at": "2024-01-30T14:28:54.533Z", "is_selected": true, "provider_id": "manual", "is_initiated": true, "idempotency_key": null, "payment_authorized_at": null}], "sales_channel_id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "shipping_address": null, "shipping_methods": [], "billing_address_id": null, "raw_discount_total": 0, "shipping_tax_total": 0, "gift_card_tax_total": 0, "shipping_address_id": null, "payment_authorized_at": null}}	finished
ikey_01HMW45G6ENQKGWTTYFA216EFY	d7e25c63-5813-4196-b248-2a40430caafb	2024-01-23 21:38:35.342482+00	\N	POST	{"id": "cart_01HMW455PM9KPMQ188CTN3BEPD"}	/cart_01HMW455PM9KPMQ188CTN3BEPD/line-items	200	{"cart": {"id": "cart_01HMW455PM9KPMQ188CTN3BEPD", "type": "default", "email": null, "items": [{"id": "item_01HMW45G7G981JCM75QMHN00B2", "title": "Franela Negra con un Logo", "total": 3629, "cart_id": "cart_01HMW455PM9KPMQ188CTN3BEPD", "swap_id": null, "variant": {"id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "ean": null, "sku": null, "upc": null, "title": "XL", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "product": {"id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "title": "Franela Negra con un Logo", "width": null, "handle": "franela-negra-con-un-logo", "height": null, "length": null, "status": "published", "weight": null, "hs_code": null, "profile": {"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}, "type_id": null, "material": null, "metadata": null, "mid_code": null, "profiles": [{"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}], "subtitle": null, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "profile_id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "updated_at": "2024-01-06T04:23:12.699Z", "description": null, "external_id": null, "is_giftcard": false, "discountable": true, "collection_id": null, "origin_country": null}, "material": null, "metadata": null, "mid_code": null, "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "product_id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "updated_at": "2024-01-06T04:28:41.256Z", "variant_rank": 0, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 7}, "metadata": {}, "order_id": null, "quantity": 1, "subtotal": 2999, "is_return": false, "tax_lines": [{"code": "21", "name": "21% iva", "rate": 21, "item_id": "item_01HMW45G7G981JCM75QMHN00B2"}], "tax_total": 630, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-23T21:38:35.360Z", "unit_price": 2999, "updated_at": "2024-01-23T21:38:35.360Z", "variant_id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "adjustments": [], "description": "XL", "is_giftcard": false, "has_shipping": false, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 3629, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 630, "raw_discount_total": 0}], "total": 3629, "object": "cart", "region": {"id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "name": "EU", "metadata": null, "tax_code": null, "tax_rate": 0, "countries": [{"id": 109, "name": "ITALY", "iso_2": "it", "iso_3": "ita", "num_code": 380, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Italy"}, {"id": 209, "name": "SPAIN", "iso_2": "es", "iso_3": "esp", "num_code": 724, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Spain"}, {"id": 75, "name": "FRANCE", "iso_2": "fr", "iso_3": "fra", "num_code": 250, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "France"}, {"id": 60, "name": "DENMARK", "iso_2": "dk", "iso_3": "dnk", "num_code": 208, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Denmark"}, {"id": 82, "name": "GERMANY", "iso_2": "de", "iso_3": "deu", "num_code": 276, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Germany"}, {"id": 235, "name": "UNITED KINGDOM", "iso_2": "gb", "iso_3": "gbr", "num_code": 826, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "United Kingdom"}, {"id": 215, "name": "SWEDEN", "iso_2": "se", "iso_3": "swe", "num_code": 752, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Sweden"}], "tax_rates": [{"id": "txr_01HM6VF955JXB29T12X4ZEDBKG", "code": "21", "name": "21% iva", "rate": 21, "metadata": null, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "created_at": "2024-01-15T15:22:35.555Z", "updated_at": "2024-01-15T15:22:35.555Z"}], "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:17.482Z", "currency_code": "eur", "automatic_taxes": true, "tax_provider_id": null, "payment_providers": [{"id": "manual", "is_installed": true}], "gift_cards_taxable": true}, "context": {"ip": "193.177.211.16", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"}, "payment": null, "customer": null, "metadata": null, "subtotal": 2999, "discounts": [], "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "tax_total": 630, "created_at": "2024-01-23T21:38:24.586Z", "deleted_at": null, "gift_cards": [], "payment_id": null, "updated_at": "2024-01-23T21:38:24.586Z", "customer_id": null, "completed_at": null, "sales_channel": {"id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "name": "Default Sales Channel", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z", "description": "Created by Medusa", "is_disabled": false}, "discount_total": 0, "item_tax_total": 630, "shipping_total": 0, "billing_address": null, "gift_card_total": 0, "idempotency_key": null, "payment_sessions": [], "sales_channel_id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "shipping_address": null, "shipping_methods": [], "billing_address_id": null, "raw_discount_total": 0, "shipping_tax_total": 0, "gift_card_tax_total": 0, "shipping_address_id": null, "payment_authorized_at": null}}	finished
ikey_01HMW45JJXGKYT5PPK96ZAF8F4	ed3bc6fc-0fd2-4555-a4f9-87c6a0a01660	2024-01-23 21:38:37.789425+00	\N	POST	{"id": "cart_01HMW455PM9KPMQ188CTN3BEPD"}	/cart_01HMW455PM9KPMQ188CTN3BEPD/line-items	200	{"cart": {"id": "cart_01HMW455PM9KPMQ188CTN3BEPD", "type": "default", "email": null, "items": [{"id": "item_01HMW45JKQ95EH9SW37EG0FDJG", "title": "Franela Negra con un Logo", "total": 3145, "cart_id": "cart_01HMW455PM9KPMQ188CTN3BEPD", "swap_id": null, "variant": {"id": "variant_01HKEG5EKGETQHJ5MJ58A2D61Y", "ean": null, "sku": null, "upc": null, "title": "S", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "product": {"id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "title": "Franela Negra con un Logo", "width": null, "handle": "franela-negra-con-un-logo", "height": null, "length": null, "status": "published", "weight": null, "hs_code": null, "profile": {"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}, "type_id": null, "material": null, "metadata": null, "mid_code": null, "profiles": [{"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}], "subtitle": null, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "profile_id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "updated_at": "2024-01-06T04:23:12.699Z", "description": null, "external_id": null, "is_giftcard": false, "discountable": true, "collection_id": null, "origin_country": null}, "material": null, "metadata": null, "mid_code": null, "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "product_id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "updated_at": "2024-01-06T04:23:12.699Z", "variant_rank": 1, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 15}, "metadata": {}, "order_id": null, "quantity": 1, "subtotal": 2599, "is_return": false, "tax_lines": [{"code": "21", "name": "21% iva", "rate": 21, "item_id": "item_01HMW45JKQ95EH9SW37EG0FDJG"}], "tax_total": 546, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-23T21:38:37.804Z", "unit_price": 2599, "updated_at": "2024-01-23T21:38:37.804Z", "variant_id": "variant_01HKEG5EKGETQHJ5MJ58A2D61Y", "adjustments": [], "description": "S", "is_giftcard": false, "has_shipping": false, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 3145, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 546, "raw_discount_total": 0}, {"id": "item_01HMW45G7G981JCM75QMHN00B2", "title": "Franela Negra con un Logo", "total": 3629, "cart_id": "cart_01HMW455PM9KPMQ188CTN3BEPD", "swap_id": null, "variant": {"id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "ean": null, "sku": null, "upc": null, "title": "XL", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "product": {"id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "title": "Franela Negra con un Logo", "width": null, "handle": "franela-negra-con-un-logo", "height": null, "length": null, "status": "published", "weight": null, "hs_code": null, "profile": {"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}, "type_id": null, "material": null, "metadata": null, "mid_code": null, "profiles": [{"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}], "subtitle": null, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "profile_id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "updated_at": "2024-01-06T04:23:12.699Z", "description": null, "external_id": null, "is_giftcard": false, "discountable": true, "collection_id": null, "origin_country": null}, "material": null, "metadata": null, "mid_code": null, "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "product_id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "updated_at": "2024-01-06T04:28:41.256Z", "variant_rank": 0, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 7}, "metadata": {}, "order_id": null, "quantity": 1, "subtotal": 2999, "is_return": false, "tax_lines": [{"code": "21", "name": "21% iva", "rate": 21, "item_id": "item_01HMW45G7G981JCM75QMHN00B2"}], "tax_total": 630, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-23T21:38:35.360Z", "unit_price": 2999, "updated_at": "2024-01-23T21:38:35.360Z", "variant_id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "adjustments": [], "description": "XL", "is_giftcard": false, "has_shipping": false, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 3629, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 630, "raw_discount_total": 0}], "total": 6774, "object": "cart", "region": {"id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "name": "EU", "metadata": null, "tax_code": null, "tax_rate": 0, "countries": [{"id": 109, "name": "ITALY", "iso_2": "it", "iso_3": "ita", "num_code": 380, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Italy"}, {"id": 209, "name": "SPAIN", "iso_2": "es", "iso_3": "esp", "num_code": 724, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Spain"}, {"id": 75, "name": "FRANCE", "iso_2": "fr", "iso_3": "fra", "num_code": 250, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "France"}, {"id": 60, "name": "DENMARK", "iso_2": "dk", "iso_3": "dnk", "num_code": 208, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Denmark"}, {"id": 82, "name": "GERMANY", "iso_2": "de", "iso_3": "deu", "num_code": 276, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Germany"}, {"id": 235, "name": "UNITED KINGDOM", "iso_2": "gb", "iso_3": "gbr", "num_code": 826, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "United Kingdom"}, {"id": 215, "name": "SWEDEN", "iso_2": "se", "iso_3": "swe", "num_code": 752, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Sweden"}], "tax_rates": [{"id": "txr_01HM6VF955JXB29T12X4ZEDBKG", "code": "21", "name": "21% iva", "rate": 21, "metadata": null, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "created_at": "2024-01-15T15:22:35.555Z", "updated_at": "2024-01-15T15:22:35.555Z"}], "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:17.482Z", "currency_code": "eur", "automatic_taxes": true, "tax_provider_id": null, "payment_providers": [{"id": "manual", "is_installed": true}], "gift_cards_taxable": true}, "context": {"ip": "193.177.211.16", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"}, "payment": null, "customer": null, "metadata": null, "subtotal": 5598, "discounts": [], "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "tax_total": 1176, "created_at": "2024-01-23T21:38:24.586Z", "deleted_at": null, "gift_cards": [], "payment_id": null, "updated_at": "2024-01-23T21:38:24.586Z", "customer_id": null, "completed_at": null, "sales_channel": {"id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "name": "Default Sales Channel", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z", "description": "Created by Medusa", "is_disabled": false}, "discount_total": 0, "item_tax_total": 1176, "shipping_total": 0, "billing_address": null, "gift_card_total": 0, "idempotency_key": null, "payment_sessions": [], "sales_channel_id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "shipping_address": null, "shipping_methods": [], "billing_address_id": null, "raw_discount_total": 0, "shipping_tax_total": 0, "gift_card_tax_total": 0, "shipping_address_id": null, "payment_authorized_at": null}}	finished
ikey_01HNFVA6FXVN98F1328871CAF7	264cca6e-e693-4af2-856d-3f4f737b97c3	2024-01-31 13:28:40.698607+00	\N	POST	{"id": "cart_01HNFMR1GPDJT3T39WAWWYHJRX"}	/cart_01HNFMR1GPDJT3T39WAWWYHJRX/complete	200	{"data": {"id": "order_01HNFVA6PA3X641SN5K2QQNHTM", "email": "yo@yo.es", "items": [{"id": "item_01HNFMT3NPK4RMG17Y35VXMBQW", "title": "Medusa Hoodie", "total": 2473, "cart_id": "cart_01HNFMR1GPDJT3T39WAWWYHJRX", "swap_id": null, "variant": {"id": "variant_01HJQ62GT3ZMC2B76FGKWCW92E", "ean": null, "sku": null, "upc": null, "title": "L", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "material": null, "metadata": null, "mid_code": null, "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "product_id": "prod_01HJQ62GQGCQ64V8BMRHT1VAT7", "updated_at": "2024-01-31T13:28:40.836Z", "variant_rank": 2, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 99}, "metadata": {}, "order_id": "order_01HNFVA6PA3X641SN5K2QQNHTM", "quantity": 1, "subtotal": 3650, "is_return": false, "tax_lines": [{"id": "litl_01HNFVA6H2VBXCJG2XF82T83Y7", "code": "21", "name": "21% iva", "rate": 21, "item_id": "item_01HNFMT3NPK4RMG17Y35VXMBQW", "metadata": null, "created_at": "2024-01-31T13:28:40.705Z", "updated_at": "2024-01-31T13:28:40.836Z"}], "tax_total": 429, "thumbnail": "https://medusa-public-images.s3.eu-west-1.amazonaws.com/black_hoodie_front.png", "created_at": "2024-01-31T11:35:02.054Z", "refundable": 2473, "unit_price": 3650, "updated_at": "2024-01-31T13:28:40.836Z", "variant_id": "variant_01HJQ62GT3ZMC2B76FGKWCW92E", "adjustments": [{"id": "lia_01HNFV6RG1NW0CVHHAZETE4QHS", "amount": 1606, "item_id": "item_01HNFMT3NPK4RMG17Y35VXMBQW", "metadata": null, "description": "discount", "discount_id": "disc_01HM6VJ61272P6R31QVVYQQR83"}], "description": "L", "is_giftcard": false, "has_shipping": true, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 1606, "original_total": 4417, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 767, "raw_discount_total": 1606}, {"id": "item_01HNFV6RF46X9VNYSBNNH2PFYZ", "title": "Franela Negra con un Logo", "total": 3629, "cart_id": "cart_01HNFMR1GPDJT3T39WAWWYHJRX", "swap_id": null, "variant": {"id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "ean": null, "sku": null, "upc": null, "title": "XL", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "material": null, "metadata": null, "mid_code": null, "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "product_id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "updated_at": "2024-01-31T13:28:40.836Z", "variant_rank": 0, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 3}, "metadata": {}, "order_id": "order_01HNFVA6PA3X641SN5K2QQNHTM", "quantity": 1, "subtotal": 2999, "is_return": false, "tax_lines": [{"id": "litl_01HNFVA6H2TBKFA84CGHTZGT1X", "code": "21", "name": "21% iva", "rate": 21, "item_id": "item_01HNFV6RF46X9VNYSBNNH2PFYZ", "metadata": null, "created_at": "2024-01-31T13:28:40.705Z", "updated_at": "2024-01-31T13:28:40.836Z"}], "tax_total": 630, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-31T13:26:48.021Z", "refundable": 3629, "unit_price": 2999, "updated_at": "2024-01-31T13:28:40.836Z", "variant_id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "adjustments": [], "description": "XL", "is_giftcard": false, "has_shipping": true, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 3629, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 630, "raw_discount_total": 0}], "swaps": [], "total": 7602, "claims": [], "object": "order", "region": {"id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "name": "EU", "metadata": null, "tax_code": null, "tax_rate": 0, "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:17.482Z", "currency_code": "eur", "automatic_taxes": true, "tax_provider_id": null, "gift_cards_taxable": true}, "status": "pending", "cart_id": "cart_01HNFMR1GPDJT3T39WAWWYHJRX", "refunds": [], "metadata": {}, "payments": [{"id": "pay_01HNFVA6KM1R51RTH9PW4YGSYA", "data": {"status": "authorized"}, "amount": 7602, "cart_id": "cart_01HNFMR1GPDJT3T39WAWWYHJRX", "swap_id": null, "metadata": null, "order_id": "order_01HNFVA6PA3X641SN5K2QQNHTM", "created_at": "2024-01-31T13:28:40.749Z", "updated_at": "2024-01-31T13:28:40.836Z", "canceled_at": null, "captured_at": null, "provider_id": "manual", "currency_code": "eur", "amount_refunded": 0, "idempotency_key": null}], "subtotal": 6649, "tax_rate": null, "discounts": [{"id": "disc_01HM6VJ61272P6R31QVVYQQR83", "code": "VERANO", "rule": {"id": "dru_01HM6VJ60XTZ24R9H4C22ZD68M", "type": "percentage", "value": 44, "metadata": null, "allocation": "total", "created_at": "2024-01-15T15:24:10.650Z", "deleted_at": null, "updated_at": "2024-01-15T15:24:10.650Z", "description": "verano22 222222"}, "ends_at": null, "rule_id": "dru_01HM6VJ60XTZ24R9H4C22ZD68M", "metadata": {}, "starts_at": "2024-01-15T15:23:48.060Z", "created_at": "2024-01-15T15:24:10.650Z", "deleted_at": null, "is_dynamic": false, "updated_at": "2024-01-31T11:33:57.177Z", "is_disabled": false, "usage_count": 1, "usage_limit": null, "valid_duration": null, "parent_discount_id": null}], "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "tax_total": 1059, "created_at": "2024-01-31T13:28:40.836Z", "display_id": 4, "gift_cards": [], "paid_total": 7602, "updated_at": "2024-01-31T13:28:40.836Z", "canceled_at": null, "customer_id": "cus_01HNFV8Q3BCE5MM80HQJ8AKAZC", "external_id": null, "currency_code": "eur", "discount_total": 1606, "draft_order_id": null, "item_tax_total": 1059, "payment_status": "awaiting", "refunded_total": 0, "shipping_total": 1500, "gift_card_total": 0, "idempotency_key": null, "no_notification": null, "sales_channel_id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "shipping_address": {"id": "addr_01HNFV9ZYT651QTZV9TQ7T76Y0", "city": "aas", "phone": "", "company": "", "metadata": null, "province": "", "address_1": "adresssss", "address_2": "", "last_name": "wee", "created_at": "2024-01-31T13:28:33.943Z", "deleted_at": null, "first_name": "ass", "updated_at": "2024-01-31T13:28:33.943Z", "customer_id": null, "postal_code": "03001", "country_code": "it"}, "shipping_methods": [{"id": "sm_01HNFVA2YE7XBFCAG3NQ4WC4T8", "data": {}, "price": 1500, "total": 1500, "cart_id": "cart_01HNFMR1GPDJT3T39WAWWYHJRX", "swap_id": null, "order_id": "order_01HNFVA6PA3X641SN5K2QQNHTM", "subtotal": 1500, "return_id": null, "tax_lines": [{"id": "smtl_01HNFVA6H3Y7406KTYZX7RGERD", "code": "default", "name": "default", "rate": 0, "metadata": null, "created_at": "2024-01-31T13:28:40.705Z", "updated_at": "2024-01-31T13:28:40.836Z", "shipping_method_id": "sm_01HNFVA2YE7XBFCAG3NQ4WC4T8"}], "tax_total": 0, "claim_order_id": null, "original_total": 1500, "original_tax_total": 0, "shipping_option_id": "so_01HJQ62FMPGJDBQZZAZ84H7S1P"}], "refundable_amount": 7602, "billing_address_id": "addr_01HNFV9ZYSDCZXP7NY5SV1K4MY", "fulfillment_status": "not_fulfilled", "raw_discount_total": 1606, "shipping_tax_total": 0, "gift_card_tax_total": 0, "shipping_address_id": "addr_01HNFV9ZYT651QTZV9TQ7T76Y0", "gift_card_transactions": []}, "type": "order"}	finished
ikey_01HMW45ZCEENJ692V7NDSPWNET	c2fbd6df-8e14-4b3e-a9b1-6493d955df0a	2024-01-23 21:38:50.894228+00	\N	POST	{"id": "cart_01HMW455PM9KPMQ188CTN3BEPD"}	/cart_01HMW455PM9KPMQ188CTN3BEPD/line-items	200	{"cart": {"id": "cart_01HMW455PM9KPMQ188CTN3BEPD", "type": "default", "email": null, "items": [{"id": "item_01HMW45ZDG1BH41DZX1XM91JEN", "title": "Medusa T-Shirt", "total": 2360, "cart_id": "cart_01HMW455PM9KPMQ188CTN3BEPD", "swap_id": null, "variant": {"id": "variant_01HJQ62G18RW9J8R989JWZ4MPY", "ean": null, "sku": null, "upc": null, "title": "S / White", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "product": {"id": "prod_01HJQ62FWPA7FSQZ2B176YBX1D", "title": "Medusa T-Shirt", "width": null, "handle": "t-shirt", "height": null, "length": null, "status": "published", "weight": 400, "hs_code": null, "profile": {"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}, "type_id": null, "material": null, "metadata": null, "mid_code": null, "profiles": [{"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}], "subtitle": null, "thumbnail": "https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png", "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "profile_id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "updated_at": "2023-12-28T03:04:17.482Z", "description": "Reimagine the feeling of a classic T-shirt. With our cotton T-shirts, everyday essentials no longer have to be ordinary.", "external_id": null, "is_giftcard": false, "discountable": true, "collection_id": null, "origin_country": null}, "material": null, "metadata": null, "mid_code": null, "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "product_id": "prod_01HJQ62FWPA7FSQZ2B176YBX1D", "updated_at": "2023-12-28T03:04:17.482Z", "variant_rank": 1, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 100}, "metadata": {}, "order_id": null, "quantity": 1, "subtotal": 1950, "is_return": false, "tax_lines": [{"code": "21", "name": "21% iva", "rate": 21, "item_id": "item_01HMW45ZDG1BH41DZX1XM91JEN"}], "tax_total": 410, "thumbnail": "https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png", "created_at": "2024-01-23T21:38:50.912Z", "unit_price": 1950, "updated_at": "2024-01-23T21:38:50.912Z", "variant_id": "variant_01HJQ62G18RW9J8R989JWZ4MPY", "adjustments": [], "description": "S / White", "is_giftcard": false, "has_shipping": false, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 2360, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 410, "raw_discount_total": 0}, {"id": "item_01HMW45JKQ95EH9SW37EG0FDJG", "title": "Franela Negra con un Logo", "total": 3145, "cart_id": "cart_01HMW455PM9KPMQ188CTN3BEPD", "swap_id": null, "variant": {"id": "variant_01HKEG5EKGETQHJ5MJ58A2D61Y", "ean": null, "sku": null, "upc": null, "title": "S", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "product": {"id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "title": "Franela Negra con un Logo", "width": null, "handle": "franela-negra-con-un-logo", "height": null, "length": null, "status": "published", "weight": null, "hs_code": null, "profile": {"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}, "type_id": null, "material": null, "metadata": null, "mid_code": null, "profiles": [{"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}], "subtitle": null, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "profile_id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "updated_at": "2024-01-06T04:23:12.699Z", "description": null, "external_id": null, "is_giftcard": false, "discountable": true, "collection_id": null, "origin_country": null}, "material": null, "metadata": null, "mid_code": null, "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "product_id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "updated_at": "2024-01-06T04:23:12.699Z", "variant_rank": 1, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 15}, "metadata": {}, "order_id": null, "quantity": 1, "subtotal": 2599, "is_return": false, "tax_lines": [{"code": "21", "name": "21% iva", "rate": 21, "item_id": "item_01HMW45JKQ95EH9SW37EG0FDJG"}], "tax_total": 546, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-23T21:38:37.804Z", "unit_price": 2599, "updated_at": "2024-01-23T21:38:37.804Z", "variant_id": "variant_01HKEG5EKGETQHJ5MJ58A2D61Y", "adjustments": [], "description": "S", "is_giftcard": false, "has_shipping": false, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 3145, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 546, "raw_discount_total": 0}, {"id": "item_01HMW45G7G981JCM75QMHN00B2", "title": "Franela Negra con un Logo", "total": 3629, "cart_id": "cart_01HMW455PM9KPMQ188CTN3BEPD", "swap_id": null, "variant": {"id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "ean": null, "sku": null, "upc": null, "title": "XL", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "product": {"id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "title": "Franela Negra con un Logo", "width": null, "handle": "franela-negra-con-un-logo", "height": null, "length": null, "status": "published", "weight": null, "hs_code": null, "profile": {"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}, "type_id": null, "material": null, "metadata": null, "mid_code": null, "profiles": [{"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}], "subtitle": null, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "profile_id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "updated_at": "2024-01-06T04:23:12.699Z", "description": null, "external_id": null, "is_giftcard": false, "discountable": true, "collection_id": null, "origin_country": null}, "material": null, "metadata": null, "mid_code": null, "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "product_id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "updated_at": "2024-01-06T04:28:41.256Z", "variant_rank": 0, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 7}, "metadata": {}, "order_id": null, "quantity": 1, "subtotal": 2999, "is_return": false, "tax_lines": [{"code": "21", "name": "21% iva", "rate": 21, "item_id": "item_01HMW45G7G981JCM75QMHN00B2"}], "tax_total": 630, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-23T21:38:35.360Z", "unit_price": 2999, "updated_at": "2024-01-23T21:38:35.360Z", "variant_id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "adjustments": [], "description": "XL", "is_giftcard": false, "has_shipping": false, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 3629, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 630, "raw_discount_total": 0}], "total": 9134, "object": "cart", "region": {"id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "name": "EU", "metadata": null, "tax_code": null, "tax_rate": 0, "countries": [{"id": 109, "name": "ITALY", "iso_2": "it", "iso_3": "ita", "num_code": 380, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Italy"}, {"id": 209, "name": "SPAIN", "iso_2": "es", "iso_3": "esp", "num_code": 724, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Spain"}, {"id": 75, "name": "FRANCE", "iso_2": "fr", "iso_3": "fra", "num_code": 250, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "France"}, {"id": 60, "name": "DENMARK", "iso_2": "dk", "iso_3": "dnk", "num_code": 208, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Denmark"}, {"id": 82, "name": "GERMANY", "iso_2": "de", "iso_3": "deu", "num_code": 276, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Germany"}, {"id": 235, "name": "UNITED KINGDOM", "iso_2": "gb", "iso_3": "gbr", "num_code": 826, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "United Kingdom"}, {"id": 215, "name": "SWEDEN", "iso_2": "se", "iso_3": "swe", "num_code": 752, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Sweden"}], "tax_rates": [{"id": "txr_01HM6VF955JXB29T12X4ZEDBKG", "code": "21", "name": "21% iva", "rate": 21, "metadata": null, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "created_at": "2024-01-15T15:22:35.555Z", "updated_at": "2024-01-15T15:22:35.555Z"}], "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:17.482Z", "currency_code": "eur", "automatic_taxes": true, "tax_provider_id": null, "payment_providers": [{"id": "manual", "is_installed": true}], "gift_cards_taxable": true}, "context": {"ip": "193.177.211.16", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"}, "payment": null, "customer": null, "metadata": null, "subtotal": 7548, "discounts": [], "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "tax_total": 1586, "created_at": "2024-01-23T21:38:24.586Z", "deleted_at": null, "gift_cards": [], "payment_id": null, "updated_at": "2024-01-23T21:38:24.586Z", "customer_id": null, "completed_at": null, "sales_channel": {"id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "name": "Default Sales Channel", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z", "description": "Created by Medusa", "is_disabled": false}, "discount_total": 0, "item_tax_total": 1586, "shipping_total": 0, "billing_address": null, "gift_card_total": 0, "idempotency_key": null, "payment_sessions": [], "sales_channel_id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "shipping_address": null, "shipping_methods": [], "billing_address_id": null, "raw_discount_total": 0, "shipping_tax_total": 0, "gift_card_tax_total": 0, "shipping_address_id": null, "payment_authorized_at": null}}	finished
ikey_01HMW465PDGE03X03133NHDE4F	9c458312-f4b3-4bcc-a085-30816dfdf78c	2024-01-23 21:38:57.356188+00	\N	POST	{"id": "cart_01HMW455PM9KPMQ188CTN3BEPD"}	/cart_01HMW455PM9KPMQ188CTN3BEPD/payment-sessions	200	{"cart": {"id": "cart_01HMW455PM9KPMQ188CTN3BEPD", "type": "default", "email": null, "items": [{"id": "item_01HMW45ZDG1BH41DZX1XM91JEN", "title": "Medusa T-Shirt", "total": 2360, "cart_id": "cart_01HMW455PM9KPMQ188CTN3BEPD", "swap_id": null, "variant": {"id": "variant_01HJQ62G18RW9J8R989JWZ4MPY", "ean": null, "sku": null, "upc": null, "title": "S / White", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "product": {"id": "prod_01HJQ62FWPA7FSQZ2B176YBX1D", "title": "Medusa T-Shirt", "width": null, "handle": "t-shirt", "height": null, "length": null, "status": "published", "weight": 400, "hs_code": null, "profile": {"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}, "type_id": null, "material": null, "metadata": null, "mid_code": null, "profiles": [{"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}], "subtitle": null, "thumbnail": "https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png", "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "profile_id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "updated_at": "2023-12-28T03:04:17.482Z", "description": "Reimagine the feeling of a classic T-shirt. With our cotton T-shirts, everyday essentials no longer have to be ordinary.", "external_id": null, "is_giftcard": false, "discountable": true, "collection_id": null, "origin_country": null}, "material": null, "metadata": null, "mid_code": null, "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "product_id": "prod_01HJQ62FWPA7FSQZ2B176YBX1D", "updated_at": "2023-12-28T03:04:17.482Z", "variant_rank": 1, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 100}, "metadata": {}, "order_id": null, "quantity": 1, "subtotal": 1950, "is_return": false, "tax_lines": [{"code": "21", "name": "21% iva", "rate": 21, "item_id": "item_01HMW45ZDG1BH41DZX1XM91JEN"}], "tax_total": 410, "thumbnail": "https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png", "created_at": "2024-01-23T21:38:50.912Z", "unit_price": 1950, "updated_at": "2024-01-23T21:38:50.912Z", "variant_id": "variant_01HJQ62G18RW9J8R989JWZ4MPY", "adjustments": [], "description": "S / White", "is_giftcard": false, "has_shipping": false, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 2360, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 410, "raw_discount_total": 0}, {"id": "item_01HMW45JKQ95EH9SW37EG0FDJG", "title": "Franela Negra con un Logo", "total": 3145, "cart_id": "cart_01HMW455PM9KPMQ188CTN3BEPD", "swap_id": null, "variant": {"id": "variant_01HKEG5EKGETQHJ5MJ58A2D61Y", "ean": null, "sku": null, "upc": null, "title": "S", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "product": {"id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "title": "Franela Negra con un Logo", "width": null, "handle": "franela-negra-con-un-logo", "height": null, "length": null, "status": "published", "weight": null, "hs_code": null, "profile": {"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}, "type_id": null, "material": null, "metadata": null, "mid_code": null, "profiles": [{"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}], "subtitle": null, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "profile_id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "updated_at": "2024-01-06T04:23:12.699Z", "description": null, "external_id": null, "is_giftcard": false, "discountable": true, "collection_id": null, "origin_country": null}, "material": null, "metadata": null, "mid_code": null, "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "product_id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "updated_at": "2024-01-06T04:23:12.699Z", "variant_rank": 1, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 15}, "metadata": {}, "order_id": null, "quantity": 1, "subtotal": 2599, "is_return": false, "tax_lines": [{"code": "21", "name": "21% iva", "rate": 21, "item_id": "item_01HMW45JKQ95EH9SW37EG0FDJG"}], "tax_total": 546, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-23T21:38:37.804Z", "unit_price": 2599, "updated_at": "2024-01-23T21:38:37.804Z", "variant_id": "variant_01HKEG5EKGETQHJ5MJ58A2D61Y", "adjustments": [], "description": "S", "is_giftcard": false, "has_shipping": false, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 3145, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 546, "raw_discount_total": 0}, {"id": "item_01HMW45G7G981JCM75QMHN00B2", "title": "Franela Negra con un Logo", "total": 3629, "cart_id": "cart_01HMW455PM9KPMQ188CTN3BEPD", "swap_id": null, "variant": {"id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "ean": null, "sku": null, "upc": null, "title": "XL", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "product": {"id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "title": "Franela Negra con un Logo", "width": null, "handle": "franela-negra-con-un-logo", "height": null, "length": null, "status": "published", "weight": null, "hs_code": null, "profile": {"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}, "type_id": null, "material": null, "metadata": null, "mid_code": null, "profiles": [{"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}], "subtitle": null, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "profile_id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "updated_at": "2024-01-06T04:23:12.699Z", "description": null, "external_id": null, "is_giftcard": false, "discountable": true, "collection_id": null, "origin_country": null}, "material": null, "metadata": null, "mid_code": null, "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "product_id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "updated_at": "2024-01-06T04:28:41.256Z", "variant_rank": 0, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 7}, "metadata": {}, "order_id": null, "quantity": 1, "subtotal": 2999, "is_return": false, "tax_lines": [{"code": "21", "name": "21% iva", "rate": 21, "item_id": "item_01HMW45G7G981JCM75QMHN00B2"}], "tax_total": 630, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-23T21:38:35.360Z", "unit_price": 2999, "updated_at": "2024-01-23T21:38:35.360Z", "variant_id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "adjustments": [], "description": "XL", "is_giftcard": false, "has_shipping": false, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 3629, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 630, "raw_discount_total": 0}], "total": 9134, "object": "cart", "region": {"id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "name": "EU", "metadata": null, "tax_code": null, "tax_rate": 0, "countries": [{"id": 109, "name": "ITALY", "iso_2": "it", "iso_3": "ita", "num_code": 380, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Italy"}, {"id": 209, "name": "SPAIN", "iso_2": "es", "iso_3": "esp", "num_code": 724, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Spain"}, {"id": 75, "name": "FRANCE", "iso_2": "fr", "iso_3": "fra", "num_code": 250, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "France"}, {"id": 60, "name": "DENMARK", "iso_2": "dk", "iso_3": "dnk", "num_code": 208, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Denmark"}, {"id": 82, "name": "GERMANY", "iso_2": "de", "iso_3": "deu", "num_code": 276, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Germany"}, {"id": 235, "name": "UNITED KINGDOM", "iso_2": "gb", "iso_3": "gbr", "num_code": 826, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "United Kingdom"}, {"id": 215, "name": "SWEDEN", "iso_2": "se", "iso_3": "swe", "num_code": 752, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Sweden"}], "tax_rates": [{"id": "txr_01HM6VF955JXB29T12X4ZEDBKG", "code": "21", "name": "21% iva", "rate": 21, "metadata": null, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "created_at": "2024-01-15T15:22:35.555Z", "updated_at": "2024-01-15T15:22:35.555Z"}], "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:17.482Z", "currency_code": "eur", "automatic_taxes": true, "tax_provider_id": null, "payment_providers": [{"id": "manual", "is_installed": true}], "gift_cards_taxable": true}, "context": {"ip": "193.177.211.16", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"}, "payment": null, "metadata": null, "subtotal": 7548, "discounts": [], "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "tax_total": 1586, "created_at": "2024-01-23T21:38:24.586Z", "deleted_at": null, "gift_cards": [], "payment_id": null, "updated_at": "2024-01-23T21:38:24.586Z", "customer_id": null, "completed_at": null, "sales_channel": {"id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "name": "Default Sales Channel", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z", "description": "Created by Medusa", "is_disabled": false}, "discount_total": 0, "item_tax_total": 1586, "shipping_total": 0, "billing_address": null, "gift_card_total": 0, "idempotency_key": null, "payment_session": {"id": "ps_01HMW465QA7CK2QH3BSPGGHYV1", "data": {"status": "pending"}, "amount": 9134, "status": "pending", "cart_id": "cart_01HMW455PM9KPMQ188CTN3BEPD", "created_at": "2024-01-23T21:38:57.360Z", "updated_at": "2024-01-23T21:38:57.360Z", "is_selected": true, "provider_id": "manual", "is_initiated": true, "idempotency_key": null, "payment_authorized_at": null}, "payment_sessions": [{"id": "ps_01HMW465QA7CK2QH3BSPGGHYV1", "data": {"status": "pending"}, "amount": 9134, "status": "pending", "cart_id": "cart_01HMW455PM9KPMQ188CTN3BEPD", "created_at": "2024-01-23T21:38:57.360Z", "updated_at": "2024-01-23T21:38:57.360Z", "is_selected": true, "provider_id": "manual", "is_initiated": true, "idempotency_key": null, "payment_authorized_at": null}], "sales_channel_id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "shipping_address": null, "shipping_methods": [], "billing_address_id": null, "raw_discount_total": 0, "shipping_tax_total": 0, "gift_card_tax_total": 0, "shipping_address_id": null, "payment_authorized_at": null}}	finished
ikey_01HNFMR0ZHN186C4MAR2QQ9TKK	369b219c-98fa-4ea7-b5fd-0ef9bba4d8e4	2024-01-31 11:33:53.774926+00	\N	POST	{"id": "cart_01HM6THN376FNFK12TTTPYR2KH"}	/cart_01HM6THN376FNFK12TTTPYR2KH/complete	200	{"data": {"id": "order_01HNFMR16MP15H71KPM48VMAX9", "email": "aaa@ee.es", "items": [{"id": "item_01HNDCBH76E0T3YMYY4Q22GEFF", "title": "Franela Negra con un Logo", "total": 7258, "cart_id": "cart_01HM6THN376FNFK12TTTPYR2KH", "swap_id": null, "variant": {"id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "ean": null, "sku": null, "upc": null, "title": "XL", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "material": null, "metadata": null, "mid_code": null, "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "product_id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "updated_at": "2024-01-31T11:33:53.924Z", "variant_rank": 0, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 4}, "metadata": {}, "order_id": "order_01HNFMR16MP15H71KPM48VMAX9", "quantity": 2, "subtotal": 5998, "is_return": false, "tax_lines": [{"id": "litl_01HNFMR10N5D83MET01AC5S07W", "code": "21", "name": "21% iva", "rate": 21, "item_id": "item_01HNDCBH76E0T3YMYY4Q22GEFF", "metadata": null, "created_at": "2024-01-31T11:33:53.783Z", "updated_at": "2024-01-31T11:33:53.924Z"}], "tax_total": 1260, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-30T14:28:46.924Z", "refundable": 7258, "unit_price": 2999, "updated_at": "2024-01-31T11:33:53.924Z", "variant_id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "adjustments": [], "description": "XL", "is_giftcard": false, "has_shipping": true, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 7258, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 1260, "raw_discount_total": 0}], "swaps": [], "total": 8258, "claims": [], "object": "order", "region": {"id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "name": "EU", "metadata": null, "tax_code": null, "tax_rate": 0, "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:17.482Z", "currency_code": "eur", "automatic_taxes": true, "tax_provider_id": null, "gift_cards_taxable": true}, "status": "pending", "cart_id": "cart_01HM6THN376FNFK12TTTPYR2KH", "refunds": [], "metadata": {}, "payments": [{"id": "pay_01HNFMR13HNXPFSAAKKA2XVKJB", "data": {"status": "authorized"}, "amount": 8258, "cart_id": "cart_01HM6THN376FNFK12TTTPYR2KH", "swap_id": null, "metadata": null, "order_id": "order_01HNFMR16MP15H71KPM48VMAX9", "created_at": "2024-01-31T11:33:53.824Z", "updated_at": "2024-01-31T11:33:53.924Z", "canceled_at": null, "captured_at": null, "provider_id": "manual", "currency_code": "eur", "amount_refunded": 0, "idempotency_key": null}], "subtotal": 5998, "tax_rate": null, "discounts": [{"id": "disc_01HM6VJ61272P6R31QVVYQQR83", "code": "VERANO", "rule": {"id": "dru_01HM6VJ60XTZ24R9H4C22ZD68M", "type": "percentage", "value": 44, "metadata": null, "allocation": "total", "created_at": "2024-01-15T15:24:10.650Z", "deleted_at": null, "updated_at": "2024-01-15T15:24:10.650Z", "description": "verano22 222222"}, "ends_at": null, "rule_id": "dru_01HM6VJ60XTZ24R9H4C22ZD68M", "metadata": {}, "starts_at": "2024-01-15T15:23:48.060Z", "created_at": "2024-01-15T15:24:10.650Z", "deleted_at": null, "is_dynamic": false, "updated_at": "2024-01-31T11:29:31.123Z", "is_disabled": false, "usage_count": 0, "usage_limit": null, "valid_duration": null, "parent_discount_id": null}], "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "tax_total": 1260, "created_at": "2024-01-31T11:33:53.924Z", "display_id": 3, "gift_cards": [], "paid_total": 8258, "updated_at": "2024-01-31T11:33:53.924Z", "canceled_at": null, "customer_id": "cus_01HNFMPR4RMWGS1WEK4E73MV96", "external_id": null, "currency_code": "eur", "discount_total": 0, "draft_order_id": null, "item_tax_total": 1260, "payment_status": "awaiting", "refunded_total": 0, "shipping_total": 1000, "gift_card_total": 0, "idempotency_key": null, "no_notification": null, "sales_channel_id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "shipping_address": {"id": "addr_01HNFMPR5BC7K9JFZZHF91DB3E", "city": "aaaa", "phone": "", "company": "", "metadata": null, "province": "aaaa", "address_1": "dsdsds", "address_2": "", "last_name": "dsds", "created_at": "2024-01-31T11:33:11.919Z", "deleted_at": null, "first_name": "dsds", "updated_at": "2024-01-31T11:33:11.919Z", "customer_id": null, "postal_code": "03001", "country_code": "es"}, "shipping_methods": [{"id": "sm_01HNFMPVYN898JMH7JN3AXZNH4", "data": {}, "price": 1000, "total": 1000, "cart_id": "cart_01HM6THN376FNFK12TTTPYR2KH", "swap_id": null, "order_id": "order_01HNFMR16MP15H71KPM48VMAX9", "subtotal": 1000, "return_id": null, "tax_lines": [{"id": "smtl_01HNFMR10PJQJE0T5QPV6G0R3C", "code": "default", "name": "default", "rate": 0, "metadata": null, "created_at": "2024-01-31T11:33:53.783Z", "updated_at": "2024-01-31T11:33:53.924Z", "shipping_method_id": "sm_01HNFMPVYN898JMH7JN3AXZNH4"}], "tax_total": 0, "claim_order_id": null, "original_total": 1000, "original_tax_total": 0, "shipping_option_id": "so_01HJQ62FM7ZN9GKDX2BHGWDFNK"}], "refundable_amount": 8258, "billing_address_id": "addr_01HNFMPR5BMKEJ8YH9JQDJXB1A", "fulfillment_status": "not_fulfilled", "raw_discount_total": 0, "shipping_tax_total": 0, "gift_card_tax_total": 0, "shipping_address_id": "addr_01HNFMPR5BC7K9JFZZHF91DB3E", "gift_card_transactions": []}, "type": "order"}	finished
ikey_01HMW4C45898SJ5SY5K0H39VG8	131b4061-dbe4-4af0-bfaf-fb5f7f2f57e7	2024-01-23 21:42:12.388038+00	\N	POST	{"id": "cart_01HMW455PM9KPMQ188CTN3BEPD"}	/cart_01HMW455PM9KPMQ188CTN3BEPD/complete	200	{"data": {"id": "order_01HMW4C4BFQ0JCSRQZMJZAD0YM", "email": "cliente1@gmail.com", "items": [{"id": "item_01HMW45ZDG1BH41DZX1XM91JEN", "title": "Medusa T-Shirt", "total": 2360, "cart_id": "cart_01HMW455PM9KPMQ188CTN3BEPD", "swap_id": null, "variant": {"id": "variant_01HJQ62G18RW9J8R989JWZ4MPY", "ean": null, "sku": null, "upc": null, "title": "S / White", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "material": null, "metadata": null, "mid_code": null, "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "product_id": "prod_01HJQ62FWPA7FSQZ2B176YBX1D", "updated_at": "2024-01-23T21:42:12.527Z", "variant_rank": 1, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 99}, "metadata": {}, "order_id": "order_01HMW4C4BFQ0JCSRQZMJZAD0YM", "quantity": 1, "subtotal": 1950, "is_return": false, "tax_lines": [{"id": "litl_01HMW4C464HMNB4QH6ENA8D0FB", "code": "21", "name": "21% iva", "rate": 21, "item_id": "item_01HMW45ZDG1BH41DZX1XM91JEN", "metadata": null, "created_at": "2024-01-23T21:42:12.396Z", "updated_at": "2024-01-23T21:42:12.527Z"}], "tax_total": 410, "thumbnail": "https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png", "created_at": "2024-01-23T21:38:50.912Z", "refundable": 2360, "unit_price": 1950, "updated_at": "2024-01-23T21:42:12.527Z", "variant_id": "variant_01HJQ62G18RW9J8R989JWZ4MPY", "adjustments": [], "description": "S / White", "is_giftcard": false, "has_shipping": true, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 2360, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 410, "raw_discount_total": 0}, {"id": "item_01HMW45JKQ95EH9SW37EG0FDJG", "title": "Franela Negra con un Logo", "total": 3145, "cart_id": "cart_01HMW455PM9KPMQ188CTN3BEPD", "swap_id": null, "variant": {"id": "variant_01HKEG5EKGETQHJ5MJ58A2D61Y", "ean": null, "sku": null, "upc": null, "title": "S", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "material": null, "metadata": null, "mid_code": null, "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "product_id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "updated_at": "2024-01-23T21:42:12.527Z", "variant_rank": 1, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 14}, "metadata": {}, "order_id": "order_01HMW4C4BFQ0JCSRQZMJZAD0YM", "quantity": 1, "subtotal": 2599, "is_return": false, "tax_lines": [{"id": "litl_01HMW4C464ACZRKA9GBTEW187H", "code": "21", "name": "21% iva", "rate": 21, "item_id": "item_01HMW45JKQ95EH9SW37EG0FDJG", "metadata": null, "created_at": "2024-01-23T21:42:12.396Z", "updated_at": "2024-01-23T21:42:12.527Z"}], "tax_total": 546, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-23T21:38:37.804Z", "refundable": 3145, "unit_price": 2599, "updated_at": "2024-01-23T21:42:12.527Z", "variant_id": "variant_01HKEG5EKGETQHJ5MJ58A2D61Y", "adjustments": [], "description": "S", "is_giftcard": false, "has_shipping": true, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 3145, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 546, "raw_discount_total": 0}, {"id": "item_01HMW45G7G981JCM75QMHN00B2", "title": "Franela Negra con un Logo", "total": 3629, "cart_id": "cart_01HMW455PM9KPMQ188CTN3BEPD", "swap_id": null, "variant": {"id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "ean": null, "sku": null, "upc": null, "title": "XL", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "material": null, "metadata": null, "mid_code": null, "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "product_id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "updated_at": "2024-01-23T21:42:12.527Z", "variant_rank": 0, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 6}, "metadata": {}, "order_id": "order_01HMW4C4BFQ0JCSRQZMJZAD0YM", "quantity": 1, "subtotal": 2999, "is_return": false, "tax_lines": [{"id": "litl_01HMW4C464RQPAXN4PP6DDEGA7", "code": "21", "name": "21% iva", "rate": 21, "item_id": "item_01HMW45G7G981JCM75QMHN00B2", "metadata": null, "created_at": "2024-01-23T21:42:12.396Z", "updated_at": "2024-01-23T21:42:12.527Z"}], "tax_total": 630, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-23T21:38:35.360Z", "refundable": 3629, "unit_price": 2999, "updated_at": "2024-01-23T21:42:12.527Z", "variant_id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "adjustments": [], "description": "XL", "is_giftcard": false, "has_shipping": true, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 3629, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 630, "raw_discount_total": 0}], "swaps": [], "total": 10134, "claims": [], "object": "order", "region": {"id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "name": "EU", "metadata": null, "tax_code": null, "tax_rate": 0, "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:17.482Z", "currency_code": "eur", "automatic_taxes": true, "tax_provider_id": null, "gift_cards_taxable": true}, "status": "pending", "cart_id": "cart_01HMW455PM9KPMQ188CTN3BEPD", "refunds": [], "metadata": {}, "payments": [{"id": "pay_01HMW4C490GPPAXZ5Y5S0R0BJ0", "data": {"status": "authorized"}, "amount": 10134, "cart_id": "cart_01HMW455PM9KPMQ188CTN3BEPD", "swap_id": null, "metadata": null, "order_id": "order_01HMW4C4BFQ0JCSRQZMJZAD0YM", "created_at": "2024-01-23T21:42:12.428Z", "updated_at": "2024-01-23T21:42:12.527Z", "canceled_at": null, "captured_at": null, "provider_id": "manual", "currency_code": "eur", "amount_refunded": 0, "idempotency_key": null}], "subtotal": 7548, "tax_rate": null, "discounts": [], "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "tax_total": 1586, "created_at": "2024-01-23T21:42:12.527Z", "display_id": 2, "gift_cards": [], "paid_total": 10134, "updated_at": "2024-01-23T21:42:12.527Z", "canceled_at": null, "customer_id": "cus_01HMW47S2TZFRTFAS9Q37XY7XK", "external_id": null, "currency_code": "eur", "discount_total": 0, "draft_order_id": null, "item_tax_total": 1586, "payment_status": "awaiting", "refunded_total": 0, "shipping_total": 1000, "gift_card_total": 0, "idempotency_key": null, "no_notification": null, "sales_channel_id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "shipping_address": {"id": "addr_01HMW4BT8N0KS5SZ10XCZZ5ATK", "city": "Jav", "phone": "645566", "company": "empr 1 segund dir", "metadata": null, "province": "Val", "address_1": "di1 segun", "address_2": "", "last_name": "ap1", "created_at": "2024-01-23T21:42:02.193Z", "deleted_at": null, "first_name": "cli 1", "updated_at": "2024-01-23T21:42:02.193Z", "customer_id": null, "postal_code": "05422", "country_code": "es"}, "shipping_methods": [{"id": "sm_01HMW4BY3QS6Z58K46RBCR15CD", "data": {}, "price": 1000, "total": 1000, "cart_id": "cart_01HMW455PM9KPMQ188CTN3BEPD", "swap_id": null, "order_id": "order_01HMW4C4BFQ0JCSRQZMJZAD0YM", "subtotal": 1000, "return_id": null, "tax_lines": [{"id": "smtl_01HMW4C465R5SY2Z8NBTB0AQKS", "code": "default", "name": "default", "rate": 0, "metadata": null, "created_at": "2024-01-23T21:42:12.396Z", "updated_at": "2024-01-23T21:42:12.527Z", "shipping_method_id": "sm_01HMW4BY3QS6Z58K46RBCR15CD"}], "tax_total": 0, "claim_order_id": null, "original_total": 1000, "original_tax_total": 0, "shipping_option_id": "so_01HJQ62FM7ZN9GKDX2BHGWDFNK"}], "refundable_amount": 10134, "billing_address_id": "addr_01HMW4BT8MCXZX691BPFHZ9KYT", "fulfillment_status": "not_fulfilled", "raw_discount_total": 0, "shipping_tax_total": 0, "gift_card_tax_total": 0, "shipping_address_id": "addr_01HMW4BT8N0KS5SZ10XCZZ5ATK", "gift_card_transactions": []}, "type": "order"}	finished
ikey_01HNN2G3KSV9S6396KA9MDJE1S	e8f39d23-5d96-4edf-b6bf-8cdc24e5423d	2024-02-02 14:10:26.552398+00	\N	POST	{"id": "cart_01HNFVA6ZREPT6BJ0X0N1DE5PK"}	/cart_01HNFVA6ZREPT6BJ0X0N1DE5PK/line-items	200	{"cart": {"id": "cart_01HNFVA6ZREPT6BJ0X0N1DE5PK", "type": "default", "email": "yo@yo.es", "items": [{"id": "item_01HNN2G3NKMDH96P16PEGWMFGS", "title": "Medusa Coffee Mug", "total": 1000, "cart_id": "cart_01HNFVA6ZREPT6BJ0X0N1DE5PK", "swap_id": null, "variant": {"id": "variant_01HJQ62H2NRGRY3ZAQCBWK5QTX", "ean": null, "sku": null, "upc": null, "title": "One Size", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "product": {"id": "prod_01HJQ62H1V8MN0MKYKZ6M6DWGB", "title": "Medusa Coffee Mug", "width": null, "handle": "coffee-mug", "height": null, "length": null, "status": "published", "weight": 400, "hs_code": null, "profile": {"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}, "type_id": null, "material": null, "metadata": null, "mid_code": null, "profiles": [{"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}], "subtitle": null, "thumbnail": "https://medusa-public-images.s3.eu-west-1.amazonaws.com/coffee-mug.png", "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "profile_id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "updated_at": "2023-12-28T03:04:17.482Z", "description": "Every programmer's best friend.", "external_id": null, "is_giftcard": false, "discountable": true, "collection_id": null, "origin_country": null}, "material": null, "metadata": null, "mid_code": null, "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "product_id": "prod_01HJQ62H1V8MN0MKYKZ6M6DWGB", "updated_at": "2023-12-28T03:04:17.482Z", "variant_rank": 0, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 100}, "metadata": {}, "order_id": null, "quantity": 1, "subtotal": 1000, "is_return": false, "tax_lines": [{"code": "default", "name": "default", "rate": 0, "item_id": "item_01HNN2G3NKMDH96P16PEGWMFGS"}], "tax_total": 0, "thumbnail": "https://medusa-public-images.s3.eu-west-1.amazonaws.com/coffee-mug.png", "created_at": "2024-02-02T14:10:26.582Z", "unit_price": 1000, "updated_at": "2024-02-02T14:10:26.582Z", "variant_id": "variant_01HJQ62H2NRGRY3ZAQCBWK5QTX", "adjustments": [], "description": "One Size", "is_giftcard": false, "has_shipping": false, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 1000, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 0, "raw_discount_total": 0}], "total": 1000, "object": "cart", "region": {"id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "name": "EU", "metadata": null, "tax_code": null, "tax_rate": 0, "countries": [{"id": 109, "name": "ITALY", "iso_2": "it", "iso_3": "ita", "num_code": 380, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Italy"}, {"id": 209, "name": "SPAIN", "iso_2": "es", "iso_3": "esp", "num_code": 724, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Spain"}, {"id": 75, "name": "FRANCE", "iso_2": "fr", "iso_3": "fra", "num_code": 250, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "France"}, {"id": 60, "name": "DENMARK", "iso_2": "dk", "iso_3": "dnk", "num_code": 208, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Denmark"}, {"id": 82, "name": "GERMANY", "iso_2": "de", "iso_3": "deu", "num_code": 276, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Germany"}, {"id": 235, "name": "UNITED KINGDOM", "iso_2": "gb", "iso_3": "gbr", "num_code": 826, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "United Kingdom"}, {"id": 215, "name": "SWEDEN", "iso_2": "se", "iso_3": "swe", "num_code": 752, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Sweden"}], "tax_rates": [{"id": "txr_01HM6VF955JXB29T12X4ZEDBKG", "code": "21", "name": "21% iva", "rate": 21, "metadata": null, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "created_at": "2024-01-15T15:22:35.555Z", "updated_at": "2024-01-15T15:22:35.555Z"}], "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:17.482Z", "currency_code": "eur", "automatic_taxes": true, "tax_provider_id": null, "payment_providers": [{"id": "manual", "is_installed": true}], "gift_cards_taxable": true}, "context": {"ip": "85.59.11.41", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"}, "payment": null, "customer": {"id": "cus_01HNFV8Q3BCE5MM80HQJ8AKAZC", "email": "yo@yo.es", "phone": "675874455", "metadata": null, "last_name": "alo", "created_at": "2024-01-31T13:27:52.163Z", "deleted_at": null, "first_name": "al", "updated_at": "2024-01-31T13:27:52.163Z", "has_account": true, "billing_address_id": null}, "metadata": null, "subtotal": 1000, "discounts": [], "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "tax_total": 0, "created_at": "2024-01-31T13:28:41.182Z", "deleted_at": null, "gift_cards": [], "payment_id": null, "updated_at": "2024-01-31T13:40:38.114Z", "customer_id": "cus_01HNFV8Q3BCE5MM80HQJ8AKAZC", "completed_at": null, "sales_channel": {"id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "name": "Default Sales Channel", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z", "description": "Created by Medusa", "is_disabled": false}, "discount_total": 0, "item_tax_total": 0, "shipping_total": 0, "billing_address": null, "gift_card_total": 0, "idempotency_key": null, "payment_sessions": [], "sales_channel_id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "shipping_address": null, "shipping_methods": [], "billing_address_id": null, "raw_discount_total": 0, "shipping_tax_total": 0, "gift_card_tax_total": 0, "shipping_address_id": null, "payment_authorized_at": null}}	finished
ikey_01HNFMT3MH4KS8TWGZN76DQFWS	eac45e76-604a-44ba-b270-810427d18b89	2024-01-31 11:35:02.033148+00	\N	POST	{"id": "cart_01HNFMR1GPDJT3T39WAWWYHJRX"}	/cart_01HNFMR1GPDJT3T39WAWWYHJRX/line-items	200	{"cart": {"id": "cart_01HNFMR1GPDJT3T39WAWWYHJRX", "type": "default", "email": null, "items": [{"id": "item_01HNFMT3NPK4RMG17Y35VXMBQW", "title": "Medusa Hoodie", "total": 4417, "cart_id": "cart_01HNFMR1GPDJT3T39WAWWYHJRX", "swap_id": null, "variant": {"id": "variant_01HJQ62GT3ZMC2B76FGKWCW92E", "ean": null, "sku": null, "upc": null, "title": "L", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "product": {"id": "prod_01HJQ62GQGCQ64V8BMRHT1VAT7", "title": "Medusa Hoodie", "width": null, "handle": "hoodie", "height": null, "length": null, "status": "published", "weight": 400, "hs_code": null, "profile": {"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}, "type_id": null, "material": null, "metadata": null, "mid_code": null, "profiles": [{"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}], "subtitle": null, "thumbnail": "https://medusa-public-images.s3.eu-west-1.amazonaws.com/black_hoodie_front.png", "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "profile_id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "updated_at": "2023-12-28T03:04:17.482Z", "description": "Reimagine the feeling of a classic hoodie. With our cotton hoodie, everyday essentials no longer have to be ordinary.", "external_id": null, "is_giftcard": false, "discountable": true, "collection_id": null, "origin_country": null}, "material": null, "metadata": null, "mid_code": null, "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "product_id": "prod_01HJQ62GQGCQ64V8BMRHT1VAT7", "updated_at": "2023-12-28T03:04:17.482Z", "variant_rank": 2, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 100}, "metadata": {}, "order_id": null, "quantity": 1, "subtotal": 3650, "is_return": false, "tax_lines": [{"code": "21", "name": "21% iva", "rate": 21, "item_id": "item_01HNFMT3NPK4RMG17Y35VXMBQW"}], "tax_total": 767, "thumbnail": "https://medusa-public-images.s3.eu-west-1.amazonaws.com/black_hoodie_front.png", "created_at": "2024-01-31T11:35:02.054Z", "unit_price": 3650, "updated_at": "2024-01-31T11:35:02.054Z", "variant_id": "variant_01HJQ62GT3ZMC2B76FGKWCW92E", "adjustments": [], "description": "L", "is_giftcard": false, "has_shipping": false, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 4417, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 767, "raw_discount_total": 0}], "total": 4417, "object": "cart", "region": {"id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "name": "EU", "metadata": null, "tax_code": null, "tax_rate": 0, "countries": [{"id": 109, "name": "ITALY", "iso_2": "it", "iso_3": "ita", "num_code": 380, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Italy"}, {"id": 209, "name": "SPAIN", "iso_2": "es", "iso_3": "esp", "num_code": 724, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Spain"}, {"id": 75, "name": "FRANCE", "iso_2": "fr", "iso_3": "fra", "num_code": 250, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "France"}, {"id": 60, "name": "DENMARK", "iso_2": "dk", "iso_3": "dnk", "num_code": 208, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Denmark"}, {"id": 82, "name": "GERMANY", "iso_2": "de", "iso_3": "deu", "num_code": 276, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Germany"}, {"id": 235, "name": "UNITED KINGDOM", "iso_2": "gb", "iso_3": "gbr", "num_code": 826, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "United Kingdom"}, {"id": 215, "name": "SWEDEN", "iso_2": "se", "iso_3": "swe", "num_code": 752, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Sweden"}], "tax_rates": [{"id": "txr_01HM6VF955JXB29T12X4ZEDBKG", "code": "21", "name": "21% iva", "rate": 21, "metadata": null, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "created_at": "2024-01-15T15:22:35.555Z", "updated_at": "2024-01-15T15:22:35.555Z"}], "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:17.482Z", "currency_code": "eur", "automatic_taxes": true, "tax_provider_id": null, "payment_providers": [{"id": "manual", "is_installed": true}], "gift_cards_taxable": true}, "context": {"ip": "85.59.11.41", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"}, "payment": null, "customer": null, "metadata": null, "subtotal": 3650, "discounts": [], "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "tax_total": 767, "created_at": "2024-01-31T11:33:54.302Z", "deleted_at": null, "gift_cards": [], "payment_id": null, "updated_at": "2024-01-31T11:33:54.302Z", "customer_id": null, "completed_at": null, "sales_channel": {"id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "name": "Default Sales Channel", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z", "description": "Created by Medusa", "is_disabled": false}, "discount_total": 0, "item_tax_total": 767, "shipping_total": 0, "billing_address": null, "gift_card_total": 0, "idempotency_key": null, "payment_sessions": [], "sales_channel_id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "shipping_address": null, "shipping_methods": [], "billing_address_id": null, "raw_discount_total": 0, "shipping_tax_total": 0, "gift_card_tax_total": 0, "shipping_address_id": null, "payment_authorized_at": null}}	finished
ikey_01HNFMTMK8XT4HDVM2J6RKMFXG	89d53334-c3d4-4ef6-bf0d-051c774bda75	2024-01-31 11:35:19.396772+00	\N	POST	{"id": "cart_01HNFMR1GPDJT3T39WAWWYHJRX"}	/cart_01HNFMR1GPDJT3T39WAWWYHJRX/payment-sessions	200	{"cart": {"id": "cart_01HNFMR1GPDJT3T39WAWWYHJRX", "type": "default", "email": null, "items": [{"id": "item_01HNFMT3NPK4RMG17Y35VXMBQW", "title": "Medusa Hoodie", "total": 4417, "cart_id": "cart_01HNFMR1GPDJT3T39WAWWYHJRX", "swap_id": null, "variant": {"id": "variant_01HJQ62GT3ZMC2B76FGKWCW92E", "ean": null, "sku": null, "upc": null, "title": "L", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "product": {"id": "prod_01HJQ62GQGCQ64V8BMRHT1VAT7", "title": "Medusa Hoodie", "width": null, "handle": "hoodie", "height": null, "length": null, "status": "published", "weight": 400, "hs_code": null, "profile": {"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}, "type_id": null, "material": null, "metadata": null, "mid_code": null, "profiles": [{"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}], "subtitle": null, "thumbnail": "https://medusa-public-images.s3.eu-west-1.amazonaws.com/black_hoodie_front.png", "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "profile_id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "updated_at": "2023-12-28T03:04:17.482Z", "description": "Reimagine the feeling of a classic hoodie. With our cotton hoodie, everyday essentials no longer have to be ordinary.", "external_id": null, "is_giftcard": false, "discountable": true, "collection_id": null, "origin_country": null}, "material": null, "metadata": null, "mid_code": null, "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "product_id": "prod_01HJQ62GQGCQ64V8BMRHT1VAT7", "updated_at": "2023-12-28T03:04:17.482Z", "variant_rank": 2, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 100}, "metadata": {}, "order_id": null, "quantity": 1, "subtotal": 3650, "is_return": false, "tax_lines": [{"code": "21", "name": "21% iva", "rate": 21, "item_id": "item_01HNFMT3NPK4RMG17Y35VXMBQW"}], "tax_total": 767, "thumbnail": "https://medusa-public-images.s3.eu-west-1.amazonaws.com/black_hoodie_front.png", "created_at": "2024-01-31T11:35:02.054Z", "unit_price": 3650, "updated_at": "2024-01-31T11:35:02.054Z", "variant_id": "variant_01HJQ62GT3ZMC2B76FGKWCW92E", "adjustments": [], "description": "L", "is_giftcard": false, "has_shipping": false, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 4417, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 767, "raw_discount_total": 0}], "total": 4417, "object": "cart", "region": {"id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "name": "EU", "metadata": null, "tax_code": null, "tax_rate": 0, "countries": [{"id": 109, "name": "ITALY", "iso_2": "it", "iso_3": "ita", "num_code": 380, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Italy"}, {"id": 209, "name": "SPAIN", "iso_2": "es", "iso_3": "esp", "num_code": 724, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Spain"}, {"id": 75, "name": "FRANCE", "iso_2": "fr", "iso_3": "fra", "num_code": 250, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "France"}, {"id": 60, "name": "DENMARK", "iso_2": "dk", "iso_3": "dnk", "num_code": 208, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Denmark"}, {"id": 82, "name": "GERMANY", "iso_2": "de", "iso_3": "deu", "num_code": 276, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Germany"}, {"id": 235, "name": "UNITED KINGDOM", "iso_2": "gb", "iso_3": "gbr", "num_code": 826, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "United Kingdom"}, {"id": 215, "name": "SWEDEN", "iso_2": "se", "iso_3": "swe", "num_code": 752, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Sweden"}], "tax_rates": [{"id": "txr_01HM6VF955JXB29T12X4ZEDBKG", "code": "21", "name": "21% iva", "rate": 21, "metadata": null, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "created_at": "2024-01-15T15:22:35.555Z", "updated_at": "2024-01-15T15:22:35.555Z"}], "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:17.482Z", "currency_code": "eur", "automatic_taxes": true, "tax_provider_id": null, "payment_providers": [{"id": "manual", "is_installed": true}], "gift_cards_taxable": true}, "context": {"ip": "85.59.11.41", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"}, "payment": null, "metadata": null, "subtotal": 3650, "discounts": [], "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "tax_total": 767, "created_at": "2024-01-31T11:33:54.302Z", "deleted_at": null, "gift_cards": [], "payment_id": null, "updated_at": "2024-01-31T11:33:54.302Z", "customer_id": null, "completed_at": null, "sales_channel": {"id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "name": "Default Sales Channel", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z", "description": "Created by Medusa", "is_disabled": false}, "discount_total": 0, "item_tax_total": 767, "shipping_total": 0, "billing_address": null, "gift_card_total": 0, "idempotency_key": null, "payment_session": {"id": "ps_01HNFMTMMYFTKRP7X8D74PG9ZR", "data": {"status": "pending"}, "amount": 4417, "status": "pending", "cart_id": "cart_01HNFMR1GPDJT3T39WAWWYHJRX", "created_at": "2024-01-31T11:35:19.405Z", "updated_at": "2024-01-31T11:35:19.405Z", "is_selected": true, "provider_id": "manual", "is_initiated": true, "idempotency_key": null, "payment_authorized_at": null}, "payment_sessions": [{"id": "ps_01HNFMTMMYFTKRP7X8D74PG9ZR", "data": {"status": "pending"}, "amount": 4417, "status": "pending", "cart_id": "cart_01HNFMR1GPDJT3T39WAWWYHJRX", "created_at": "2024-01-31T11:35:19.405Z", "updated_at": "2024-01-31T11:35:19.405Z", "is_selected": true, "provider_id": "manual", "is_initiated": true, "idempotency_key": null, "payment_authorized_at": null}], "sales_channel_id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "shipping_address": null, "shipping_methods": [], "billing_address_id": null, "raw_discount_total": 0, "shipping_tax_total": 0, "gift_card_tax_total": 0, "shipping_address_id": null, "payment_authorized_at": null}}	finished
ikey_01HNFV6RE2F6WE9BVJ00YXK5Y5	90d2dabd-0cd9-4a67-b80e-4c39d1e6633e	2024-01-31 13:26:48.002357+00	\N	POST	{"id": "cart_01HNFMR1GPDJT3T39WAWWYHJRX"}	/cart_01HNFMR1GPDJT3T39WAWWYHJRX/line-items	200	{"cart": {"id": "cart_01HNFMR1GPDJT3T39WAWWYHJRX", "type": "default", "email": null, "items": [{"id": "item_01HNFMT3NPK4RMG17Y35VXMBQW", "title": "Medusa Hoodie", "total": 2473, "cart_id": "cart_01HNFMR1GPDJT3T39WAWWYHJRX", "swap_id": null, "variant": {"id": "variant_01HJQ62GT3ZMC2B76FGKWCW92E", "ean": null, "sku": null, "upc": null, "title": "L", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "product": {"id": "prod_01HJQ62GQGCQ64V8BMRHT1VAT7", "title": "Medusa Hoodie", "width": null, "handle": "hoodie", "height": null, "length": null, "status": "published", "weight": 400, "hs_code": null, "profile": {"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}, "type_id": null, "material": null, "metadata": null, "mid_code": null, "profiles": [{"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}], "subtitle": null, "thumbnail": "https://medusa-public-images.s3.eu-west-1.amazonaws.com/black_hoodie_front.png", "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "profile_id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "updated_at": "2023-12-28T03:04:17.482Z", "description": "Reimagine the feeling of a classic hoodie. With our cotton hoodie, everyday essentials no longer have to be ordinary.", "external_id": null, "is_giftcard": false, "discountable": true, "collection_id": null, "origin_country": null}, "material": null, "metadata": null, "mid_code": null, "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "product_id": "prod_01HJQ62GQGCQ64V8BMRHT1VAT7", "updated_at": "2023-12-28T03:04:17.482Z", "variant_rank": 2, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 100}, "metadata": {}, "order_id": null, "quantity": 1, "subtotal": 3650, "is_return": false, "tax_lines": [{"code": "21", "name": "21% iva", "rate": 21, "item_id": "item_01HNFMT3NPK4RMG17Y35VXMBQW"}], "tax_total": 429, "thumbnail": "https://medusa-public-images.s3.eu-west-1.amazonaws.com/black_hoodie_front.png", "created_at": "2024-01-31T11:35:02.054Z", "unit_price": 3650, "updated_at": "2024-01-31T11:35:02.054Z", "variant_id": "variant_01HJQ62GT3ZMC2B76FGKWCW92E", "adjustments": [{"id": "lia_01HNFV6RG1NW0CVHHAZETE4QHS", "amount": 1606, "item_id": "item_01HNFMT3NPK4RMG17Y35VXMBQW", "metadata": null, "description": "discount", "discount_id": "disc_01HM6VJ61272P6R31QVVYQQR83"}], "description": "L", "is_giftcard": false, "has_shipping": false, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 1606, "original_total": 4417, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 767, "raw_discount_total": 1606}, {"id": "item_01HNFV6RF46X9VNYSBNNH2PFYZ", "title": "Franela Negra con un Logo", "total": 3629, "cart_id": "cart_01HNFMR1GPDJT3T39WAWWYHJRX", "swap_id": null, "variant": {"id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "ean": null, "sku": null, "upc": null, "title": "XL", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "product": {"id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "title": "Franela Negra con un Logo", "width": null, "handle": "franela-negra-con-un-logo", "height": null, "length": null, "status": "published", "weight": null, "hs_code": null, "profile": {"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}, "type_id": null, "material": null, "metadata": null, "mid_code": null, "profiles": [{"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}], "subtitle": null, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "profile_id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "updated_at": "2024-01-06T04:23:12.699Z", "description": null, "external_id": null, "is_giftcard": false, "discountable": true, "collection_id": null, "origin_country": null}, "material": null, "metadata": null, "mid_code": null, "created_at": "2024-01-06T04:23:12.699Z", "deleted_at": null, "product_id": "prod_01HKEG5EJAJ169G595EB6HHQ7A", "updated_at": "2024-01-31T11:33:53.924Z", "variant_rank": 0, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 4}, "metadata": {}, "order_id": null, "quantity": 1, "subtotal": 2999, "is_return": false, "tax_lines": [{"code": "21", "name": "21% iva", "rate": 21, "item_id": "item_01HNFV6RF46X9VNYSBNNH2PFYZ"}], "tax_total": 630, "thumbnail": "https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg", "created_at": "2024-01-31T13:26:48.021Z", "unit_price": 2999, "updated_at": "2024-01-31T13:26:48.021Z", "variant_id": "variant_01HKEG5EKEDSNP6ATNTTB2378F", "adjustments": [], "description": "XL", "is_giftcard": false, "has_shipping": false, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 3629, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 630, "raw_discount_total": 0}], "total": 6102, "object": "cart", "region": {"id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "name": "EU", "metadata": null, "tax_code": null, "tax_rate": 0, "countries": [{"id": 109, "name": "ITALY", "iso_2": "it", "iso_3": "ita", "num_code": 380, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Italy"}, {"id": 209, "name": "SPAIN", "iso_2": "es", "iso_3": "esp", "num_code": 724, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Spain"}, {"id": 75, "name": "FRANCE", "iso_2": "fr", "iso_3": "fra", "num_code": 250, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "France"}, {"id": 60, "name": "DENMARK", "iso_2": "dk", "iso_3": "dnk", "num_code": 208, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Denmark"}, {"id": 82, "name": "GERMANY", "iso_2": "de", "iso_3": "deu", "num_code": 276, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Germany"}, {"id": 235, "name": "UNITED KINGDOM", "iso_2": "gb", "iso_3": "gbr", "num_code": 826, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "United Kingdom"}, {"id": 215, "name": "SWEDEN", "iso_2": "se", "iso_3": "swe", "num_code": 752, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Sweden"}], "tax_rates": [{"id": "txr_01HM6VF955JXB29T12X4ZEDBKG", "code": "21", "name": "21% iva", "rate": 21, "metadata": null, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "created_at": "2024-01-15T15:22:35.555Z", "updated_at": "2024-01-15T15:22:35.555Z"}], "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:17.482Z", "currency_code": "eur", "automatic_taxes": true, "tax_provider_id": null, "payment_providers": [{"id": "manual", "is_installed": true}], "gift_cards_taxable": true}, "context": {"ip": "85.59.11.41", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"}, "payment": null, "customer": null, "metadata": null, "subtotal": 6649, "discounts": [{"id": "disc_01HM6VJ61272P6R31QVVYQQR83", "code": "VERANO", "rule": {"id": "dru_01HM6VJ60XTZ24R9H4C22ZD68M", "type": "percentage", "value": 44, "metadata": null, "allocation": "total", "created_at": "2024-01-15T15:24:10.650Z", "deleted_at": null, "updated_at": "2024-01-15T15:24:10.650Z", "description": "verano22 222222"}, "ends_at": null, "rule_id": "dru_01HM6VJ60XTZ24R9H4C22ZD68M", "metadata": {}, "starts_at": "2024-01-15T15:23:48.060Z", "created_at": "2024-01-15T15:24:10.650Z", "deleted_at": null, "is_dynamic": false, "updated_at": "2024-01-31T11:33:57.177Z", "is_disabled": false, "usage_count": 1, "usage_limit": null, "valid_duration": null, "parent_discount_id": null}], "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "tax_total": 1059, "created_at": "2024-01-31T11:33:54.302Z", "deleted_at": null, "gift_cards": [], "payment_id": null, "updated_at": "2024-01-31T11:35:30.179Z", "customer_id": null, "completed_at": null, "sales_channel": {"id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "name": "Default Sales Channel", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z", "description": "Created by Medusa", "is_disabled": false}, "discount_total": 1606, "item_tax_total": 1059, "shipping_total": 0, "billing_address": null, "gift_card_total": 0, "idempotency_key": null, "payment_session": {"id": "ps_01HNFMTMMYFTKRP7X8D74PG9ZR", "data": {"status": "pending"}, "amount": 2473, "status": "pending", "cart_id": "cart_01HNFMR1GPDJT3T39WAWWYHJRX", "created_at": "2024-01-31T11:35:19.405Z", "updated_at": "2024-01-31T11:35:30.179Z", "is_selected": true, "provider_id": "manual", "is_initiated": true, "idempotency_key": null, "payment_authorized_at": null}, "payment_sessions": [{"id": "ps_01HNFMTMMYFTKRP7X8D74PG9ZR", "data": {"status": "pending"}, "amount": 2473, "status": "pending", "cart_id": "cart_01HNFMR1GPDJT3T39WAWWYHJRX", "created_at": "2024-01-31T11:35:19.405Z", "updated_at": "2024-01-31T11:35:30.179Z", "is_selected": true, "provider_id": "manual", "is_initiated": true, "idempotency_key": null, "payment_authorized_at": null}], "sales_channel_id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "shipping_address": null, "shipping_methods": [], "billing_address_id": null, "raw_discount_total": 1606, "shipping_tax_total": 0, "gift_card_tax_total": 0, "shipping_address_id": null, "payment_authorized_at": null}}	finished
ikey_01HNN2G6SZY4VY5G2JA9R1K5SM	d38f4283-96f0-43eb-b806-39b1ebc45432	2024-02-02 14:10:29.820774+00	\N	POST	{"id": "cart_01HNFVA6ZREPT6BJ0X0N1DE5PK"}	/cart_01HNFVA6ZREPT6BJ0X0N1DE5PK/payment-sessions	200	{"cart": {"id": "cart_01HNFVA6ZREPT6BJ0X0N1DE5PK", "type": "default", "email": "yo@yo.es", "items": [{"id": "item_01HNN2G3NKMDH96P16PEGWMFGS", "title": "Medusa Coffee Mug", "total": 1000, "cart_id": "cart_01HNFVA6ZREPT6BJ0X0N1DE5PK", "swap_id": null, "variant": {"id": "variant_01HJQ62H2NRGRY3ZAQCBWK5QTX", "ean": null, "sku": null, "upc": null, "title": "One Size", "width": null, "height": null, "length": null, "weight": null, "barcode": null, "hs_code": null, "product": {"id": "prod_01HJQ62H1V8MN0MKYKZ6M6DWGB", "title": "Medusa Coffee Mug", "width": null, "handle": "coffee-mug", "height": null, "length": null, "status": "published", "weight": 400, "hs_code": null, "profile": {"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}, "type_id": null, "material": null, "metadata": null, "mid_code": null, "profiles": [{"id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "name": "Default Shipping Profile", "type": "default", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z"}], "subtitle": null, "thumbnail": "https://medusa-public-images.s3.eu-west-1.amazonaws.com/coffee-mug.png", "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "profile_id": "sp_01HJQ62F0MRD4WRSYX1KYME2JW", "updated_at": "2023-12-28T03:04:17.482Z", "description": "Every programmer's best friend.", "external_id": null, "is_giftcard": false, "discountable": true, "collection_id": null, "origin_country": null}, "material": null, "metadata": null, "mid_code": null, "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "product_id": "prod_01HJQ62H1V8MN0MKYKZ6M6DWGB", "updated_at": "2023-12-28T03:04:17.482Z", "variant_rank": 0, "origin_country": null, "allow_backorder": false, "manage_inventory": true, "inventory_quantity": 100}, "metadata": {}, "order_id": null, "quantity": 1, "subtotal": 1000, "is_return": false, "tax_lines": [{"code": "default", "name": "default", "rate": 0, "item_id": "item_01HNN2G3NKMDH96P16PEGWMFGS"}], "tax_total": 0, "thumbnail": "https://medusa-public-images.s3.eu-west-1.amazonaws.com/coffee-mug.png", "created_at": "2024-02-02T14:10:26.582Z", "unit_price": 1000, "updated_at": "2024-02-02T14:10:26.582Z", "variant_id": "variant_01HJQ62H2NRGRY3ZAQCBWK5QTX", "adjustments": [], "description": "One Size", "is_giftcard": false, "has_shipping": false, "should_merge": true, "order_edit_id": null, "claim_order_id": null, "discount_total": 0, "original_total": 1000, "allow_discounts": true, "original_item_id": null, "shipped_quantity": null, "returned_quantity": null, "fulfilled_quantity": null, "original_tax_total": 0, "raw_discount_total": 0}], "total": 1000, "object": "cart", "region": {"id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "name": "EU", "metadata": null, "tax_code": null, "tax_rate": 0, "countries": [{"id": 109, "name": "ITALY", "iso_2": "it", "iso_3": "ita", "num_code": 380, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Italy"}, {"id": 209, "name": "SPAIN", "iso_2": "es", "iso_3": "esp", "num_code": 724, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Spain"}, {"id": 75, "name": "FRANCE", "iso_2": "fr", "iso_3": "fra", "num_code": 250, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "France"}, {"id": 60, "name": "DENMARK", "iso_2": "dk", "iso_3": "dnk", "num_code": 208, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Denmark"}, {"id": 82, "name": "GERMANY", "iso_2": "de", "iso_3": "deu", "num_code": 276, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Germany"}, {"id": 235, "name": "UNITED KINGDOM", "iso_2": "gb", "iso_3": "gbr", "num_code": 826, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "United Kingdom"}, {"id": 215, "name": "SWEDEN", "iso_2": "se", "iso_3": "swe", "num_code": 752, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "display_name": "Sweden"}], "tax_rates": [{"id": "txr_01HM6VF955JXB29T12X4ZEDBKG", "code": "21", "name": "21% iva", "rate": 21, "metadata": null, "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "created_at": "2024-01-15T15:22:35.555Z", "updated_at": "2024-01-15T15:22:35.555Z"}], "created_at": "2023-12-28T03:04:17.482Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:17.482Z", "currency_code": "eur", "automatic_taxes": true, "tax_provider_id": null, "payment_providers": [{"id": "manual", "is_installed": true}], "gift_cards_taxable": true}, "context": {"ip": "85.59.11.41", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"}, "payment": null, "metadata": null, "subtotal": 1000, "discounts": [], "region_id": "reg_01HJQ62FHQEHVFQQK69CA8PK41", "tax_total": 0, "created_at": "2024-01-31T13:28:41.182Z", "deleted_at": null, "gift_cards": [], "payment_id": null, "updated_at": "2024-01-31T13:40:38.114Z", "customer_id": "cus_01HNFV8Q3BCE5MM80HQJ8AKAZC", "completed_at": null, "sales_channel": {"id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "name": "Default Sales Channel", "metadata": null, "created_at": "2023-12-28T03:04:16.900Z", "deleted_at": null, "updated_at": "2023-12-28T03:04:16.900Z", "description": "Created by Medusa", "is_disabled": false}, "discount_total": 0, "item_tax_total": 0, "shipping_total": 0, "billing_address": null, "gift_card_total": 0, "idempotency_key": null, "payment_session": {"id": "ps_01HNN2G6V77B5QA4NCW3FRSNW3", "data": {"status": "pending"}, "amount": 1000, "status": "pending", "cart_id": "cart_01HNFVA6ZREPT6BJ0X0N1DE5PK", "created_at": "2024-02-02T14:10:29.826Z", "updated_at": "2024-02-02T14:10:29.826Z", "is_selected": true, "provider_id": "manual", "is_initiated": true, "idempotency_key": null, "payment_authorized_at": null}, "payment_sessions": [{"id": "ps_01HNN2G6V77B5QA4NCW3FRSNW3", "data": {"status": "pending"}, "amount": 1000, "status": "pending", "cart_id": "cart_01HNFVA6ZREPT6BJ0X0N1DE5PK", "created_at": "2024-02-02T14:10:29.826Z", "updated_at": "2024-02-02T14:10:29.826Z", "is_selected": true, "provider_id": "manual", "is_initiated": true, "idempotency_key": null, "payment_authorized_at": null}], "sales_channel_id": "sc_01HJQ62F3H1V5R0YME9AZ7PMMG", "shipping_address": null, "shipping_methods": [], "billing_address_id": null, "raw_discount_total": 0, "shipping_tax_total": 0, "gift_card_tax_total": 0, "shipping_address_id": null, "payment_authorized_at": null}}	finished
\.


--
-- Data for Name: image; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.image (id, url, created_at, updated_at, deleted_at, metadata) FROM stdin;
img_01HJQ62FWDHM4N3HHDAD81X2AQ	https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
img_01HJQ62FWD8DZVZ0HKRAMPV505	https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-back.png	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
img_01HJQ62FWD764279BW6TR1SKP4	https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-white-front.png	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
img_01HJQ62FWDYDCVG4FH9P60T93M	https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-white-back.png	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
img_01HJQ62G96470R7GCACFEBCNWJ	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
img_01HJQ62G96W2CHQ4GVEF7KWDC0	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-back.png	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
img_01HJQ62GEHJQ9NGD3Q3E15JVXE	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatpants-gray-front.png	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
img_01HJQ62GEHCH2JZV0KPSCBBEHY	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatpants-gray-back.png	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
img_01HJQ62GKFHMCC4X826YQFGE4W	https://medusa-public-images.s3.eu-west-1.amazonaws.com/shorts-vintage-front.png	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
img_01HJQ62GKFEBGF9Q5WCGEXE399	https://medusa-public-images.s3.eu-west-1.amazonaws.com/shorts-vintage-back.png	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
img_01HJQ62GQ6ESPYMJ2CCXY3JN0E	https://medusa-public-images.s3.eu-west-1.amazonaws.com/black_hoodie_front.png	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
img_01HJQ62GQ6BYZF5Q49XF38DV84	https://medusa-public-images.s3.eu-west-1.amazonaws.com/black_hoodie_back.png	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
img_01HJQ62GWTT5DSTFRMVKKBS98H	https://medusa-public-images.s3.eu-west-1.amazonaws.com/ls-black-front.png	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
img_01HJQ62GWT3H97EEDMJNRV307M	https://medusa-public-images.s3.eu-west-1.amazonaws.com/ls-black-back.png	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
img_01HJQ62H1H7D5FQBS8GRZ6P2BF	https://medusa-public-images.s3.eu-west-1.amazonaws.com/coffee-mug.png	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
img_01HJQ67WRZA7944WQ7SP842JD2	https://ecommerce.autoges.eu/uploads/1703732833925-5ff616ceb6e7dda51fbe53ba6dbd43c4.jpg	2023-12-28 03:07:15.09277+00	2023-12-28 03:07:15.09277+00	\N	\N
img_01HJX89SXVPMR6JSKYTQQRYTJG	https://minio.autoges.eu/medusa-bucket/5ff616ceb6e7dda51fbe53ba6dbd43c4-1703936319158.jpg	2023-12-30 11:38:41.456278+00	2023-12-30 11:38:41.456278+00	\N	\N
img_01HJX8DJVCQNK3NCP21F3X63X4	https://minio.autoges.eu/medusa-bucket/Ref.-110125453-2-1703936444171.png	2023-12-30 11:40:45.285085+00	2023-12-30 11:40:45.285085+00	\N	\N
img_01HJXESBTM2A1PCZ8TW9HZJ0MJ	https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1703943121883.jpg	2023-12-30 13:32:02.760981+00	2023-12-30 13:32:02.760981+00	\N	\N
img_01HKAQE4P0A5SGHQ3JVG1R0TGM	https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704388397828.jpg	2024-01-04 17:13:19.796531+00	2024-01-04 17:13:19.796531+00	\N	\N
img_01HKEG5EJ22T81B35Y9CP8YTTY	https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514990880.jpg	2024-01-06 04:23:12.69999+00	2024-01-06 04:23:12.69999+00	\N	\N
img_01HM6VN902X7C8S188JGM9MC1S	https://minio.autoges.eu/medusa-bucket/VAcXKdZt9E%20%286%29-1705332351641.png	2024-01-15 15:25:51.981785+00	2024-01-15 15:25:51.981785+00	\N	\N
img_01HM6VN9022F9EHR0M2ACGZCWS	https://minio.autoges.eu/medusa-bucket/VAcXKdZt9E%20%284%29-1705332351648.png	2024-01-15 15:25:51.981785+00	2024-01-15 15:25:51.981785+00	\N	\N
img_01HM6VN9023GSJFFYX75MZBY3Q	https://minio.autoges.eu/medusa-bucket/VAcXKdZt9E%20%283%29-1705332351649.png	2024-01-15 15:25:51.981785+00	2024-01-15 15:25:51.981785+00	\N	\N
\.


--
-- Data for Name: invite; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invite (id, user_email, role, accepted, created_at, updated_at, deleted_at, metadata, token, expires_at) FROM stdin;
\.


--
-- Data for Name: line_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.line_item (id, cart_id, order_id, swap_id, title, description, thumbnail, is_giftcard, should_merge, allow_discounts, has_shipping, unit_price, variant_id, quantity, fulfilled_quantity, returned_quantity, shipped_quantity, created_at, updated_at, metadata, claim_order_id, is_return, original_item_id, order_edit_id) FROM stdin;
item_01HMW3K1Z0H0WYY0FJNAABGB2W	\N	\N	\N	Medusa T-Shirt	M / White	https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png	f	t	t	\N	100	variant_01HJQ62G31A6XR3R0QAA805S8T	1	\N	\N	\N	2024-01-23 21:28:30.869402+00	2024-01-23 21:28:30.869402+00	{}	\N	f	\N	oe_01HMW3J3KA3BF1ZS2HJY87AVTH
item_01HMW42D3CXXTFXDXS8FTT983H	\N	\N	\N	Medusa Hoodie	L	https://medusa-public-images.s3.eu-west-1.amazonaws.com/black_hoodie_front.png	f	t	t	\N	4150	variant_01HJQ62GT3ZMC2B76FGKWCW92E	4	\N	\N	\N	2024-01-23 21:36:53.783361+00	2024-01-23 21:37:02.581151+00	{}	\N	f	\N	oe_01HMW41SDHGXS3QYVC9Y2AS7C9
item_01HMW3KCS1BDT4QP80R9PAQBB4	\N	\N	\N	Franela Negra con un Logo	XL	https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg	f	t	t	\N	3299	variant_01HKEG5EKEDSNP6ATNTTB2378F	2	\N	\N	\N	2024-01-23 21:28:41.976778+00	2024-01-23 21:28:47.720734+00	{}	\N	f	\N	oe_01HMW3J3KA3BF1ZS2HJY87AVTH
item_01HMW42D3RNXMEWNVDQ4D64PY2	\N	\N	\N	Medusa Hoodie	S	https://medusa-public-images.s3.eu-west-1.amazonaws.com/black_hoodie_front.png	f	t	t	\N	4150	variant_01HJQ62GRDR8CXCHCWNFMNG39W	6	\N	\N	\N	2024-01-23 21:36:53.795084+00	2024-01-23 21:37:09.613812+00	{}	\N	f	\N	oe_01HMW41SDHGXS3QYVC9Y2AS7C9
item_01HMW3K1YW0AGX3SAD0XSPZJYT	\N	\N	\N	Medusa T-Shirt	L / White	https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png	f	t	t	\N	1100	variant_01HJQ62G5CF8NT71MZ8KCZFSVT	3	\N	\N	\N	2024-01-23 21:28:30.862883+00	2024-01-23 21:28:58.401821+00	{}	\N	f	\N	oe_01HMW3J3KA3BF1ZS2HJY87AVTH
item_01HMW41SDRDSARKWHP5Q94GXVW	\N	\N	\N	Medusa Sweatpants	M	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatpants-gray-front.png	f	t	t	t	3350	variant_01HJQ62GGFHCX6NG3JH63SJRR5	2	2	\N	2	2024-01-06 04:25:23.427+00	2024-01-06 04:31:03.178+00	{}	\N	f	item_01HKEG9E7NCNQRM18Q5J7D023Q	oe_01HMW41SDHGXS3QYVC9Y2AS7C9
item_01HMW41SDRFRKN79GMTHXS31AQ	\N	\N	\N	Medusa Hoodie	M	https://medusa-public-images.s3.eu-west-1.amazonaws.com/black_hoodie_front.png	f	t	t	t	4150	variant_01HJQ62GSGSKX7ZPXBKBMJRP28	1	1	\N	1	2024-01-06 04:25:38.217+00	2024-01-06 04:31:03.178+00	{}	\N	f	item_01HKEG9WNT60N7BF1WFP74FYEJ	oe_01HMW41SDHGXS3QYVC9Y2AS7C9
item_01HMW41SDR43P8E0XJ305WDAKJ	\N	\N	\N	Franela Negra con un Logo	XL	https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg	f	t	t	t	3299	variant_01HKEG5EKEDSNP6ATNTTB2378F	3	3	\N	3	2024-01-06 04:25:02.458+00	2024-01-06 04:31:03.178+00	{}	\N	f	item_01HKEG8SRDW5SRXES29QJT11TG	oe_01HMW41SDHGXS3QYVC9Y2AS7C9
item_01HKEG8SRDW5SRXES29QJT11TG	cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5	order_01HKEGFFG7P3NFDAE7WV6DTQAH	\N	Franela Negra con un Logo	XL	https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg	f	t	t	t	3299	variant_01HKEG5EKEDSNP6ATNTTB2378F	3	3	\N	3	2024-01-06 04:25:02.458107+00	2024-01-06 04:31:03.178177+00	{}	\N	f	\N	\N
item_01HKEG9E7NCNQRM18Q5J7D023Q	cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5	order_01HKEGFFG7P3NFDAE7WV6DTQAH	\N	Medusa Sweatpants	M	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatpants-gray-front.png	f	t	t	t	3350	variant_01HJQ62GGFHCX6NG3JH63SJRR5	2	2	\N	2	2024-01-06 04:25:23.427224+00	2024-01-06 04:31:03.178177+00	{}	\N	f	\N	\N
item_01HKEG9WNT60N7BF1WFP74FYEJ	cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5	order_01HKEGFFG7P3NFDAE7WV6DTQAH	\N	Medusa Hoodie	M	https://medusa-public-images.s3.eu-west-1.amazonaws.com/black_hoodie_front.png	f	t	t	t	4150	variant_01HJQ62GSGSKX7ZPXBKBMJRP28	1	1	\N	1	2024-01-06 04:25:38.217137+00	2024-01-06 04:31:03.178177+00	{}	\N	f	\N	\N
item_01HMW3J3KJRMN25CXQ5HJ6WG24	\N	\N	\N	Medusa Sweatpants	M	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatpants-gray-front.png	f	t	t	t	3350	variant_01HJQ62GGFHCX6NG3JH63SJRR5	2	2	\N	2	2024-01-06 04:25:23.427+00	2024-01-06 04:31:03.178+00	{}	\N	f	item_01HKEG9E7NCNQRM18Q5J7D023Q	oe_01HMW3J3KA3BF1ZS2HJY87AVTH
item_01HMW3J3KJSPF936S87WHTWEX7	\N	\N	\N	Medusa Hoodie	M	https://medusa-public-images.s3.eu-west-1.amazonaws.com/black_hoodie_front.png	f	t	t	t	4150	variant_01HJQ62GSGSKX7ZPXBKBMJRP28	1	1	\N	1	2024-01-06 04:25:38.217+00	2024-01-06 04:31:03.178+00	{}	\N	f	item_01HKEG9WNT60N7BF1WFP74FYEJ	oe_01HMW3J3KA3BF1ZS2HJY87AVTH
item_01HMW3J3KJDDXFBPHT7DGX9BTE	\N	\N	\N	Franela Negra con un Logo	XL	https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg	f	t	t	t	3299	variant_01HKEG5EKEDSNP6ATNTTB2378F	3	3	\N	3	2024-01-06 04:25:02.458+00	2024-01-06 04:31:03.178+00	{}	\N	f	item_01HKEG8SRDW5SRXES29QJT11TG	oe_01HMW3J3KA3BF1ZS2HJY87AVTH
item_01HMW3K1YKMM8MEB95436XBXJM	\N	\N	\N	Medusa T-Shirt	S / White	https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png	f	t	t	\N	100	variant_01HJQ62G18RW9J8R989JWZ4MPY	1	\N	\N	\N	2024-01-23 21:28:30.860872+00	2024-01-23 21:28:30.860872+00	{}	\N	f	\N	oe_01HMW3J3KA3BF1ZS2HJY87AVTH
item_01HMW3K1YWA7H2B2CGJ28CMKN1	\N	\N	\N	Medusa T-Shirt	XL / White	https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png	f	t	t	\N	1100	variant_01HJQ62G7ME141NMQ4XNGQ0RTD	1	\N	\N	\N	2024-01-23 21:28:30.875435+00	2024-01-23 21:28:30.875435+00	{}	\N	f	\N	oe_01HMW3J3KA3BF1ZS2HJY87AVTH
item_01HMW42D3RRAJP1SQAF9PM4S02	\N	\N	\N	Medusa Hoodie	XL	https://medusa-public-images.s3.eu-west-1.amazonaws.com/black_hoodie_front.png	f	t	t	\N	4150	variant_01HJQ62GVAM90DS9WKQRA7WGKE	7	\N	\N	\N	2024-01-23 21:36:53.803864+00	2024-01-23 21:37:17.012822+00	{}	\N	f	\N	oe_01HMW41SDHGXS3QYVC9Y2AS7C9
item_01HMW42D3AXMA118E6K08NKBFB	\N	\N	\N	Medusa Hoodie	M	https://medusa-public-images.s3.eu-west-1.amazonaws.com/black_hoodie_front.png	f	t	t	\N	4150	variant_01HJQ62GSGSKX7ZPXBKBMJRP28	5	\N	\N	\N	2024-01-23 21:36:53.78627+00	2024-01-23 21:37:05.449036+00	{}	\N	f	\N	oe_01HMW41SDHGXS3QYVC9Y2AS7C9
item_01HMW45ZDG1BH41DZX1XM91JEN	cart_01HMW455PM9KPMQ188CTN3BEPD	\N	\N	Medusa T-Shirt	S / White	https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png	f	t	t	t	1950	variant_01HJQ62G18RW9J8R989JWZ4MPY	1	\N	\N	\N	2024-01-23 21:38:50.912034+00	2024-01-23 21:42:59.614504+00	{}	\N	f	\N	\N
item_01HNFMT3NPK4RMG17Y35VXMBQW	cart_01HNFMR1GPDJT3T39WAWWYHJRX	order_01HNFVA6PA3X641SN5K2QQNHTM	\N	Medusa Hoodie	L	https://medusa-public-images.s3.eu-west-1.amazonaws.com/black_hoodie_front.png	f	t	t	t	3650	variant_01HJQ62GT3ZMC2B76FGKWCW92E	1	1	\N	1	2024-01-31 11:35:02.054754+00	2024-01-31 13:30:38.997001+00	{}	\N	f	\N	\N
item_01HNFV6RF46X9VNYSBNNH2PFYZ	cart_01HNFMR1GPDJT3T39WAWWYHJRX	order_01HNFVA6PA3X641SN5K2QQNHTM	\N	Franela Negra con un Logo	XL	https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg	f	t	t	t	2999	variant_01HKEG5EKEDSNP6ATNTTB2378F	1	1	\N	1	2024-01-31 13:26:48.021293+00	2024-01-31 13:30:38.997001+00	{}	\N	f	\N	\N
item_01HMW45JKQ95EH9SW37EG0FDJG	cart_01HMW455PM9KPMQ188CTN3BEPD	\N	\N	Franela Negra con un Logo	S	https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg	f	t	t	t	2599	variant_01HKEG5EKGETQHJ5MJ58A2D61Y	1	\N	\N	\N	2024-01-23 21:38:37.804588+00	2024-01-23 21:42:59.614504+00	{}	\N	f	\N	\N
item_01HMW45G7G981JCM75QMHN00B2	cart_01HMW455PM9KPMQ188CTN3BEPD	\N	\N	Franela Negra con un Logo	XL	https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg	f	t	t	t	2999	variant_01HKEG5EKEDSNP6ATNTTB2378F	1	\N	\N	\N	2024-01-23 21:38:35.360814+00	2024-01-23 21:42:59.614504+00	{}	\N	f	\N	\N
item_01HMW4D3BGM1YTPHDKS1RRJ3P3	\N	order_01HMW4C4BFQ0JCSRQZMJZAD0YM	\N	Medusa Hoodie	XL	https://medusa-public-images.s3.eu-west-1.amazonaws.com/black_hoodie_front.png	f	t	t	\N	3650	variant_01HJQ62GVAM90DS9WKQRA7WGKE	4	\N	\N	\N	2024-01-23 21:42:44.263391+00	2024-01-23 21:42:59.614504+00	{}	\N	f	\N	oe_01HMW4CPB8PB1VZ38KJPCA84AZ
item_01HMW4D3B6HKJX8XC1ZA2GC6AY	\N	order_01HMW4C4BFQ0JCSRQZMJZAD0YM	\N	Medusa Hoodie	M	https://medusa-public-images.s3.eu-west-1.amazonaws.com/black_hoodie_front.png	f	t	t	\N	3650	variant_01HJQ62GSGSKX7ZPXBKBMJRP28	3	\N	\N	\N	2024-01-23 21:42:44.252611+00	2024-01-23 21:42:59.614504+00	{}	\N	f	\N	oe_01HMW4CPB8PB1VZ38KJPCA84AZ
item_01HMW4D3B4DHYN1EHAGMKKAMYQ	\N	order_01HMW4C4BFQ0JCSRQZMJZAD0YM	\N	Medusa Hoodie	S	https://medusa-public-images.s3.eu-west-1.amazonaws.com/black_hoodie_front.png	f	t	t	\N	3650	variant_01HJQ62GRDR8CXCHCWNFMNG39W	2	\N	\N	\N	2024-01-23 21:42:44.243458+00	2024-01-23 21:42:59.614504+00	{}	\N	f	\N	oe_01HMW4CPB8PB1VZ38KJPCA84AZ
item_01HMW4D39ZB4REVF4R1R5AZ4XW	\N	order_01HMW4C4BFQ0JCSRQZMJZAD0YM	\N	Medusa Hoodie	L	https://medusa-public-images.s3.eu-west-1.amazonaws.com/black_hoodie_front.png	f	t	t	\N	3650	variant_01HJQ62GT3ZMC2B76FGKWCW92E	1	\N	\N	\N	2024-01-23 21:42:44.242228+00	2024-01-23 21:42:59.614504+00	{}	\N	f	\N	oe_01HMW4CPB8PB1VZ38KJPCA84AZ
item_01HMW4CPBG91BHEEWND2Y5KETB	\N	order_01HMW4C4BFQ0JCSRQZMJZAD0YM	\N	Medusa T-Shirt	S / White	https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png	f	t	t	t	1950	variant_01HJQ62G18RW9J8R989JWZ4MPY	1	\N	\N	\N	2024-01-23 21:38:50.912+00	2024-01-23 21:42:59.614504+00	{}	\N	f	item_01HMW45ZDG1BH41DZX1XM91JEN	oe_01HMW4CPB8PB1VZ38KJPCA84AZ
item_01HMW4CPBG69FSRN6W3TV35N10	\N	order_01HMW4C4BFQ0JCSRQZMJZAD0YM	\N	Franela Negra con un Logo	S	https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg	f	t	t	t	2599	variant_01HKEG5EKGETQHJ5MJ58A2D61Y	1	\N	\N	\N	2024-01-23 21:38:37.804+00	2024-01-23 21:42:59.614504+00	{}	\N	f	item_01HMW45JKQ95EH9SW37EG0FDJG	oe_01HMW4CPB8PB1VZ38KJPCA84AZ
item_01HMW4CPBGYQ40914SHD129K8J	\N	order_01HMW4C4BFQ0JCSRQZMJZAD0YM	\N	Franela Negra con un Logo	XL	https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg	f	t	t	t	2999	variant_01HKEG5EKEDSNP6ATNTTB2378F	1	\N	\N	\N	2024-01-23 21:38:35.36+00	2024-01-23 21:42:59.614504+00	{}	\N	f	item_01HMW45G7G981JCM75QMHN00B2	oe_01HMW4CPB8PB1VZ38KJPCA84AZ
item_01HNN2G3NKMDH96P16PEGWMFGS	cart_01HNFVA6ZREPT6BJ0X0N1DE5PK	\N	\N	Medusa Coffee Mug	One Size	https://medusa-public-images.s3.eu-west-1.amazonaws.com/coffee-mug.png	f	t	t	f	1000	variant_01HJQ62H2NRGRY3ZAQCBWK5QTX	1	\N	\N	\N	2024-02-02 14:10:26.582373+00	2024-02-02 14:10:26.582373+00	{}	\N	f	\N	\N
item_01HNDCBH76E0T3YMYY4Q22GEFF	cart_01HM6THN376FNFK12TTTPYR2KH	order_01HNFMR16MP15H71KPM48VMAX9	\N	Franela Negra con un Logo	XL	https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg	f	t	t	t	2999	variant_01HKEG5EKEDSNP6ATNTTB2378F	2	\N	\N	\N	2024-01-30 14:28:46.924131+00	2024-01-31 11:33:53.924934+00	{}	\N	f	\N	\N
\.


--
-- Data for Name: line_item_adjustment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.line_item_adjustment (id, item_id, description, discount_id, amount, metadata) FROM stdin;
lia_01HNFV6RG1NW0CVHHAZETE4QHS	item_01HNFMT3NPK4RMG17Y35VXMBQW	discount	disc_01HM6VJ61272P6R31QVVYQQR83	1606	\N
\.


--
-- Data for Name: line_item_tax_line; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.line_item_tax_line (id, rate, name, code, created_at, updated_at, metadata, item_id) FROM stdin;
litl_01HKEGFF7RNESRM1CCFB9Y1AEM	0	default	default	2024-01-06 04:28:41.049208+00	2024-01-06 04:28:41.256921+00	\N	item_01HKEG8SRDW5SRXES29QJT11TG
litl_01HKEGFF7R88ZRSW8ASP4NDAZX	0	default	default	2024-01-06 04:28:41.049208+00	2024-01-06 04:28:41.256921+00	\N	item_01HKEG9E7NCNQRM18Q5J7D023Q
litl_01HKEGFF7RMT4KNFYFYVJ2HK41	0	default	default	2024-01-06 04:28:41.049208+00	2024-01-06 04:28:41.256921+00	\N	item_01HKEG9WNT60N7BF1WFP74FYEJ
litl_01HMW3J3KKZPN1VKQT4S08DSKB	0	default	default	2024-01-06 04:28:41.049+00	2024-01-06 04:28:41.256+00	\N	item_01HMW3J3KJRMN25CXQ5HJ6WG24
litl_01HMW3J3KKG0FV8TX21YR18CRA	0	default	default	2024-01-06 04:28:41.049+00	2024-01-06 04:28:41.256+00	\N	item_01HMW3J3KJSPF936S87WHTWEX7
litl_01HMW3J3KKRW38FYDEYBHW4V9V	0	default	default	2024-01-06 04:28:41.049+00	2024-01-06 04:28:41.256+00	\N	item_01HMW3J3KJDDXFBPHT7DGX9BTE
litl_01HMW3K211QBE1GEGC1QCFX2Z0	0	default	default	2024-01-23 21:28:30.860872+00	2024-01-23 21:28:30.860872+00	\N	item_01HMW3K1YKMM8MEB95436XBXJM
litl_01HMW3K21AC23XSG5XT3QKSZ64	0	default	default	2024-01-23 21:28:30.869402+00	2024-01-23 21:28:30.869402+00	\N	item_01HMW3K1Z0H0WYY0FJNAABGB2W
litl_01HMW3K21AXNYMDBYW9BKH4J85	0	default	default	2024-01-23 21:28:30.862883+00	2024-01-23 21:28:30.862883+00	\N	item_01HMW3K1YW0AGX3SAD0XSPZJYT
litl_01HMW3K21ASA2EGTYVVBCJ58HH	0	default	default	2024-01-23 21:28:30.875435+00	2024-01-23 21:28:30.875435+00	\N	item_01HMW3K1YWA7H2B2CGJ28CMKN1
litl_01HMW3KCTDXGXMJ3S7VKPZDF48	0	default	default	2024-01-23 21:28:41.976778+00	2024-01-23 21:28:41.976778+00	\N	item_01HMW3KCS1BDT4QP80R9PAQBB4
litl_01HMW41SDSEYPKKHMFDFJFSJWA	0	default	default	2024-01-06 04:28:41.049+00	2024-01-06 04:28:41.256+00	\N	item_01HMW41SDRDSARKWHP5Q94GXVW
litl_01HMW41SDSPX3JDFQGF6T64M4J	0	default	default	2024-01-06 04:28:41.049+00	2024-01-06 04:28:41.256+00	\N	item_01HMW41SDRFRKN79GMTHXS31AQ
litl_01HMW41SDSJPV7ZYCEZA3T0XMG	0	default	default	2024-01-06 04:28:41.049+00	2024-01-06 04:28:41.256+00	\N	item_01HMW41SDR43P8E0XJ305WDAKJ
litl_01HMW42D6HQDBRB5C8C55BTN2B	0	default	default	2024-01-23 21:36:53.78627+00	2024-01-23 21:36:53.78627+00	\N	item_01HMW42D3AXMA118E6K08NKBFB
litl_01HMW42D6S01TPZFNY0PC9W9S1	0	default	default	2024-01-23 21:36:53.783361+00	2024-01-23 21:36:53.783361+00	\N	item_01HMW42D3CXXTFXDXS8FTT983H
litl_01HMW42D6T59426H1AVF3Z37E2	0	default	default	2024-01-23 21:36:53.795084+00	2024-01-23 21:36:53.795084+00	\N	item_01HMW42D3RNXMEWNVDQ4D64PY2
litl_01HMW42D7FGRMR9D3RJ3E194D1	0	default	default	2024-01-23 21:36:53.803864+00	2024-01-23 21:36:53.803864+00	\N	item_01HMW42D3RRAJP1SQAF9PM4S02
litl_01HMW4C464HMNB4QH6ENA8D0FB	21	21% iva	21	2024-01-23 21:42:12.396605+00	2024-01-23 21:42:12.527487+00	\N	item_01HMW45ZDG1BH41DZX1XM91JEN
litl_01HMW4C464ACZRKA9GBTEW187H	21	21% iva	21	2024-01-23 21:42:12.396605+00	2024-01-23 21:42:12.527487+00	\N	item_01HMW45JKQ95EH9SW37EG0FDJG
litl_01HMW4C464RQPAXN4PP6DDEGA7	21	21% iva	21	2024-01-23 21:42:12.396605+00	2024-01-23 21:42:12.527487+00	\N	item_01HMW45G7G981JCM75QMHN00B2
litl_01HMW4CPBGZXQJNGGF480WTENV	21	21% iva	21	2024-01-23 21:42:12.396+00	2024-01-23 21:42:12.527+00	\N	item_01HMW4CPBG91BHEEWND2Y5KETB
litl_01HMW4CPBGHQJA49KF428WGRY8	21	21% iva	21	2024-01-23 21:42:12.396+00	2024-01-23 21:42:12.527+00	\N	item_01HMW4CPBG69FSRN6W3TV35N10
litl_01HMW4CPBGBKTDQRBDQBT29GQ2	21	21% iva	21	2024-01-23 21:42:12.396+00	2024-01-23 21:42:12.527+00	\N	item_01HMW4CPBGYQ40914SHD129K8J
litl_01HMW4D3C2X73667Q1E4T1T2B6	21	21% iva	21	2024-01-23 21:42:44.242228+00	2024-01-23 21:42:44.242228+00	\N	item_01HMW4D39ZB4REVF4R1R5AZ4XW
litl_01HMW4D3DT9D5C7R60AW1YG5FV	21	21% iva	21	2024-01-23 21:42:44.243458+00	2024-01-23 21:42:44.243458+00	\N	item_01HMW4D3B4DHYN1EHAGMKKAMYQ
litl_01HMW4D3DT1H3EEDH1ANWJAZGJ	21	21% iva	21	2024-01-23 21:42:44.263391+00	2024-01-23 21:42:44.263391+00	\N	item_01HMW4D3BGM1YTPHDKS1RRJ3P3
litl_01HMW4D3DY1X0FBAFMB1SGQN0G	21	21% iva	21	2024-01-23 21:42:44.252611+00	2024-01-23 21:42:44.252611+00	\N	item_01HMW4D3B6HKJX8XC1ZA2GC6AY
litl_01HNFMR10N5D83MET01AC5S07W	21	21% iva	21	2024-01-31 11:33:53.783673+00	2024-01-31 11:33:53.924934+00	\N	item_01HNDCBH76E0T3YMYY4Q22GEFF
litl_01HNFVA6H2VBXCJG2XF82T83Y7	21	21% iva	21	2024-01-31 13:28:40.705534+00	2024-01-31 13:28:40.836463+00	\N	item_01HNFMT3NPK4RMG17Y35VXMBQW
litl_01HNFVA6H2TBKFA84CGHTZGT1X	21	21% iva	21	2024-01-31 13:28:40.705534+00	2024-01-31 13:28:40.836463+00	\N	item_01HNFV6RF46X9VNYSBNNH2PFYZ
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, "timestamp", name) FROM stdin;
1	1611063162649	initialSchema1611063162649
2	1611063174563	countriesCurrencies1611063174563
3	1612284947120	claims1612284947120
4	1612353094577	indexes1612353094577
5	1613146953072	notifications1613146953072
6	1613146953073	productTypeCategoryTags1613146953073
7	1613384784316	draftOrders1613384784316
8	1613656135167	trackingLinks1613656135167
9	1614684597235	cartContext1614684597235
10	1615891636559	returnReason1615891636559
11	1615970124120	discountUsageCount1615970124120
12	1617002207608	discountUsage1617002207608
13	1619108646647	nullablePassword1619108646647
14	1623231564533	noNotification1623231564533
15	1624287602631	gcRemoveUniqueOrder1624287602631
16	1624610325746	softDeletingUniqueConstraints1624610325746
17	1625560513367	ensureCancellationFieldsExist1625560513367
18	1627995307200	addDiscountableToProduct1627995307200
19	1630505790603	allowBackorderSwaps1630505790603
20	1631104895519	RankColumnWithDefaultValue1631104895519
21	1631261634964	enforceUniqueness1631261634964
22	1631696624528	validDurationForDiscount1631696624528
23	1631800727788	nestedReturnReasons1631800727788
24	1631864388026	statusOnProduct1631864388026
25	1632220294687	addNotes1632220294687
26	1632828114899	deleteDateOnShippingOptionRequirements1632828114899
27	1633512755401	extendedUserApi1633512755401
28	1633614437919	addCustomShippingOptions1633614437919
29	1638543550000	orderTaxRateToRealType1638543550000
30	1638952072999	externalIdOrder1638952072999
31	1641636508055	newTaxSystem1641636508055
32	1644943746861	customerGroups1644943746861
33	1646324713514	discountConditions1646324713514
34	1646915480108	updateMoneyAmountAddPriceList1646915480108
35	1648600574750	addLineItemAdjustments1648600574750
36	1648641130007	taxLineConstraints1648641130007
37	1649775522087	addBatchJobModel1649775522087
38	1656949291839	salesChannel1656949291839
39	1657098186554	taxedGiftCardTransactions1657098186554
40	1657267320181	extendedBatchJob1657267320181
41	1660040729000	paymentSessionUniqCartIdProviderId1660040729000
42	1661345741249	multiPaymentCart1661345741249
43	1661863940645	swapFulfillmentStatusRequiresAction1661863940645
44	1663059812399	orderEditing1663059812399
45	1663059812400	lineItemOriginalItemRelation1663059812400
46	1664880666982	paymentCollection1664880666982
47	1666173221888	addAnalyticsConfig1666173221888
48	1667815005070	publishableApiKey1667815005070
49	1669032280562	updateCustomerEmailConstraint_1669032280562
50	1670855241304	addTaxRateToGiftCards1670855241304
51	1671711415179	multiLocation1671711415179
52	1672906846559	productCategory1672906846559
53	1672906846560	paymentSessionIsInitiated1672906846560
54	1673003729870	stagedJobOptions1673003729870
55	1673550502785	uniquePaySessCartId1673550502785
56	1674455083104	productCategoryProduct1674455083104
57	1675689306130	multiLocationSoftDelete1675689306130
58	1677234878504	productCategoryRank1677234878504
59	1678093365811	ensureRequiredQuantity1678093365811
60	1678093365812	lineItemAdjustmentsAmount1678093365812
61	1679950221063	categoryRemoveSoftDelete1679950221063
62	1679950645253	categoryCreateIndexes1679950645253
63	1679950645254	productDomainImprovedIndexes1679950645254
64	1679950645254	productSearchGinIndexes1679950645254
65	1680714052628	addSalesChannelMetadata1680714052628
66	1680857773272	addDescriptionToProductCategory1680857773272
67	1680857773272	lineItemTaxAdjustmentOnCascadeDelete1680857773272
68	1680857773273	addTableProductShippingProfile1680857773273
69	1680857773273	dropProductIdFkSalesChannels1680857773273
70	1680857773273	dropVariantIdFkMoneyAmount1680857773273
71	1692870898423	UpdateReturnReasonIndex1692870898423
72	1692953518123	dropMoneyAmountConstraintsForPricingModule1692953518123
73	1699564794649	AddMetadataToProductCategory1699564794649
\.


--
-- Data for Name: money_amount; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.money_amount (id, currency_code, amount, region_id, created_at, updated_at, deleted_at, min_quantity, max_quantity, price_list_id) FROM stdin;
ma_01HJQ62G0CZ7K01V2KCRZ5MWEX	eur	1950	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62G0D3GZK9WD208P95HHD	usd	2200	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62G1MM5HK6N1134EZP9KK	eur	1950	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62G1MDW7RT0EYTG6VGR1T	usd	2200	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62G2CFJ3TTENZ41W7E6MP	eur	1950	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62G2CERSFEJ0M7VHCTXEV	usd	2200	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62G398ZXTK59BPCW4DFGJ	eur	1950	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62G39W3WWS9KAB2C5VB1B	usd	2200	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62G4SCFNAQPSW01ZMMSE9	eur	1950	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62G4V0P4Q8HJAYQ05M75R	usd	2200	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62G5WXN6ZA7ZW3R6Z9A3Z	eur	1950	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62G5WKHW0DD77A1J2SEE0	usd	2200	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62G6WZBN06C7AXDZRPHGG	eur	1950	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62G6WCYJJH1KRGY37TG9H	usd	2200	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62G8JYQNX6DXE1JBN8HP1	eur	1950	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62G8JHNT6JT3TR4PTW573	usd	2200	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GBCA2ZKPBM5ZGPYNMMX	eur	2950	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GBCNSPZJBJCZ0NASV2P	usd	3350	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GCJ8QJV5959QK59XSWC	eur	2950	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GCJ8XS2QSY2VT46RQEW	usd	3350	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GDJ7JE1RH4FAZB4W0N5	eur	2950	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GDJHCFJV5R2HKM40FFB	usd	3350	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GE7VBDVW57X57Z66WER	eur	2950	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GE7MMA6RDS9YQQ85MA7	usd	3350	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GFQK11FN8R7V5M55RWR	eur	2950	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GFQ6K651RNYNB1Z9YE2	usd	3350	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GGQ62GYQZE1RQP2JP6C	eur	2950	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GGQRVHXA12D3QYMWF31	usd	3350	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GHX0805XRGFH9YR9V7T	eur	2950	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GHXMCP1CY7EQ7M9JV57	usd	3350	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GK9J6ZHNMSAFD8YP25M	eur	2950	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GK9ZKBZT7HF4J7Y6NYJ	usd	3350	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GMJMS7MQX0AEWJNN452	eur	2500	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GMJQ7NSFA6EEYX39T7Z	usd	2850	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GNFP1HFD2QRQ60NAWXJ	eur	2500	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GNFPFZAJ578CPXXP1XQ	usd	2850	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GP30ET16NS86Z370SBX	eur	2500	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GP3RD8EKNXF32F8CTV4	usd	2850	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GPTF3TMNP80CGP5FSSN	eur	2500	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GPTAY07BDHHFJP74HTP	usd	2850	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GSSD6GAJE11G7KX66MN	eur	3650	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GSS93Z8327TZQN7SY54	usd	4150	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GTBQ5XB3KJ6YFMWWXAF	eur	3650	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GTB2SJX2PVR3WMN7A19	usd	4150	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GWG8B8J9SDYTWETZZ1B	eur	3650	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GWG4ED7EM1YRM718A0X	usd	4150	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GY9ZXR4XRF282FEFJ5X	eur	3650	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GY9JWCZDBGYKFP4TR06	usd	4150	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GYZCZQPD1ZQ32Y7N6B2	eur	3650	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62GYZDE2TKKRR6B2HY1ZT	usd	4150	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62H04GRCJ1X8KG0SQ7MGE	eur	3650	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62H04CRAA5BNNVW4PFS8F	usd	4150	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62H19YF2K6BTKWSQD4150	eur	3650	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62H19EAHD42KQ2KYGA6NA	usd	4150	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62H2ZV3XEF74EQRQCXP4J	eur	1000	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HJQ62H2ZMXV46K2ETMEZFQTH	usd	1200	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N
ma_01HKEEW75TN029JSRC386FMFGV	usd	4000	\N	2024-01-06 04:12:45.468166+00	2024-01-06 04:19:07.383312+00	2024-01-06 04:19:07.383312+00	\N	\N	\N
ma_01HKEEW75TWK2Y20TSGCMP2VHJ	eur	3500	\N	2024-01-06 04:12:45.468166+00	2024-01-06 04:19:07.383312+00	2024-01-06 04:19:07.383312+00	\N	\N	\N
ma_01HKEG86Q1TG1NYX60SMPDZHZB	usd	2799	\N	2024-01-06 04:24:42.950332+00	2024-01-06 04:24:42.950332+00	\N	\N	\N	\N
ma_01HKEG86Q1X9B43D50TH1SQDWR	eur	2599	\N	2024-01-06 04:24:42.950332+00	2024-01-06 04:24:42.950332+00	\N	\N	\N	\N
ma_01HKEG86RGBWWWECD2T233A3M1	eur	2999	\N	2024-01-06 04:24:42.992916+00	2024-01-06 04:24:42.992916+00	\N	\N	\N	\N
ma_01HKEG86RGYTV9RM6V275EKNR8	usd	3299	\N	2024-01-06 04:24:42.992916+00	2024-01-06 04:24:42.992916+00	\N	\N	\N	\N
ma_01HM6VA76QTYNK2RF47AJ9YG14	usd	1000	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA76R2TM4142F75QWWT9V	eur	900	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA76R7WSDWZ0SP82FWC6B	usd	1200	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA76R4PJNVZXQXSJ16PB2	eur	800	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA76RN08PJ3Y6TEAGRTW2	usd	1200	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA76R4MT01R1Z09N0V9FB	eur	800	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA76SGJ5NTPYGMRG1B9F1	usd	1100	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA76SNW72NJJNB4Y2KEYX	eur	700	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA76S7WZQ4WYX8RP3FFFK	usd	1000	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA76SHH0F1X9512C228T2	eur	900	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA76S7EDP887F2DXN5FCK	usd	1200	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA76SP7G17PB7ETM0154Q	eur	800	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA76T2H0E6A7RK4MKRQQV	usd	1200	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA76TYBB1VFVHM63983MV	eur	800	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA76TN6KCTQBC8X868GXH	usd	1100	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA76T2G87TDCS4JJV7FWG	eur	700	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA76THC00E85FQQACYEQV	usd	100	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA76TYG4SCHE97X33J5E5	eur	200	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA76TXFE537H6BF1ZZGEN	usd	100	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA76V9PGBPAMHNSA13KPG	eur	200	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA76VB4RE8FYBWVY004KH	usd	100	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA76VJEDZFBPVNBA66Y38	eur	200	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA76VRGYKQJSCZ4PED099	usd	100	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA76VH9XEYDPQVMFCVR65	eur	200	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA76VHR05BHMHP99NNMS4	usd	1100	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA76VP519E0Q7HZSV97KQ	eur	200	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA76XV3V53NV1N65P3ACD	usd	1100	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA76X2P6N1Q7BHG589VR9	eur	200	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA770EDS0861AF3ERAP0C	usd	1100	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA7703VGH9DCFFW3VCAHW	eur	200	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA770P0EWW3NT167D969W	usd	1100	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HM6VA7707PD7HHD8T5YYP393	eur	200	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N	\N	\N	pl_01HM6VA76FPMBHGK8QG4QAHVMT
ma_01HMW3CGXKE072KGV0V7GC5EYY	usd	2200	\N	2024-01-23 21:24:56.875965+00	2024-01-23 21:24:56.875965+00	\N	\N	\N	pl_01HMW3CGXDCK593HX0T3WFT885
ma_01HMW3CGXKFPPBTSFRDXN4D0XD	eur	22200	\N	2024-01-23 21:24:56.875965+00	2024-01-23 21:24:56.875965+00	\N	\N	\N	pl_01HMW3CGXDCK593HX0T3WFT885
ma_01HJQ62GS69N7FNHH70ZS1D4AA	eur	3650	\N	2024-01-23 21:30:25.317707+00	2024-01-23 21:30:25.317707+00	\N	\N	\N	\N
ma_01HJQ62GS6D60CTB3Z57KSQ3XX	usd	4150	\N	2024-01-23 21:30:25.317707+00	2024-01-23 21:30:25.317707+00	\N	\N	\N	\N
ma_01HMW3TYH9D5H3PG2625RPQ04W	eur	1950	\N	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00	\N	\N	\N	\N
ma_01HMW3TYH9CM6AEQHZXEW5TJEZ	usd	2200	\N	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00	\N	\N	\N	\N
ma_01HMW3TYH98CWMSDQBHVECHJSW	eur	1950	\N	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00	\N	\N	\N	\N
ma_01HMW3TYH9PNQBZ7A3X547Z9EG	usd	2200	\N	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00	\N	\N	\N	\N
ma_01HMW3TYH994R9HZMZ519XZ815	eur	1950	\N	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00	\N	\N	\N	\N
ma_01HMW3TYH94Q9WC3BJF4G2AF3E	usd	2200	\N	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00	\N	\N	\N	\N
ma_01HMW3TYH991TMPJSM3RMQD4VA	eur	1950	\N	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00	\N	\N	\N	\N
ma_01HMW3TYH919VH3T9MHYXECDV6	usd	2200	\N	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00	\N	\N	\N	\N
ma_01HMW3TYH98ACY4XGJT7QG655C	eur	1950	\N	2024-01-23 21:32:57.380131+00	2024-01-23 21:32:57.380131+00	\N	\N	\N	\N
ma_01HMW3TYH96RPEPRM9DPQ2CF61	usd	2200	\N	2024-01-23 21:32:57.380131+00	2024-01-23 21:32:57.380131+00	\N	\N	\N	\N
ma_01HMW3TYH8YP5874BK1R991SWP	eur	1950	\N	2024-01-23 21:33:09.805585+00	2024-01-23 21:33:09.805585+00	\N	\N	\N	\N
ma_01HMW3TYH8YHJQA96592XSW9V2	usd	2200	\N	2024-01-23 21:33:09.805585+00	2024-01-23 21:33:09.805585+00	\N	\N	\N	\N
ma_01HMW3TYH88NRG9J2MTGW77NH2	eur	1950	\N	2024-01-23 21:34:14.810656+00	2024-01-23 21:34:14.810656+00	\N	\N	\N	\N
ma_01HMW3TYH8XRYZRP8DAP2PQSBW	usd	2200	\N	2024-01-23 21:34:14.810656+00	2024-01-23 21:34:14.810656+00	\N	\N	\N	\N
ma_01HMW3TYH8XHCM2WBGF182C2QT	eur	1950	\N	2024-01-23 21:34:35.578405+00	2024-01-23 21:34:35.578405+00	\N	\N	\N	\N
ma_01HMW3TYH8TDGTHMZHEXKASGBE	usd	2200	\N	2024-01-23 21:34:35.578405+00	2024-01-23 21:34:35.578405+00	\N	\N	\N	\N
\.


--
-- Data for Name: note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.note (id, value, resource_type, resource_id, author_id, created_at, updated_at, deleted_at, metadata) FROM stdin;
note_01HKEGSGZJFFMC02MEVTHC0SP9	Todo bien	order	order_01HKEGFFG7P3NFDAE7WV6DTQAH	usr_01HJQ657D3JKGCCVVCE4ZG170M	2024-01-06 04:34:10.545183+00	2024-01-06 04:34:10.545183+00	\N	{}
\.


--
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification (id, event_name, resource_type, resource_id, customer_id, "to", data, parent_id, provider_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: notification_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification_provider (id, is_installed) FROM stdin;
\.


--
-- Data for Name: oauth; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oauth (id, display_name, application_name, install_url, uninstall_url, data) FROM stdin;
\.


--
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."order" (id, status, fulfillment_status, payment_status, display_id, cart_id, customer_id, email, billing_address_id, shipping_address_id, region_id, currency_code, tax_rate, canceled_at, created_at, updated_at, metadata, idempotency_key, draft_order_id, no_notification, external_id, sales_channel_id) FROM stdin;
order_01HKEGFFG7P3NFDAE7WV6DTQAH	pending	shipped	captured	1	cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5	cus_01HKEGBS7NS9MWK5ZYX4N07VM8	ejemplo1065@gmail.com	addr_01HKEGF1FZR4MJFBJ7GS2P84MD	addr_01HKEEXM20VE433YHRTKT9QQQ2	reg_01HJQ62FKBJHFRR89DWYF1XVAM	usd	\N	\N	2024-01-06 04:28:41.256921+00	2024-01-06 04:31:03.178177+00	{}	\N	\N	\N	\N	sc_01HJQ62F3H1V5R0YME9AZ7PMMG
order_01HMW4C4BFQ0JCSRQZMJZAD0YM	pending	not_fulfilled	awaiting	2	cart_01HMW455PM9KPMQ188CTN3BEPD	cus_01HMW47S2TZFRTFAS9Q37XY7XK	cliente1@gmail.com	addr_01HMW4BT8MCXZX691BPFHZ9KYT	addr_01HMW4BT8N0KS5SZ10XCZZ5ATK	reg_01HJQ62FHQEHVFQQK69CA8PK41	eur	\N	\N	2024-01-23 21:42:12.527487+00	2024-01-23 21:42:12.527487+00	{}	\N	\N	\N	\N	sc_01HJQ62F3H1V5R0YME9AZ7PMMG
order_01HNFMR16MP15H71KPM48VMAX9	pending	not_fulfilled	awaiting	3	cart_01HM6THN376FNFK12TTTPYR2KH	cus_01HNFMPR4RMWGS1WEK4E73MV96	aaa@ee.es	addr_01HNFMPR5BMKEJ8YH9JQDJXB1A	addr_01HNFMPR5BC7K9JFZZHF91DB3E	reg_01HJQ62FHQEHVFQQK69CA8PK41	eur	\N	\N	2024-01-31 11:33:53.924934+00	2024-01-31 11:33:53.924934+00	{}	\N	\N	\N	\N	sc_01HJQ62F3H1V5R0YME9AZ7PMMG
order_01HNFVA6PA3X641SN5K2QQNHTM	pending	shipped	captured	4	cart_01HNFMR1GPDJT3T39WAWWYHJRX	cus_01HNFV8Q3BCE5MM80HQJ8AKAZC	yo@yo.es	addr_01HNFV9ZYSDCZXP7NY5SV1K4MY	addr_01HNFV9ZYT651QTZV9TQ7T76Y0	reg_01HJQ62FHQEHVFQQK69CA8PK41	eur	\N	\N	2024-01-31 13:28:40.836463+00	2024-01-31 13:31:24.95259+00	{}	\N	\N	\N	\N	sc_01HJQ62F3H1V5R0YME9AZ7PMMG
\.


--
-- Data for Name: order_discounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_discounts (order_id, discount_id) FROM stdin;
order_01HNFMR16MP15H71KPM48VMAX9	disc_01HM6VJ61272P6R31QVVYQQR83
order_01HNFVA6PA3X641SN5K2QQNHTM	disc_01HM6VJ61272P6R31QVVYQQR83
\.


--
-- Data for Name: order_edit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_edit (id, created_at, updated_at, order_id, internal_note, created_by, requested_by, requested_at, confirmed_by, confirmed_at, declined_by, declined_reason, declined_at, canceled_by, canceled_at, payment_collection_id) FROM stdin;
oe_01HMW3J3KA3BF1ZS2HJY87AVTH	2024-01-23 21:27:59.845525+00	2024-01-23 21:36:30.516475+00	order_01HKEGFFG7P3NFDAE7WV6DTQAH	sss	usr_01HJQ657D3JKGCCVVCE4ZG170M	usr_01HJQ657D3JKGCCVVCE4ZG170M	2024-01-23 21:29:02.903+00	\N	\N	\N	\N	\N	usr_01HJQ657D3JKGCCVVCE4ZG170M	2024-01-23 21:36:30.518+00	paycol_01HMW3M16ZBNW1YPSK7Q76FSR6
oe_01HMW41SDHGXS3QYVC9Y2AS7C9	2024-01-23 21:36:33.710873+00	2024-01-23 21:37:18.100402+00	order_01HKEGFFG7P3NFDAE7WV6DTQAH	\N	usr_01HJQ657D3JKGCCVVCE4ZG170M	usr_01HJQ657D3JKGCCVVCE4ZG170M	2024-01-23 21:37:18.106+00	\N	\N	\N	\N	\N	\N	\N	paycol_01HMW434SNQ4XZNCNWJB8MK4X5
oe_01HMW4CPB8PB1VZ38KJPCA84AZ	2024-01-23 21:42:31.012774+00	2024-01-23 21:42:59.614504+00	order_01HMW4C4BFQ0JCSRQZMJZAD0YM	\N	usr_01HJQ657D3JKGCCVVCE4ZG170M	usr_01HJQ657D3JKGCCVVCE4ZG170M	2024-01-23 21:42:53.776+00	usr_01HJQ657D3JKGCCVVCE4ZG170M	2024-01-23 21:42:59.632+00	\N	\N	\N	\N	\N	paycol_01HMW4DCKDYQYW38CZ7BVW904T
\.


--
-- Data for Name: order_gift_cards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_gift_cards (order_id, gift_card_id) FROM stdin;
\.


--
-- Data for Name: order_item_change; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_item_change (id, created_at, updated_at, deleted_at, type, order_edit_id, original_line_item_id, line_item_id) FROM stdin;
oic_01HMW3K20DGF40PJP825Q0M1DQ	2024-01-23 21:28:30.860872+00	2024-01-23 21:29:02.895987+00	\N	item_add	oe_01HMW3J3KA3BF1ZS2HJY87AVTH	\N	item_01HMW3K1YKMM8MEB95436XBXJM
oic_01HMW3K20R3C34C9Z0KYHMHJ37	2024-01-23 21:28:30.875435+00	2024-01-23 21:29:02.895987+00	\N	item_add	oe_01HMW3J3KA3BF1ZS2HJY87AVTH	\N	item_01HMW3K1YWA7H2B2CGJ28CMKN1
oic_01HMW3K2130F9RGNN5KTPHEBV7	2024-01-23 21:28:30.869402+00	2024-01-23 21:29:02.895987+00	\N	item_add	oe_01HMW3J3KA3BF1ZS2HJY87AVTH	\N	item_01HMW3K1Z0H0WYY0FJNAABGB2W
oic_01HMW3K215X8CFMNMPE4TE24Q3	2024-01-23 21:28:30.862883+00	2024-01-23 21:29:02.895987+00	\N	item_add	oe_01HMW3J3KA3BF1ZS2HJY87AVTH	\N	item_01HMW3K1YW0AGX3SAD0XSPZJYT
oic_01HMW3KCT89P87TP2H7B9V5JP2	2024-01-23 21:28:41.976778+00	2024-01-23 21:29:02.895987+00	\N	item_add	oe_01HMW3J3KA3BF1ZS2HJY87AVTH	\N	item_01HMW3KCS1BDT4QP80R9PAQBB4
oic_01HMW42D5TSGKRRCXWQXGBMF64	2024-01-23 21:36:53.78627+00	2024-01-23 21:37:18.100402+00	\N	item_add	oe_01HMW41SDHGXS3QYVC9Y2AS7C9	\N	item_01HMW42D3AXMA118E6K08NKBFB
oic_01HMW42D6CCJKPE7GM2EDVR8F3	2024-01-23 21:36:53.783361+00	2024-01-23 21:37:18.100402+00	\N	item_add	oe_01HMW41SDHGXS3QYVC9Y2AS7C9	\N	item_01HMW42D3CXXTFXDXS8FTT983H
oic_01HMW42D6ESFNKSK1PYH6YRQ9A	2024-01-23 21:36:53.795084+00	2024-01-23 21:37:18.100402+00	\N	item_add	oe_01HMW41SDHGXS3QYVC9Y2AS7C9	\N	item_01HMW42D3RNXMEWNVDQ4D64PY2
oic_01HMW42D713TMXYTA651VAMDE8	2024-01-23 21:36:53.803864+00	2024-01-23 21:37:18.100402+00	\N	item_add	oe_01HMW41SDHGXS3QYVC9Y2AS7C9	\N	item_01HMW42D3RRAJP1SQAF9PM4S02
oic_01HMW4D3DP7BDZY5DZE6671BGS	2024-01-23 21:42:44.252611+00	2024-01-23 21:42:53.768717+00	\N	item_add	oe_01HMW4CPB8PB1VZ38KJPCA84AZ	\N	item_01HMW4D3B6HKJX8XC1ZA2GC6AY
oic_01HMW4D3DB4AA8P95PS6BSNVHY	2024-01-23 21:42:44.263391+00	2024-01-23 21:42:53.768717+00	\N	item_add	oe_01HMW4CPB8PB1VZ38KJPCA84AZ	\N	item_01HMW4D3BGM1YTPHDKS1RRJ3P3
oic_01HMW4D3D9PEH3VB2FFWEVANM5	2024-01-23 21:42:44.243458+00	2024-01-23 21:42:53.768717+00	\N	item_add	oe_01HMW4CPB8PB1VZ38KJPCA84AZ	\N	item_01HMW4D3B4DHYN1EHAGMKKAMYQ
oic_01HMW4D3BJ5RJAQD9W55BQSPPD	2024-01-23 21:42:44.242228+00	2024-01-23 21:42:53.768717+00	\N	item_add	oe_01HMW4CPB8PB1VZ38KJPCA84AZ	\N	item_01HMW4D39ZB4REVF4R1R5AZ4XW
\.


--
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment (id, swap_id, cart_id, order_id, amount, currency_code, amount_refunded, provider_id, data, captured_at, canceled_at, created_at, updated_at, metadata, idempotency_key) FROM stdin;
pay_01HKEGFFB2TGHBT39RB6S3J03K	\N	cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5	order_01HKEGFFG7P3NFDAE7WV6DTQAH	21547	usd	0	manual	{"status": "captured"}	2024-01-06 04:29:51.308+00	\N	2024-01-06 04:28:41.091093+00	2024-01-06 04:29:51.299688+00	\N	\N
pay_01HMW4C490GPPAXZ5Y5S0R0BJ0	\N	cart_01HMW455PM9KPMQ188CTN3BEPD	order_01HMW4C4BFQ0JCSRQZMJZAD0YM	10134	eur	0	manual	{"status": "authorized"}	\N	\N	2024-01-23 21:42:12.428853+00	2024-01-23 21:42:12.527487+00	\N	\N
pay_01HNFMR13HNXPFSAAKKA2XVKJB	\N	cart_01HM6THN376FNFK12TTTPYR2KH	order_01HNFMR16MP15H71KPM48VMAX9	8258	eur	0	manual	{"status": "authorized"}	\N	\N	2024-01-31 11:33:53.824485+00	2024-01-31 11:33:53.924934+00	\N	\N
pay_01HNFVA6KM1R51RTH9PW4YGSYA	\N	cart_01HNFMR1GPDJT3T39WAWWYHJRX	order_01HNFVA6PA3X641SN5K2QQNHTM	7602	eur	0	manual	{"status": "captured"}	2024-01-31 13:31:24.961+00	\N	2024-01-31 13:28:40.749588+00	2024-01-31 13:31:24.95259+00	\N	\N
\.


--
-- Data for Name: payment_collection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_collection (id, created_at, updated_at, deleted_at, type, status, description, amount, authorized_amount, region_id, currency_code, metadata, created_by) FROM stdin;
paycol_01HMW3M16ZBNW1YPSK7Q76FSR6	2024-01-23 21:29:02.895987+00	2024-01-23 21:29:02.895987+00	\N	order_edit	not_paid	\N	11198	\N	reg_01HJQ62FKBJHFRR89DWYF1XVAM	usd	\N	usr_01HJQ657D3JKGCCVVCE4ZG170M
paycol_01HMW434SNQ4XZNCNWJB8MK4X5	2024-01-23 21:37:18.100402+00	2024-01-23 21:37:18.100402+00	\N	order_edit	not_paid	\N	91300	\N	reg_01HJQ62FKBJHFRR89DWYF1XVAM	usd	\N	usr_01HJQ657D3JKGCCVVCE4ZG170M
paycol_01HMW4DCKDYQYW38CZ7BVW904T	2024-01-23 21:42:53.768717+00	2024-01-23 21:42:53.768717+00	\N	order_edit	not_paid	\N	44166	\N	reg_01HJQ62FHQEHVFQQK69CA8PK41	eur	\N	usr_01HJQ657D3JKGCCVVCE4ZG170M
\.


--
-- Data for Name: payment_collection_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_collection_payments (payment_collection_id, payment_id) FROM stdin;
\.


--
-- Data for Name: payment_collection_sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_collection_sessions (payment_collection_id, payment_session_id) FROM stdin;
\.


--
-- Data for Name: payment_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_provider (id, is_installed) FROM stdin;
manual	t
\.


--
-- Data for Name: payment_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_session (id, cart_id, provider_id, is_selected, status, data, created_at, updated_at, idempotency_key, payment_authorized_at, amount, is_initiated) FROM stdin;
ps_01HKEGEDWK2TJK7T9XXHSVQS06	cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5	manual	t	authorized	{"status": "authorized"}	2024-01-06 04:28:06.891014+00	2024-01-06 04:28:41.091093+00	\N	2024-01-06 04:28:41.178+00	21547	t
ps_01HMW465QA7CK2QH3BSPGGHYV1	cart_01HMW455PM9KPMQ188CTN3BEPD	manual	t	authorized	{"status": "authorized"}	2024-01-23 21:38:57.360456+00	2024-01-23 21:42:12.428853+00	\N	2024-01-23 21:42:12.506+00	10134	t
ps_01HNDCBRN5JAWR89VQ60HF51EK	cart_01HM6THN376FNFK12TTTPYR2KH	manual	t	authorized	{"status": "authorized"}	2024-01-30 14:28:54.533614+00	2024-01-31 11:33:53.824485+00	\N	2024-01-31 11:33:53.898+00	8258	t
ps_01HNFMTMMYFTKRP7X8D74PG9ZR	cart_01HNFMR1GPDJT3T39WAWWYHJRX	manual	t	authorized	{"status": "authorized"}	2024-01-31 11:35:19.405671+00	2024-01-31 13:28:40.749588+00	\N	2024-01-31 13:28:40.813+00	7602	t
ps_01HNN2G6V77B5QA4NCW3FRSNW3	cart_01HNFVA6ZREPT6BJ0X0N1DE5PK	manual	t	pending	{"status": "pending"}	2024-02-02 14:10:29.826638+00	2024-02-02 14:10:29.826638+00	\N	\N	1000	t
\.


--
-- Data for Name: price_list; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.price_list (id, name, description, type, status, starts_at, ends_at, created_at, updated_at, deleted_at) FROM stdin;
pl_01HM6VA76FPMBHGK8QG4QAHVMT	tarifa economica	es la mas economica de todas	sale	active	2024-01-13 23:00:00+00	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00	\N
pl_01HMW3CGXDCK593HX0T3WFT885	OFERTA 2	es oferta pasajera	sale	active	2024-01-21 23:00:00+00	2024-01-30 23:00:00+00	2024-01-23 21:24:56.875965+00	2024-01-23 21:24:56.875965+00	\N
\.


--
-- Data for Name: price_list_customer_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.price_list_customer_groups (price_list_id, customer_group_id) FROM stdin;
pl_01HM6VA76FPMBHGK8QG4QAHVMT	cgrp_01HM6VAZZ100Y6JG82Y1WQK8GB
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product (id, title, subtitle, description, handle, is_giftcard, thumbnail, weight, length, height, width, hs_code, origin_country, mid_code, material, created_at, updated_at, deleted_at, metadata, collection_id, type_id, discountable, status, external_id) FROM stdin;
prod_01HJQ62FWPA7FSQZ2B176YBX1D	Medusa T-Shirt	\N	Reimagine the feeling of a classic T-shirt. With our cotton T-shirts, everyday essentials no longer have to be ordinary.	t-shirt	f	https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png	400	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N	t	published	\N
prod_01HJQ62G9KVHQMFK2HY40X4M2P	Medusa Sweatshirt	\N	Reimagine the feeling of a classic sweatshirt. With our cotton sweatshirt, everyday essentials no longer have to be ordinary.	sweatshirt	f	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png	400	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N	t	published	\N
prod_01HJQ62GEQ1EPNN20XP5FFHZ2H	Medusa Sweatpants	\N	Reimagine the feeling of classic sweatpants. With our cotton sweatpants, everyday essentials no longer have to be ordinary.	sweatpants	f	https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatpants-gray-front.png	400	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N	t	published	\N
prod_01HJQ62GKNJ228Q3MD3KB6M7W7	Medusa Shorts	\N	Reimagine the feeling of classic shorts. With our cotton shorts, everyday essentials no longer have to be ordinary.	shorts	f	https://medusa-public-images.s3.eu-west-1.amazonaws.com/shorts-vintage-front.png	400	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N	t	published	\N
prod_01HJQ62GQGCQ64V8BMRHT1VAT7	Medusa Hoodie	\N	Reimagine the feeling of a classic hoodie. With our cotton hoodie, everyday essentials no longer have to be ordinary.	hoodie	f	https://medusa-public-images.s3.eu-west-1.amazonaws.com/black_hoodie_front.png	400	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N	t	published	\N
prod_01HJQ62GX0MCBE9YBZ7YWTJCHR	Medusa Longsleeve	\N	Reimagine the feeling of a classic longsleeve. With our cotton longsleeve, everyday essentials no longer have to be ordinary.	longsleeve	f	https://medusa-public-images.s3.eu-west-1.amazonaws.com/ls-black-front.png	400	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N	t	published	\N
prod_01HJQ62H1V8MN0MKYKZ6M6DWGB	Medusa Coffee Mug	\N	Every programmer's best friend.	coffee-mug	f	https://medusa-public-images.s3.eu-west-1.amazonaws.com/coffee-mug.png	400	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	\N	\N	t	published	\N
prod_01HJQ67WS7GFA5QB6ETXN58GVG	Winter Jacket	\N	\N	winter-jacket	f	https://ecommerce.autoges.eu/uploads/1703732834837-5ff616ceb6e7dda51fbe53ba6dbd43c4.jpg	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:07:15.09277+00	2023-12-30 11:37:58.209246+00	2023-12-30 11:37:58.209246+00	\N	\N	\N	t	published	\N
prod_01HJXESBTW5K7RDFDXAGCQJ3SX	Franela	\N	\N	franela	f	https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1703943122359.jpg	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-30 13:32:02.760981+00	2023-12-30 13:33:32.04625+00	2023-12-30 13:33:32.04625+00	\N	\N	\N	t	published	\N
prod_01HJX8DJVKVX5V1JMSM8JN4SCB	Zapatos	\N	\N	zapatos	f	https://minio.autoges.eu/medusa-bucket/Ref.-110125453-2-1703936444984.png	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-30 11:40:45.285085+00	2023-12-30 13:33:35.257923+00	2023-12-30 13:33:35.257923+00	\N	\N	\N	t	published	\N
prod_01HJX89SY2RRAP8MQ4FKNQXTS6	Chaqueta de invierno	\N	\N	chaqueta-de-invierno	f	https://minio.autoges.eu/medusa-bucket/5ff616ceb6e7dda51fbe53ba6dbd43c4-1703936321025.jpg	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-30 11:38:41.456278+00	2023-12-30 13:33:38.163846+00	2023-12-30 13:33:38.163846+00	\N	\N	\N	t	published	\N
prod_01HKAQE4PPZ44S739N397K70M1	Franela	\N	\N	winter-jacket	f	https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704388399479.jpg	400	\N	\N	\N	\N	\N	\N	\N	2024-01-04 17:13:19.796531+00	2024-01-06 04:19:07.383312+00	2024-01-06 04:19:07.383312+00	{}	\N	\N	t	published	\N
prod_01HKEG5EJAJ169G595EB6HHQ7A	Franela Negra con un Logo	\N	\N	franela-negra-con-un-logo	f	https://minio.autoges.eu/medusa-bucket/NKCD2105-010-1704514992377.jpg	\N	\N	\N	\N	\N	\N	\N	\N	2024-01-06 04:23:12.69999+00	2024-01-06 04:23:12.69999+00	\N	\N	\N	\N	t	published	\N
prod_01HMW3TYF02KCWWFMMQ429DK9B	Medusa T-Shirt (22:32:47)	\N	\N	t-shirt-copy-22-32-47	f	https://medusa-public-images.s3.eu-west-1.amazonaws.com/tee-black-front.png	\N	\N	\N	\N	\N	\N	\N	\N	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00	\N	\N	\N	\N	t	draft	\N
\.


--
-- Data for Name: product_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_category (id, name, handle, parent_category_id, mpath, is_active, is_internal, created_at, updated_at, rank, description, metadata) FROM stdin;
pcat_pants	Pants	pants	\N	pcat_pants.	t	f	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	0		\N
pcat_shirts	Shirts	shirts	\N	pcat_shirts.	t	f	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	1		\N
pcat_merch	Merch	merch	\N	pcat_merch.	t	f	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	2		\N
pcat_hidden_carousel	Hidden homepage carousel	hidden-homepage-carousel	\N	pcat_hidden_carousel.	t	f	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	3		\N
pcat_hidden_featured	Hidden homepage featured	hidden-homepage-featured-items	\N	pcat_hidden_featured.	t	f	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	4		\N
\.


--
-- Data for Name: product_category_product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_category_product (product_category_id, product_id) FROM stdin;
pcat_shirts	prod_01HJQ62FWPA7FSQZ2B176YBX1D
pcat_shirts	prod_01HJQ62G9KVHQMFK2HY40X4M2P
pcat_pants	prod_01HJQ62GEQ1EPNN20XP5FFHZ2H
pcat_merch	prod_01HJQ62GKNJ228Q3MD3KB6M7W7
pcat_merch	prod_01HJQ62GQGCQ64V8BMRHT1VAT7
pcat_hidden_featured	prod_01HJQ62GQGCQ64V8BMRHT1VAT7
pcat_shirts	prod_01HJQ62GX0MCBE9YBZ7YWTJCHR
pcat_hidden_featured	prod_01HJQ62GX0MCBE9YBZ7YWTJCHR
pcat_merch	prod_01HJQ62H1V8MN0MKYKZ6M6DWGB
pcat_hidden_featured	prod_01HJQ62H1V8MN0MKYKZ6M6DWGB
\.


--
-- Data for Name: product_collection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_collection (id, title, handle, created_at, updated_at, deleted_at, metadata) FROM stdin;
\.


--
-- Data for Name: product_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_images (product_id, image_id) FROM stdin;
prod_01HJQ62FWPA7FSQZ2B176YBX1D	img_01HJQ62FWDHM4N3HHDAD81X2AQ
prod_01HJQ62FWPA7FSQZ2B176YBX1D	img_01HJQ62FWD8DZVZ0HKRAMPV505
prod_01HJQ62FWPA7FSQZ2B176YBX1D	img_01HJQ62FWD764279BW6TR1SKP4
prod_01HJQ62FWPA7FSQZ2B176YBX1D	img_01HJQ62FWDYDCVG4FH9P60T93M
prod_01HJQ62G9KVHQMFK2HY40X4M2P	img_01HJQ62G96470R7GCACFEBCNWJ
prod_01HJQ62G9KVHQMFK2HY40X4M2P	img_01HJQ62G96W2CHQ4GVEF7KWDC0
prod_01HJQ62GEQ1EPNN20XP5FFHZ2H	img_01HJQ62GEHJQ9NGD3Q3E15JVXE
prod_01HJQ62GEQ1EPNN20XP5FFHZ2H	img_01HJQ62GEHCH2JZV0KPSCBBEHY
prod_01HJQ62GKNJ228Q3MD3KB6M7W7	img_01HJQ62GKFHMCC4X826YQFGE4W
prod_01HJQ62GKNJ228Q3MD3KB6M7W7	img_01HJQ62GKFEBGF9Q5WCGEXE399
prod_01HJQ62GQGCQ64V8BMRHT1VAT7	img_01HJQ62GQ6ESPYMJ2CCXY3JN0E
prod_01HJQ62GQGCQ64V8BMRHT1VAT7	img_01HJQ62GQ6BYZF5Q49XF38DV84
prod_01HJQ62GX0MCBE9YBZ7YWTJCHR	img_01HJQ62GWTT5DSTFRMVKKBS98H
prod_01HJQ62GX0MCBE9YBZ7YWTJCHR	img_01HJQ62GWT3H97EEDMJNRV307M
prod_01HJQ62H1V8MN0MKYKZ6M6DWGB	img_01HJQ62H1H7D5FQBS8GRZ6P2BF
prod_01HJQ67WS7GFA5QB6ETXN58GVG	img_01HJQ67WRZA7944WQ7SP842JD2
prod_01HJX89SY2RRAP8MQ4FKNQXTS6	img_01HJX89SXVPMR6JSKYTQQRYTJG
prod_01HJX8DJVKVX5V1JMSM8JN4SCB	img_01HJX8DJVCQNK3NCP21F3X63X4
prod_01HJXESBTW5K7RDFDXAGCQJ3SX	img_01HJXESBTM2A1PCZ8TW9HZJ0MJ
prod_01HKAQE4PPZ44S739N397K70M1	img_01HKAQE4P0A5SGHQ3JVG1R0TGM
prod_01HKEG5EJAJ169G595EB6HHQ7A	img_01HKEG5EJ22T81B35Y9CP8YTTY
prod_01HKEG5EJAJ169G595EB6HHQ7A	img_01HM6VN902X7C8S188JGM9MC1S
prod_01HKEG5EJAJ169G595EB6HHQ7A	img_01HM6VN9022F9EHR0M2ACGZCWS
prod_01HKEG5EJAJ169G595EB6HHQ7A	img_01HM6VN9023GSJFFYX75MZBY3Q
prod_01HMW3TYF02KCWWFMMQ429DK9B	img_01HJQ62FWDHM4N3HHDAD81X2AQ
prod_01HMW3TYF02KCWWFMMQ429DK9B	img_01HJQ62FWD8DZVZ0HKRAMPV505
prod_01HMW3TYF02KCWWFMMQ429DK9B	img_01HJQ62FWD764279BW6TR1SKP4
prod_01HMW3TYF02KCWWFMMQ429DK9B	img_01HJQ62FWDYDCVG4FH9P60T93M
\.


--
-- Data for Name: product_option; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_option (id, title, created_at, updated_at, deleted_at, metadata, product_id) FROM stdin;
opt_01HJQ62FXK907BCM6TTHYFWB0J	Size	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	prod_01HJQ62FWPA7FSQZ2B176YBX1D
opt_01HJQ62FXMRHRYYAF4JZ8BEXBW	Color	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	prod_01HJQ62FWPA7FSQZ2B176YBX1D
opt_01HJQ62G9W5XJS2W46DP3V0FVE	Size	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	prod_01HJQ62G9KVHQMFK2HY40X4M2P
opt_01HJQ62GEXVATKBK0K8P7D5G7Z	Size	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	prod_01HJQ62GEQ1EPNN20XP5FFHZ2H
opt_01HJQ62GKVJ2KKEVBY28AXEX7M	Size	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	prod_01HJQ62GKNJ228Q3MD3KB6M7W7
opt_01HJQ62GQVX09RD0EB0ZWS8RT0	Size	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	prod_01HJQ62GQGCQ64V8BMRHT1VAT7
opt_01HJQ62GX53T06XDNYBFRQBBV0	Size	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	prod_01HJQ62GX0MCBE9YBZ7YWTJCHR
opt_01HJQ62H2AQSW1JBP8362ZC67W	Size	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	prod_01HJQ62H1V8MN0MKYKZ6M6DWGB
opt_01HKEFBCBWBXCFBQD8ATJVVNW9	Size	2024-01-06 04:08:58.481008+00	2024-01-06 04:08:58.481008+00	\N	\N	prod_01HKAQE4PPZ44S739N397K70M1
opt_01HKEG5EJNRK0Q8DVK3DXTM7S7	Color	2024-01-06 04:23:12.69999+00	2024-01-06 04:23:12.69999+00	\N	\N	prod_01HKEG5EJAJ169G595EB6HHQ7A
opt_01HMW3TYFB42BPRFZ5QD21RXZT	Size	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00	\N	\N	prod_01HMW3TYF02KCWWFMMQ429DK9B
opt_01HMW3TYFC2GBK61KPYJVHXG6R	Color	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00	\N	\N	prod_01HMW3TYF02KCWWFMMQ429DK9B
\.


--
-- Data for Name: product_option_value; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_option_value (id, value, option_id, variant_id, created_at, updated_at, deleted_at, metadata) FROM stdin;
optval_01HJQ62FYVFBE53CRQYXBWG71G	S	opt_01HJQ62FXK907BCM6TTHYFWB0J	variant_01HJQ62FYVHHKAB8E3M0XBKHKM	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62FYVB1Q14XVV7S8XQ3AJ	Black	opt_01HJQ62FXMRHRYYAF4JZ8BEXBW	variant_01HJQ62FYVHHKAB8E3M0XBKHKM	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62G1893XAM7X66WCDHANJ	S	opt_01HJQ62FXK907BCM6TTHYFWB0J	variant_01HJQ62G18RW9J8R989JWZ4MPY	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62G18N5VM6FYPJFWYDQTH	White	opt_01HJQ62FXMRHRYYAF4JZ8BEXBW	variant_01HJQ62G18RW9J8R989JWZ4MPY	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62G23N38WT1BYAP5JBH33	M	opt_01HJQ62FXK907BCM6TTHYFWB0J	variant_01HJQ62G223SV9T8H0JA7NBFYD	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62G23K9K7SZ439VAD2KP6	Black	opt_01HJQ62FXMRHRYYAF4JZ8BEXBW	variant_01HJQ62G223SV9T8H0JA7NBFYD	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62G31ZZKBPYTTF9GW2W64	M	opt_01HJQ62FXK907BCM6TTHYFWB0J	variant_01HJQ62G31A6XR3R0QAA805S8T	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62G31W364BV58D5D0VRMB	White	opt_01HJQ62FXMRHRYYAF4JZ8BEXBW	variant_01HJQ62G31A6XR3R0QAA805S8T	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62G40RS89VSZHWBCT10XX	L	opt_01HJQ62FXK907BCM6TTHYFWB0J	variant_01HJQ62G40EW5JY2E7FSFN7B2C	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62G46V3Z72KC687D31X8D	Black	opt_01HJQ62FXMRHRYYAF4JZ8BEXBW	variant_01HJQ62G40EW5JY2E7FSFN7B2C	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62G5CZC95YRTPNGRT5XD9	L	opt_01HJQ62FXK907BCM6TTHYFWB0J	variant_01HJQ62G5CF8NT71MZ8KCZFSVT	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62G5CRFJ14302SXN606A6	White	opt_01HJQ62FXMRHRYYAF4JZ8BEXBW	variant_01HJQ62G5CF8NT71MZ8KCZFSVT	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62G6EGMMHYN5N15FVYTKN	XL	opt_01HJQ62FXK907BCM6TTHYFWB0J	variant_01HJQ62G6EB7PVD76BN65TBF3T	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62G6EBB4NP4EZM1MXX5QW	Black	opt_01HJQ62FXMRHRYYAF4JZ8BEXBW	variant_01HJQ62G6EB7PVD76BN65TBF3T	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62G7MKNR7YQ0XKFKCSCK8	XL	opt_01HJQ62FXK907BCM6TTHYFWB0J	variant_01HJQ62G7ME141NMQ4XNGQ0RTD	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62G7NFQZF8MT9V8NPZ3XT	White	opt_01HJQ62FXMRHRYYAF4JZ8BEXBW	variant_01HJQ62G7ME141NMQ4XNGQ0RTD	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62GABFDKQF3E6QAHYZ69X	S	opt_01HJQ62G9W5XJS2W46DP3V0FVE	variant_01HJQ62GABST7KDDNMZ0F8Y7FH	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62GBVJ74SYB0N8SB5CGPQ	M	opt_01HJQ62G9W5XJS2W46DP3V0FVE	variant_01HJQ62GBVW906EVEA3QBD9FZ1	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62GD0KCFV5NC9V41H155W	L	opt_01HJQ62G9W5XJS2W46DP3V0FVE	variant_01HJQ62GD0BVJBQ65MED3SCD9K	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62GDZETAKNYA3R2V50VDF	XL	opt_01HJQ62G9W5XJS2W46DP3V0FVE	variant_01HJQ62GDZPSJKF81WN3J068DR	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62GFASEQH8ZYMKBECAP0R	S	opt_01HJQ62GEXVATKBK0K8P7D5G7Z	variant_01HJQ62GFAAW1E6RKVKGJC2D8R	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62GGFSPNR0DH7XMYD0ZVY	M	opt_01HJQ62GEXVATKBK0K8P7D5G7Z	variant_01HJQ62GGFHCX6NG3JH63SJRR5	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62GH9Y0ED1H7EAA1YXNZQ	L	opt_01HJQ62GEXVATKBK0K8P7D5G7Z	variant_01HJQ62GH9600Z6HE8Y7HWBX52	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62GJEPGG6EJ3GYZCMTQ0K	XL	opt_01HJQ62GEXVATKBK0K8P7D5G7Z	variant_01HJQ62GJEGTFH5SZ3WS0WKDTV	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62GM9FXECPSZP02P7NWYY	S	opt_01HJQ62GKVJ2KKEVBY28AXEX7M	variant_01HJQ62GM9JVV6KCZ4ZBMS1WFF	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62GMXH7EGC5SAVTVK3S4K	M	opt_01HJQ62GKVJ2KKEVBY28AXEX7M	variant_01HJQ62GMXTVX45SAEZ97RV61X	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62GNV6NA0DXQ477W7AQRE	L	opt_01HJQ62GKVJ2KKEVBY28AXEX7M	variant_01HJQ62GNVS0R4DQBYT1MSMETE	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62GPEXAFNF4S14E5QZWH6	XL	opt_01HJQ62GKVJ2KKEVBY28AXEX7M	variant_01HJQ62GPEWTW9EMWGZY8E3FAS	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62GSHFGM76GD7W9VVN1VN	M	opt_01HJQ62GQVX09RD0EB0ZWS8RT0	variant_01HJQ62GSGSKX7ZPXBKBMJRP28	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62GT3KQ79GY4F6S13QNCY	L	opt_01HJQ62GQVX09RD0EB0ZWS8RT0	variant_01HJQ62GT3ZMC2B76FGKWCW92E	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62GVA77PRQ6QJQ206ZKJB	XL	opt_01HJQ62GQVX09RD0EB0ZWS8RT0	variant_01HJQ62GVAM90DS9WKQRA7WGKE	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62GXV6JGPMJ07C120QMCP	S	opt_01HJQ62GX53T06XDNYBFRQBBV0	variant_01HJQ62GXV39DPAJ4D6TFHFS8K	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62GYR5W8QEG512K8TRP2F	M	opt_01HJQ62GX53T06XDNYBFRQBBV0	variant_01HJQ62GYR0V15QPKGX8D1W3CJ	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62GZN470A1XSCBTMJ0DZ5	L	opt_01HJQ62GX53T06XDNYBFRQBBV0	variant_01HJQ62GZNQVT8BXGKD0GBFAY9	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62H0T94873TAQPVC1P41V	XL	opt_01HJQ62GX53T06XDNYBFRQBBV0	variant_01HJQ62H0TGNGGARPQWTBXTHAE	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HJQ62H2NG68KSPZTSHWF6ZMN	One Size	opt_01HJQ62H2AQSW1JBP8362ZC67W	variant_01HJQ62H2NRGRY3ZAQCBWK5QTX	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N
optval_01HMW3TYG4AFZ2VV915SH2YBR1	jk	opt_01HMW3TYFB42BPRFZ5QD21RXZT	variant_01HMW3TYG4YW7FTDTCPF06NN3C	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:57.380131+00	\N	\N
optval_01HKEFBCC1X922KA64ZJKRA05G	One Size	opt_01HKEFBCBWBXCFBQD8ATJVVNW9	variant_01HKEEV9R01T9BTQ4G45NWRS8F	2024-01-06 04:08:58.481008+00	2024-01-06 04:19:07.383312+00	2024-01-06 04:19:07.383312+00	\N
optval_01HKEG5EKFEGW877TE2FAB7KE0	Negro	opt_01HKEG5EJNRK0Q8DVK3DXTM7S7	variant_01HKEG5EKEDSNP6ATNTTB2378F	2024-01-06 04:23:12.69999+00	2024-01-06 04:23:12.69999+00	\N	\N
optval_01HKEG5EKGWYJFDPXTV6KJBZ1T	Azul	opt_01HKEG5EJNRK0Q8DVK3DXTM7S7	variant_01HKEG5EKGETQHJ5MJ58A2D61Y	2024-01-06 04:23:12.69999+00	2024-01-06 04:23:12.69999+00	\N	\N
optval_01HJQ62GRD1TXHH82B4YAXM16R	hh	opt_01HJQ62GQVX09RD0EB0ZWS8RT0	variant_01HJQ62GRDR8CXCHCWNFMNG39W	2023-12-28 03:04:17.48254+00	2024-01-23 21:30:25.317707+00	\N	\N
optval_01HMW3TYG2FH55B96TA309YPG6	S	opt_01HMW3TYFB42BPRFZ5QD21RXZT	variant_01HMW3TYG2Z1NGN0WQQK0NT39S	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00	\N	\N
optval_01HMW3TYG337CP4VDSVB4BAMP5	S	opt_01HMW3TYFB42BPRFZ5QD21RXZT	variant_01HMW3TYG3Y7BTF66HKEX29YX7	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00	\N	\N
optval_01HMW3TYG35HGT7260H7CCTF2X	White	opt_01HMW3TYFC2GBK61KPYJVHXG6R	variant_01HMW3TYG3Y7BTF66HKEX29YX7	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00	\N	\N
optval_01HMW3TYG4XKWVAX5BS5PPBFGK	White	opt_01HMW3TYFC2GBK61KPYJVHXG6R	variant_01HMW3TYG4YW7FTDTCPF06NN3C	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00	\N	\N
optval_01HMW3TYG5AC62F43HGT5DEE9A	L	opt_01HMW3TYFB42BPRFZ5QD21RXZT	variant_01HMW3TYG578Y20PW6QTWKE8BS	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00	\N	\N
optval_01HMW3TYG5M09N7RFR9F3RXTKG	Black	opt_01HMW3TYFC2GBK61KPYJVHXG6R	variant_01HMW3TYG578Y20PW6QTWKE8BS	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00	\N	\N
optval_01HMW3TYG6RTMKJFMSA7K8MGY4	L	opt_01HMW3TYFB42BPRFZ5QD21RXZT	variant_01HMW3TYG67P3DSSYD3GNV3AQG	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00	\N	\N
optval_01HMW3TYG42AKMAXPC9RA24NPT	qwqw	opt_01HMW3TYFB42BPRFZ5QD21RXZT	variant_01HMW3TYG4TRDZRAT6YNT305J2	2024-01-23 21:32:49.494933+00	2024-01-23 21:33:09.805585+00	\N	\N
optval_01HMW3TYG48V4B260KPP5J89SQ	ass	opt_01HMW3TYFC2GBK61KPYJVHXG6R	variant_01HMW3TYG4TRDZRAT6YNT305J2	2024-01-23 21:32:49.494933+00	2024-01-23 21:33:09.805585+00	\N	\N
optval_01HMW3TYG2Q44QC1GV4VN3X4NE	verddss	opt_01HMW3TYFC2GBK61KPYJVHXG6R	variant_01HMW3TYG2Z1NGN0WQQK0NT39S	2024-01-23 21:32:49.494933+00	2024-01-23 21:34:35.578405+00	\N	\N
optval_01HMW3TYG661F4HWTEKP5WCHRN	White	opt_01HMW3TYFC2GBK61KPYJVHXG6R	variant_01HMW3TYG67P3DSSYD3GNV3AQG	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00	\N	\N
optval_01HMW3TYG77XDN9TWMAX7ZFQBS	XL	opt_01HMW3TYFB42BPRFZ5QD21RXZT	variant_01HMW3TYG6SHPFM60XJ3MVKAXK	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00	\N	\N
optval_01HMW3TYG7TM319A15WBCN33XF	Black	opt_01HMW3TYFC2GBK61KPYJVHXG6R	variant_01HMW3TYG6SHPFM60XJ3MVKAXK	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00	\N	\N
optval_01HMW3TYG7X4ZNTWVDE5KWC8RD	XL	opt_01HMW3TYFB42BPRFZ5QD21RXZT	variant_01HMW3TYG756MHZ5PEFAJZBX6D	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00	\N	\N
optval_01HMW3TYG7426Z5BE8TTJ23FH9	White	opt_01HMW3TYFC2GBK61KPYJVHXG6R	variant_01HMW3TYG756MHZ5PEFAJZBX6D	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00	\N	\N
\.


--
-- Data for Name: product_sales_channel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_sales_channel (product_id, sales_channel_id) FROM stdin;
prod_01HJQ62FWPA7FSQZ2B176YBX1D	sc_01HJQ62F3H1V5R0YME9AZ7PMMG
prod_01HJQ62G9KVHQMFK2HY40X4M2P	sc_01HJQ62F3H1V5R0YME9AZ7PMMG
prod_01HJQ62GEQ1EPNN20XP5FFHZ2H	sc_01HJQ62F3H1V5R0YME9AZ7PMMG
prod_01HJQ62GKNJ228Q3MD3KB6M7W7	sc_01HJQ62F3H1V5R0YME9AZ7PMMG
prod_01HJQ62GQGCQ64V8BMRHT1VAT7	sc_01HJQ62F3H1V5R0YME9AZ7PMMG
prod_01HJQ62GX0MCBE9YBZ7YWTJCHR	sc_01HJQ62F3H1V5R0YME9AZ7PMMG
prod_01HJQ62H1V8MN0MKYKZ6M6DWGB	sc_01HJQ62F3H1V5R0YME9AZ7PMMG
prod_01HJQ67WS7GFA5QB6ETXN58GVG	sc_01HJQ62F3H1V5R0YME9AZ7PMMG
prod_01HJX89SY2RRAP8MQ4FKNQXTS6	sc_01HJQ62F3H1V5R0YME9AZ7PMMG
prod_01HJX8DJVKVX5V1JMSM8JN4SCB	sc_01HJQ62F3H1V5R0YME9AZ7PMMG
prod_01HJXESBTW5K7RDFDXAGCQJ3SX	sc_01HJQ62F3H1V5R0YME9AZ7PMMG
prod_01HKAQE4PPZ44S739N397K70M1	sc_01HJQ62F3H1V5R0YME9AZ7PMMG
prod_01HKEG5EJAJ169G595EB6HHQ7A	sc_01HJQ62F3H1V5R0YME9AZ7PMMG
prod_01HMW3TYF02KCWWFMMQ429DK9B	sc_01HJQ62F3H1V5R0YME9AZ7PMMG
prod_01HKEG5EJAJ169G595EB6HHQ7A	sc_01HNFMD6M8ZJZ6TX4S1MYMR3AW
prod_01HJQ62GKNJ228Q3MD3KB6M7W7	sc_01HNFMD6M8ZJZ6TX4S1MYMR3AW
prod_01HJQ62G9KVHQMFK2HY40X4M2P	sc_01HNFMD6M8ZJZ6TX4S1MYMR3AW
\.


--
-- Data for Name: product_shipping_profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_shipping_profile (profile_id, product_id) FROM stdin;
sp_01HJQ62F0MRD4WRSYX1KYME2JW	prod_01HJQ62FWPA7FSQZ2B176YBX1D
sp_01HJQ62F0MRD4WRSYX1KYME2JW	prod_01HJQ62G9KVHQMFK2HY40X4M2P
sp_01HJQ62F0MRD4WRSYX1KYME2JW	prod_01HJQ62GEQ1EPNN20XP5FFHZ2H
sp_01HJQ62F0MRD4WRSYX1KYME2JW	prod_01HJQ62GKNJ228Q3MD3KB6M7W7
sp_01HJQ62F0MRD4WRSYX1KYME2JW	prod_01HJQ62GQGCQ64V8BMRHT1VAT7
sp_01HJQ62F0MRD4WRSYX1KYME2JW	prod_01HJQ62GX0MCBE9YBZ7YWTJCHR
sp_01HJQ62F0MRD4WRSYX1KYME2JW	prod_01HJQ62H1V8MN0MKYKZ6M6DWGB
sp_01HJQ62F0MRD4WRSYX1KYME2JW	prod_01HJQ67WS7GFA5QB6ETXN58GVG
sp_01HJQ62F0MRD4WRSYX1KYME2JW	prod_01HJX89SY2RRAP8MQ4FKNQXTS6
sp_01HJQ62F0MRD4WRSYX1KYME2JW	prod_01HJX8DJVKVX5V1JMSM8JN4SCB
sp_01HJQ62F0MRD4WRSYX1KYME2JW	prod_01HJXESBTW5K7RDFDXAGCQJ3SX
sp_01HJQ62F0MRD4WRSYX1KYME2JW	prod_01HKAQE4PPZ44S739N397K70M1
sp_01HJQ62F0MRD4WRSYX1KYME2JW	prod_01HKEG5EJAJ169G595EB6HHQ7A
sp_01HJQ62F0MRD4WRSYX1KYME2JW	prod_01HMW3TYF02KCWWFMMQ429DK9B
\.


--
-- Data for Name: product_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_tag (id, value, created_at, updated_at, deleted_at, metadata) FROM stdin;
\.


--
-- Data for Name: product_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_tags (product_id, product_tag_id) FROM stdin;
\.


--
-- Data for Name: product_tax_rate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_tax_rate (product_id, rate_id, created_at, updated_at, metadata) FROM stdin;
prod_01HKEG5EJAJ169G595EB6HHQ7A	txr_01HM6VF955JXB29T12X4ZEDBKG	2024-01-15 15:22:35.55569+00	2024-01-15 15:22:35.55569+00	\N
prod_01HJQ62GQGCQ64V8BMRHT1VAT7	txr_01HM6VF955JXB29T12X4ZEDBKG	2024-01-15 15:22:35.55569+00	2024-01-15 15:22:35.55569+00	\N
prod_01HJQ62GX0MCBE9YBZ7YWTJCHR	txr_01HM6VF955JXB29T12X4ZEDBKG	2024-01-15 15:22:35.55569+00	2024-01-15 15:22:35.55569+00	\N
prod_01HJQ62GKNJ228Q3MD3KB6M7W7	txr_01HM6VF955JXB29T12X4ZEDBKG	2024-01-15 15:22:35.55569+00	2024-01-15 15:22:35.55569+00	\N
prod_01HJQ62FWPA7FSQZ2B176YBX1D	txr_01HM6VF955JXB29T12X4ZEDBKG	2024-01-15 15:22:35.55569+00	2024-01-15 15:22:35.55569+00	\N
\.


--
-- Data for Name: product_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_type (id, value, created_at, updated_at, deleted_at, metadata) FROM stdin;
\.


--
-- Data for Name: product_type_tax_rate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_type_tax_rate (product_type_id, rate_id, created_at, updated_at, metadata) FROM stdin;
\.


--
-- Data for Name: product_variant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_variant (id, title, product_id, sku, barcode, ean, upc, inventory_quantity, allow_backorder, manage_inventory, hs_code, origin_country, mid_code, material, weight, length, height, width, created_at, updated_at, deleted_at, metadata, variant_rank) FROM stdin;
variant_01HJQ62FYVHHKAB8E3M0XBKHKM	S / Black	prod_01HJQ62FWPA7FSQZ2B176YBX1D	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	0
variant_01HJQ62G223SV9T8H0JA7NBFYD	M / Black	prod_01HJQ62FWPA7FSQZ2B176YBX1D	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	2
variant_01HJQ62G31A6XR3R0QAA805S8T	M / White	prod_01HJQ62FWPA7FSQZ2B176YBX1D	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	3
variant_01HJQ62G40EW5JY2E7FSFN7B2C	L / Black	prod_01HJQ62FWPA7FSQZ2B176YBX1D	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	4
variant_01HJQ62G5CF8NT71MZ8KCZFSVT	L / White	prod_01HJQ62FWPA7FSQZ2B176YBX1D	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	5
variant_01HJQ62G6EB7PVD76BN65TBF3T	XL / Black	prod_01HJQ62FWPA7FSQZ2B176YBX1D	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	6
variant_01HJQ62G7ME141NMQ4XNGQ0RTD	XL / White	prod_01HJQ62FWPA7FSQZ2B176YBX1D	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	7
variant_01HJQ62GABST7KDDNMZ0F8Y7FH	S	prod_01HJQ62G9KVHQMFK2HY40X4M2P	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	0
variant_01HJQ62GBVW906EVEA3QBD9FZ1	M	prod_01HJQ62G9KVHQMFK2HY40X4M2P	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	1
variant_01HJQ62GD0BVJBQ65MED3SCD9K	L	prod_01HJQ62G9KVHQMFK2HY40X4M2P	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	2
variant_01HJQ62GDZPSJKF81WN3J068DR	XL	prod_01HJQ62G9KVHQMFK2HY40X4M2P	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	3
variant_01HJQ62GFAAW1E6RKVKGJC2D8R	S	prod_01HJQ62GEQ1EPNN20XP5FFHZ2H	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	0
variant_01HJQ62GH9600Z6HE8Y7HWBX52	L	prod_01HJQ62GEQ1EPNN20XP5FFHZ2H	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	2
variant_01HJQ62GJEGTFH5SZ3WS0WKDTV	XL	prod_01HJQ62GEQ1EPNN20XP5FFHZ2H	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	3
variant_01HJQ62GM9JVV6KCZ4ZBMS1WFF	S	prod_01HJQ62GKNJ228Q3MD3KB6M7W7	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	0
variant_01HJQ62GMXTVX45SAEZ97RV61X	M	prod_01HJQ62GKNJ228Q3MD3KB6M7W7	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	1
variant_01HJQ62GNVS0R4DQBYT1MSMETE	L	prod_01HJQ62GKNJ228Q3MD3KB6M7W7	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	2
variant_01HJQ62GPEWTW9EMWGZY8E3FAS	XL	prod_01HJQ62GKNJ228Q3MD3KB6M7W7	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	3
variant_01HJQ62GVAM90DS9WKQRA7WGKE	XL	prod_01HJQ62GQGCQ64V8BMRHT1VAT7	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	3
variant_01HJQ62GXV39DPAJ4D6TFHFS8K	S	prod_01HJQ62GX0MCBE9YBZ7YWTJCHR	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	0
variant_01HJQ62GYR0V15QPKGX8D1W3CJ	M	prod_01HJQ62GX0MCBE9YBZ7YWTJCHR	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	1
variant_01HJQ62GZNQVT8BXGKD0GBFAY9	L	prod_01HJQ62GX0MCBE9YBZ7YWTJCHR	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	2
variant_01HJQ62H0TGNGGARPQWTBXTHAE	XL	prod_01HJQ62GX0MCBE9YBZ7YWTJCHR	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	3
variant_01HJQ62H2NRGRY3ZAQCBWK5QTX	One Size	prod_01HJQ62H1V8MN0MKYKZ6M6DWGB	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	0
variant_01HMW3TYG4TRDZRAT6YNT305J2	12	prod_01HMW3TYF02KCWWFMMQ429DK9B	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2024-01-23 21:32:49.494933+00	2024-01-23 21:33:09.805585+00	\N	{}	2
variant_01HMW3TYG3Y7BTF66HKEX29YX7	ter	prod_01HMW3TYF02KCWWFMMQ429DK9B	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2024-01-23 21:32:49.494933+00	2024-01-23 21:34:14.810656+00	\N	{}	1
variant_01HKEEV9R01T9BTQ4G45NWRS8F	One Size	prod_01HKAQE4PPZ44S739N397K70M1		\N	\N	\N	100	f	t	\N	\N	\N	80% lana, 20% algodon	\N	\N	\N	\N	2024-01-06 04:00:11.489606+00	2024-01-06 04:19:07.383312+00	2024-01-06 04:19:07.383312+00	{}	0
variant_01HJQ62GGFHCX6NG3JH63SJRR5	M	prod_01HJQ62GEQ1EPNN20XP5FFHZ2H	\N	\N	\N	\N	98	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2024-01-06 04:28:41.256921+00	\N	\N	1
variant_01HJQ62GSGSKX7ZPXBKBMJRP28	M	prod_01HJQ62GQGCQ64V8BMRHT1VAT7	\N	\N	\N	\N	99	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2024-01-06 04:28:41.256921+00	\N	\N	1
variant_01HJQ62GRDR8CXCHCWNFMNG39W	S	prod_01HJQ62GQGCQ64V8BMRHT1VAT7	\N	\N	\N	\N	100	f	t		\N		\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2024-01-23 21:30:25.317707+00	\N	{}	0
variant_01HMW3TYG578Y20PW6QTWKE8BS	L / Black	prod_01HMW3TYF02KCWWFMMQ429DK9B	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00	\N	\N	4
variant_01HMW3TYG67P3DSSYD3GNV3AQG	L / White	prod_01HMW3TYF02KCWWFMMQ429DK9B	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00	\N	\N	5
variant_01HMW3TYG6SHPFM60XJ3MVKAXK	XL / Black	prod_01HMW3TYF02KCWWFMMQ429DK9B	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00	\N	\N	6
variant_01HMW3TYG756MHZ5PEFAJZBX6D	XL / White	prod_01HMW3TYF02KCWWFMMQ429DK9B	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00	\N	\N	7
variant_01HMW3TYG4YW7FTDTCPF06NN3C	M / White	prod_01HMW3TYF02KCWWFMMQ429DK9B	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:57.380131+00	\N	{}	3
variant_01HMW3TYG2Z1NGN0WQQK0NT39S	S / Black	prod_01HMW3TYF02KCWWFMMQ429DK9B	\N	\N	\N	\N	100	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2024-01-23 21:32:49.494933+00	2024-01-23 21:34:35.578405+00	\N	{}	0
variant_01HJQ62G18RW9J8R989JWZ4MPY	S / White	prod_01HJQ62FWPA7FSQZ2B176YBX1D	\N	\N	\N	\N	99	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2024-01-23 21:42:12.527487+00	\N	\N	1
variant_01HKEG5EKGETQHJ5MJ58A2D61Y	S	prod_01HKEG5EJAJ169G595EB6HHQ7A	\N	\N	\N	\N	14	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2024-01-06 04:23:12.69999+00	2024-01-23 21:42:12.527487+00	\N	\N	1
variant_01HJQ62GT3ZMC2B76FGKWCW92E	L	prod_01HJQ62GQGCQ64V8BMRHT1VAT7	\N	\N	\N	\N	99	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2023-12-28 03:04:17.48254+00	2024-01-31 13:28:40.836463+00	\N	\N	2
variant_01HKEG5EKEDSNP6ATNTTB2378F	XL	prod_01HKEG5EJAJ169G595EB6HHQ7A	\N	\N	\N	\N	3	f	t	\N	\N	\N	\N	\N	\N	\N	\N	2024-01-06 04:23:12.69999+00	2024-01-31 13:28:40.836463+00	\N	\N	0
\.


--
-- Data for Name: product_variant_inventory_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_variant_inventory_item (id, created_at, updated_at, inventory_item_id, variant_id, required_quantity, deleted_at) FROM stdin;
\.


--
-- Data for Name: product_variant_money_amount; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_variant_money_amount (id, money_amount_id, variant_id, deleted_at, created_at, updated_at) FROM stdin;
pvma__01HJQ62G0H7XZ1X03PAD8478E2	ma_01HJQ62G0CZ7K01V2KCRZ5MWEX	variant_01HJQ62FYVHHKAB8E3M0XBKHKM	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62G0H78THPDQWYJZNAKV5	ma_01HJQ62G0D3GZK9WD208P95HHD	variant_01HJQ62FYVHHKAB8E3M0XBKHKM	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62G1PAADWJZARP61JKKT9	ma_01HJQ62G1MM5HK6N1134EZP9KK	variant_01HJQ62G18RW9J8R989JWZ4MPY	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62G1Q434MQZKN692VEMV9	ma_01HJQ62G1MDW7RT0EYTG6VGR1T	variant_01HJQ62G18RW9J8R989JWZ4MPY	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62G2EN6N866167ZTH37B5	ma_01HJQ62G2CFJ3TTENZ41W7E6MP	variant_01HJQ62G223SV9T8H0JA7NBFYD	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62G2F8VW4EEXAW6SYWG6V	ma_01HJQ62G2CERSFEJ0M7VHCTXEV	variant_01HJQ62G223SV9T8H0JA7NBFYD	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62G3BVKAFXN4MCGZSBHR4	ma_01HJQ62G398ZXTK59BPCW4DFGJ	variant_01HJQ62G31A6XR3R0QAA805S8T	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62G3B9RA9072P871SR464	ma_01HJQ62G39W3WWS9KAB2C5VB1B	variant_01HJQ62G31A6XR3R0QAA805S8T	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62G4XCW2TVVFPFZ2M58TP	ma_01HJQ62G4SCFNAQPSW01ZMMSE9	variant_01HJQ62G40EW5JY2E7FSFN7B2C	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62G4X8BQMFNSVG36RZK25	ma_01HJQ62G4V0P4Q8HJAYQ05M75R	variant_01HJQ62G40EW5JY2E7FSFN7B2C	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62G61KH3S4BQ2DZAE3W15	ma_01HJQ62G5WXN6ZA7ZW3R6Z9A3Z	variant_01HJQ62G5CF8NT71MZ8KCZFSVT	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62G6160MCVDCXNZJ6WPXJ	ma_01HJQ62G5WKHW0DD77A1J2SEE0	variant_01HJQ62G5CF8NT71MZ8KCZFSVT	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62G6Y12MK25H8ECZY39YG	ma_01HJQ62G6WZBN06C7AXDZRPHGG	variant_01HJQ62G6EB7PVD76BN65TBF3T	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62G6YZHGZJ23F53PCANQZ	ma_01HJQ62G6WCYJJH1KRGY37TG9H	variant_01HJQ62G6EB7PVD76BN65TBF3T	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62G90H21ZZJASVYT7K3ZQ	ma_01HJQ62G8JYQNX6DXE1JBN8HP1	variant_01HJQ62G7ME141NMQ4XNGQ0RTD	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62G90P50EVYBHETT9Z3D3	ma_01HJQ62G8JHNT6JT3TR4PTW573	variant_01HJQ62G7ME141NMQ4XNGQ0RTD	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GBFXCK2WN1W6PTMVJTW	ma_01HJQ62GBCA2ZKPBM5ZGPYNMMX	variant_01HJQ62GABST7KDDNMZ0F8Y7FH	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GBF1WX54HWRV2J9EXMR	ma_01HJQ62GBCNSPZJBJCZ0NASV2P	variant_01HJQ62GABST7KDDNMZ0F8Y7FH	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GCPPEWTWSCBPM9TMS62	ma_01HJQ62GCJ8QJV5959QK59XSWC	variant_01HJQ62GBVW906EVEA3QBD9FZ1	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GCPEG55WVE6A3GB25KJ	ma_01HJQ62GCJ8XS2QSY2VT46RQEW	variant_01HJQ62GBVW906EVEA3QBD9FZ1	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GDM011QB3HYVP7X09MZ	ma_01HJQ62GDJ7JE1RH4FAZB4W0N5	variant_01HJQ62GD0BVJBQ65MED3SCD9K	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GDM8M1GX4VNMCRE33KR	ma_01HJQ62GDJHCFJV5R2HKM40FFB	variant_01HJQ62GD0BVJBQ65MED3SCD9K	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GECE5A1WD2WX6NPMPFM	ma_01HJQ62GE7VBDVW57X57Z66WER	variant_01HJQ62GDZPSJKF81WN3J068DR	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GECCTJQC2HTNV8GDJYY	ma_01HJQ62GE7MMA6RDS9YQQ85MA7	variant_01HJQ62GDZPSJKF81WN3J068DR	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GFWDZ9PRVH56R093YRC	ma_01HJQ62GFQK11FN8R7V5M55RWR	variant_01HJQ62GFAAW1E6RKVKGJC2D8R	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GFW1GBGE93AB7RMJAF2	ma_01HJQ62GFQ6K651RNYNB1Z9YE2	variant_01HJQ62GFAAW1E6RKVKGJC2D8R	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GGSMBNCR7H9JSAGWXPQ	ma_01HJQ62GGQ62GYQZE1RQP2JP6C	variant_01HJQ62GGFHCX6NG3JH63SJRR5	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GGSY6HCB4HDB8YNV4R7	ma_01HJQ62GGQRVHXA12D3QYMWF31	variant_01HJQ62GGFHCX6NG3JH63SJRR5	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GHZZGWVTHC5M0Y0NSTZ	ma_01HJQ62GHX0805XRGFH9YR9V7T	variant_01HJQ62GH9600Z6HE8Y7HWBX52	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GHZNJ5NQ6ZCDJ2D1Y9Y	ma_01HJQ62GHXMCP1CY7EQ7M9JV57	variant_01HJQ62GH9600Z6HE8Y7HWBX52	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GKBTS1KJHTYPC9Z657D	ma_01HJQ62GK9J6ZHNMSAFD8YP25M	variant_01HJQ62GJEGTFH5SZ3WS0WKDTV	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GKBAF61HTNNK1F3MKY8	ma_01HJQ62GK9ZKBZT7HF4J7Y6NYJ	variant_01HJQ62GJEGTFH5SZ3WS0WKDTV	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GMMH8VDYHNBDAXB3G7X	ma_01HJQ62GMJMS7MQX0AEWJNN452	variant_01HJQ62GM9JVV6KCZ4ZBMS1WFF	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GMMJH4ME4EKDCN2QV26	ma_01HJQ62GMJQ7NSFA6EEYX39T7Z	variant_01HJQ62GM9JVV6KCZ4ZBMS1WFF	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GNKAGEE8PWDY0QPXKYC	ma_01HJQ62GNFP1HFD2QRQ60NAWXJ	variant_01HJQ62GMXTVX45SAEZ97RV61X	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GNK2NQGN4MER9T840R5	ma_01HJQ62GNFPFZAJ578CPXXP1XQ	variant_01HJQ62GMXTVX45SAEZ97RV61X	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GP5Q90ZVKFDT127E53G	ma_01HJQ62GP30ET16NS86Z370SBX	variant_01HJQ62GNVS0R4DQBYT1MSMETE	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GP5SQ5M9QBPH51XWQVV	ma_01HJQ62GP3RD8EKNXF32F8CTV4	variant_01HJQ62GNVS0R4DQBYT1MSMETE	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GPW7E5QVF9FG5C5WGPQ	ma_01HJQ62GPTF3TMNP80CGP5FSSN	variant_01HJQ62GPEWTW9EMWGZY8E3FAS	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GPW8K7261NR1EM2FDVE	ma_01HJQ62GPTAY07BDHHFJP74HTP	variant_01HJQ62GPEWTW9EMWGZY8E3FAS	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GSV3NXC3TYPVWAA60FR	ma_01HJQ62GSSD6GAJE11G7KX66MN	variant_01HJQ62GSGSKX7ZPXBKBMJRP28	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GSV3CTM6Z4RRX1VGHQ6	ma_01HJQ62GSS93Z8327TZQN7SY54	variant_01HJQ62GSGSKX7ZPXBKBMJRP28	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GTCRSZH130HVE0VY84M	ma_01HJQ62GTBQ5XB3KJ6YFMWWXAF	variant_01HJQ62GT3ZMC2B76FGKWCW92E	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GTC5VK33SMVD045192F	ma_01HJQ62GTB2SJX2PVR3WMN7A19	variant_01HJQ62GT3ZMC2B76FGKWCW92E	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GWJB1DM1NB2HMC94N15	ma_01HJQ62GWG8B8J9SDYTWETZZ1B	variant_01HJQ62GVAM90DS9WKQRA7WGKE	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GWJBB6JAZW2MFQWDPZT	ma_01HJQ62GWG4ED7EM1YRM718A0X	variant_01HJQ62GVAM90DS9WKQRA7WGKE	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GYAYZGCZ8YFMPJ1QQYJ	ma_01HJQ62GY9ZXR4XRF282FEFJ5X	variant_01HJQ62GXV39DPAJ4D6TFHFS8K	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GYBE2DBHAHDYCZZKR37	ma_01HJQ62GY9JWCZDBGYKFP4TR06	variant_01HJQ62GXV39DPAJ4D6TFHFS8K	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GZ3AZK2J2897HRRPHR8	ma_01HJQ62GYZCZQPD1ZQ32Y7N6B2	variant_01HJQ62GYR0V15QPKGX8D1W3CJ	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62GZ4YD8AM54JPBDVVMEF	ma_01HJQ62GYZDE2TKKRR6B2HY1ZT	variant_01HJQ62GYR0V15QPKGX8D1W3CJ	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62H0A4MMW5AFHWC0XFWGC	ma_01HJQ62H04GRCJ1X8KG0SQ7MGE	variant_01HJQ62GZNQVT8BXGKD0GBFAY9	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62H0AHE6K37Y5ZDQY5EQM	ma_01HJQ62H04CRAA5BNNVW4PFS8F	variant_01HJQ62GZNQVT8BXGKD0GBFAY9	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62H1BATJR3WV7R77TE82Q	ma_01HJQ62H19YF2K6BTKWSQD4150	variant_01HJQ62H0TGNGGARPQWTBXTHAE	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62H1B3ECAEBM9FY3CJPHS	ma_01HJQ62H19EAHD42KQ2KYGA6NA	variant_01HJQ62H0TGNGGARPQWTBXTHAE	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62H30XP053GFVX0NNNT58	ma_01HJQ62H2ZV3XEF74EQRQCXP4J	variant_01HJQ62H2NRGRY3ZAQCBWK5QTX	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HJQ62H30CJCZ6ADW4QBMQW99	ma_01HJQ62H2ZMXV46K2ETMEZFQTH	variant_01HJQ62H2NRGRY3ZAQCBWK5QTX	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00
pvma__01HKEFJA1DC82H4PX1CJ9HKVD7	ma_01HKEEW75TN029JSRC386FMFGV	variant_01HKEEV9R01T9BTQ4G45NWRS8F	\N	2024-01-06 04:12:45.468166+00	2024-01-06 04:12:45.468166+00
pvma__01HKEFJA1DSD7J1VGDSYCVG46P	ma_01HKEEW75TWK2Y20TSGCMP2VHJ	variant_01HKEEV9R01T9BTQ4G45NWRS8F	\N	2024-01-06 04:12:45.468166+00	2024-01-06 04:12:45.468166+00
pvma__01HKEG86Q572HX2872PJ36SFFT	ma_01HKEG86Q1TG1NYX60SMPDZHZB	variant_01HKEG5EKGETQHJ5MJ58A2D61Y	\N	2024-01-06 04:24:42.950332+00	2024-01-06 04:24:42.950332+00
pvma__01HKEG86Q6Q9H2WX4FGBZDK04E	ma_01HKEG86Q1X9B43D50TH1SQDWR	variant_01HKEG5EKGETQHJ5MJ58A2D61Y	\N	2024-01-06 04:24:42.950332+00	2024-01-06 04:24:42.950332+00
pvma__01HKEG86RN3EN5QKF9SFDW4P4B	ma_01HKEG86RGBWWWECD2T233A3M1	variant_01HKEG5EKEDSNP6ATNTTB2378F	\N	2024-01-06 04:24:42.992916+00	2024-01-06 04:24:42.992916+00
pvma__01HKEG86RN0RM7ABF88HYA8D42	ma_01HKEG86RGYTV9RM6V275EKNR8	variant_01HKEG5EKEDSNP6ATNTTB2378F	\N	2024-01-06 04:24:42.992916+00	2024-01-06 04:24:42.992916+00
pvma__01HM6VA779CPFMT1ERW0ES15PH	ma_01HM6VA76QTYNK2RF47AJ9YG14	variant_01HJQ62GABST7KDDNMZ0F8Y7FH	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA779X6X4JZ9YWW8KFMTP	ma_01HM6VA76R2TM4142F75QWWT9V	variant_01HJQ62GABST7KDDNMZ0F8Y7FH	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA779Y475HZAAA0PEBSM1	ma_01HM6VA76R7WSDWZ0SP82FWC6B	variant_01HJQ62GBVW906EVEA3QBD9FZ1	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA779CTDV8HA9HQDG83TD	ma_01HM6VA76R4PJNVZXQXSJ16PB2	variant_01HJQ62GBVW906EVEA3QBD9FZ1	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA779XAHV532Y3T1VHZMH	ma_01HM6VA76RN08PJ3Y6TEAGRTW2	variant_01HJQ62GD0BVJBQ65MED3SCD9K	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA77A0FF9RFZQ25KX4PRG	ma_01HM6VA76R4MT01R1Z09N0V9FB	variant_01HJQ62GD0BVJBQ65MED3SCD9K	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA77A1A2770K6FG12K9Q1	ma_01HM6VA76SGJ5NTPYGMRG1B9F1	variant_01HJQ62GDZPSJKF81WN3J068DR	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA77AG3R0G7HAZP2Q8ARD	ma_01HM6VA76SNW72NJJNB4Y2KEYX	variant_01HJQ62GDZPSJKF81WN3J068DR	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA77A8JDG1J22Y76KHB1E	ma_01HM6VA76S7WZQ4WYX8RP3FFFK	variant_01HJQ62GABST7KDDNMZ0F8Y7FH	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA77A6H0XC2C4M7QF0T0C	ma_01HM6VA76SHH0F1X9512C228T2	variant_01HJQ62GABST7KDDNMZ0F8Y7FH	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA77AAR2EQ1ZB9Y3Y8WPD	ma_01HM6VA76S7EDP887F2DXN5FCK	variant_01HJQ62GBVW906EVEA3QBD9FZ1	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA77AVFSZ3Y5JSYQ15MR7	ma_01HM6VA76SP7G17PB7ETM0154Q	variant_01HJQ62GBVW906EVEA3QBD9FZ1	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA77AS9725E8XQR3TV3DV	ma_01HM6VA76T2H0E6A7RK4MKRQQV	variant_01HJQ62GD0BVJBQ65MED3SCD9K	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA77AYEZ951K11CAAB0TF	ma_01HM6VA76TYBB1VFVHM63983MV	variant_01HJQ62GD0BVJBQ65MED3SCD9K	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA77A5XTSH9FZYQCSV0CA	ma_01HM6VA76TN6KCTQBC8X868GXH	variant_01HJQ62GDZPSJKF81WN3J068DR	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA77A5DS3GSXKRFYT559N	ma_01HM6VA76T2G87TDCS4JJV7FWG	variant_01HJQ62GDZPSJKF81WN3J068DR	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA77AYPQX7EN2KZD8RW0T	ma_01HM6VA76THC00E85FQQACYEQV	variant_01HJQ62FYVHHKAB8E3M0XBKHKM	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA77ANMBB6Y834FCCCT4N	ma_01HM6VA76TYG4SCHE97X33J5E5	variant_01HJQ62FYVHHKAB8E3M0XBKHKM	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA77BFZC9PYNR67RC26CG	ma_01HM6VA76TXFE537H6BF1ZZGEN	variant_01HJQ62G18RW9J8R989JWZ4MPY	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA77B9F5Z4K08TZX25XQD	ma_01HM6VA76V9PGBPAMHNSA13KPG	variant_01HJQ62G18RW9J8R989JWZ4MPY	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA77B6EFCJG9GPE2A40MT	ma_01HM6VA76VB4RE8FYBWVY004KH	variant_01HJQ62G223SV9T8H0JA7NBFYD	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA77BAR9R48VWS92HAHCG	ma_01HM6VA76VJEDZFBPVNBA66Y38	variant_01HJQ62G223SV9T8H0JA7NBFYD	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA77BTMQNH695YYQXSSWZ	ma_01HM6VA76VRGYKQJSCZ4PED099	variant_01HJQ62G31A6XR3R0QAA805S8T	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA77BND5RQV6SK4AKBN5X	ma_01HM6VA76VH9XEYDPQVMFCVR65	variant_01HJQ62G31A6XR3R0QAA805S8T	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA77B61RVZ8QYY4SPXH5Z	ma_01HM6VA76VHR05BHMHP99NNMS4	variant_01HJQ62G40EW5JY2E7FSFN7B2C	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA77BAZK5B1G7N787DDP7	ma_01HM6VA76VP519E0Q7HZSV97KQ	variant_01HJQ62G40EW5JY2E7FSFN7B2C	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA77BT6AJXQ4NSTYEVQRZ	ma_01HM6VA76XV3V53NV1N65P3ACD	variant_01HJQ62G5CF8NT71MZ8KCZFSVT	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA77BMM8M41Y2ACS9H2Q9	ma_01HM6VA76X2P6N1Q7BHG589VR9	variant_01HJQ62G5CF8NT71MZ8KCZFSVT	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA77BDWKYAESYA496G5PZ	ma_01HM6VA770EDS0861AF3ERAP0C	variant_01HJQ62G6EB7PVD76BN65TBF3T	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA77C12B3H7TNJ0JJ0M99	ma_01HM6VA7703VGH9DCFFW3VCAHW	variant_01HJQ62G6EB7PVD76BN65TBF3T	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA77DAVAK1EFKXC2FKK0B	ma_01HM6VA770P0EWW3NT167D969W	variant_01HJQ62G7ME141NMQ4XNGQ0RTD	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HM6VA77DK3892A49GV39Y6BS	ma_01HM6VA7707PD7HHD8T5YYP393	variant_01HJQ62G7ME141NMQ4XNGQ0RTD	\N	2024-01-15 15:19:49.709542+00	2024-01-15 15:19:49.709542+00
pvma__01HMW3CGXQB55DNVB4X218KXS2	ma_01HMW3CGXKE072KGV0V7GC5EYY	variant_01HJQ62H2NRGRY3ZAQCBWK5QTX	\N	2024-01-23 21:24:56.875965+00	2024-01-23 21:24:56.875965+00
pvma__01HMW3CGXQ1N2YCGWV6MTNGTG0	ma_01HMW3CGXKFPPBTSFRDXN4D0XD	variant_01HJQ62H2NRGRY3ZAQCBWK5QTX	\N	2024-01-23 21:24:56.875965+00	2024-01-23 21:24:56.875965+00
pvma__01HMW3PHNY8NDX2PKYXXRJ62TS	ma_01HJQ62GS69N7FNHH70ZS1D4AA	variant_01HJQ62GRDR8CXCHCWNFMNG39W	\N	2024-01-23 21:30:25.317707+00	2024-01-23 21:30:25.317707+00
pvma__01HMW3PHNY69W3C5G8J5KEKVB0	ma_01HJQ62GS6D60CTB3Z57KSQ3XX	variant_01HJQ62GRDR8CXCHCWNFMNG39W	\N	2024-01-23 21:30:25.317707+00	2024-01-23 21:30:25.317707+00
pvma__01HMW3TYHGANJNTZFDAABG52S6	ma_01HMW3TYH9D5H3PG2625RPQ04W	variant_01HMW3TYG578Y20PW6QTWKE8BS	\N	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00
pvma__01HMW3TYHGK3F4Z0A6A2SWAGZ1	ma_01HMW3TYH9CM6AEQHZXEW5TJEZ	variant_01HMW3TYG578Y20PW6QTWKE8BS	\N	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00
pvma__01HMW3TYHGG4SN9T9VG7B3339D	ma_01HMW3TYH98CWMSDQBHVECHJSW	variant_01HMW3TYG67P3DSSYD3GNV3AQG	\N	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00
pvma__01HMW3TYHGJ7H7ADTSS70VN4F8	ma_01HMW3TYH9PNQBZ7A3X547Z9EG	variant_01HMW3TYG67P3DSSYD3GNV3AQG	\N	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00
pvma__01HMW3TYHGDW6FKS17RYTVABWF	ma_01HMW3TYH994R9HZMZ519XZ815	variant_01HMW3TYG6SHPFM60XJ3MVKAXK	\N	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00
pvma__01HMW3TYHG27D52F0W9A9YCWM1	ma_01HMW3TYH94Q9WC3BJF4G2AF3E	variant_01HMW3TYG6SHPFM60XJ3MVKAXK	\N	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00
pvma__01HMW3TYHGZV8WZ25E2TK9B10Y	ma_01HMW3TYH991TMPJSM3RMQD4VA	variant_01HMW3TYG756MHZ5PEFAJZBX6D	\N	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00
pvma__01HMW3TYHGJMK49NRKKCXEB8GH	ma_01HMW3TYH919VH3T9MHYXECDV6	variant_01HMW3TYG756MHZ5PEFAJZBX6D	\N	2024-01-23 21:32:49.494933+00	2024-01-23 21:32:49.494933+00
pvma__01HMW3V65MBK3EAF0Z8DRV0XNR	ma_01HMW3TYH98ACY4XGJT7QG655C	variant_01HMW3TYG4YW7FTDTCPF06NN3C	\N	2024-01-23 21:32:57.380131+00	2024-01-23 21:32:57.380131+00
pvma__01HMW3V65M62C0VTPBXPHSSCFB	ma_01HMW3TYH96RPEPRM9DPQ2CF61	variant_01HMW3TYG4YW7FTDTCPF06NN3C	\N	2024-01-23 21:32:57.380131+00	2024-01-23 21:32:57.380131+00
pvma__01HMW3VJ9V00T0RZGZMM6N6MCP	ma_01HMW3TYH8YP5874BK1R991SWP	variant_01HMW3TYG4TRDZRAT6YNT305J2	\N	2024-01-23 21:33:09.805585+00	2024-01-23 21:33:09.805585+00
pvma__01HMW3VJ9VFH7497DDMJ3M0YTA	ma_01HMW3TYH8YHJQA96592XSW9V2	variant_01HMW3TYG4TRDZRAT6YNT305J2	\N	2024-01-23 21:33:09.805585+00	2024-01-23 21:33:09.805585+00
pvma__01HMW3XHSAVEX0GGH0YAF6AEWZ	ma_01HMW3TYH88NRG9J2MTGW77NH2	variant_01HMW3TYG3Y7BTF66HKEX29YX7	\N	2024-01-23 21:34:14.810656+00	2024-01-23 21:34:14.810656+00
pvma__01HMW3XHSABE1DP9WYWQ9WMBMT	ma_01HMW3TYH8XRYZRP8DAP2PQSBW	variant_01HMW3TYG3Y7BTF66HKEX29YX7	\N	2024-01-23 21:34:14.810656+00	2024-01-23 21:34:14.810656+00
pvma__01HMW3Y62AKF7VGVQZRY0C5JNG	ma_01HMW3TYH8XHCM2WBGF182C2QT	variant_01HMW3TYG2Z1NGN0WQQK0NT39S	\N	2024-01-23 21:34:35.578405+00	2024-01-23 21:34:35.578405+00
pvma__01HMW3Y62AZ6CT5KVDTJFEFFSZ	ma_01HMW3TYH8TDGTHMZHEXKASGBE	variant_01HMW3TYG2Z1NGN0WQQK0NT39S	\N	2024-01-23 21:34:35.578405+00	2024-01-23 21:34:35.578405+00
\.


--
-- Data for Name: provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.provider (id, provider_payment_id, customer_id, ambit_operations_id, account_iva, account_irpf, account_provider, account_creditor) FROM stdin;
\.


--
-- Data for Name: provider_payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.provider_payment (id, provider_id, payment_method, payday, bank_name, bank_country, currency_code, iban, swift) FROM stdin;
\.


--
-- Data for Name: publishable_api_key; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.publishable_api_key (id, created_at, updated_at, created_by, revoked_by, revoked_at, title) FROM stdin;
\.


--
-- Data for Name: publishable_api_key_sales_channel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.publishable_api_key_sales_channel (sales_channel_id, publishable_key_id) FROM stdin;
\.


--
-- Data for Name: refund; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.refund (id, order_id, amount, note, reason, created_at, updated_at, metadata, idempotency_key, payment_id) FROM stdin;
\.


--
-- Data for Name: region; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.region (id, name, currency_code, tax_rate, tax_code, created_at, updated_at, deleted_at, metadata, gift_cards_taxable, automatic_taxes, tax_provider_id) FROM stdin;
reg_01HJQ62FHQEHVFQQK69CA8PK41	EU	eur	0	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	t	t	\N
reg_01HJQ62FKBJHFRR89DWYF1XVAM	NA	usd	0	\N	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	t	t	\N
\.


--
-- Data for Name: region_fulfillment_providers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.region_fulfillment_providers (region_id, provider_id) FROM stdin;
reg_01HJQ62FHQEHVFQQK69CA8PK41	manual
reg_01HJQ62FKBJHFRR89DWYF1XVAM	manual
\.


--
-- Data for Name: region_payment_providers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.region_payment_providers (region_id, provider_id) FROM stdin;
reg_01HJQ62FHQEHVFQQK69CA8PK41	manual
reg_01HJQ62FKBJHFRR89DWYF1XVAM	manual
\.


--
-- Data for Name: return; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.return (id, status, swap_id, order_id, shipping_data, refund_amount, received_at, created_at, updated_at, metadata, idempotency_key, claim_order_id, no_notification, location_id) FROM stdin;
\.


--
-- Data for Name: return_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.return_item (return_id, item_id, quantity, is_requested, requested_quantity, received_quantity, metadata, reason_id, note) FROM stdin;
\.


--
-- Data for Name: return_reason; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.return_reason (id, value, label, description, created_at, updated_at, deleted_at, metadata, parent_return_reason_id) FROM stdin;
rr_01HMW32C5G3KAG2Q8TRW1CSGH2	error-tamaño	Error tamaño	El cliente recibió mal el tamaño	2024-01-23 21:19:24.3347+00	2024-01-23 21:19:24.3347+00	\N	\N	\N
\.


--
-- Data for Name: sales_channel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sales_channel (id, created_at, updated_at, deleted_at, name, description, is_disabled, metadata) FROM stdin;
sc_01HJQ62F3H1V5R0YME9AZ7PMMG	2023-12-28 03:04:16.900294+00	2023-12-28 03:04:16.900294+00	\N	Default Sales Channel	Created by Medusa	f	\N
sc_01HNFMD6M8ZJZ6TX4S1MYMR3AW	2024-01-31 11:27:59.105277+00	2024-01-31 11:27:59.105277+00	\N	ventas de amazon	productos que se venden en amazon	f	\N
\.


--
-- Data for Name: sales_channel_location; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sales_channel_location (id, created_at, updated_at, sales_channel_id, location_id, deleted_at) FROM stdin;
\.


--
-- Data for Name: shipping_method; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shipping_method (id, shipping_option_id, order_id, cart_id, swap_id, return_id, price, data, claim_order_id) FROM stdin;
sm_01HKEGF77FDNGNQCWRFKFB1SV0	so_01HJQ62FPSXPFFEC9HWHZKED5B	order_01HKEGFFG7P3NFDAE7WV6DTQAH	cart_01HJX9JS9SXA5ZFHBEXBQ8J6Q5	\N	\N	800	{}	\N
sm_01HMW4BY3QS6Z58K46RBCR15CD	so_01HJQ62FM7ZN9GKDX2BHGWDFNK	order_01HMW4C4BFQ0JCSRQZMJZAD0YM	cart_01HMW455PM9KPMQ188CTN3BEPD	\N	\N	1000	{}	\N
sm_01HNFMPVYN898JMH7JN3AXZNH4	so_01HJQ62FM7ZN9GKDX2BHGWDFNK	order_01HNFMR16MP15H71KPM48VMAX9	cart_01HM6THN376FNFK12TTTPYR2KH	\N	\N	1000	{}	\N
sm_01HNFVA2YE7XBFCAG3NQ4WC4T8	so_01HJQ62FMPGJDBQZZAZ84H7S1P	order_01HNFVA6PA3X641SN5K2QQNHTM	cart_01HNFMR1GPDJT3T39WAWWYHJRX	\N	\N	1500	{}	\N
\.


--
-- Data for Name: shipping_method_tax_line; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shipping_method_tax_line (id, rate, name, code, created_at, updated_at, metadata, shipping_method_id) FROM stdin;
smtl_01HKEGFF7SZF095GNZ54F6CVNF	0	default	default	2024-01-06 04:28:41.049208+00	2024-01-06 04:28:41.256921+00	\N	sm_01HKEGF77FDNGNQCWRFKFB1SV0
smtl_01HMW4C465R5SY2Z8NBTB0AQKS	0	default	default	2024-01-23 21:42:12.396605+00	2024-01-23 21:42:12.527487+00	\N	sm_01HMW4BY3QS6Z58K46RBCR15CD
smtl_01HNFMR10PJQJE0T5QPV6G0R3C	0	default	default	2024-01-31 11:33:53.783673+00	2024-01-31 11:33:53.924934+00	\N	sm_01HNFMPVYN898JMH7JN3AXZNH4
smtl_01HNFVA6H3Y7406KTYZX7RGERD	0	default	default	2024-01-31 13:28:40.705534+00	2024-01-31 13:28:40.836463+00	\N	sm_01HNFVA2YE7XBFCAG3NQ4WC4T8
\.


--
-- Data for Name: shipping_option; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shipping_option (id, name, region_id, profile_id, provider_id, price_type, amount, is_return, data, created_at, updated_at, deleted_at, metadata, admin_only) FROM stdin;
so_01HJQ62FM7ZN9GKDX2BHGWDFNK	PostFake Standard	reg_01HJQ62FHQEHVFQQK69CA8PK41	sp_01HJQ62F0MRD4WRSYX1KYME2JW	manual	flat_rate	1000	f	{"id": "manual-fulfillment"}	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	f
so_01HJQ62FMPGJDBQZZAZ84H7S1P	PostFake Express	reg_01HJQ62FHQEHVFQQK69CA8PK41	sp_01HJQ62F0MRD4WRSYX1KYME2JW	manual	flat_rate	1500	f	{"id": "manual-fulfillment"}	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	f
so_01HJQ62FNE3942JGB0TMEPWKDS	PostFake Return	reg_01HJQ62FHQEHVFQQK69CA8PK41	sp_01HJQ62F0MRD4WRSYX1KYME2JW	manual	flat_rate	1000	t	{"id": "manual-fulfillment"}	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	f
so_01HJQ62FNWF1JHRJ980T7EESY5	I want to return it myself	reg_01HJQ62FHQEHVFQQK69CA8PK41	sp_01HJQ62F0MRD4WRSYX1KYME2JW	manual	flat_rate	0	t	{"id": "manual-fulfillment"}	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	f
so_01HJQ62FPSXPFFEC9HWHZKED5B	FakeEx Standard	reg_01HJQ62FKBJHFRR89DWYF1XVAM	sp_01HJQ62F0MRD4WRSYX1KYME2JW	manual	flat_rate	800	f	{"id": "manual-fulfillment"}	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	f
so_01HJQ62FQJ2B8QQMJ3P0CVWE9H	FakeEx Express	reg_01HJQ62FKBJHFRR89DWYF1XVAM	sp_01HJQ62F0MRD4WRSYX1KYME2JW	manual	flat_rate	1200	f	{"id": "manual-fulfillment"}	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	f
so_01HJQ62FRPZBA7GQVN0330FC0W	FakeEx Return	reg_01HJQ62FKBJHFRR89DWYF1XVAM	sp_01HJQ62F0MRD4WRSYX1KYME2JW	manual	flat_rate	800	t	{"id": "manual-fulfillment"}	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	f
so_01HJQ62FS0HJMJ532N8E8G49BM	I want to return it myself	reg_01HJQ62FKBJHFRR89DWYF1XVAM	sp_01HJQ62F0MRD4WRSYX1KYME2JW	manual	flat_rate	0	t	{"id": "manual-fulfillment"}	2023-12-28 03:04:17.48254+00	2023-12-28 03:04:17.48254+00	\N	\N	f
\.


--
-- Data for Name: shipping_option_requirement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shipping_option_requirement (id, shipping_option_id, type, amount, deleted_at) FROM stdin;
\.


--
-- Data for Name: shipping_profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shipping_profile (id, name, type, created_at, updated_at, deleted_at, metadata) FROM stdin;
sp_01HJQ62F0MRD4WRSYX1KYME2JW	Default Shipping Profile	default	2023-12-28 03:04:16.900294+00	2023-12-28 03:04:16.900294+00	\N	\N
sp_01HJQ62F0PM8CFGZG97H65E98V	Gift Card Profile	gift_card	2023-12-28 03:04:16.900294+00	2023-12-28 03:04:16.900294+00	\N	\N
\.


--
-- Data for Name: shipping_tax_rate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shipping_tax_rate (shipping_option_id, rate_id, created_at, updated_at, metadata) FROM stdin;
\.


--
-- Data for Name: staged_job; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.staged_job (id, event_name, data, options) FROM stdin;
\.


--
-- Data for Name: store; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store (id, name, default_currency_code, swap_link_template, created_at, updated_at, metadata, payment_link_template, invite_link_template, default_sales_channel_id, default_location_id) FROM stdin;
store_01HJQ62ETXQGT57BZ5R4R5NWPN	Medusa Store	eur	\N	2023-12-28 03:04:16.900294+00	2024-01-15 15:21:49.419046+00	\N	\N	\N	sc_01HJQ62F3H1V5R0YME9AZ7PMMG	\N
\.


--
-- Data for Name: store_currencies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_currencies (store_id, currency_code) FROM stdin;
store_01HJQ62ETXQGT57BZ5R4R5NWPN	usd
store_01HJQ62ETXQGT57BZ5R4R5NWPN	eur
\.


--
-- Data for Name: swap; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.swap (id, fulfillment_status, payment_status, order_id, difference_due, shipping_address_id, cart_id, confirmed_at, created_at, updated_at, deleted_at, metadata, idempotency_key, no_notification, canceled_at, allow_backorder) FROM stdin;
\.


--
-- Data for Name: tax_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tax_provider (id, is_installed) FROM stdin;
\.


--
-- Data for Name: tax_rate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tax_rate (id, rate, code, name, region_id, created_at, updated_at, metadata) FROM stdin;
txr_01HM6VF955JXB29T12X4ZEDBKG	21	21	21% iva	reg_01HJQ62FHQEHVFQQK69CA8PK41	2024-01-15 15:22:35.55569+00	2024-01-15 15:22:35.55569+00	\N
\.


--
-- Data for Name: tracking_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tracking_link (id, url, tracking_number, fulfillment_id, created_at, updated_at, deleted_at, metadata, idempotency_key) FROM stdin;
tlink_01HKEGKT0VYVZ73ENBMDWZDJC0	\N	envionumero1000	ful_01HKEGJF51KYW502D1P9QW3S06	2024-01-06 04:31:03.178177+00	2024-01-06 04:31:03.178177+00	\N	\N	\N
tlink_01HNFVDT1E1F556RVS15T1ZXSC	\N		ful_01HNFVD6CG8GHENMHBY8F81RR2	2024-01-31 13:30:38.997001+00	2024-01-31 13:30:38.997001+00	\N	\N	\N
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, email, first_name, last_name, password_hash, api_token, created_at, updated_at, deleted_at, metadata, role) FROM stdin;
usr_01HJQ657D3JKGCCVVCE4ZG170M	admin@medusajs-test.com	\N	\N	c2NyeXB0AAEAAAABAAAAAUIiD81hLTFLFcww2iyj3HjKcfn5HAtzfpKBBya916KOdT5d5Ov5t6uuC0r0lulku7uI8Dl4LgoX+bAlqE5Z86VdWMLCPKsJNK9Fe8/3Aap8	\N	2023-12-28 03:05:47.666711+00	2023-12-28 03:05:47.666711+00	\N	\N	member
usr_01HJQ62FD504BGC95M85QYP9RE	admin@medusa-test.com	alvaro	co	c2NyeXB0AAEAAAABAAAAAZ2ZeTCD6ZBeh95USuwn/HJVM6SZHRR6bRIwEIsEXOcUxr4hh7f2Xx7MmwoSEPpPg7xJxuTTHyDzxCYNrk4LW8tfGeCnxQhBQDCFnaT/Fy3l	\N	2023-12-28 03:04:17.48254+00	2024-01-23 21:18:14.541201+00	\N	\N	member
\.


--
-- Name: country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.country_id_seq', 250, true);


--
-- Name: draft_order_display_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.draft_order_display_id_seq', 1, false);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 73, true);


--
-- Name: order_display_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_display_id_seq', 4, true);


--
-- Name: payment_session OneSelected; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_session
    ADD CONSTRAINT "OneSelected" UNIQUE (cart_id, is_selected);


--
-- Name: money_amount PK_022e49a7e21a8dfb820f788778a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.money_amount
    ADD CONSTRAINT "PK_022e49a7e21a8dfb820f788778a" PRIMARY KEY (id);


--
-- Name: notification_provider PK_0425c2423e2ce9fdfd5c23761d9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_provider
    ADD CONSTRAINT "PK_0425c2423e2ce9fdfd5c23761d9" PRIMARY KEY (id);


--
-- Name: store_currencies PK_0f2bff3bccc785c320a4df836de; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_currencies
    ADD CONSTRAINT "PK_0f2bff3bccc785c320a4df836de" PRIMARY KEY (store_id, currency_code);


--
-- Name: order PK_1031171c13130102495201e3e20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "PK_1031171c13130102495201e3e20" PRIMARY KEY (id);


--
-- Name: cart_discounts PK_10bd412c9071ccc0cf555afd9bb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_discounts
    ADD CONSTRAINT "PK_10bd412c9071ccc0cf555afd9bb" PRIMARY KEY (cart_id, discount_id);


--
-- Name: product_images PK_10de97980da2e939c4c0e8423f2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_images
    ADD CONSTRAINT "PK_10de97980da2e939c4c0e8423f2" PRIMARY KEY (product_id, image_id);


--
-- Name: product_tag PK_1439455c6528caa94fcc8564fda; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_tag
    ADD CONSTRAINT "PK_1439455c6528caa94fcc8564fda" PRIMARY KEY (id);


--
-- Name: discount_regions PK_15974566a8b6e04a7c754e85b75; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_regions
    ADD CONSTRAINT "PK_15974566a8b6e04a7c754e85b75" PRIMARY KEY (discount_id, region_id);


--
-- Name: product_variant PK_1ab69c9935c61f7c70791ae0a9f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_variant
    ADD CONSTRAINT "PK_1ab69c9935c61f7c70791ae0a9f" PRIMARY KEY (id);


--
-- Name: price_list_customer_groups PK_1afcbe15cc8782dc80c05707df9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.price_list_customer_groups
    ADD CONSTRAINT "PK_1afcbe15cc8782dc80c05707df9" PRIMARY KEY (price_list_id, customer_group_id);


--
-- Name: product_tags PK_1cf5c9537e7198df494b71b993f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_tags
    ADD CONSTRAINT "PK_1cf5c9537e7198df494b71b993f" PRIMARY KEY (product_id, product_tag_id);


--
-- Name: idempotency_key PK_213f125e14469be304f9ff1d452; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idempotency_key
    ADD CONSTRAINT "PK_213f125e14469be304f9ff1d452" PRIMARY KEY (id);


--
-- Name: cart_gift_cards PK_2389be82bf0ef3635e2014c9ef1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_gift_cards
    ADD CONSTRAINT "PK_2389be82bf0ef3635e2014c9ef1" PRIMARY KEY (cart_id, gift_card_id);


--
-- Name: tax_rate PK_23b71b53f650c0b39e99ccef4fd; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_rate
    ADD CONSTRAINT "PK_23b71b53f650c0b39e99ccef4fd" PRIMARY KEY (id);


--
-- Name: product_option_value PK_2ab71ed3b21be5800905c621535; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_option_value
    ADD CONSTRAINT "PK_2ab71ed3b21be5800905c621535" PRIMARY KEY (id);


--
-- Name: line_item_adjustment PK_2b1360103753df2dc8257c2c8c3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.line_item_adjustment
    ADD CONSTRAINT "PK_2b1360103753df2dc8257c2c8c3" PRIMARY KEY (id);


--
-- Name: shipping_option PK_2e56fddaa65f3a26d402e5d786e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_option
    ADD CONSTRAINT "PK_2e56fddaa65f3a26d402e5d786e" PRIMARY KEY (id);


--
-- Name: product_tax_rate PK_326257ce468df46cd5c8c5922e9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_tax_rate
    ADD CONSTRAINT "PK_326257ce468df46cd5c8c5922e9" PRIMARY KEY (product_id, rate_id);


--
-- Name: discount_rule_products PK_351c8c92f5d27283c445cd022ee; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_rule_products
    ADD CONSTRAINT "PK_351c8c92f5d27283c445cd022ee" PRIMARY KEY (discount_rule_id, product_id);


--
-- Name: discount_condition_product_type PK_35d538a5a24399d0df978df12ed; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_condition_product_type
    ADD CONSTRAINT "PK_35d538a5a24399d0df978df12ed" PRIMARY KEY (product_type_id, condition_id);


--
-- Name: return_item PK_46409dc1dd5f38509b9000c3069; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.return_item
    ADD CONSTRAINT "PK_46409dc1dd5f38509b9000c3069" PRIMARY KEY (return_id, item_id);


--
-- Name: order_gift_cards PK_49a8ec66a6625d7c2e3526e05b4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_gift_cards
    ADD CONSTRAINT "PK_49a8ec66a6625d7c2e3526e05b4" PRIMARY KEY (order_id, gift_card_id);


--
-- Name: product_collection PK_49d419fc77d3aed46c835c558ac; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_collection
    ADD CONSTRAINT "PK_49d419fc77d3aed46c835c558ac" PRIMARY KEY (id);


--
-- Name: line_item_tax_line PK_4a0f4322fcd5ce4af85727f89a8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.line_item_tax_line
    ADD CONSTRAINT "PK_4a0f4322fcd5ce4af85727f89a8" PRIMARY KEY (id);


--
-- Name: swap PK_4a10d0f359339acef77e7f986d9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.swap
    ADD CONSTRAINT "PK_4a10d0f359339acef77e7f986d9" PRIMARY KEY (id);


--
-- Name: product_option PK_4cf3c467e9bc764bdd32c4cd938; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_option
    ADD CONSTRAINT "PK_4cf3c467e9bc764bdd32c4cd938" PRIMARY KEY (id);


--
-- Name: fulfillment PK_50c102da132afffae660585981f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fulfillment
    ADD CONSTRAINT "PK_50c102da132afffae660585981f" PRIMARY KEY (id);


--
-- Name: price_list PK_52ea7826468b1c889cb2c28df03; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.price_list
    ADD CONSTRAINT "PK_52ea7826468b1c889cb2c28df03" PRIMARY KEY (id);


--
-- Name: claim_item_tags PK_54ab8ce0f7e99167068188fbd81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.claim_item_tags
    ADD CONSTRAINT "PK_54ab8ce0f7e99167068188fbd81" PRIMARY KEY (item_id, tag_id);


--
-- Name: shipping_method_tax_line PK_54c94f5908aacbd51cf0a73edb1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_method_tax_line
    ADD CONSTRAINT "PK_54c94f5908aacbd51cf0a73edb1" PRIMARY KEY (id);


--
-- Name: claim_item PK_5679662039bc4c7c6bc7fa1be2d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.claim_item
    ADD CONSTRAINT "PK_5679662039bc4c7c6bc7fa1be2d" PRIMARY KEY (id);


--
-- Name: order_edit PK_58ab6acf2e84b4e827f5f846f7a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_edit
    ADD CONSTRAINT "PK_58ab6acf2e84b4e827f5f846f7a" PRIMARY KEY (id);


--
-- Name: region_fulfillment_providers PK_5b7d928a1fb50d6803868cfab3a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.region_fulfillment_providers
    ADD CONSTRAINT "PK_5b7d928a1fb50d6803868cfab3a" PRIMARY KEY (region_id, provider_id);


--
-- Name: region PK_5f48ffc3af96bc486f5f3f3a6da; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT "PK_5f48ffc3af96bc486f5f3f3a6da" PRIMARY KEY (id);


--
-- Name: publishable_api_key_sales_channel PK_68eaeb14bdac8954460054c567c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publishable_api_key_sales_channel
    ADD CONSTRAINT "PK_68eaeb14bdac8954460054c567c" PRIMARY KEY (sales_channel_id, publishable_key_id);


--
-- Name: notification PK_705b6c7cdf9b2c2ff7ac7872cb7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT "PK_705b6c7cdf9b2c2ff7ac7872cb7" PRIMARY KEY (id);


--
-- Name: currency PK_723472e41cae44beb0763f4039c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.currency
    ADD CONSTRAINT "PK_723472e41cae44beb0763f4039c" PRIMARY KEY (code);


--
-- Name: claim_tag PK_7761180541142a5926501018d34; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.claim_tag
    ADD CONSTRAINT "PK_7761180541142a5926501018d34" PRIMARY KEY (id);


--
-- Name: claim_image PK_7c49e44bfe8840ca7d917890101; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.claim_image
    ADD CONSTRAINT "PK_7c49e44bfe8840ca7d917890101" PRIMARY KEY (id);


--
-- Name: customer_group PK_88e7da3ff7262d9e0a35aa3664e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_group
    ADD CONSTRAINT "PK_88e7da3ff7262d9e0a35aa3664e" PRIMARY KEY (id);


--
-- Name: claim_order PK_8981f5595a4424021466aa4c7a4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.claim_order
    ADD CONSTRAINT "PK_8981f5595a4424021466aa4c7a4" PRIMARY KEY (id);


--
-- Name: migrations PK_8c82d7f526340ab734260ea46be; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT "PK_8c82d7f526340ab734260ea46be" PRIMARY KEY (id);


--
-- Name: custom_shipping_option PK_8dfcb5c1172c29eec4a728420cc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.custom_shipping_option
    ADD CONSTRAINT "PK_8dfcb5c1172c29eec4a728420cc" PRIMARY KEY (id);


--
-- Name: analytics_config PK_93505647c5d7cb479becb810b0f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analytics_config
    ADD CONSTRAINT "PK_93505647c5d7cb479becb810b0f" PRIMARY KEY (id);


--
-- Name: return_reason PK_95fd1172973165790903e65660a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.return_reason
    ADD CONSTRAINT "PK_95fd1172973165790903e65660a" PRIMARY KEY (id);


--
-- Name: note PK_96d0c172a4fba276b1bbed43058; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.note
    ADD CONSTRAINT "PK_96d0c172a4fba276b1bbed43058" PRIMARY KEY (id);


--
-- Name: discount_condition_product PK_994eb4529fdbf14450d64ec17e8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_condition_product
    ADD CONSTRAINT "PK_994eb4529fdbf14450d64ec17e8" PRIMARY KEY (product_id, condition_id);


--
-- Name: product_variant_inventory_item PK_9a1188b8d36f4d198303b4f7efa; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_variant_inventory_item
    ADD CONSTRAINT "PK_9a1188b8d36f4d198303b4f7efa" PRIMARY KEY (id);


--
-- Name: staged_job PK_9a28fb48c46c5509faf43ac8c8d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staged_job
    ADD CONSTRAINT "PK_9a28fb48c46c5509faf43ac8c8d" PRIMARY KEY (id);


--
-- Name: publishable_api_key PK_9e613278673a87de92c606b4494; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publishable_api_key
    ADD CONSTRAINT "PK_9e613278673a87de92c606b4494" PRIMARY KEY (id);


--
-- Name: region_payment_providers PK_9fa1e69914d3dd752de6b1da407; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.region_payment_providers
    ADD CONSTRAINT "PK_9fa1e69914d3dd752de6b1da407" PRIMARY KEY (region_id, provider_id);


--
-- Name: shipping_option_requirement PK_a0ff15442606d9f783602cb23a7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_option_requirement
    ADD CONSTRAINT "PK_a0ff15442606d9f783602cb23a7" PRIMARY KEY (id);


--
-- Name: payment_session PK_a1a91b20f7f3b1e5afb5485cbcd; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_session
    ADD CONSTRAINT "PK_a1a91b20f7f3b1e5afb5485cbcd" PRIMARY KEY (id);


--
-- Name: order_discounts PK_a7418714ffceebc125bf6d8fcfe; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_discounts
    ADD CONSTRAINT "PK_a7418714ffceebc125bf6d8fcfe" PRIMARY KEY (order_id, discount_id);


--
-- Name: customer PK_a7a13f4cacb744524e44dfdad32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT "PK_a7a13f4cacb744524e44dfdad32" PRIMARY KEY (id);


--
-- Name: discount_condition_product_tag PK_a95382c1e62205b121aa058682b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_condition_product_tag
    ADD CONSTRAINT "PK_a95382c1e62205b121aa058682b" PRIMARY KEY (product_tag_id, condition_id);


--
-- Name: oauth PK_a957b894e50eb16b969c0640a8d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth
    ADD CONSTRAINT "PK_a957b894e50eb16b969c0640a8d" PRIMARY KEY (id);


--
-- Name: discount_rule PK_ac2c280de3701b2d66f6817f760; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_rule
    ADD CONSTRAINT "PK_ac2c280de3701b2d66f6817f760" PRIMARY KEY (id);


--
-- Name: gift_card PK_af4e338d2d41035042843ad641f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gift_card
    ADD CONSTRAINT "PK_af4e338d2d41035042843ad641f" PRIMARY KEY (id);


--
-- Name: sales_channel_location PK_afd2c2c52634bc8280a9c9ee533; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_channel_location
    ADD CONSTRAINT "PK_afd2c2c52634bc8280a9c9ee533" PRIMARY KEY (id);


--
-- Name: tax_provider PK_b198bf82ba6a317c11763d99b99; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_provider
    ADD CONSTRAINT "PK_b198bf82ba6a317c11763d99b99" PRIMARY KEY (id);


--
-- Name: discount_condition_product_collection PK_b3508fc787aa4a38705866cbb6d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_condition_product_collection
    ADD CONSTRAINT "PK_b3508fc787aa4a38705866cbb6d" PRIMARY KEY (product_collection_id, condition_id);


--
-- Name: shipping_method PK_b9b0adfad3c6b99229c1e7d4865; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_method
    ADD CONSTRAINT "PK_b9b0adfad3c6b99229c1e7d4865" PRIMARY KEY (id);


--
-- Name: fulfillment_item PK_bc3e8a388de75db146a249922e0; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fulfillment_item
    ADD CONSTRAINT "PK_bc3e8a388de75db146a249922e0" PRIMARY KEY (fulfillment_id, item_id);


--
-- Name: shipping_tax_rate PK_bcd93b14d7e2695365d383f5eae; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_tax_rate
    ADD CONSTRAINT "PK_bcd93b14d7e2695365d383f5eae" PRIMARY KEY (shipping_option_id, rate_id);


--
-- Name: fulfillment_provider PK_beb35a6de60a6c4f91d5ae57e44; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fulfillment_provider
    ADD CONSTRAINT "PK_beb35a6de60a6c4f91d5ae57e44" PRIMARY KEY (id);


--
-- Name: product PK_bebc9158e480b949565b4dc7a82; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT "PK_bebc9158e480b949565b4dc7a82" PRIMARY KEY (id);


--
-- Name: country PK_bf6e37c231c4f4ea56dcd887269; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT "PK_bf6e37c231c4f4ea56dcd887269" PRIMARY KEY (id);


--
-- Name: cart PK_c524ec48751b9b5bcfbf6e59be7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT "PK_c524ec48751b9b5bcfbf6e59be7" PRIMARY KEY (id);


--
-- Name: shipping_profile PK_c8120e4543a5a3a121f2968a1ec; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_profile
    ADD CONSTRAINT "PK_c8120e4543a5a3a121f2968a1ec" PRIMARY KEY (id);


--
-- Name: return PK_c8ad68d13e76d75d803b5aeebc4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.return
    ADD CONSTRAINT "PK_c8ad68d13e76d75d803b5aeebc4" PRIMARY KEY (id);


--
-- Name: user PK_cace4a159ff9f2512dd42373760; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "PK_cace4a159ff9f2512dd42373760" PRIMARY KEY (id);


--
-- Name: line_item PK_cce6b13e67fa506d1d9618ac68b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.line_item
    ADD CONSTRAINT "PK_cce6b13e67fa506d1d9618ac68b" PRIMARY KEY (id);


--
-- Name: discount_condition_customer_group PK_cdc8b2277169a16b8b7d4c73e0e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_condition_customer_group
    ADD CONSTRAINT "PK_cdc8b2277169a16b8b7d4c73e0e" PRIMARY KEY (customer_group_id, condition_id);


--
-- Name: gift_card_transaction PK_cfb5b4ba5447a507aef87d73fe7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gift_card_transaction
    ADD CONSTRAINT "PK_cfb5b4ba5447a507aef87d73fe7" PRIMARY KEY (id);


--
-- Name: discount PK_d05d8712e429673e459e7f1cddb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount
    ADD CONSTRAINT "PK_d05d8712e429673e459e7f1cddb" PRIMARY KEY (id);


--
-- Name: sales_channel PK_d1eb0b923ea5a0eb1e0916191f1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_channel
    ADD CONSTRAINT "PK_d1eb0b923ea5a0eb1e0916191f1" PRIMARY KEY (id);


--
-- Name: image PK_d6db1ab4ee9ad9dbe86c64e4cc3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT "PK_d6db1ab4ee9ad9dbe86c64e4cc3" PRIMARY KEY (id);


--
-- Name: order_item_change PK_d6eb138f77ffdee83567b85af0c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item_change
    ADD CONSTRAINT "PK_d6eb138f77ffdee83567b85af0c" PRIMARY KEY (id);


--
-- Name: address PK_d92de1f82754668b5f5f5dd4fd5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT "PK_d92de1f82754668b5f5f5dd4fd5" PRIMARY KEY (id);


--
-- Name: product_type_tax_rate PK_ddc9242de1d99bc7674969289f0; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_type_tax_rate
    ADD CONSTRAINT "PK_ddc9242de1d99bc7674969289f0" PRIMARY KEY (product_type_id, rate_id);


--
-- Name: product_type PK_e0843930fbb8854fe36ca39dae1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_type
    ADD CONSTRAINT "PK_e0843930fbb8854fe36ca39dae1" PRIMARY KEY (id);


--
-- Name: customer_group_customers PK_e28a55e34ad1e2d3df9a0ac86d3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_group_customers
    ADD CONSTRAINT "PK_e28a55e34ad1e2d3df9a0ac86d3" PRIMARY KEY (customer_group_id, customer_id);


--
-- Name: batch_job PK_e57f84d485145d5be96bc6d871e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batch_job
    ADD CONSTRAINT "PK_e57f84d485145d5be96bc6d871e" PRIMARY KEY (id);


--
-- Name: discount_condition PK_e6b81d83133ddc21a2baf2e2204; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_condition
    ADD CONSTRAINT "PK_e6b81d83133ddc21a2baf2e2204" PRIMARY KEY (id);


--
-- Name: payment_provider PK_ea94f42b6c88e9191c3649d7522; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_provider
    ADD CONSTRAINT "PK_ea94f42b6c88e9191c3649d7522" PRIMARY KEY (id);


--
-- Name: refund PK_f1cefa2e60d99b206c46c1116e5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refund
    ADD CONSTRAINT "PK_f1cefa2e60d99b206c46c1116e5" PRIMARY KEY (id);


--
-- Name: store PK_f3172007d4de5ae8e7692759d79; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store
    ADD CONSTRAINT "PK_f3172007d4de5ae8e7692759d79" PRIMARY KEY (id);


--
-- Name: draft_order PK_f478946c183d98f8d88a94cfcd7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.draft_order
    ADD CONSTRAINT "PK_f478946c183d98f8d88a94cfcd7" PRIMARY KEY (id);


--
-- Name: invite PK_fc9fa190e5a3c5d80604a4f63e1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invite
    ADD CONSTRAINT "PK_fc9fa190e5a3c5d80604a4f63e1" PRIMARY KEY (id);


--
-- Name: payment PK_fcaec7df5adf9cac408c686b2ab; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT "PK_fcaec7df5adf9cac408c686b2ab" PRIMARY KEY (id);


--
-- Name: tracking_link PK_fcfd77feb9012ec2126d7c0bfb6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tracking_link
    ADD CONSTRAINT "PK_fcfd77feb9012ec2126d7c0bfb6" PRIMARY KEY (id);


--
-- Name: product_sales_channel PK_fd29b6a8bd641052628dee19583; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_sales_channel
    ADD CONSTRAINT "PK_fd29b6a8bd641052628dee19583" PRIMARY KEY (product_id, sales_channel_id);


--
-- Name: payment_collection PK_payment_collection_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_collection
    ADD CONSTRAINT "PK_payment_collection_id" PRIMARY KEY (id);


--
-- Name: payment_collection_payments PK_payment_collection_payments; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_collection_payments
    ADD CONSTRAINT "PK_payment_collection_payments" PRIMARY KEY (payment_collection_id, payment_id);


--
-- Name: payment_collection_sessions PK_payment_collection_sessions; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_collection_sessions
    ADD CONSTRAINT "PK_payment_collection_sessions" PRIMARY KEY (payment_collection_id, payment_session_id);


--
-- Name: product_variant_money_amount PK_product_variant_money_amount; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_variant_money_amount
    ADD CONSTRAINT "PK_product_variant_money_amount" PRIMARY KEY (id);


--
-- Name: product_category PK_qgguwbn1cwstxk93efl0px9oqwt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_category
    ADD CONSTRAINT "PK_qgguwbn1cwstxk93efl0px9oqwt" PRIMARY KEY (id);


--
-- Name: shipping_method REL_1d9ad62038998c3a85c77a53cf; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_method
    ADD CONSTRAINT "REL_1d9ad62038998c3a85c77a53cf" UNIQUE (return_id);


--
-- Name: swap REL_402e8182bc553e082f6380020b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.swap
    ADD CONSTRAINT "REL_402e8182bc553e082f6380020b" UNIQUE (cart_id);


--
-- Name: draft_order REL_5bd11d0e2a9628128e2c26fd0a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.draft_order
    ADD CONSTRAINT "REL_5bd11d0e2a9628128e2c26fd0a" UNIQUE (cart_id);


--
-- Name: order_item_change REL_5f9688929761f7df108b630e64; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item_change
    ADD CONSTRAINT "REL_5f9688929761f7df108b630e64" UNIQUE (line_item_id);


--
-- Name: customer REL_8abe81b9aac151ae60bf507ad1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT "REL_8abe81b9aac151ae60bf507ad1" UNIQUE (billing_address_id);


--
-- Name: draft_order REL_8f6dd6c49202f1466ebf21e77d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.draft_order
    ADD CONSTRAINT "REL_8f6dd6c49202f1466ebf21e77d" UNIQUE (order_id);


--
-- Name: cart REL_9d1a161434c610aae7c3df2dc7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT "REL_9d1a161434c610aae7c3df2dc7" UNIQUE (payment_id);


--
-- Name: return REL_bad82d7bff2b08b87094bfac3d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.return
    ADD CONSTRAINT "REL_bad82d7bff2b08b87094bfac3d" UNIQUE (swap_id);


--
-- Name: payment REL_c17aff091441b7c25ec3d68d36; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT "REL_c17aff091441b7c25ec3d68d36" UNIQUE (swap_id);


--
-- Name: order REL_c99a206eb11ad45f6b7f04f2dc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "REL_c99a206eb11ad45f6b7f04f2dc" UNIQUE (cart_id);


--
-- Name: custom_shipping_option UQ_0f838b122a9a01d921aa1cdb669; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.custom_shipping_option
    ADD CONSTRAINT "UQ_0f838b122a9a01d921aa1cdb669" UNIQUE (shipping_option_id, cart_id);


--
-- Name: line_item_tax_line UQ_3c2af51043ed7243e7d9775a2ad; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.line_item_tax_line
    ADD CONSTRAINT "UQ_3c2af51043ed7243e7d9775a2ad" UNIQUE (item_id, code);


--
-- Name: order_item_change UQ_5b7a99181e4db2ea821be0b6196; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item_change
    ADD CONSTRAINT "UQ_5b7a99181e4db2ea821be0b6196" UNIQUE (order_edit_id, original_line_item_id);


--
-- Name: store UQ_61b0f48cccbb5f41c750bac7286; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store
    ADD CONSTRAINT "UQ_61b0f48cccbb5f41c750bac7286" UNIQUE (default_sales_channel_id);


--
-- Name: return UQ_71773d56eb2bacb922bc3283398; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.return
    ADD CONSTRAINT "UQ_71773d56eb2bacb922bc3283398" UNIQUE (claim_order_id);


--
-- Name: order UQ_727b872f86c7378474a8fa46147; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "UQ_727b872f86c7378474a8fa46147" UNIQUE (draft_order_id);


--
-- Name: product_variant_inventory_item UQ_c9be7c1b11a1a729eb51d1b6bca; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_variant_inventory_item
    ADD CONSTRAINT "UQ_c9be7c1b11a1a729eb51d1b6bca" UNIQUE (variant_id, inventory_item_id);


--
-- Name: shipping_method_tax_line UQ_cd147fca71e50bc954139fa3104; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_method_tax_line
    ADD CONSTRAINT "UQ_cd147fca71e50bc954139fa3104" UNIQUE (shipping_method_id, code);


--
-- Name: order_item_change UQ_da93cee3ca0dd50a5246268c2e9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item_change
    ADD CONSTRAINT "UQ_da93cee3ca0dd50a5246268c2e9" UNIQUE (order_edit_id, line_item_id);


--
-- Name: customer UQ_unique_email_for_guests_and_customer_accounts; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT "UQ_unique_email_for_guests_and_customer_accounts" UNIQUE (email, has_account);


--
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: customer_payment customer_payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_payment
    ADD CONSTRAINT customer_payment_pkey PRIMARY KEY (id);


--
-- Name: discount_condition dctypeuniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_condition
    ADD CONSTRAINT dctypeuniq UNIQUE (type, operator, discount_rule_id);


--
-- Name: gift_card_transaction gcuniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gift_card_transaction
    ADD CONSTRAINT gcuniq UNIQUE (gift_card_id, order_id);


--
-- Name: provider_payment provider_payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provider_payment
    ADD CONSTRAINT provider_payment_pkey PRIMARY KEY (id);


--
-- Name: provider provider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provider
    ADD CONSTRAINT provider_pkey PRIMARY KEY (id);


--
-- Name: IDX_012a62ba743e427b5ebe9dee18; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_012a62ba743e427b5ebe9dee18" ON public.shipping_option_requirement USING btree (shipping_option_id);


--
-- Name: IDX_01486cc9dc6b36bf658685535f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_01486cc9dc6b36bf658685535f" ON public.discount_condition_product_tag USING btree (product_tag_id);


--
-- Name: IDX_017d58bf8260c6e1a2588d258e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_017d58bf8260c6e1a2588d258e" ON public.claim_order USING btree (shipping_address_id);


--
-- Name: IDX_045d4a149c09f4704e0bc08dd4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_045d4a149c09f4704e0bc08dd4" ON public.product_variant USING btree (barcode) WHERE (deleted_at IS NULL);


--
-- Name: IDX_0fb38b6d167793192bc126d835; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_0fb38b6d167793192bc126d835" ON public.cart_gift_cards USING btree (gift_card_id);


--
-- Name: IDX_0fc1ec4e3db9001ad60c19daf1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_0fc1ec4e3db9001ad60c19daf1" ON public.order_discounts USING btree (discount_id);


--
-- Name: IDX_118e3c48f09a7728f41023c94e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_118e3c48f09a7728f41023c94e" ON public.line_item USING btree (claim_order_id);


--
-- Name: IDX_19b0c6293443d1b464f604c331; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_19b0c6293443d1b464f604c331" ON public."order" USING btree (shipping_address_id);


--
-- Name: IDX_1d04aebeabb6a89f87e536a124; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_1d04aebeabb6a89f87e536a124" ON public.product_tax_rate USING btree (product_id);


--
-- Name: IDX_1d9ad62038998c3a85c77a53cf; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_1d9ad62038998c3a85c77a53cf" ON public.shipping_method USING btree (return_id);


--
-- Name: IDX_21683a063fe82dafdf681ecc9c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_21683a063fe82dafdf681ecc9c" ON public.product_tags USING btree (product_tag_id);


--
-- Name: IDX_21cbfedd83d736d86f4c6f4ce5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_21cbfedd83d736d86f4c6f4ce5" ON public.claim_image USING btree (claim_item_id);


--
-- Name: IDX_2212515ba306c79f42c46a99db; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_2212515ba306c79f42c46a99db" ON public.product_images USING btree (image_id);


--
-- Name: IDX_242205c81c1152fab1b6e84847; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_242205c81c1152fab1b6e84847" ON public.cart USING btree (customer_id);


--
-- Name: IDX_2484cf14c437a04586b07e7ddd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_2484cf14c437a04586b07e7ddd" ON public.product_tax_rate USING btree (rate_id);


--
-- Name: IDX_25a3138bb236f63d9bb6c8ff11; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_25a3138bb236f63d9bb6c8ff11" ON public.product_type_tax_rate USING btree (product_type_id);


--
-- Name: IDX_27283ee631862266d0f1c68064; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_27283ee631862266d0f1c68064" ON public.line_item USING btree (cart_id);


--
-- Name: IDX_2ca8cfbdafb998ecfd6d340389; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_2ca8cfbdafb998ecfd6d340389" ON public.product_variant USING btree (sku) WHERE (deleted_at IS NULL);


--
-- Name: IDX_2f41b20a71f30e60471d7e3769; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_2f41b20a71f30e60471d7e3769" ON public.line_item_adjustment USING btree (discount_id);


--
-- Name: IDX_3287f98befad26c3a7dab088cf; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_3287f98befad26c3a7dab088cf" ON public.note USING btree (resource_id);


--
-- Name: IDX_346e0016cf045b998074774764; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_346e0016cf045b998074774764" ON public.shipping_tax_rate USING btree (rate_id);


--
-- Name: IDX_37341bad297fe5cca91f921032; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_37341bad297fe5cca91f921032" ON public.product_sales_channel USING btree (sales_channel_id);


--
-- Name: IDX_379ca70338ce9991f3affdeedf; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_379ca70338ce9991f3affdeedf" ON public.analytics_config USING btree (id, user_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_37f361c38a18d12a3fa3158d0c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_37f361c38a18d12a3fa3158d0c" ON public.region_fulfillment_providers USING btree (provider_id);


--
-- Name: IDX_3a6947180aeec283cd92c59ebb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_3a6947180aeec283cd92c59ebb" ON public.region_payment_providers USING btree (provider_id);


--
-- Name: IDX_3c6412d076292f439269abe1a2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_3c6412d076292f439269abe1a2" ON public.customer_group_customers USING btree (customer_id);


--
-- Name: IDX_3fa354d8d1233ff81097b2fcb6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_3fa354d8d1233ff81097b2fcb6" ON public.line_item USING btree (swap_id);


--
-- Name: IDX_43a2b24495fe1d9fc2a9c835bc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_43a2b24495fe1d9fc2a9c835bc" ON public.line_item USING btree (order_id);


--
-- Name: IDX_44090cb11b06174cbcc667e91c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_44090cb11b06174cbcc667e91c" ON public.custom_shipping_option USING btree (shipping_option_id);


--
-- Name: IDX_4665f17abc1e81dd58330e5854; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_4665f17abc1e81dd58330e5854" ON public.payment USING btree (cart_id);


--
-- Name: IDX_484c329f4783be4e18e5e2ff09; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_484c329f4783be4e18e5e2ff09" ON public.cart USING btree (region_id);


--
-- Name: IDX_4d5f98645a67545d8dea42e2eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_4d5f98645a67545d8dea42e2eb" ON public.discount_condition_customer_group USING btree (customer_group_id);


--
-- Name: IDX_4e0739e5f0244c08d41174ca08; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_4e0739e5f0244c08d41174ca08" ON public.discount_rule_products USING btree (discount_rule_id);


--
-- Name: IDX_4f166bb8c2bfcef2498d97b406; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_4f166bb8c2bfcef2498d97b406" ON public.product_images USING btree (product_id);


--
-- Name: IDX_5077fa54b0d037e984385dfe8a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_5077fa54b0d037e984385dfe8a" ON public.line_item_tax_line USING btree (item_id);


--
-- Name: IDX_5267705a43d547e232535b656c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_5267705a43d547e232535b656c" ON public.shipping_method USING btree (order_id);


--
-- Name: IDX_52875734e9dd69064f0041f4d9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_52875734e9dd69064f0041f4d9" ON public.price_list_customer_groups USING btree (price_list_id);


--
-- Name: IDX_52dd74e8c989aa5665ad2852b8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_52dd74e8c989aa5665ad2852b8" ON public.swap USING btree (order_id);


--
-- Name: IDX_5371cbaa3be5200f373d24e3d5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_5371cbaa3be5200f373d24e3d5" ON public.line_item USING btree (variant_id);


--
-- Name: IDX_53cb5605fa42e82b4d47b47bda; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_53cb5605fa42e82b4d47b47bda" ON public.gift_card USING btree (code);


--
-- Name: IDX_5568d3b9ce9f7abeeb37511ecf; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_5568d3b9ce9f7abeeb37511ecf" ON public."order" USING btree (billing_address_id);


--
-- Name: IDX_579e01fb94f4f58db480857e05; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_579e01fb94f4f58db480857e05" ON public."order" USING btree (display_id);


--
-- Name: IDX_5a4d5e1e60f97633547821ec8d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_5a4d5e1e60f97633547821ec8d" ON public.product_sales_channel USING btree (product_id);


--
-- Name: IDX_5b0c6fc53c574299ecc7f9ee22; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_5b0c6fc53c574299ecc7f9ee22" ON public.product_tags USING btree (product_id);


--
-- Name: IDX_5bd11d0e2a9628128e2c26fd0a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_5bd11d0e2a9628128e2c26fd0a" ON public.draft_order USING btree (cart_id);


--
-- Name: IDX_5c58105f1752fca0f4ce69f466; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_5c58105f1752fca0f4ce69f466" ON public.shipping_option USING btree (region_id);


--
-- Name: IDX_620330964db8d2999e67b0dbe3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_620330964db8d2999e67b0dbe3" ON public.customer_group_customers USING btree (customer_group_id);


--
-- Name: IDX_64980511ca32c8e92b417644af; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_64980511ca32c8e92b417644af" ON public.claim_item USING btree (variant_id);


--
-- Name: IDX_6680319ebe1f46d18f106191d5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_6680319ebe1f46d18f106191d5" ON public.cart_discounts USING btree (cart_id);


--
-- Name: IDX_6b0ce4b4bcfd24491510bf19d1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_6b0ce4b4bcfd24491510bf19d1" ON public.invite USING btree (user_email);


--
-- Name: IDX_6b9c66b5e36f7c827dfaa092f9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_6b9c66b5e36f7c827dfaa092f9" ON public.cart USING btree (billing_address_id);


--
-- Name: IDX_6e0cad0daef76bb642675910b9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_6e0cad0daef76bb642675910b9" ON public.claim_item USING btree (item_id);


--
-- Name: IDX_6ef23ce0b1d9cf9b5b833e52b9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_6ef23ce0b1d9cf9b5b833e52b9" ON public.discount_condition_product_type USING btree (condition_id);


--
-- Name: IDX_6f234f058bbbea810dce1d04d0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_6f234f058bbbea810dce1d04d0" ON public.product_collection USING btree (handle) WHERE (deleted_at IS NULL);


--
-- Name: IDX_71773d56eb2bacb922bc328339; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_71773d56eb2bacb922bc328339" ON public.return USING btree (claim_order_id);


--
-- Name: IDX_82a6bbb0b527c20a0002ddcbd6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_82a6bbb0b527c20a0002ddcbd6" ON public.store_currencies USING btree (currency_code);


--
-- Name: IDX_8486ee16e69013c645d0b8716b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_8486ee16e69013c645d0b8716b" ON public.discount_condition_customer_group USING btree (condition_id);


--
-- Name: IDX_8aaa78ba90d3802edac317df86; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_8aaa78ba90d3802edac317df86" ON public.region_payment_providers USING btree (region_id);


--
-- Name: IDX_8abe81b9aac151ae60bf507ad1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_8abe81b9aac151ae60bf507ad1" ON public.customer USING btree (billing_address_id);


--
-- Name: IDX_8df75ef4f35f217768dc113545; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_8df75ef4f35f217768dc113545" ON public.cart_discounts USING btree (discount_id);


--
-- Name: IDX_8f6dd6c49202f1466ebf21e77d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_8f6dd6c49202f1466ebf21e77d" ON public.draft_order USING btree (order_id);


--
-- Name: IDX_900a9c3834257304396b2b0fe7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_900a9c3834257304396b2b0fe7" ON public.claim_item USING btree (claim_order_id);


--
-- Name: IDX_926ca9f29014af8091722dede0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_926ca9f29014af8091722dede0" ON public.shipping_method_tax_line USING btree (shipping_method_id);


--
-- Name: IDX_93caeb1bb70d37c1d36d6701a7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_93caeb1bb70d37c1d36d6701a7" ON public.custom_shipping_option USING btree (cart_id);


--
-- Name: IDX_9c9614b2f9d01665800ea8dbff; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_9c9614b2f9d01665800ea8dbff" ON public.address USING btree (customer_id);


--
-- Name: IDX_9d1a161434c610aae7c3df2dc7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_9d1a161434c610aae7c3df2dc7" ON public.cart USING btree (payment_id);


--
-- Name: IDX_a0b05dc4257abe639cb75f8eae; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_a0b05dc4257abe639cb75f8eae" ON public.discount_condition_product_collection USING btree (product_collection_id);


--
-- Name: IDX_a0e206bfaed3cb63c186091734; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_a0e206bfaed3cb63c186091734" ON public.shipping_option USING btree (provider_id);


--
-- Name: IDX_a1c4f9cfb599ad1f0db39cadd5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_a1c4f9cfb599ad1f0db39cadd5" ON public.discount_condition_product_collection USING btree (condition_id);


--
-- Name: IDX_a21a7ffbe420d492eb46c305fe; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_a21a7ffbe420d492eb46c305fe" ON public.discount_regions USING btree (region_id);


--
-- Name: IDX_a421bf4588d0004a9b0c0fe84f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_a421bf4588d0004a9b0c0fe84f" ON public.idempotency_key USING btree (idempotency_key);


--
-- Name: IDX_a52e234f729db789cf473297a5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_a52e234f729db789cf473297a5" ON public.fulfillment USING btree (swap_id);


--
-- Name: IDX_aa16f61348be02dd07ce3fc54e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_aa16f61348be02dd07ce3fc54e" ON public.product_variant USING btree (upc) WHERE (deleted_at IS NULL);


--
-- Name: IDX_aac4855eadda71aa1e4b6d7684; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_aac4855eadda71aa1e4b6d7684" ON public.payment USING btree (cart_id) WHERE (canceled_at IS NOT NULL);


--
-- Name: IDX_ac2c280de3701b2d66f6817f76; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_ac2c280de3701b2d66f6817f76" ON public.discount USING btree (rule_id);


--
-- Name: IDX_b1aac8314662fa6b25569a575b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_b1aac8314662fa6b25569a575b" ON public.country USING btree (region_id);


--
-- Name: IDX_b4f4b63d1736689b7008980394; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_b4f4b63d1736689b7008980394" ON public.store_currencies USING btree (store_id);


--
-- Name: IDX_b5b6225539ee8501082fbc0714; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_b5b6225539ee8501082fbc0714" ON public.product_variant USING btree (ean) WHERE (deleted_at IS NULL);


--
-- Name: IDX_b5df0f53a74b9d0c0a2b652c88; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_b5df0f53a74b9d0c0a2b652c88" ON public.notification USING btree (customer_id);


--
-- Name: IDX_b6bcf8c3903097b84e85154eed; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_b6bcf8c3903097b84e85154eed" ON public.gift_card USING btree (region_id);


--
-- Name: IDX_ba8de19442d86957a3aa3b5006; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_ba8de19442d86957a3aa3b5006" ON public."user" USING btree (email) WHERE (deleted_at IS NULL);


--
-- Name: IDX_bad82d7bff2b08b87094bfac3d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_bad82d7bff2b08b87094bfac3d" ON public.return USING btree (swap_id);


--
-- Name: IDX_be66106a673b88a81c603abe7e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_be66106a673b88a81c603abe7e" ON public.discount_rule_products USING btree (product_id);


--
-- Name: IDX_be9aea2ccf3567007b6227da4d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_be9aea2ccf3567007b6227da4d" ON public.line_item_adjustment USING btree (item_id);


--
-- Name: IDX_beb35a6de60a6c4f91d5ae57e4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_beb35a6de60a6c4f91d5ae57e4" ON public.fulfillment USING btree (provider_id);


--
-- Name: IDX_bf701b88d2041392a288785ada; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_bf701b88d2041392a288785ada" ON public.line_item_adjustment USING btree (discount_id, item_id) WHERE (discount_id IS NOT NULL);


--
-- Name: IDX_c17aff091441b7c25ec3d68d36; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_c17aff091441b7c25ec3d68d36" ON public.payment USING btree (swap_id);


--
-- Name: IDX_c2c0f3edf39515bd15432afe6e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_c2c0f3edf39515bd15432afe6e" ON public.claim_item_tags USING btree (item_id);


--
-- Name: IDX_c49c061b1a686843c5d673506f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_c49c061b1a686843c5d673506f" ON public.oauth USING btree (application_name);


--
-- Name: IDX_c4c3a5225a7a1f0af782c40abc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_c4c3a5225a7a1f0af782c40abc" ON public.customer_group USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: IDX_c5516f550433c9b1c2630d787a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_c5516f550433c9b1c2630d787a" ON public.price_list_customer_groups USING btree (customer_group_id);


--
-- Name: IDX_c556e14eff4d6f03db593df955; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_c556e14eff4d6f03db593df955" ON public.region_fulfillment_providers USING btree (region_id);


--
-- Name: IDX_c759f53b2e48e8cfb50638fe4e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_c759f53b2e48e8cfb50638fe4e" ON public.discount_condition_product USING btree (product_id);


--
-- Name: IDX_c951439af4c98bf2bd7fb8726c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_c951439af4c98bf2bd7fb8726c" ON public.shipping_option USING btree (profile_id);


--
-- Name: IDX_c99a206eb11ad45f6b7f04f2dc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_c99a206eb11ad45f6b7f04f2dc" ON public."order" USING btree (cart_id);


--
-- Name: IDX_ca67dd080aac5ecf99609960cd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_ca67dd080aac5ecf99609960cd" ON public.product_variant USING btree (product_id);


--
-- Name: IDX_cd7812c96209c5bdd48a6b858b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_cd7812c96209c5bdd48a6b858b" ON public."order" USING btree (customer_id);


--
-- Name: IDX_ced15a9a695d2b5db9dabce763; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_ced15a9a695d2b5db9dabce763" ON public.cart USING btree (shipping_address_id);


--
-- Name: IDX_cf9cc6c3f2e6414b992223fff1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_cf9cc6c3f2e6414b992223fff1" ON public.product USING btree (handle) WHERE (deleted_at IS NULL);


--
-- Name: IDX_d18ad72f2fb7c87f075825b6f8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_d18ad72f2fb7c87f075825b6f8" ON public.payment_session USING btree (provider_id);


--
-- Name: IDX_d25ba0787e1510ddc5d442ebcf; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_d25ba0787e1510ddc5d442ebcf" ON public.payment_session USING btree (cart_id);


--
-- Name: IDX_d38047a90f3d42f0be7909e8ae; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_d38047a90f3d42f0be7909e8ae" ON public.cart_gift_cards USING btree (cart_id);


--
-- Name: IDX_d4bd17f918fc6c332b74a368c3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_d4bd17f918fc6c332b74a368c3" ON public.return USING btree (order_id);


--
-- Name: IDX_d73e55964e0ff2db8f03807d52; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_d73e55964e0ff2db8f03807d52" ON public.fulfillment USING btree (claim_order_id);


--
-- Name: IDX_d783a66d1c91c0858752c933e6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_d783a66d1c91c0858752c933e6" ON public.shipping_method USING btree (claim_order_id);


--
-- Name: IDX_d7d441b81012f87d4265fa57d2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_d7d441b81012f87d4265fa57d2" ON public.gift_card_transaction USING btree (order_id);


--
-- Name: IDX_d92993a7d554d84571f4eea1d1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_d92993a7d554d84571f4eea1d1" ON public.shipping_method USING btree (cart_id);


--
-- Name: IDX_dc9bbf9fcb9ba458d25d512811; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_dc9bbf9fcb9ba458d25d512811" ON public.claim_item_tags USING btree (tag_id);


--
-- Name: IDX_df1494d263740fcfb1d09a98fc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_df1494d263740fcfb1d09a98fc" ON public.notification USING btree (resource_type);


--
-- Name: IDX_dfc1f02bb0552e79076aa58dbb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_dfc1f02bb0552e79076aa58dbb" ON public.gift_card USING btree (order_id);


--
-- Name: IDX_e1fcce2b18dbcdbe0a5ba9a68b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_e1fcce2b18dbcdbe0a5ba9a68b" ON public."order" USING btree (region_id);


--
-- Name: IDX_e62ff11e4730bb3adfead979ee; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_e62ff11e4730bb3adfead979ee" ON public.order_gift_cards USING btree (order_id);


--
-- Name: IDX_e706deb68f52ab2756119b9e70; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_e706deb68f52ab2756119b9e70" ON public.discount_condition_product_type USING btree (product_type_id);


--
-- Name: IDX_e78901b1131eaf8203d9b1cb5f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_e78901b1131eaf8203d9b1cb5f" ON public.country USING btree (iso_2);


--
-- Name: IDX_e7b488cebe333f449398769b2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_e7b488cebe333f449398769b2c" ON public.order_discounts USING btree (order_id);


--
-- Name: IDX_e87cc617a22ef4edce5601edab; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_e87cc617a22ef4edce5601edab" ON public.draft_order USING btree (display_id);


--
-- Name: IDX_ea6a358d9ce41c16499aae55f9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_ea6a358d9ce41c16499aae55f9" ON public.notification USING btree (resource_id);


--
-- Name: IDX_ea94f42b6c88e9191c3649d752; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_ea94f42b6c88e9191c3649d752" ON public.payment USING btree (provider_id);


--
-- Name: IDX_ec10c54769877840c132260e4a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_ec10c54769877840c132260e4a" ON public.claim_tag USING btree (value);


--
-- Name: IDX_ece65a774192b34253abc4cd67; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_ece65a774192b34253abc4cd67" ON public.product_type_tax_rate USING btree (rate_id);


--
-- Name: IDX_eec9d9af4ca098e19ea6b499ea; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_eec9d9af4ca098e19ea6b499ea" ON public.refund USING btree (order_id);


--
-- Name: IDX_efff700651718e452ca9580a62; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_efff700651718e452ca9580a62" ON public.discount_condition USING btree (discount_rule_id);


--
-- Name: IDX_f05132301e95bdab4ba1cf29a2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_f05132301e95bdab4ba1cf29a2" ON public.discount_condition_product USING btree (condition_id);


--
-- Name: IDX_f129acc85e346a10eed12b86fc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_f129acc85e346a10eed12b86fc" ON public.fulfillment USING btree (order_id);


--
-- Name: IDX_f2bb9f71e95b315eb24b2b84cb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_f2bb9f71e95b315eb24b2b84cb" ON public.order_gift_cards USING btree (gift_card_id);


--
-- Name: IDX_f4194aa81073f3fab8aa86906f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_f4194aa81073f3fab8aa86906f" ON public.discount_regions USING btree (discount_id);


--
-- Name: IDX_f49e3974465d3c3a33d449d3f3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_f49e3974465d3c3a33d449d3f3" ON public.claim_order USING btree (order_id);


--
-- Name: IDX_f5221735ace059250daac9d980; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_f5221735ace059250daac9d980" ON public.payment USING btree (order_id);


--
-- Name: IDX_f65bf52e2239ace276ece2b2f4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_f65bf52e2239ace276ece2b2f4" ON public.discount USING btree (code) WHERE (deleted_at IS NULL);


--
-- Name: IDX_f672727ab020df6c50fb64c1a7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_f672727ab020df6c50fb64c1a7" ON public.shipping_tax_rate USING btree (shipping_option_id);


--
-- Name: IDX_f74980b411cf94af523a72af7d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_f74980b411cf94af523a72af7d" ON public.note USING btree (resource_type);


--
-- Name: IDX_fb94fa8d5ca940daa2a58139f8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_fb94fa8d5ca940daa2a58139f8" ON public.shipping_method USING btree (swap_id);


--
-- Name: IDX_fbb2499551ed074526f3ee3624; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_fbb2499551ed074526f3ee3624" ON public.discount_condition_product_tag USING btree (condition_id);


--
-- Name: IDX_fc963e94854bff2714ca84cd19; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_fc963e94854bff2714ca84cd19" ON public.shipping_method USING btree (shipping_option_id);


--
-- Name: IDX_money_amount_currency_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_money_amount_currency_code" ON public.money_amount USING btree (currency_code);


--
-- Name: IDX_order_currency_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_currency_code" ON public."order" USING btree (currency_code);


--
-- Name: IDX_order_edit_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_edit_order_id" ON public.order_edit USING btree (order_id);


--
-- Name: IDX_order_edit_payment_collection_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_order_edit_payment_collection_id" ON public.order_edit USING btree (payment_collection_id);


--
-- Name: IDX_payment_collection_currency_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_payment_collection_currency_code" ON public.payment_collection USING btree (currency_code) WHERE (deleted_at IS NULL);


--
-- Name: IDX_payment_collection_payments_payment_collection_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_payment_collection_payments_payment_collection_id" ON public.payment_collection_payments USING btree (payment_collection_id);


--
-- Name: IDX_payment_collection_payments_payment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_payment_collection_payments_payment_id" ON public.payment_collection_payments USING btree (payment_id);


--
-- Name: IDX_payment_collection_region_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_payment_collection_region_id" ON public.payment_collection USING btree (region_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_payment_collection_sessions_payment_collection_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_payment_collection_sessions_payment_collection_id" ON public.payment_collection_sessions USING btree (payment_collection_id);


--
-- Name: IDX_payment_collection_sessions_payment_session_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_payment_collection_sessions_payment_session_id" ON public.payment_collection_sessions USING btree (payment_session_id);


--
-- Name: IDX_payment_currency_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_payment_currency_code" ON public.payment USING btree (currency_code);


--
-- Name: IDX_pcp_product_category_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_pcp_product_category_id" ON public.product_category_product USING btree (product_category_id);


--
-- Name: IDX_pcp_product_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_pcp_product_id" ON public.product_category_product USING btree (product_id);


--
-- Name: IDX_product_category_active_public; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_category_active_public" ON public.product_category USING btree (parent_category_id, is_active, is_internal) WHERE ((is_active IS TRUE) AND (is_internal IS FALSE));


--
-- Name: IDX_product_category_handle; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_product_category_handle" ON public.product_category USING btree (handle);


--
-- Name: IDX_product_category_path; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_category_path" ON public.product_category USING btree (mpath);


--
-- Name: IDX_product_variant_inventory_item_inventory_item_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_variant_inventory_item_inventory_item_id" ON public.product_variant_inventory_item USING btree (inventory_item_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_product_variant_inventory_item_variant_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_product_variant_inventory_item_variant_id" ON public.product_variant_inventory_item USING btree (variant_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_refund_payment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_refund_payment_id" ON public.refund USING btree (payment_id);


--
-- Name: IDX_region_currency_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_region_currency_code" ON public.region USING btree (currency_code);


--
-- Name: IDX_return_reason_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_return_reason_value" ON public.return_reason USING btree (value) WHERE (deleted_at IS NULL);


--
-- Name: IDX_sales_channel_location_location_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_sales_channel_location_location_id" ON public.sales_channel_location USING btree (location_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_sales_channel_location_sales_channel_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_sales_channel_location_sales_channel_id" ON public.sales_channel_location USING btree (sales_channel_id) WHERE (deleted_at IS NULL);


--
-- Name: IDX_upcp_product_id_product_category_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_upcp_product_id_product_category_id" ON public.product_category_product USING btree (product_category_id, product_id);


--
-- Name: UniqPaymentSessionCartIdProviderId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "UniqPaymentSessionCartIdProviderId" ON public.payment_session USING btree (cart_id, provider_id) WHERE (cart_id IS NOT NULL);


--
-- Name: UniqProductCategoryParentIdRank; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "UniqProductCategoryParentIdRank" ON public.product_category USING btree (parent_category_id, rank);


--
-- Name: UniquePaymentActive; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "UniquePaymentActive" ON public.payment USING btree (cart_id) WHERE (canceled_at IS NULL);


--
-- Name: idx_gin_product_collection; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_gin_product_collection ON public.product_collection USING gin (title public.gin_trgm_ops) WHERE (deleted_at IS NULL);


--
-- Name: idx_gin_product_description; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_gin_product_description ON public.product USING gin (description public.gin_trgm_ops) WHERE (deleted_at IS NULL);


--
-- Name: idx_gin_product_title; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_gin_product_title ON public.product USING gin (title public.gin_trgm_ops) WHERE (deleted_at IS NULL);


--
-- Name: idx_gin_product_variant_sku; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_gin_product_variant_sku ON public.product_variant USING gin (sku public.gin_trgm_ops) WHERE (deleted_at IS NULL);


--
-- Name: idx_gin_product_variant_title; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_gin_product_variant_title ON public.product_variant USING gin (title public.gin_trgm_ops) WHERE (deleted_at IS NULL);


--
-- Name: idx_money_amount_region_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_money_amount_region_id ON public.money_amount USING btree (region_id);


--
-- Name: idx_product_option_value_option_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_product_option_value_option_id ON public.product_option_value USING btree (option_id);


--
-- Name: idx_product_option_value_variant_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_product_option_value_variant_id ON public.product_option_value USING btree (variant_id);


--
-- Name: idx_product_shipping_profile_product_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_product_shipping_profile_product_id ON public.product_shipping_profile USING btree (product_id);


--
-- Name: idx_product_shipping_profile_profile_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_product_shipping_profile_profile_id ON public.product_shipping_profile USING btree (profile_id);


--
-- Name: idx_product_shipping_profile_profile_id_product_id_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_product_shipping_profile_profile_id_product_id_unique ON public.product_shipping_profile USING btree (profile_id, product_id);


--
-- Name: idx_product_variant_money_amount_money_amount_id_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_product_variant_money_amount_money_amount_id_unique ON public.product_variant_money_amount USING btree (money_amount_id);


--
-- Name: idx_product_variant_money_amount_variant_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_product_variant_money_amount_variant_id ON public.product_variant_money_amount USING btree (variant_id);


--
-- Name: unique_li_original_item_id_order_edit_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unique_li_original_item_id_order_edit_id ON public.line_item USING btree (order_edit_id, original_item_id) WHERE ((original_item_id IS NOT NULL) AND (order_edit_id IS NOT NULL));


--
-- Name: shipping_option_requirement FK_012a62ba743e427b5ebe9dee18e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_option_requirement
    ADD CONSTRAINT "FK_012a62ba743e427b5ebe9dee18e" FOREIGN KEY (shipping_option_id) REFERENCES public.shipping_option(id);


--
-- Name: discount_condition_product_tag FK_01486cc9dc6b36bf658685535f6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_condition_product_tag
    ADD CONSTRAINT "FK_01486cc9dc6b36bf658685535f6" FOREIGN KEY (product_tag_id) REFERENCES public.product_tag(id) ON DELETE CASCADE;


--
-- Name: claim_order FK_017d58bf8260c6e1a2588d258e2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.claim_order
    ADD CONSTRAINT "FK_017d58bf8260c6e1a2588d258e2" FOREIGN KEY (shipping_address_id) REFERENCES public.address(id);


--
-- Name: notification FK_0425c2423e2ce9fdfd5c23761d9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT "FK_0425c2423e2ce9fdfd5c23761d9" FOREIGN KEY (provider_id) REFERENCES public.notification_provider(id);


--
-- Name: cart_gift_cards FK_0fb38b6d167793192bc126d835e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_gift_cards
    ADD CONSTRAINT "FK_0fb38b6d167793192bc126d835e" FOREIGN KEY (gift_card_id) REFERENCES public.gift_card(id) ON DELETE CASCADE;


--
-- Name: order_discounts FK_0fc1ec4e3db9001ad60c19daf16; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_discounts
    ADD CONSTRAINT "FK_0fc1ec4e3db9001ad60c19daf16" FOREIGN KEY (discount_id) REFERENCES public.discount(id) ON DELETE CASCADE;


--
-- Name: line_item FK_118e3c48f09a7728f41023c94ef; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.line_item
    ADD CONSTRAINT "FK_118e3c48f09a7728f41023c94ef" FOREIGN KEY (claim_order_id) REFERENCES public.claim_order(id);


--
-- Name: order FK_19b0c6293443d1b464f604c3316; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "FK_19b0c6293443d1b464f604c3316" FOREIGN KEY (shipping_address_id) REFERENCES public.address(id);


--
-- Name: product_tax_rate FK_1d04aebeabb6a89f87e536a124d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_tax_rate
    ADD CONSTRAINT "FK_1d04aebeabb6a89f87e536a124d" FOREIGN KEY (product_id) REFERENCES public.product(id) ON DELETE CASCADE;


--
-- Name: shipping_method FK_1d9ad62038998c3a85c77a53cfb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_method
    ADD CONSTRAINT "FK_1d9ad62038998c3a85c77a53cfb" FOREIGN KEY (return_id) REFERENCES public.return(id);


--
-- Name: order_edit FK_1f3a251488a91510f57e1bf93cd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_edit
    ADD CONSTRAINT "FK_1f3a251488a91510f57e1bf93cd" FOREIGN KEY (order_id) REFERENCES public."order"(id);


--
-- Name: product_tags FK_21683a063fe82dafdf681ecc9c4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_tags
    ADD CONSTRAINT "FK_21683a063fe82dafdf681ecc9c4" FOREIGN KEY (product_tag_id) REFERENCES public.product_tag(id) ON DELETE CASCADE;


--
-- Name: claim_image FK_21cbfedd83d736d86f4c6f4ce56; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.claim_image
    ADD CONSTRAINT "FK_21cbfedd83d736d86f4c6f4ce56" FOREIGN KEY (claim_item_id) REFERENCES public.claim_item(id);


--
-- Name: product_images FK_2212515ba306c79f42c46a99db7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_images
    ADD CONSTRAINT "FK_2212515ba306c79f42c46a99db7" FOREIGN KEY (image_id) REFERENCES public.image(id) ON DELETE CASCADE;


--
-- Name: return_reason FK_2250c5d9e975987ab212f61a657; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.return_reason
    ADD CONSTRAINT "FK_2250c5d9e975987ab212f61a657" FOREIGN KEY (parent_return_reason_id) REFERENCES public.return_reason(id);


--
-- Name: discount FK_2250c5d9e975987ab212f61a663; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount
    ADD CONSTRAINT "FK_2250c5d9e975987ab212f61a663" FOREIGN KEY (parent_discount_id) REFERENCES public.discount(id);


--
-- Name: cart FK_242205c81c1152fab1b6e848470; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT "FK_242205c81c1152fab1b6e848470" FOREIGN KEY (customer_id) REFERENCES public.customer(id);


--
-- Name: product_tax_rate FK_2484cf14c437a04586b07e7dddb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_tax_rate
    ADD CONSTRAINT "FK_2484cf14c437a04586b07e7dddb" FOREIGN KEY (rate_id) REFERENCES public.tax_rate(id) ON DELETE CASCADE;


--
-- Name: product_type_tax_rate FK_25a3138bb236f63d9bb6c8ff111; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_type_tax_rate
    ADD CONSTRAINT "FK_25a3138bb236f63d9bb6c8ff111" FOREIGN KEY (product_type_id) REFERENCES public.product_type(id) ON DELETE CASCADE;


--
-- Name: line_item FK_27283ee631862266d0f1c680646; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.line_item
    ADD CONSTRAINT "FK_27283ee631862266d0f1c680646" FOREIGN KEY (cart_id) REFERENCES public.cart(id);


--
-- Name: line_item_adjustment FK_2f41b20a71f30e60471d7e3769c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.line_item_adjustment
    ADD CONSTRAINT "FK_2f41b20a71f30e60471d7e3769c" FOREIGN KEY (discount_id) REFERENCES public.discount(id);


--
-- Name: shipping_tax_rate FK_346e0016cf045b9980747747645; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_tax_rate
    ADD CONSTRAINT "FK_346e0016cf045b9980747747645" FOREIGN KEY (rate_id) REFERENCES public.tax_rate(id) ON DELETE CASCADE;


--
-- Name: notification FK_371db513192c083f48ba63c33be; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT "FK_371db513192c083f48ba63c33be" FOREIGN KEY (parent_id) REFERENCES public.notification(id);


--
-- Name: product_sales_channel FK_37341bad297fe5cca91f921032b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_sales_channel
    ADD CONSTRAINT "FK_37341bad297fe5cca91f921032b" FOREIGN KEY (sales_channel_id) REFERENCES public.sales_channel(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: region_fulfillment_providers FK_37f361c38a18d12a3fa3158d0cf; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.region_fulfillment_providers
    ADD CONSTRAINT "FK_37f361c38a18d12a3fa3158d0cf" FOREIGN KEY (provider_id) REFERENCES public.fulfillment_provider(id) ON DELETE CASCADE;


--
-- Name: region_payment_providers FK_3a6947180aeec283cd92c59ebb0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.region_payment_providers
    ADD CONSTRAINT "FK_3a6947180aeec283cd92c59ebb0" FOREIGN KEY (provider_id) REFERENCES public.payment_provider(id) ON DELETE CASCADE;


--
-- Name: region FK_3bdd5896ec93be2f1c62a3309a5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT "FK_3bdd5896ec93be2f1c62a3309a5" FOREIGN KEY (currency_code) REFERENCES public.currency(code);


--
-- Name: customer_group_customers FK_3c6412d076292f439269abe1a23; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_group_customers
    ADD CONSTRAINT "FK_3c6412d076292f439269abe1a23" FOREIGN KEY (customer_id) REFERENCES public.customer(id) ON DELETE CASCADE;


--
-- Name: line_item FK_3fa354d8d1233ff81097b2fcb6b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.line_item
    ADD CONSTRAINT "FK_3fa354d8d1233ff81097b2fcb6b" FOREIGN KEY (swap_id) REFERENCES public.swap(id);


--
-- Name: gift_card_transaction FK_3ff5597f1d7e02bba41541846f4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gift_card_transaction
    ADD CONSTRAINT "FK_3ff5597f1d7e02bba41541846f4" FOREIGN KEY (gift_card_id) REFERENCES public.gift_card(id);


--
-- Name: swap FK_402e8182bc553e082f6380020b4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.swap
    ADD CONSTRAINT "FK_402e8182bc553e082f6380020b4" FOREIGN KEY (cart_id) REFERENCES public.cart(id);


--
-- Name: line_item FK_43a2b24495fe1d9fc2a9c835bc7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.line_item
    ADD CONSTRAINT "FK_43a2b24495fe1d9fc2a9c835bc7" FOREIGN KEY (order_id) REFERENCES public."order"(id);


--
-- Name: custom_shipping_option FK_44090cb11b06174cbcc667e91ca; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.custom_shipping_option
    ADD CONSTRAINT "FK_44090cb11b06174cbcc667e91ca" FOREIGN KEY (shipping_option_id) REFERENCES public.shipping_option(id);


--
-- Name: order_item_change FK_44feeebb258bf4cfa4cc4202281; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item_change
    ADD CONSTRAINT "FK_44feeebb258bf4cfa4cc4202281" FOREIGN KEY (order_edit_id) REFERENCES public.order_edit(id);


--
-- Name: payment FK_4665f17abc1e81dd58330e58542; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT "FK_4665f17abc1e81dd58330e58542" FOREIGN KEY (cart_id) REFERENCES public.cart(id);


--
-- Name: tracking_link FK_471e9e4c96e02ba209a307db32b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tracking_link
    ADD CONSTRAINT "FK_471e9e4c96e02ba209a307db32b" FOREIGN KEY (fulfillment_id) REFERENCES public.fulfillment(id);


--
-- Name: cart FK_484c329f4783be4e18e5e2ff090; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT "FK_484c329f4783be4e18e5e2ff090" FOREIGN KEY (region_id) REFERENCES public.region(id);


--
-- Name: product FK_49d419fc77d3aed46c835c558ac; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT "FK_49d419fc77d3aed46c835c558ac" FOREIGN KEY (collection_id) REFERENCES public.product_collection(id);


--
-- Name: discount_condition_customer_group FK_4d5f98645a67545d8dea42e2eb8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_condition_customer_group
    ADD CONSTRAINT "FK_4d5f98645a67545d8dea42e2eb8" FOREIGN KEY (customer_group_id) REFERENCES public.customer_group(id) ON DELETE CASCADE;


--
-- Name: discount_rule_products FK_4e0739e5f0244c08d41174ca08a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_rule_products
    ADD CONSTRAINT "FK_4e0739e5f0244c08d41174ca08a" FOREIGN KEY (discount_rule_id) REFERENCES public.discount_rule(id) ON DELETE CASCADE;


--
-- Name: product_images FK_4f166bb8c2bfcef2498d97b4068; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_images
    ADD CONSTRAINT "FK_4f166bb8c2bfcef2498d97b4068" FOREIGN KEY (product_id) REFERENCES public.product(id) ON DELETE CASCADE;


--
-- Name: line_item_tax_line FK_5077fa54b0d037e984385dfe8ad; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.line_item_tax_line
    ADD CONSTRAINT "FK_5077fa54b0d037e984385dfe8ad" FOREIGN KEY (item_id) REFERENCES public.line_item(id) ON DELETE CASCADE;


--
-- Name: shipping_method FK_5267705a43d547e232535b656c2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_method
    ADD CONSTRAINT "FK_5267705a43d547e232535b656c2" FOREIGN KEY (order_id) REFERENCES public."order"(id);


--
-- Name: price_list_customer_groups FK_52875734e9dd69064f0041f4d92; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.price_list_customer_groups
    ADD CONSTRAINT "FK_52875734e9dd69064f0041f4d92" FOREIGN KEY (price_list_id) REFERENCES public.price_list(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: swap FK_52dd74e8c989aa5665ad2852b8b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.swap
    ADD CONSTRAINT "FK_52dd74e8c989aa5665ad2852b8b" FOREIGN KEY (order_id) REFERENCES public."order"(id);


--
-- Name: line_item FK_5371cbaa3be5200f373d24e3d5b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.line_item
    ADD CONSTRAINT "FK_5371cbaa3be5200f373d24e3d5b" FOREIGN KEY (variant_id) REFERENCES public.product_variant(id);


--
-- Name: order FK_5568d3b9ce9f7abeeb37511ecf2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "FK_5568d3b9ce9f7abeeb37511ecf2" FOREIGN KEY (billing_address_id) REFERENCES public.address(id);


--
-- Name: store FK_55beebaa09e947cccca554af222; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store
    ADD CONSTRAINT "FK_55beebaa09e947cccca554af222" FOREIGN KEY (default_currency_code) REFERENCES public.currency(code);


--
-- Name: product_tags FK_5b0c6fc53c574299ecc7f9ee22e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_tags
    ADD CONSTRAINT "FK_5b0c6fc53c574299ecc7f9ee22e" FOREIGN KEY (product_id) REFERENCES public.product(id) ON DELETE CASCADE;


--
-- Name: draft_order FK_5bd11d0e2a9628128e2c26fd0a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.draft_order
    ADD CONSTRAINT "FK_5bd11d0e2a9628128e2c26fd0a6" FOREIGN KEY (cart_id) REFERENCES public.cart(id);


--
-- Name: shipping_option FK_5c58105f1752fca0f4ce69f4663; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_option
    ADD CONSTRAINT "FK_5c58105f1752fca0f4ce69f4663" FOREIGN KEY (region_id) REFERENCES public.region(id);


--
-- Name: order_item_change FK_5f9688929761f7df108b630e64a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item_change
    ADD CONSTRAINT "FK_5f9688929761f7df108b630e64a" FOREIGN KEY (line_item_id) REFERENCES public.line_item(id);


--
-- Name: store FK_61b0f48cccbb5f41c750bac7286; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store
    ADD CONSTRAINT "FK_61b0f48cccbb5f41c750bac7286" FOREIGN KEY (default_sales_channel_id) REFERENCES public.sales_channel(id);


--
-- Name: customer_group_customers FK_620330964db8d2999e67b0dbe3e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_group_customers
    ADD CONSTRAINT "FK_620330964db8d2999e67b0dbe3e" FOREIGN KEY (customer_group_id) REFERENCES public.customer_group(id) ON DELETE CASCADE;


--
-- Name: claim_item FK_64980511ca32c8e92b417644afa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.claim_item
    ADD CONSTRAINT "FK_64980511ca32c8e92b417644afa" FOREIGN KEY (variant_id) REFERENCES public.product_variant(id);


--
-- Name: cart_discounts FK_6680319ebe1f46d18f106191d59; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_discounts
    ADD CONSTRAINT "FK_6680319ebe1f46d18f106191d59" FOREIGN KEY (cart_id) REFERENCES public.cart(id) ON DELETE CASCADE;


--
-- Name: cart FK_6b9c66b5e36f7c827dfaa092f94; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT "FK_6b9c66b5e36f7c827dfaa092f94" FOREIGN KEY (billing_address_id) REFERENCES public.address(id);


--
-- Name: address FK_6df8c6bf969a51d24c1980c4ff4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT "FK_6df8c6bf969a51d24c1980c4ff4" FOREIGN KEY (country_code) REFERENCES public.country(iso_2);


--
-- Name: claim_item FK_6e0cad0daef76bb642675910b9d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.claim_item
    ADD CONSTRAINT "FK_6e0cad0daef76bb642675910b9d" FOREIGN KEY (item_id) REFERENCES public.line_item(id);


--
-- Name: discount_condition_product_type FK_6ef23ce0b1d9cf9b5b833e52b9d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_condition_product_type
    ADD CONSTRAINT "FK_6ef23ce0b1d9cf9b5b833e52b9d" FOREIGN KEY (condition_id) REFERENCES public.discount_condition(id) ON DELETE CASCADE;


--
-- Name: order FK_6ff7e874f01b478c115fdd462eb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "FK_6ff7e874f01b478c115fdd462eb" FOREIGN KEY (sales_channel_id) REFERENCES public.sales_channel(id);


--
-- Name: return FK_71773d56eb2bacb922bc3283398; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.return
    ADD CONSTRAINT "FK_71773d56eb2bacb922bc3283398" FOREIGN KEY (claim_order_id) REFERENCES public.claim_order(id);


--
-- Name: order FK_717a141f96b76d794d409f38129; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "FK_717a141f96b76d794d409f38129" FOREIGN KEY (currency_code) REFERENCES public.currency(code);


--
-- Name: product_option_value FK_7234ed737ff4eb1b6ae6e6d7b01; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_option_value
    ADD CONSTRAINT "FK_7234ed737ff4eb1b6ae6e6d7b01" FOREIGN KEY (variant_id) REFERENCES public.product_variant(id) ON DELETE CASCADE;


--
-- Name: order FK_727b872f86c7378474a8fa46147; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "FK_727b872f86c7378474a8fa46147" FOREIGN KEY (draft_order_id) REFERENCES public.draft_order(id);


--
-- Name: return_item FK_7edab75b4fc88ea6d4f2574f087; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.return_item
    ADD CONSTRAINT "FK_7edab75b4fc88ea6d4f2574f087" FOREIGN KEY (return_id) REFERENCES public.return(id);


--
-- Name: store_currencies FK_82a6bbb0b527c20a0002ddcbd60; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_currencies
    ADD CONSTRAINT "FK_82a6bbb0b527c20a0002ddcbd60" FOREIGN KEY (currency_code) REFERENCES public.currency(code) ON DELETE CASCADE;


--
-- Name: discount_condition_customer_group FK_8486ee16e69013c645d0b8716b6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_condition_customer_group
    ADD CONSTRAINT "FK_8486ee16e69013c645d0b8716b6" FOREIGN KEY (condition_id) REFERENCES public.discount_condition(id) ON DELETE CASCADE;


--
-- Name: return_item FK_87774591f44564effd8039d7162; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.return_item
    ADD CONSTRAINT "FK_87774591f44564effd8039d7162" FOREIGN KEY (item_id) REFERENCES public.line_item(id);


--
-- Name: region_payment_providers FK_8aaa78ba90d3802edac317df869; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.region_payment_providers
    ADD CONSTRAINT "FK_8aaa78ba90d3802edac317df869" FOREIGN KEY (region_id) REFERENCES public.region(id) ON DELETE CASCADE;


--
-- Name: customer FK_8abe81b9aac151ae60bf507ad15; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT "FK_8abe81b9aac151ae60bf507ad15" FOREIGN KEY (billing_address_id) REFERENCES public.address(id);


--
-- Name: cart_discounts FK_8df75ef4f35f217768dc1135458; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_discounts
    ADD CONSTRAINT "FK_8df75ef4f35f217768dc1135458" FOREIGN KEY (discount_id) REFERENCES public.discount(id) ON DELETE CASCADE;


--
-- Name: draft_order FK_8f6dd6c49202f1466ebf21e77da; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.draft_order
    ADD CONSTRAINT "FK_8f6dd6c49202f1466ebf21e77da" FOREIGN KEY (order_id) REFERENCES public."order"(id);


--
-- Name: claim_item FK_900a9c3834257304396b2b0fe7c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.claim_item
    ADD CONSTRAINT "FK_900a9c3834257304396b2b0fe7c" FOREIGN KEY (claim_order_id) REFERENCES public.claim_order(id);


--
-- Name: region FK_91f88052197680f9790272aaf5b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT "FK_91f88052197680f9790272aaf5b" FOREIGN KEY (tax_provider_id) REFERENCES public.tax_provider(id);


--
-- Name: shipping_method_tax_line FK_926ca9f29014af8091722dede08; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_method_tax_line
    ADD CONSTRAINT "FK_926ca9f29014af8091722dede08" FOREIGN KEY (shipping_method_id) REFERENCES public.shipping_method(id);


--
-- Name: custom_shipping_option FK_93caeb1bb70d37c1d36d6701a7a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.custom_shipping_option
    ADD CONSTRAINT "FK_93caeb1bb70d37c1d36d6701a7a" FOREIGN KEY (cart_id) REFERENCES public.cart(id);


--
-- Name: address FK_9c9614b2f9d01665800ea8dbff7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT "FK_9c9614b2f9d01665800ea8dbff7" FOREIGN KEY (customer_id) REFERENCES public.customer(id);


--
-- Name: cart FK_9d1a161434c610aae7c3df2dc7e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT "FK_9d1a161434c610aae7c3df2dc7e" FOREIGN KEY (payment_id) REFERENCES public.payment(id);


--
-- Name: fulfillment_item FK_a033f83cc6bd7701a5687ab4b38; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fulfillment_item
    ADD CONSTRAINT "FK_a033f83cc6bd7701a5687ab4b38" FOREIGN KEY (fulfillment_id) REFERENCES public.fulfillment(id);


--
-- Name: discount_condition_product_collection FK_a0b05dc4257abe639cb75f8eae2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_condition_product_collection
    ADD CONSTRAINT "FK_a0b05dc4257abe639cb75f8eae2" FOREIGN KEY (product_collection_id) REFERENCES public.product_collection(id) ON DELETE CASCADE;


--
-- Name: shipping_option FK_a0e206bfaed3cb63c1860917347; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_option
    ADD CONSTRAINT "FK_a0e206bfaed3cb63c1860917347" FOREIGN KEY (provider_id) REFERENCES public.fulfillment_provider(id);


--
-- Name: discount_condition_product_collection FK_a1c4f9cfb599ad1f0db39cadd5f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_condition_product_collection
    ADD CONSTRAINT "FK_a1c4f9cfb599ad1f0db39cadd5f" FOREIGN KEY (condition_id) REFERENCES public.discount_condition(id) ON DELETE CASCADE;


--
-- Name: discount_regions FK_a21a7ffbe420d492eb46c305fec; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_regions
    ADD CONSTRAINT "FK_a21a7ffbe420d492eb46c305fec" FOREIGN KEY (region_id) REFERENCES public.region(id) ON DELETE CASCADE;


--
-- Name: cart FK_a2bd3c26f42e754b9249ba78fd6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT "FK_a2bd3c26f42e754b9249ba78fd6" FOREIGN KEY (sales_channel_id) REFERENCES public.sales_channel(id);


--
-- Name: fulfillment FK_a52e234f729db789cf473297a5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fulfillment
    ADD CONSTRAINT "FK_a52e234f729db789cf473297a5c" FOREIGN KEY (swap_id) REFERENCES public.swap(id);


--
-- Name: discount FK_ac2c280de3701b2d66f6817f760; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount
    ADD CONSTRAINT "FK_ac2c280de3701b2d66f6817f760" FOREIGN KEY (rule_id) REFERENCES public.discount_rule(id);


--
-- Name: country FK_b1aac8314662fa6b25569a575bb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT "FK_b1aac8314662fa6b25569a575bb" FOREIGN KEY (region_id) REFERENCES public.region(id);


--
-- Name: money_amount FK_b433e27b7a83e6d12ab26b15b03; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.money_amount
    ADD CONSTRAINT "FK_b433e27b7a83e6d12ab26b15b03" FOREIGN KEY (region_id) REFERENCES public.region(id);


--
-- Name: order_item_change FK_b4d53b8d03c9f5e7d4317e818d9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item_change
    ADD CONSTRAINT "FK_b4d53b8d03c9f5e7d4317e818d9" FOREIGN KEY (original_line_item_id) REFERENCES public.line_item(id);


--
-- Name: store_currencies FK_b4f4b63d1736689b7008980394c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_currencies
    ADD CONSTRAINT "FK_b4f4b63d1736689b7008980394c" FOREIGN KEY (store_id) REFERENCES public.store(id) ON DELETE CASCADE;


--
-- Name: notification FK_b5df0f53a74b9d0c0a2b652c88d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT "FK_b5df0f53a74b9d0c0a2b652c88d" FOREIGN KEY (customer_id) REFERENCES public.customer(id);


--
-- Name: gift_card FK_b6bcf8c3903097b84e85154eed3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gift_card
    ADD CONSTRAINT "FK_b6bcf8c3903097b84e85154eed3" FOREIGN KEY (region_id) REFERENCES public.region(id);


--
-- Name: tax_rate FK_b95a1e03b051993d208366cb960; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_rate
    ADD CONSTRAINT "FK_b95a1e03b051993d208366cb960" FOREIGN KEY (region_id) REFERENCES public.region(id);


--
-- Name: return FK_bad82d7bff2b08b87094bfac3d6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.return
    ADD CONSTRAINT "FK_bad82d7bff2b08b87094bfac3d6" FOREIGN KEY (swap_id) REFERENCES public.swap(id);


--
-- Name: discount_rule_products FK_be66106a673b88a81c603abe7eb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_rule_products
    ADD CONSTRAINT "FK_be66106a673b88a81c603abe7eb" FOREIGN KEY (product_id) REFERENCES public.product(id) ON DELETE CASCADE;


--
-- Name: line_item_adjustment FK_be9aea2ccf3567007b6227da4d2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.line_item_adjustment
    ADD CONSTRAINT "FK_be9aea2ccf3567007b6227da4d2" FOREIGN KEY (item_id) REFERENCES public.line_item(id) ON DELETE CASCADE;


--
-- Name: fulfillment FK_beb35a6de60a6c4f91d5ae57e44; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fulfillment
    ADD CONSTRAINT "FK_beb35a6de60a6c4f91d5ae57e44" FOREIGN KEY (provider_id) REFERENCES public.fulfillment_provider(id);


--
-- Name: payment FK_c17aff091441b7c25ec3d68d36c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT "FK_c17aff091441b7c25ec3d68d36c" FOREIGN KEY (swap_id) REFERENCES public.swap(id);


--
-- Name: claim_item_tags FK_c2c0f3edf39515bd15432afe6e5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.claim_item_tags
    ADD CONSTRAINT "FK_c2c0f3edf39515bd15432afe6e5" FOREIGN KEY (item_id) REFERENCES public.claim_item(id) ON DELETE CASCADE;


--
-- Name: price_list_customer_groups FK_c5516f550433c9b1c2630d787a7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.price_list_customer_groups
    ADD CONSTRAINT "FK_c5516f550433c9b1c2630d787a7" FOREIGN KEY (customer_group_id) REFERENCES public.customer_group(id) ON DELETE CASCADE;


--
-- Name: region_fulfillment_providers FK_c556e14eff4d6f03db593df955e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.region_fulfillment_providers
    ADD CONSTRAINT "FK_c556e14eff4d6f03db593df955e" FOREIGN KEY (region_id) REFERENCES public.region(id) ON DELETE CASCADE;


--
-- Name: discount_condition_product FK_c759f53b2e48e8cfb50638fe4e0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_condition_product
    ADD CONSTRAINT "FK_c759f53b2e48e8cfb50638fe4e0" FOREIGN KEY (product_id) REFERENCES public.product(id) ON DELETE CASCADE;


--
-- Name: shipping_option FK_c951439af4c98bf2bd7fb8726cd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_option
    ADD CONSTRAINT "FK_c951439af4c98bf2bd7fb8726cd" FOREIGN KEY (profile_id) REFERENCES public.shipping_profile(id);


--
-- Name: order FK_c99a206eb11ad45f6b7f04f2dcc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "FK_c99a206eb11ad45f6b7f04f2dcc" FOREIGN KEY (cart_id) REFERENCES public.cart(id);


--
-- Name: product_variant FK_ca67dd080aac5ecf99609960cd2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_variant
    ADD CONSTRAINT "FK_ca67dd080aac5ecf99609960cd2" FOREIGN KEY (product_id) REFERENCES public.product(id);


--
-- Name: order FK_cd7812c96209c5bdd48a6b858b0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "FK_cd7812c96209c5bdd48a6b858b0" FOREIGN KEY (customer_id) REFERENCES public.customer(id);


--
-- Name: product_option_value FK_cdf4388f294b30a25c627d69fe9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_option_value
    ADD CONSTRAINT "FK_cdf4388f294b30a25c627d69fe9" FOREIGN KEY (option_id) REFERENCES public.product_option(id);


--
-- Name: cart FK_ced15a9a695d2b5db9dabce763d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT "FK_ced15a9a695d2b5db9dabce763d" FOREIGN KEY (shipping_address_id) REFERENCES public.address(id);


--
-- Name: payment_session FK_d25ba0787e1510ddc5d442ebcfa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_session
    ADD CONSTRAINT "FK_d25ba0787e1510ddc5d442ebcfa" FOREIGN KEY (cart_id) REFERENCES public.cart(id);


--
-- Name: cart_gift_cards FK_d38047a90f3d42f0be7909e8aea; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_gift_cards
    ADD CONSTRAINT "FK_d38047a90f3d42f0be7909e8aea" FOREIGN KEY (cart_id) REFERENCES public.cart(id) ON DELETE CASCADE;


--
-- Name: return FK_d4bd17f918fc6c332b74a368c36; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.return
    ADD CONSTRAINT "FK_d4bd17f918fc6c332b74a368c36" FOREIGN KEY (order_id) REFERENCES public."order"(id);


--
-- Name: fulfillment FK_d73e55964e0ff2db8f03807d52e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fulfillment
    ADD CONSTRAINT "FK_d73e55964e0ff2db8f03807d52e" FOREIGN KEY (claim_order_id) REFERENCES public.claim_order(id);


--
-- Name: return_item FK_d742532378a65022e7ceb328828; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.return_item
    ADD CONSTRAINT "FK_d742532378a65022e7ceb328828" FOREIGN KEY (reason_id) REFERENCES public.return_reason(id);


--
-- Name: shipping_method FK_d783a66d1c91c0858752c933e68; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_method
    ADD CONSTRAINT "FK_d783a66d1c91c0858752c933e68" FOREIGN KEY (claim_order_id) REFERENCES public.claim_order(id);


--
-- Name: gift_card_transaction FK_d7d441b81012f87d4265fa57d24; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gift_card_transaction
    ADD CONSTRAINT "FK_d7d441b81012f87d4265fa57d24" FOREIGN KEY (order_id) REFERENCES public."order"(id);


--
-- Name: shipping_method FK_d92993a7d554d84571f4eea1d13; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_method
    ADD CONSTRAINT "FK_d92993a7d554d84571f4eea1d13" FOREIGN KEY (cart_id) REFERENCES public.cart(id);


--
-- Name: claim_item_tags FK_dc9bbf9fcb9ba458d25d512811b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.claim_item_tags
    ADD CONSTRAINT "FK_dc9bbf9fcb9ba458d25d512811b" FOREIGN KEY (tag_id) REFERENCES public.claim_tag(id) ON DELETE CASCADE;


--
-- Name: gift_card FK_dfc1f02bb0552e79076aa58dbb0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gift_card
    ADD CONSTRAINT "FK_dfc1f02bb0552e79076aa58dbb0" FOREIGN KEY (order_id) REFERENCES public."order"(id);


--
-- Name: product FK_e0843930fbb8854fe36ca39dae1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT "FK_e0843930fbb8854fe36ca39dae1" FOREIGN KEY (type_id) REFERENCES public.product_type(id);


--
-- Name: fulfillment_item FK_e13ff60e74206b747a1896212d1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fulfillment_item
    ADD CONSTRAINT "FK_e13ff60e74206b747a1896212d1" FOREIGN KEY (item_id) REFERENCES public.line_item(id);


--
-- Name: money_amount FK_e15811f81339e4bd8c440aebe1c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.money_amount
    ADD CONSTRAINT "FK_e15811f81339e4bd8c440aebe1c" FOREIGN KEY (currency_code) REFERENCES public.currency(code);


--
-- Name: order FK_e1fcce2b18dbcdbe0a5ba9a68b8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "FK_e1fcce2b18dbcdbe0a5ba9a68b8" FOREIGN KEY (region_id) REFERENCES public.region(id);


--
-- Name: order_gift_cards FK_e62ff11e4730bb3adfead979ee2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_gift_cards
    ADD CONSTRAINT "FK_e62ff11e4730bb3adfead979ee2" FOREIGN KEY (order_id) REFERENCES public."order"(id) ON DELETE CASCADE;


--
-- Name: product_option FK_e634fca34f6b594b87fdbee95f6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_option
    ADD CONSTRAINT "FK_e634fca34f6b594b87fdbee95f6" FOREIGN KEY (product_id) REFERENCES public.product(id);


--
-- Name: discount_condition_product_type FK_e706deb68f52ab2756119b9e704; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_condition_product_type
    ADD CONSTRAINT "FK_e706deb68f52ab2756119b9e704" FOREIGN KEY (product_type_id) REFERENCES public.product_type(id) ON DELETE CASCADE;


--
-- Name: order_discounts FK_e7b488cebe333f449398769b2cc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_discounts
    ADD CONSTRAINT "FK_e7b488cebe333f449398769b2cc" FOREIGN KEY (order_id) REFERENCES public."order"(id) ON DELETE CASCADE;


--
-- Name: product_type_tax_rate FK_ece65a774192b34253abc4cd672; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_type_tax_rate
    ADD CONSTRAINT "FK_ece65a774192b34253abc4cd672" FOREIGN KEY (rate_id) REFERENCES public.tax_rate(id) ON DELETE CASCADE;


--
-- Name: refund FK_eec9d9af4ca098e19ea6b499eaa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refund
    ADD CONSTRAINT "FK_eec9d9af4ca098e19ea6b499eaa" FOREIGN KEY (order_id) REFERENCES public."order"(id);


--
-- Name: discount_condition FK_efff700651718e452ca9580a624; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_condition
    ADD CONSTRAINT "FK_efff700651718e452ca9580a624" FOREIGN KEY (discount_rule_id) REFERENCES public.discount_rule(id);


--
-- Name: discount_condition_product FK_f05132301e95bdab4ba1cf29a24; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_condition_product
    ADD CONSTRAINT "FK_f05132301e95bdab4ba1cf29a24" FOREIGN KEY (condition_id) REFERENCES public.discount_condition(id) ON DELETE CASCADE;


--
-- Name: fulfillment FK_f129acc85e346a10eed12b86fca; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fulfillment
    ADD CONSTRAINT "FK_f129acc85e346a10eed12b86fca" FOREIGN KEY (order_id) REFERENCES public."order"(id);


--
-- Name: money_amount FK_f249976b079375499662eb80c40; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.money_amount
    ADD CONSTRAINT "FK_f249976b079375499662eb80c40" FOREIGN KEY (price_list_id) REFERENCES public.price_list(id) ON DELETE CASCADE;


--
-- Name: order_gift_cards FK_f2bb9f71e95b315eb24b2b84cb3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_gift_cards
    ADD CONSTRAINT "FK_f2bb9f71e95b315eb24b2b84cb3" FOREIGN KEY (gift_card_id) REFERENCES public.gift_card(id) ON DELETE CASCADE;


--
-- Name: payment FK_f41553459a4b1491c9893ebc921; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT "FK_f41553459a4b1491c9893ebc921" FOREIGN KEY (currency_code) REFERENCES public.currency(code);


--
-- Name: discount_regions FK_f4194aa81073f3fab8aa86906ff; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_regions
    ADD CONSTRAINT "FK_f4194aa81073f3fab8aa86906ff" FOREIGN KEY (discount_id) REFERENCES public.discount(id) ON DELETE CASCADE;


--
-- Name: claim_order FK_f49e3974465d3c3a33d449d3f31; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.claim_order
    ADD CONSTRAINT "FK_f49e3974465d3c3a33d449d3f31" FOREIGN KEY (order_id) REFERENCES public."order"(id);


--
-- Name: swap FK_f5189d38b3d3bd496618bf54c57; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.swap
    ADD CONSTRAINT "FK_f5189d38b3d3bd496618bf54c57" FOREIGN KEY (shipping_address_id) REFERENCES public.address(id);


--
-- Name: payment FK_f5221735ace059250daac9d9803; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT "FK_f5221735ace059250daac9d9803" FOREIGN KEY (order_id) REFERENCES public."order"(id);


--
-- Name: shipping_tax_rate FK_f672727ab020df6c50fb64c1a70; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_tax_rate
    ADD CONSTRAINT "FK_f672727ab020df6c50fb64c1a70" FOREIGN KEY (shipping_option_id) REFERENCES public.shipping_option(id) ON DELETE CASCADE;


--
-- Name: batch_job FK_fa53ca4f5fd90605b532802a626; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batch_job
    ADD CONSTRAINT "FK_fa53ca4f5fd90605b532802a626" FOREIGN KEY (created_by) REFERENCES public."user"(id);


--
-- Name: shipping_method FK_fb94fa8d5ca940daa2a58139f86; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_method
    ADD CONSTRAINT "FK_fb94fa8d5ca940daa2a58139f86" FOREIGN KEY (swap_id) REFERENCES public.swap(id);


--
-- Name: discount_condition_product_tag FK_fbb2499551ed074526f3ee36241; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_condition_product_tag
    ADD CONSTRAINT "FK_fbb2499551ed074526f3ee36241" FOREIGN KEY (condition_id) REFERENCES public.discount_condition(id) ON DELETE CASCADE;


--
-- Name: shipping_method FK_fc963e94854bff2714ca84cd193; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_method
    ADD CONSTRAINT "FK_fc963e94854bff2714ca84cd193" FOREIGN KEY (shipping_option_id) REFERENCES public.shipping_option(id);


--
-- Name: order_edit FK_order_edit_payment_collection_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_edit
    ADD CONSTRAINT "FK_order_edit_payment_collection_id" FOREIGN KEY (payment_collection_id) REFERENCES public.payment_collection(id);


--
-- Name: payment_collection_payments FK_payment_collection_payments_payment_collection_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_collection_payments
    ADD CONSTRAINT "FK_payment_collection_payments_payment_collection_id" FOREIGN KEY (payment_collection_id) REFERENCES public.payment_collection(id) ON DELETE CASCADE;


--
-- Name: payment_collection_payments FK_payment_collection_payments_payment_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_collection_payments
    ADD CONSTRAINT "FK_payment_collection_payments_payment_id" FOREIGN KEY (payment_id) REFERENCES public.payment(id) ON DELETE CASCADE;


--
-- Name: payment_collection FK_payment_collection_region_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_collection
    ADD CONSTRAINT "FK_payment_collection_region_id" FOREIGN KEY (region_id) REFERENCES public.region(id);


--
-- Name: payment_collection_sessions FK_payment_collection_sessions_payment_collection_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_collection_sessions
    ADD CONSTRAINT "FK_payment_collection_sessions_payment_collection_id" FOREIGN KEY (payment_collection_id) REFERENCES public.payment_collection(id) ON DELETE CASCADE;


--
-- Name: payment_collection_sessions FK_payment_collection_sessions_payment_session_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_collection_sessions
    ADD CONSTRAINT "FK_payment_collection_sessions_payment_session_id" FOREIGN KEY (payment_session_id) REFERENCES public.payment_session(id) ON DELETE CASCADE;


--
-- Name: product_category_product FK_product_category_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_category_product
    ADD CONSTRAINT "FK_product_category_id" FOREIGN KEY (product_category_id) REFERENCES public.product_category(id) ON DELETE CASCADE;


--
-- Name: product_category_product FK_product_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_category_product
    ADD CONSTRAINT "FK_product_id" FOREIGN KEY (product_id) REFERENCES public.product(id) ON DELETE CASCADE;


--
-- Name: refund FK_refund_payment_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refund
    ADD CONSTRAINT "FK_refund_payment_id" FOREIGN KEY (payment_id) REFERENCES public.payment(id);


--
-- Name: line_item line_item_order_edit_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.line_item
    ADD CONSTRAINT line_item_order_edit_fk FOREIGN KEY (order_edit_id) REFERENCES public.order_edit(id);


--
-- Name: line_item line_item_original_item_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.line_item
    ADD CONSTRAINT line_item_original_item_fk FOREIGN KEY (original_item_id) REFERENCES public.line_item(id);


--
-- PostgreSQL database dump complete
--

