# Stage 1: Build Stage
ARG PYTHON_VERSION=3.8
FROM python:${PYTHON_VERSION} as builder

# Set the working directory
WORKDIR /app

# Copy project source into the builder image
COPY . .

# Stage 2: Run Stage
FROM python:${PYTHON_VERSION} as run

WORKDIR /app

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# Copy all project files from the builder stage
COPY --from=builder /app .

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Install netcat so we can wait for the DB to be ready
RUN apt-get update && \
    apt-get install -y netcat && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 8080

# Make entrypoint script executable
# (entrypoint.sh must exist in the project root)
RUN chmod +x /app/entrypoint.sh

# Use entrypoint script that waits for DB, runs migrations, then starts server
ENTRYPOINT ["/app/entrypoint.sh"]
