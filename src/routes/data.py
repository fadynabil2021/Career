from fastapi import APIRouter , FastAPI , Depends , UploadFile , status
from fastapi.responses import JSONResponse
from helper import get_settings , Settings 
from controllers import DataController , ProjectController
import os
import shutil
import aiofiles
from models import ResponceEnums
from .schemes import ProcessRequest


router = APIRouter(
    prefix="/api/v1/data",
    tags=["/api/v1" , "data"],
)
data_controller = DataController()
project_controller = ProjectController()

@router.post("/upload/{project_id}")
async def upload_file(project_id: str , file: UploadFile , app_settings: Settings = Depends(get_settings)):
    response = data_controller.upload_file(file = file ) 
    if not response["indicator"]:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST , content=response["message"])

    project_dir_path   = project_controller.get_project_path(project_id = project_id)
    file_path , filename = data_controller.gen_unique_filepath(original_filename = file.filename, project_id = project_id)
    
    try:
        async with aiofiles.open(file_path , "wb") as buffer:
            while chunk := await file.read(app_settings.FILE_CHUNCK_SIZE):
                await buffer.write(chunk)    

    except Exception as e:
        logger.error(f"Failed to upload file: {str(e)}")
        return JSONResponse(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR 
                        ,   content=ResponceEnums.file_upload_failed.value)

    return JSONResponse(status_code=status.HTTP_200_OK 
                        ,content={"message": ResponceEnums.file_uploaded_successfully.value
                                ,"filename": filename})

@router.post("/process/{project_id}")
async def process_file(project_id: str , process_request: ProcessRequest , app_settings: Settings = Depends(get_settings)):
    filename = process_request.filename 
    return filename 
                        