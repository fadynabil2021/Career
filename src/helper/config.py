from pydantic_settings import BaseSettings , SettingsConfigDict

class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_prefix="MINI_RAG_",
        env_file=".env",
        env_file_encoding="utf-8",
    )
    APP_NAME : str 
    APP_VERSION : str
    DEBUG : bool 
    LOG_LEVEL : str
    PORT : int 
    OPEN_AI_API_KEY : str 


    class Config:
        env_file = ".env"
        env_file_encoding = "utf-8"
        env_prefix = "MINI_RAG_"
        case_sensitive = True
def get_settings():
    return Settings()