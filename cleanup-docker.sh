#!/bin/bash

echo "🧹 Cleaning up Docker containers and volumes..."

# Stop and remove containers
docker compose down -v

# Remove all stopped containers
docker container prune -f

# Remove all unused images
docker image prune -f

# Remove all unused volumes
docker volume prune -f

# Remove all unused networks
docker network prune -f

echo "✅ Docker cleanup complete!"

# Optional: Rebuild and start fresh
read -p "🚀 Do you want to rebuild and start containers? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "🔨 Building and starting containers..."
    docker compose build --no-cache
    docker compose up -d
    echo "✅ Containers are up and running!"
fi