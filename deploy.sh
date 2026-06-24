#!/bin/bash

set -e

echo "=== Deploy started ==="

echo "Running docker compose..."
cd app
docker-compose up -d

echo "=== Deploy finished ==="
