# Models & Schemas Layer for Stateful Mini-RAG Systems

---

## Purpose & Context

Building upon the establishment of the MongoDB environment via Docker, this module transitions the mini-RAG system from **raw database connectivity** to a structured **Models and Schemas layer**.

The focus is on implementing **stateful persistence** for:

* **Projects**
* **Data Chunks**

This ensures that processed text segments are stored efficiently and can be retrieved **asynchronously** without blocking application performance.

---

## Core Ideas & Architecture

The architecture adopts a **modular, model-centric design** focused on clean separation of concerns.

### Key Architectural Principles

* **Base Data Model**

  * A shared `BaseDataModel` holds common resources:

    * `db_client`
    * FastAPI `app` instance
  * All child models inherit from it to avoid redundancy

* **Project and Chunk Separation**

  * `ProjectModel`: Handles project-level metadata
  * `DataChunkModel`: Manages individual document segments

* **Asynchronous CRUD Operations**

  * All database interactions are implemented using `async/await`
  * Powered by **Motor** to preserve FastAPI’s non-blocking nature

* **Stateful Mapping**

  * Bridges MongoDB’s **BSON** format with **Pydantic**
  * Special handling for MongoDB’s reserved `_id` field

---

## Implementation & Code

### Implementation Flowchart

1. **Request Capture**
   API receives a request (Upload, Process, etc.)

2. **Resource Injection**
   `db_client` is extracted from `request.app` and injected into the Model layer

3. **Schema Validation**
   Incoming data is validated using Pydantic schemas

4. **Database Operation**

   * **Query**: Check for existing records (e.g., `get_project_or_create`)
   * **Transformation**: Convert Pydantic models to dictionaries using `by_alias=True`
   * **Execution**: Perform `insert_one` or `bulk_write`

5. **Response Handling**
   Convert BSON/dictionary results back into Pydantic models for API responses

---

## Code Snippets

### 1. Handling the Pydantic / MongoDB `_id` Conflict

To handle MongoDB’s `_id` field while respecting Python naming conventions, an alias is used.

```python
from pydantic import Field, BaseModel
from typing import Optional

class Project(BaseModel):
    # Expose MongoDB _id as "id" in Python
    id: Optional[str] = Field(None, alias="_id")
    project_id: str

    def to_dict(self):
        # by_alias=True maps "id" -> "_id"
        # exclude_none prevents sending null values to MongoDB
        return self.model_dump(by_alias=True, exclude_none=True)
```

---

### 2. Efficient Batch Ingestion (Bulk Write)

For RAG systems dealing with thousands of chunks, batch insertion is mandatory to protect memory and reduce latency.

```python
from pymongo import InsertOne

async def insert_many_chunks(self, chunks: list, batch_size: int = 100):
    for i in range(0, len(chunks), batch_size):
        batch = chunks[i : i + batch_size]
        operations = [InsertOne(chunk.to_dict()) for chunk in batch]
        await self.collection.bulk_write(operations)
```

---

### 3. Pagination for Data Retrieval

Pagination prevents dangerous “get all” queries that can crash production systems.

```python
async def get_all_projects(self, page: int = 1, page_size: int = 10):
    skip = (page - 1) * page_size
    cursor = self.collection.find().skip(skip).limit(page_size)

    projects = []
    async for doc in cursor:
        projects.append(Project(**doc))
    return projects
```

---

## Production Considerations

* **Pagination**

  * Never expose unlimited `get_all` endpoints in production
  * Pagination prevents single-point system failures

* **Memory Management**

  * Use asynchronous cursors instead of loading full query results into memory

* **Bulk Operations**

  * `bulk_write` minimizes database round-trips and improves ingestion speed

* **Data Integrity**

  * The `do_reset` flag enables clearing old chunks before re-processing
  * Prevents duplicate embeddings in vector stores

* **Error Handling**

  * All Motor database calls **must be awaited**
  * Missing `await` results in coroutine errors instead of execution

---

## Explicit Inferences

* **Inference 1**
  Using `by_alias=True` is essential because MongoDB requires `_id`, while Python discourages public attributes starting with underscores.

* **Inference 2**
  Using `exclude_none=True` implies reliance on MongoDB’s automatic `_id` generation when one is not provided.

---

## Key Takeaways

* **Structured Models**

  * Pydantic models enforce consistency across the RAG pipeline

* **Efficiency**

  * Batching and pagination are mandatory for production-grade systems

* **Persistence Strategy**

  * Linking chunks to a `project_id` enables:

    * Multi-tenant isolation
    * Efficient reset and cleanup

* **Framework Integration**

  * Accessing `db_client` via FastAPI’s `request` object ensures:

    * Shared connections
    * Zero redundant initialization overhead


