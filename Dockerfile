FROM apache/superset:latest

USER root

# Install Postgres driver via Superset extras
RUN pip install "apache-superset[postgres]"

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
