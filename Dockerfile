FROM apache/superset:latest

# Environment variables
ENV SUPERSET_SECRET_KEY=supersecretkey
ENV FLASK_APP=superset
ENV SUPERSET_CONFIG_PATH=/app/pythonpath/superset_config.py

# Expose port
EXPOSE 8088

# Run superset via gunicorn with the correct app entrypoint
CMD ["gunicorn", "-b", "0.0.0.0:8088", "--workers=4", "--worker-class=gthread", "--threads=8", "--timeout=120", "superset.app:create_app()"]
