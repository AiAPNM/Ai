FROM apache/superset:latest

USER root

# Install system deps for psycopg2
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Activate Superset venv and install postgres extras
RUN . /app/.venv/bin/activate \
    && pip install --no-cache-dir "psycopg2-binary==2.9.9" \
    && pip install --no-cache-dir "apache-superset[postgres]"

# Verify psycopg2 inside venv
RUN . /app/.venv/bin/activate \
    && python -c "import psycopg2; print('✅ psycopg2 available in venv')"

USER superset
