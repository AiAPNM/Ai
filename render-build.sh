FROM apache/superset:latest

# Expose the Superset port
EXPOSE 8088

# Environment (you can also set these in Render dashboard instead of hardcoding)
ENV SUPERSET_SECRET_KEY=supersecretkey
ENV SUPERSET_DATABASE_URI=$SUPERSET_DATABASE_URI

# Run DB migrations + create admin + start gunicorn
CMD superset db upgrade && \
    superset fab create-admin \
      --username admin \
      --firstname Superset \
      --lastname Admin \
      --email admin@superset.com \
      --password admin || true && \
    superset init && \
    gunicorn -w 2 -k gthread --timeout 120 -b 0.0.0.0:8088 "superset.app:create_app()"
