# Integrating MongoDB and Docker for Stateful RAG Applications


---

## Purpose & Context

Building on previous modules where the system successfully processed files into segments, this session focuses on transitioning the application from **stateless** to **stateful**.

While earlier logic could display chunks temporarily, a production-grade RAG system requires **persistent storage** to reuse processed data for future retrieval tasks. This module introduces:

* **MongoDB** as the primary storage layer
* **Docker** as the deployment standard to ensure portability and consistency across environments

---

## Core Ideas & Architecture

The architectural focus is on integrating a **NoSQL, document-based database** into an **asynchronous FastAPI** application.

### Database Selection

* **MongoDB** is chosen for its flexibility in handling document-based (NoSQL) data
* Unlike relational databases (SQL), MongoDB allows:

  * Variable fields within the same collection
  * Flexible metadata structures for heterogeneous documents

---

### Orchestration with Docker

* MongoDB is deployed as a **Docker container**
* Avoids local installation issues
* Ensures consistency across machines and environments
* Entire service is encapsulated in a `docker-compose.yml` file

---

### Asynchronous Connectivity

* FastAPI is asynchronous by design
* The system uses **Motor**, an asynchronous MongoDB driver for Python
* Prevents database I/O from blocking the event loop
* Ensures responsiveness under high load

---

### Schema Enforcement

Although MongoDB is schema-less:

* The application enforces structure using **Pydantic models**
* Ensures data integrity and consistency at the application layer
* Prevents malformed records from reaching the database

---

## Implementation & Code

### 1. Docker Orchestration (`docker-compose.yml`)

The MongoDB service is defined with port mapping, persistent storage, and network isolation.

```yaml
services:
  mongodb:
    image: mongo:latest  # Base image from Docker Hub
    container_name: mongodb
    ports:
      - "27017:27017"  # Map container port to host
    volumes:
      - ./docker/mongodb:/data/db  # Persist data on host disk
    networks:
      - backend
    restart: always  # Auto-restart on failure

networks:
  backend:
    driver: bridge
```

> **Note:**
> The instructor recommends changing the default port (e.g., from `27017`) to avoid conflicts or improve security.

---

### 2. Asynchronous Database Connection (FastAPI)

The database lifecycle is managed using FastAPI startup and shutdown events.

```python
from motor.motor_asyncio import AsyncIOMotorClient

@app.on_event("startup")
async def start_up_db_client():
    settings = get_settings()
    # Initialize MongoDB client
    app.mongo_connection = AsyncIOMotorClient(settings.mongo_db_url)
    app.db_client = app.mongo_connection[settings.mongo_db_database]

@app.on_event("shutdown")
async def shutdown_db_client():
    # Close database connection gracefully
    app.mongo_connection.close()
```

---

### 3. Database Schemas (Pydantic Models)

Two core schemas are defined: **Project** and **DataChunk**.

#### Project Schema

```python
from pydantic import BaseModel, Field
from typing import Optional
from bson import ObjectId

class Project(BaseModel):
    id: Optional[ObjectId] = Field(None, alias="_id")
    project_id: str = Field(..., min_length=1)

    class Config:
        arbitrary_types_allowed = True  # Required for BSON ObjectId
```

---

#### Data Chunk Schema

```python
class DataChunk(BaseModel):
    id: Optional[ObjectId] = Field(None, alias="_id")
    chunk_text: str = Field(..., min_length=1)
    chunk_metadata: dict
    chunk_order: int = Field(..., gt=0)
    chunk_project_id: ObjectId  # Reference to Project _id
```

---

## Production Considerations

* **Data Persistence**
  Docker volumes are mandatory. Without them, all data would be lost when containers stop.

* **Asynchronous Efficiency**
  Motor enables non-blocking reads and writes, allowing FastAPI to serve other requests concurrently.

* **Validation Logic**
  Manual checks (e.g., `is_alnum`) are used to validate identifiers before database insertion.

* **External Management Tools**
  Recommended tools for development and debugging:

  * MongoDB Compass
  * Studio 3T

* **Resource Management**
  MongoDB connection settings are:

  * Centralized in a `.env` file
  * Validated through a `Settings` helper
  * Preventative against misconfiguration in production

---

## Explicit Inferences

* **Inference 1:**
  Choosing MongoDB over PostgreSQL implies the system expects **highly variable metadata** across document types (PDFs, TXT, future formats).

* **Inference 2:**
  Using `restart: always` indicates a design goal of **high availability**, ensuring the database recovers automatically after crashes.

---

## Key Takeaways

* Docker enables portable, reproducible deployment of external services like MongoDB.
* Motor is essential for preserving FastAPI’s non-blocking, high-performance nature.
* Pydantic provides a crucial logical schema layer for NoSQL databases.
* **Stateful Persistence** allows the RAG system to:

  * Store Projects
  * Reuse Data Chunks
  * Enable downstream retrieval and generation phases
