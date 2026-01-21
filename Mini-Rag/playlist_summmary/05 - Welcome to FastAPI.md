# Building the Mini-RAG Gateway with FastAPI and Uvicorn
---

## Purpose & Context

Following the initial environment setup and boilerplate creation, this session transitions the **mini-RAG** project into active development. The focus is on the application’s **gateway layer** using **FastAPI**.

The objective is to convert standard Python functions into accessible **API endpoints**, establishing the communication layer required for upcoming RAG ingestion and retrieval logic.

---

## Core Ideas & Architecture

The architecture centers on transforming a Python script into a functional web service.

* **Entry Point (`main.py`)**
  `main.py` is established as the primary gateway from which all application operations originate.

* **Controller Logic (FastAPI Decorators)**
  FastAPI decorators (`@app.get`, `@app.post`, etc.) intercept incoming HTTP requests and route them to specific handler functions.

* **Automatic Documentation (Swagger UI)**
  FastAPI automatically generates interactive API documentation via **Swagger UI**, accessible at `/docs`, enabling endpoint testing without manual setup.

* **External API Client (Postman)**
  For advanced testing and collaboration, **Postman** is integrated. Collections and Environments are used to manage variables such as the API base URL across different development stages.

---

## Implementation & Code

### 1. Project Workflow & Git Management

To maintain continuity with previous stages, a new Git branch is created for this implementation step.

```bash
# Branching from the previous setup checkpoint
# Inference: Git is used for checkpointing each feature set
git checkout -b tutorial/002 from tutorial/001

# Initialize environment variables for this branch
cp .env.example .env
```

---

### 2. FastAPI Basic Implementation

The application is initialized by importing **FastAPI** and defining the main `app` object. A simple endpoint is created to verify connectivity.

```python
from fastapi import FastAPI

# Initialize the gateway object
app = FastAPI()

# Define a simple GET endpoint
@app.get("/welcome")
def welcome():
    return {"message": "Hello World"}
```

This confirms that:

* The server is running
* Routing works correctly
* The API is reachable via HTTP

---

### 3. Executing the Server with Uvicorn

The application is served using **Uvicorn**, the ASGI server recommended for FastAPI.

```bash
# Standard development execution
uvicorn main:app --reload
```

Production-oriented execution with explicit network configuration:

```bash
# --host 0.0.0.0 allows external network access
# --port 5000 changes the default port
# --reload enables auto-reload (development only)
uvicorn main:app --reload --host 0.0.0.0 --port 5000
```

---

## Production Considerations

* **Deployment Security**
  The `--reload` flag must never be used in production, as it is intended only for development-time convenience.

* **Network Configuration**
  Setting the host to `0.0.0.0` is required to expose the API to external clients beyond the local machine.

* **API Port Management**
  The selected port (e.g., `5000`) must be opened in the server firewall to allow incoming traffic.

* **Documentation as an Asset**
  Postman Collections are exported as JSON files and stored in the project’s `assets/` directory. This enables other engineers to import and test the API with predefined requests.

* **Project Documentation**
  All critical execution commands are added to `README.md` to ensure long-term maintainability.

---

## Explicit Inferences

* **Inference:**
  Centralizing execution in `main.py` implies that future RAG components (e.g., PDF ingestion, chunking, vector search) will either be imported into this file or routed through it to maintain a unified API layer.

* **Inference:**
  The use of Postman variables (such as `{{base_url}}`) indicates preparation for **multi-environment deployment** (local, staging, cloud), where IP addresses or domains may differ.

---

## Key Takeaways

* **FastAPI** enables a smooth transition from experimental Python scripts to production-ready web services using decorators.
* **Uvicorn** acts as the execution engine, with specific flags bridging the gap between local development and network exposure.
* **Swagger UI** and **Postman** provide complementary testing layers:

  * Internal validation via `/docs`
  * Advanced, collaborative testing via Postman collections
* **Maintainability** improves when API testing assets are version-controlled alongside source code.
