from fastapi import FastAPI
app = FastAPI()

@app.get("/welcome")
def read_root():
    return "Welcome to the Mini RAG API"