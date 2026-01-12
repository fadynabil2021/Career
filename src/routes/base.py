from fastapi import APIRouter , FastAPI
from helper.config import get_settings

router = APIRouter(
    prefix="/api/v1",
    tags=["/api/v1"],
)

@router.get("/")
async def read_root():
    app_settings = get_settings() 
    app_name = app_settings.APP_NAME
    app_version = app_settings.APP_VERSION
    return {"app_name": app_name,
            "app_version": app_version}