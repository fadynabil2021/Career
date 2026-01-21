from fastapi import APIRouter , FastAPI , Depends 
from helper import get_settings , Settings 

router = APIRouter(
    prefix="/api/v1",
    tags=["/api/v1"],
)

@router.get("/" , dependencies=[Depends(get_settings)])
async def read_root(app_settings: Settings = Depends(get_settings)):
    app_name = app_settings.APP_NAME
    app_version = app_settings.APP_VERSION
    return {"app_name": app_name,
            "app_version": app_version}
