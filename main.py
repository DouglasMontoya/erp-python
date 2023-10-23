from fastapi import FastAPI, responses
from app import (
    auth_route,
    user_route,
    debug_route,
    api_route,
    rol_route,
    permission_route,
    institution_route,
    assing_route,
)
from app.schemas.V1.config_scheme import EnvSettings
from metadata import tags_metadata

settings = EnvSettings()


app = FastAPI(title="AMS", version="0.0.7", openapi_tags=tags_metadata)


@app.get("/", include_in_schema=False)
def refirect_docs():
    return responses.RedirectResponse("/docs")


# Include API Routes
app.include_router(api_route, prefix="/api/v1", tags=["api"])
app.include_router(rol_route, prefix="/api/v1", tags=["rol"])
app.include_router(permission_route, prefix="/api/v1", tags=["permission"])
app.include_router(institution_route, prefix="/api/v1", tags=["institution"])
app.include_router(user_route, prefix="/api/v1", tags=["user"])
app.include_router(auth_route, prefix="/api/v1", tags=["auth"])
app.include_router(rol_route, prefix="/api/v1", tags=["rols"])
app.include_router(assing_route, prefix="/api/v1", tags=["assing"])


if settings.API_DEBUG:
    app.include_router(debug_route, prefix="/api/v1", tags=["debug"])


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(
        "main:app",
        host=settings.API_HOST,
        port=settings.API_PORT,
        log_level="info" if settings.API_DEBUG else "debug",
        reload=settings.API_DEBUG,
    )
