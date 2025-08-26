FROM apache/superset:latest

USER root

# Install system dependencies needed for psycopg2 + geohash build
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    libpq-dev \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip and install Postgres driver inside Superset’s venv
RUN . /app/.venv/bin/activate \
    && pip install --upgrade pip \
    && pip install --no-cache-dir psycopg2-binary==2.9.9 \
    && pip install --no-cache-dir "apache-superset[postgres]"

# Verify psycopg2 is importable
RUN . /app/.venv/bin/activate \
    && python -c "import psycopg2; print('✅ psycopg2 installed and ready')"

USER superset
