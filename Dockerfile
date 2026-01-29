# ---------- Build arguments (WITH DEFAULTS) ----------
ARG BASE_IMAGE=python:3.10-slim
ARG EXPOSED_PORT=8200
ARG VOLUME_PATH=/app/chroma_db

# ---------- Base image ----------
FROM ${BASE_IMAGE}
# FROM python:3.10-slim

# ---------- Environment ----------
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Work directory inside the docker container
WORKDIR /app

# ---------- System dependencies ----------
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# ---------- Copy project ----------
COPY . .

# ---------- Install project ----------
RUN pip install --no-cache-dir -e .

# ---------- Runtime config ----------
EXPOSE ${EXPOSED_PORT}
# VOLUME ${VOLUME_PATH}

# Run the app 
# CMD ["streamlit", "run", "app/app.py", "--server.port=8501", "--server.address=0.0.0.0","--server.headless=true"]
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0","--server.headless=true"]