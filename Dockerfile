FROM apache/superset:latest

USER root

# Install system dependencies needed by psycopg2
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install psycopg2 in Superset's virtualenv
RUN /app/.venv/bin/pip install --no-cache-dir psycopg2-binary

# Optional: pin version to avoid future breakage
# RUN /app/.venv/bin/pip install psycopg2-binary==2.9.9

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
