FROM apache/superset:latest

ENV SUPERSET_SECRET_KEY=supersecretkey
ENV FLASK_APP=superset

EXPOSE 8088

CMD ["gunicorn", "-b", "0.0.0.0:8088", "--workers=4", "--worker-class=gthread", "--threads=8", "--timeout=120", "superset.app:create_app()"]
