# Implementing File Processing and Chunking in Mini-RAG Pipelines
---

## Purpose & Context

Following the implementation of the **Upload API** in previous modules, this session focuses on the **File Processing** stage of the mini-RAG pipeline.

The goal is to transition from a successfully uploaded file to a set of **processed, searchable text segments**. This involves:

* Extracting raw text from different file formats (PDF, TXT)
* Applying a chunking strategy optimized for **LLM consumption**

---

## Core Ideas & Architecture

The file processing architecture is built on **three pillars**:

### 1. Request Validation (Pydantic)

To ensure API reliability, a **Schema layer** is introduced.
Each request to the processing endpoint is validated against a Pydantic model before execution.

Validated parameters include:

* `file_id`
* `chunk_size`
* `chunk_overlap`

This prevents invalid input from propagating through the pipeline.

---

### 2. Modular Process Controller

A dedicated `ProcessController` is created:

* Inherits from `BaseController` (from earlier lessons)
* Uses `ProjectController` to resolve physical file paths
* Separates routing logic from business logic

---

### 3. The Necessity of Chunking

Large documents cannot be sent to an LLM as a whole due to:

* Token limits
* Increased latency
* Higher inference costs

By chunking:

* Only relevant context is sent to the LLM
* Chunks are stored efficiently in a **Vector Database**

---

### 4. Recursive Character Splitting

Instead of naive character splitting, the system uses a **recursive strategy** that:

* Respects paragraph breaks
* Preserves sentence boundaries
* Avoids cutting semantic concepts mid-way

---

## Implementation & Code

### 1. Data Validation Schema

A new `schemas` module defines the expected request structure.

```python
from pydantic import BaseModel
from typing import Optional

class ProcessRequest(BaseModel):
    file_id: str
    chunk_size: Optional[int] = 100
    chunk_overlap: Optional[int] = 20
    do_reset: Optional[int] = 0  # Inference: 0 for False, 1 for True
```

---

### 2. Document Loading Logic

LangChain loaders are used based on file extension.

```python
# From ProcessController
def get_file_extension(self, file_id: str):
    return os.path.splitext(file_id)[-1].lower()

def get_file_loader(self, file_id: str):
    extension = self.get_file_extension(file_id)
    file_path = os.path.join(self.project_path, file_id)
    
    if extension == ProcessingEnum.TXT.value:
        return TextLoader(file_path, encoding="utf-8")
    elif extension == ProcessingEnum.PDF.value:
        return PyMuPDFLoader(file_path)
    
    return None
```

**Key idea:**
The loader logic is modular, making it easy to extend for new file types.

---

### 3. Chunking Strategy Implementation

Text and metadata are extracted, then processed using `RecursiveCharacterTextSplitter`.

```python
from langchain.text_splitter import RecursiveCharacterTextSplitter

def process_file_content(self, file_content, chunk_size, chunk_overlap):
    # Extract text and metadata for batch processing
    text_list = [record.page_content for record in file_content]
    metadata_list = [record.metadata for record in file_content]
    
    splitter = RecursiveCharacterTextSplitter(
        chunk_size=chunk_size,
        chunk_overlap=chunk_overlap,
        length_function=len
    )
    
    # Returns chunks while preserving metadata
    return splitter.create_documents(text_list, metadatas=metadata_list)
```

---

## Production Considerations

* **Granular Framework Control**
  Use individual LangChain components instead of high-level chains for better control.

* **Encoding Robustness**
  Always set `encoding="utf-8"` in `TextLoader` to support multilingual content (e.g., Arabic) and avoid OS-specific crashes.

* **Overlap Strategy**
  Using a `chunk_overlap` (e.g., 20 characters) preserves context across chunks.

* **Resource Efficiency**
  Return `400 Bad Request` if no chunks are produced to avoid invalid downstream processing.

* **Traceability**
  Metadata is preserved so each chunk can be traced back to its source file and page number.

---

## Explicit Inferences

* **Inference 1:**
  The `do_reset` parameter suggests future support for clearing existing vector entries before re-processing a file.

* **Inference 2:**
  Although only PDF and TXT are covered, the modular loader design implies easy extensibility to formats like:

  * JSON
  * CSV
  * DOCX

---

## Key Takeaways

* File processing is the **bridge** between raw storage and the Vector Database.
* Pydantic schemas prevent *Garbage In, Garbage Out* in production APIs.
* Recursive chunking is superior to naive splitting for semantic preservation.
* Chunking balances **cost**, **latency**, and **retrieval accuracy**.
* Clean controller design leads to maintainable, professional systems.

