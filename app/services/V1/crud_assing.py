from sqlalchemy.orm import Session

from app.models.V1.user_api_model import (
    Association_User_Api_Rol,
    Association_Api_Rol,
    User,
    Api,
)

from app.utils.exeptions import (
    exception_api,
    exception_user,
    exception_int,
    exception_duplicate,
    exception_relation_api,
)


def creando_user_api_rol(db: Session, user_id: int, api_rol_id: int):
    if not isinstance(user_id, int) or not isinstance(api_rol_id, int):
        raise exception_int

    db_userid = db.query(User).filter(User.id == user_id).first()

    if not db_userid:
        raise exception_user

    db_api_rol_id = (
        db.query(Association_Api_Rol)
        .filter(Association_Api_Rol.id == api_rol_id)
        .first()
    )

    if not db_api_rol_id:
        raise exception_api

    try:
        db_user_api = Association_User_Api_Rol(
            user_id=db_userid.id,
            api_rol_id=db_api_rol_id.id,
        )

        db.add(db_user_api)
        db.commit()
        db.refresh(db_user_api)

    except:
        raise exception_duplicate

    return db_user_api


def delete_user_api_rol(db: Session, user_id: int, api_rol_id: int):
    if not isinstance(user_id, int) or not isinstance(api_rol_id, int):
        raise exception_int

    db_userid = db.query(User).filter(User.id == user_id).first()

    if not db_userid:
        raise exception_user

    db_api_rol_id = (
        db.query(Association_Api_Rol)
        .filter(Association_Api_Rol.id == api_rol_id)
        .first()
    )

    if not db_api_rol_id:
        raise exception_api
    try:
        delete_user_api_id = (
            db.query(Association_User_Api_Rol)
            .filter(
                Association_User_Api_Rol.user_id == db_userid.id,
                Association_User_Api_Rol.api_rol_id == db_api_rol_id.id,
            )
            .first()
        )
        db.delete(delete_user_api_id)
        db.commit()

    except:
        raise exception_relation_api

    return delete_user_api_id


def get_user_api_rol(db: Session, id_user: int):
    db_userid = (
        db.query(Association_User_Api_Rol)
        .filter(Association_User_Api_Rol.user_id == id_user)
        .first()
    )

    if not db_userid:
        raise exception_user

    datos = []

    # Construir la subconsulta
    subquery = (
        db.query(
            Association_Api_Rol.id.label("id"),
            Association_Api_Rol.api_id.label("api_id"),
        )
        .join(
            Association_User_Api_Rol,
            Association_Api_Rol.id == Association_User_Api_Rol.api_rol_id,
        )
        .distinct()
        .subquery()
    )

    # Construir la consulta principal
    stmt = (
        db.query(
            Association_User_Api_Rol.user_id,
            Association_User_Api_Rol.api_rol_id,
            Api.name_api,
            Association_User_Api_Rol.create_at,
            Association_User_Api_Rol.update_at,
        )
        .join(subquery, Api.id == subquery.c.api_id)
        .join(
            Association_User_Api_Rol,
            Association_User_Api_Rol.api_rol_id == subquery.c.id,
        )
        .filter(Association_User_Api_Rol.user_id == id_user)
    )

    for a, b, c, d, e in stmt:
        datos.append(
            {
                "id_user": a,
                "id_api": b,
                "name_api": c,
                "create_at": d,
                "update_at": e,
            }
        )

    return datos


def get_user_api(db: Session):
    db_userid = db.query(Association_User_Api_Rol).all()

    if not db_userid:
        raise exception_user

    return db_userid


def get_user(db: Session, user_id: int):
    db_userid = (
        db.query(Association_User_Api_Rol)
        .filter(Association_User_Api_Rol.user_id == user_id)
        .first()
    )

    if not db_userid:
        raise exception_user

    return db_userid


def get_api(db: Session, api_id: int):
    db_userid = (
        db.query(Association_User_Api_Rol)
        .outerjoin(
            Association_Api_Rol,
            Association_User_Api_Rol.api_rol_id == Association_Api_Rol.id,
        )
        .filter(Association_Api_Rol.api_id == api_id)
        .all()
    )

    return db_userid
