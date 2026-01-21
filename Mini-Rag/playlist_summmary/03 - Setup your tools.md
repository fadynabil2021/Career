# Mini-RAG Development Environment Setup

## Purpose & Context

Following the conceptual introduction to the **mini-RAG** project, this session focuses on establishing a professional development environment. The goal is to move from local scripting to a structured workflow using version control, environment isolation, and production-aligned operating system configurations.

---

## Core Ideas & Architecture

The setup architecture centers on three pillars:

* **Version Control**
* **Environment Management**
* **Operating System Parity**

### Version Control (Git & GitHub)

Every project, regardless of size, must begin with a repository. This ensures code persistence and enables collaborative workflows such as pull requests, code reviews, and controlled project evolution.

### Environment Management (Miniconda)

To prevent dependency conflicts, the system uses **Miniconda** to create isolated virtual environments. This allows the project to run on a specific Python version (**Python 3.8**) without affecting global system settings.

### Production Alignment (WSL & Linux)

While initial development may occur on Windows, professional RAG applications are typically deployed on Linux-based cloud environments.

Using **Windows Subsystem for Linux (WSL)** with an **Ubuntu** distribution enables developers to run a real Linux system inside Windows. This ensures that locally developed code behaves identically in production.

---

## Implementation & Code

### Setup Flow

The setup follows a sequential path from the cloud repository to the local Linux subsystem:

1. **Repository Initialization**
   Create a GitHub repository and clone it locally.

2. **IDE Integration**
   Open the project in **Visual Studio Code (VS Code)**.

3. **Local Environment Setup**
   Install Miniconda and create the `mini-rag-app` environment.

4. **Subsystem Configuration**
   Install WSL 2 and Ubuntu, then replicate the Miniconda setup inside the Linux terminal.

5. **Cross-Environment Access**
   Access Windows-hosted project files from the Linux terminal via the `/mnt/` path.

---

### Code & Commands

#### Environment Creation and Verification

```bash
# Verify Git installation
git --version

# Create a Conda environment with Python 3.8
conda create -n mini-rag-app python=3.8

# Activate the environment
conda activate mini-rag-app

# Verify Python version
python --version
```

#### WSL & Linux Setup

```bash
# Install WSL from Windows PowerShell (Run as Administrator)
wsl --install

# List available distributions and install Ubuntu
wsl --list --online
wsl --install -d Ubuntu

# Update Linux package manager
sudo apt update
```

#### Linux-Side Miniconda Installation

```bash
# Download Miniconda for Linux
wget [Miniconda-Linux-Link]

# Make the installer executable and run it
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh

# Refresh the profile to apply PATH changes
source ~/.bashrc
```

---

## Production Considerations

* **Security**
  Use **Personal Access Tokens (PATs)** instead of passwords for GitHub authentication.

* **Reliability**
  Developing in **WSL/Linux** reduces platform-specific issues when deploying Python-based RAG applications.

* **Scalability**
  Fixed Python versions and named virtual environments ensure reproducibility across teams and deployments.

---

## Explicit Inferences

* **Inference:**
  Choosing **Python 3.8** balances modern features with long-term ecosystem stability (e.g., LangChain and FastAPI compatibility).

* **Inference:**
  Using `/mnt/c/` allows seamless Windows-based editing with Linux-based execution for production parity.

---

## Key Takeaways

* **Start with Git** — even small projects need version control.
* **Isolate environments** to avoid dependency conflicts.
* **Think Linux-first**, even when developing on Windows.
* **Always verify installations** using `--version` flags.

---

If you want, I can now:

* Strip this to **pure README.md minimalism**
* Add **Mermaid architecture diagrams**
* Convert it into **chapter-based mini-book Markdown**
* Enforce **Docs-as-Code / Google-style documentation rules**

Just tell me the target.
