#!/usr/bin/env bash
set -e

# Apply migrations on Postgres
superset db upgrade

# Create admin (idempotent, won’t fail if exists)
superset fab create-admin \
   --username admin \
   --firstname Superset \
   --lastname Admin \
   --email admin@superset.com \
   --password admin || true

# Initialize roles/permissions
superset init
