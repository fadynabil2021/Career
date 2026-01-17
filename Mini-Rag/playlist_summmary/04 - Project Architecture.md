# Architectural Foundations for Professional Mini-RAG Development
---

## Purpose & Context

Following the environment setup in the previous lesson, this session focuses on building the **boilerplate (template) architecture** for the mini-RAG project. The goal is to move from a single-file script to a **professional, multi-file structure** that incorporates version control best practices, configuration management, and standard documentation.

This architecture acts as the **entry gate** for any developer interacting with the project for the first time.

---

## Core Ideas & Architecture

The architecture established in this phase emphasizes **project organization** and **dependency management** to ensure reproducibility, security, and long-term maintainability.

### Key Architectural Decisions

* **Branch Management**
  A structured branching strategy is used. For this tutorial, a branch named `tutorial/04` is created.
  This mirrors professional workflows where tasks are tied to identifiers (e.g., Jira tickets) for tracking features and bug fixes.

* **Web Framework Selection**
  **FastAPI** is selected as the core web framework.
  Unlike highly flexible frameworks, FastAPI enforces standardized patterns that promote code longevity and professional engineering practices.

* **Dependency Pinning**
  Exact package versions are enforced in `requirements.txt` to prevent environment conflicts caused by incompatible or breaking updates.

* **Asset Management**
  A dedicated `assets/` directory centralizes all downloaded or generated resources.

* **Configuration & Secrets Management**
  Application configuration is separated from sensitive credentials using environment variables, ensuring security and portability.

---

## Implementation & Code

### 1. Environment & Dependency Setup

The `requirements.txt` file is initialized using exact versions retrieved from PyPI to guarantee build stability over time.

```txt
# requirements.txt
fastapi==0.104.1
uvicorn[standard]==0.24.0.post1

# Necessary for RAG ingestion (uploading files)
python-multipart==0.0.6
```

> **Note:**
> A blank line is intentionally left at the end of the file to avoid unnecessary Git diff noise when new dependencies are added later.

---

### 2. Terminal Readability Enhancement

To improve readability when working with long directory paths in WSL/Ubuntu, a shell configuration is introduced to split the path from the command prompt.

```bash
# Improves terminal readability
export PS1="\w\n$ "
```

This command is documented in the `README.md` to standardize developer setup.

---

### 3. Configuration Management (`.env`)

The application relies on environment variables for constants and secrets.

To maintain security while ensuring contributor friendliness, the project includes both:

* `.env` → **Ignored by Git**
* `.env.example` → **Committed to Git**

#### Environment Structure

```env
# .env (ignored by Git)
APP_NAME="mini-RAG"
APP_VERSION="0.1.0"
OPENAI_API_KEY="sk-..."  # Placeholder for RAG LLM services
```

#### Developer Setup Workflow

```bash
# Included in README for contributors
cp .env.example .env
```

---

### 4. File Structure Flow

The standard project boilerplate follows this sequence:

1. **`.gitignore`**
   Uses the official GitHub Python template to exclude caches, environments, and generated data.

2. **`LICENSE`**
   An **Apache License** is applied for open-source compliance.

3. **`README.md`**
   Documents installation steps, Miniconda setup, and environment activation.

4. **`assets/`**
   Includes a `.gitkeep` file so Git tracks the directory even when empty.

---

## Production Considerations

* **Security**
  Sensitive data (e.g., OpenAI API keys) must never be committed.
  The `.gitignore` explicitly excludes `.env` to prevent accidental credential leaks.

* **Reliability**
  **Uvicorn** is used as the ASGI server for handling requests.
  For real production deployments, it should be paired with a robust reverse proxy such as **Nginx** or **Gunicorn**.

* **Team Collaboration**
  Including `.env.example` reflects professional maturity and prevents runtime failures for new contributors due to missing configuration values.

---

## Explicit Inferences

* **Inference:**
  The inclusion of `python-multipart` directly supports the **Upload API** defined in earlier architectural stages, as FastAPI requires it for handling file form data.

* **Inference:**
  FastAPI’s emphasis on standardization suggests that **Stage 1** will likely enforce:

  * Strict **type hints**
  * **Pydantic models** for request and response validation

---

## Key Takeaways

* **Documentation is Paramount**
  A project should be documented well enough that even an unfamiliar developer can set it up successfully.

* **Version Pinning is Non-Negotiable**
  Always lock dependency versions to protect production environments from breaking changes.

* **Separate Secrets from Code**
  Use `.env` for sensitive data and `.env.example` as a safe onboarding guide.

* **Git Hygiene Matters**
  Structured branch naming and frequent commits are defining traits of a professional AI engineer.
