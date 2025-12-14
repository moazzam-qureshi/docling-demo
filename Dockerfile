FROM python:3.11-slim

WORKDIR /app

# Install uv for fast package management
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

# Copy requirements first for better layer caching
COPY requirements.txt .

# Install Python dependencies using uv (increased timeout for large packages)
ENV UV_HTTP_TIMEOUT=300
RUN uv pip install --system --no-cache -r requirements.txt

# Copy application code
COPY . .

# Run the console application
CMD ["python", "main.py"]
