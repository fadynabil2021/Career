from .BaseControllers import BaseController
from .ProjectControllers import ProjectController
from langchain_community.document_loaders import TextLoader
from langchain_community.document_loaders import PyMuPDFLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from models import ProcessingEnums
from routes import ProcessRequest
import os

class ProcessController(BaseController):

    def __init__(self , project_id: str , filename: str):
        super().__init__()

        self.project_id = project_id
        self.project_path = ProjectController().get_project_path(project_id = project_id)
        self.process_request = ProcessRequest(filename = filename)
    
    
    def get_file_extension(self , filename: str):
        return filename.split(".")[-1]

    def get_document_loader(self , filename: str):

        file_extension = self.get_file_extension(filename = filename)
        file_path = os.path.join(self.project_path , filename)

        if file_extension == ProcessingEnums.TXT.value:
            return TextLoader(file_path , encoding = "utf-8")

        elif file_extension == ProcessingEnums.PDF.value:
            return PyMuPDFLoader(file_path)

        return None
    
    def get_file_content(self , filename: str):

        document_loader = self.get_document_loader(filename = filename)
        return document_loader.load()
    
    def process_file_content(self , filename: str):

        file_content = self.get_file_content(filename = filename)
        text_splitter = RecursiveCharacterTextSplitter(
            chunk_size = self.process_request.chunk_size,
            chunk_overlap = self.process_request.overlap_chunk_size,
            length_function = len,
            is_separator_regex = False,
        )

        file_content_text     = [text.page_content for text in file_content]

        file_content_metadata = [text.metadata for text in file_content]

        chuncks = text_splitter.create_documents(file_content_text , metadatas = file_content_metadata)

        return chuncks
