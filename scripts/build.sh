#!/bin/bash

# Exit in case of error
set -e

# Build and run containers
sudo docker compose up -d

# Hack to wait for postgres container to be up before running alembic migrations
sleep 5;

# Run migrations
sudo docker compose run --rm backend alembic upgrade head

# Create initial data
sudo docker compose run --rm backend python3 app/initial_data.py
