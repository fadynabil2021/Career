from pydantic_settings import BaseSettings , SettingsConfigDict

class Settings(BaseSettings):

    APP_NAME : str 
    APP_VERSION : str
    DEBUG : bool 
    LOG_LEVEL : str
    PORT : int 
    OPEN_AI_API_KEY : str 
    FILE_ALLOWED_TYPES : list 
    FILE_ALLOWED_SIZE : int 
    PROJECTS_DIR : str 
    FILE_CHUNCK_SIZE : int 
    class Config:
        env_file=".env"


def get_settings():
    return Settings()
    