FROM apache/superset:latest

USER root

# Install build deps
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    libpq-dev \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install psycopg2 driver
RUN pip3 install --no-cache-dir psycopg2-binary==2.9.9

# Verify
RUN python3 -c "import psycopg2; print('✅ psycopg2 installed')"

USER superset

ENV SUPERSET_SECRET_KEY=supersecretkey
ENV FLASK_APP=superset

EXPOSE 8088

CMD superset db upgrade && \
    superset fab create-admin \
      --username admin \
      --firstname Superset \
      --lastname Admin \
      --email admin@superset.com \
      --password admin || true && \
    superset init && \
    gunicorn -w 2 -k gthread --timeout 120 -b 0.0.0.0:8088 "superset.app:create_app()"
