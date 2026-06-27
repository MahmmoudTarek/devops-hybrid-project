#!/bin/bash

set -e

echo "=== Deploy started ==="

cd app

docker-compose down --remove-orphans || true

docker-compose up -d

echo "=== Deploy finished ==="
