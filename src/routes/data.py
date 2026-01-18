from fastapi import APIRouter , FastAPI , Depends , UploadFile , status
from fastapi.responses import JSONResponse
from helper import get_settings , Settings 
from controllers import DataController , ProjectController
import os
import shutil
import aiofiles
from models import ResponceEnums


router = APIRouter(
    prefix="/api/v1/data",
    tags=["/api/v1" , "data"],
)
data_controller = DataController()
@router.post("/upload/{project_id}")
async def upload_file(project_id: str , file: UploadFile , app_settings: Settings = Depends(get_settings)):
    response = data_controller.upload_file(file = file ) 
    if not response["indicator"]:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST , content=response["message"])

    project_controller = ProjectController()
    project_dir_path   = project_controller.get_project_path(project_id = project_id)
    file_path = data_controller.gen_unique_filename(original_filename = file.filename , project_id = project_id)
    
    async with aiofiles.open(file_path , "wb") as buffer:
        while chunk := await file.read(app_settings.FILE_CHUNCK_SIZE):
            await buffer.write(chunk)
            
    return JSONResponse(status_code=status.HTTP_200_OK ,
                        content={"message": ResponceEnums.file_uploaded_successfully.value})