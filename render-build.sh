#!/usr/bin/env bash
set -e

echo "Using DB: $SUPERSET_DATABASE_URI"

superset db upgrade

superset fab create-admin \
  --username admin \
  --firstname Superset \
  --lastname Admin \
  --email admin@superset.com \
  --password admin || true

superset init
