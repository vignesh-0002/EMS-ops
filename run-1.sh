#!/bin/bash

set -e

# Fetch the secret
SECRET_JSON=$(aws secretsmanager get-secret-value \
  --secret-id ems-ops/rds/db-credentials \
  --query SecretString \
  --output text \
  --region us-east-1)

# Extract credentials
export DB_USERNAME=$(echo $SECRET_JSON | jq -r .username)
export DB_PASSWORD=$(echo $SECRET_JSON | jq -r .password)
export DB_HOST=$(echo $SECRET_JSON | jq -r .host)
export DB_PORT=$(echo $SECRET_JSON | jq -r .port)

# Check if images are already built
if ! docker image inspect ems-ops-backend > /dev/null 2>&1 || ! docker image inspect ems-ops-frontend > /dev/null 2>&1; then
  echo "Docker images not found. Building..."
  docker compose -f docker-compose-new-1.yml build
else
  echo "Docker images already built. Skipping build."
fi

# Run docker-compose
docker compose -f docker-compose-new-1.yml up -d


# docker-compose-new-1.yml
