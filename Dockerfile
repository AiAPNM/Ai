FROM apache/superset:latest

# Set environment variables
ENV SUPERSET_HOME=/app/superset_home \
    SUPERSET_SECRET_KEY=supersecretkey \
    FLASK_APP=superset \
    SUPERSET_CONFIG_PATH=/app/pythonpath/superset_config.py

# Copy optional config
COPY superset_config.py /app/pythonpath/superset_config.py
