from fastapi import APIRouter , FastAPI
import os


router = APIRouter(
    prefix="/api/v1",
    tags=["/api/v1"],
)

@router.get("/")
async def read_root():
    app_name = os.getenv("APP_NAME")
    app_version = os.getenv("APP_VERSION")
    return {"app_name": app_name,
            "app_version": app_version}