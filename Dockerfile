FROM apache/superset:latest

USER root

# Install system deps for psycopg2
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Install Postgres driver directly in Superset's venv
RUN /app/.venv/bin/pip install --no-cache-dir psycopg2-binary==2.9.9 \
    && /app/.venv/bin/pip install --no-cache-dir "apache-superset[postgres]"

# Verify psycopg2 inside venv
RUN /app/.venv/bin/python -c "import psycopg2; print('✅ psycopg2 installed and ready')"

USER superset
