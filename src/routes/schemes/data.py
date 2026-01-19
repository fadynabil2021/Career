from pydantic import BaseModel
from typing import Optional

class ProcessRequest(BaseModel):
    filename: str
    chunk_size: Optional[int] = 150
    overlap_chunk_size: Optional[int] = 30
    do_reset: Optional[int] = 0

    