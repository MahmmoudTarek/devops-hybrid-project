#!/bin/bash

set -e

echo "=== Deploy started ==="

cd app

docker-compose up -d

echo "=== Deploy finished ==="
