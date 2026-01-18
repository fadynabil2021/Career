from enum import Enum

class ResponceEnums(Enum):
    file_type_not_allowed = "File type not allowed"
    file_size_too_large = "File size too large"
    file_uploaded_successfully = "File uploaded successfully" 
    file_not_found = "File not found"
    file_upload_failed = "File upload failed"
    file_validation_failed = "File validation failed"
    file_validation_success = "File validation success"