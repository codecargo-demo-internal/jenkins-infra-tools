FROM python:3.12-slim
RUN apt-get update && apt-get install -y --no-install-recommends git curl && rm -rf /var/lib/apt/lists/*
RUN pip install --no-cache-dir pip setuptools wheel
WORKDIR /workspace
