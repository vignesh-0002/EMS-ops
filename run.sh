#!/bin/bash

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

# Run docker-compose
docker compose -f docker-compose-new.yml up -d
