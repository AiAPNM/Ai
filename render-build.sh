#!/usr/bin/env bash
set -o errexit

# Apply DB migrations
superset db upgrade

# Create an admin user if it doesn’t exist
superset fab create-admin \
   --username admin \
   --firstname Superset \
   --lastname Admin \
   --email admin@admin.com \
   --password admin || true

# Setup default roles and permissions
superset init
