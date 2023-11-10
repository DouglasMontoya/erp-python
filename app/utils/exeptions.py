from fastapi import HTTPException, status

exception_permit_denied = HTTPException(
    status_code=status.HTTP_401_UNAUTHORIZED,
    detail="Permit denied.",
    headers=None,
)

exception_user = HTTPException(
    status_code=status.HTTP_404_NOT_FOUND,
    detail="User not found.",
    headers=None,
)


exception_rol = HTTPException(
    status_code=status.HTTP_404_NOT_FOUND,
    detail="Rol not found.",
    headers=None,
)

exception_permission = HTTPException(
    status_code=status.HTTP_404_NOT_FOUND,
    detail="Permission not found.",
    headers=None,
)

exception_institution = HTTPException(
    status_code=status.HTTP_404_NOT_FOUND,
    detail="Institution not found.",
    headers=None,
)

exception_api = exception = HTTPException(
    status_code=status.HTTP_404_NOT_FOUND,
    detail="API not found.",
    headers=None,
)


exception_creation = HTTPException(
    status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
    detail="Creation error. Try again later.",
    headers=None,
)

exception_int = HTTPException(
    status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
    detail="Validate your data.",
    headers=None,
)
exception_duplicate = HTTPException(
    status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
    detail="Duplicate data.",
    headers=None,
)
exception_relation_api = HTTPException(
    status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
    detail="Relation API not found.",
    headers=None,
)
