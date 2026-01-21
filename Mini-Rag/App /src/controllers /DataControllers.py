from fastapi import UploadFile
from .BaseControllers import BaseController
from .ProjectControllers import ProjectController
from models import ResponceEnums
import os
import re
import uuid
import logging

logger = logging.getLogger(__name__)

class DataController(BaseController):
    def __init__(self):
        super().__init__()

    def upload_file(self , file: UploadFile):
        if file.content_type not in self.app_settings.FILE_ALLOWED_TYPES:
            return {"message"  : ResponceEnums.file_type_not_allowed.value
        ,           "indicator": False}
        if file.size > self.app_settings.FILE_ALLOWED_SIZE * 1024 * 1024:
            return {"message"  : ResponceEnums.file_size_too_large.value
        ,           "indicator": False}
        return {"message"  : ResponceEnums.file_uploaded_successfully.value
        ,       "indicator": True}

    def gen_unique_filepath(self , original_filename: str , project_id: str):
        random_string = self.gen_random_string(length = 10)
        project_path = ProjectController().get_project_path(project_id = project_id)
        clean_filename = self.clean_filename(original_filename = original_filename)
        new_file_path = os.path.join(project_path , random_string + "_" + clean_filename)
        while os.path.exists(new_file_path):
            random_string = self.gen_random_string(length = 10)
            new_file_path = os.path.join(project_path , random_string + "_" + clean_filename)
        return new_file_path , random_string + "_" + clean_filename


    def clean_filename(self , original_filename: str):
        clean_filename = re.sub(r'[^\w.]', '', original_filename.strip())
        clean_filename = clean_filename.replace(" " , "_")
        return clean_filename
    
