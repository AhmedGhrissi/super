#!/bin/bash

set -e

echo "🚀 Déploiement Machine Monitor en production..."

# Variables
APP_NAME="machine-monitor"
DOCKER_REGISTRY="registry.example.com"
VERSION="1.0.0"

# Build de l'image
echo "📦 Building Docker image..."
docker build -t $DOCKER_REGISTRY/$APP_NAME:$VERSION .

# Push de l'image
echo "📤 Pushing image to registry..."
docker push $DOCKER_REGISTRY/$APP_NAME:$VERSION

# Arrêt des containers existants
echo "🛑 Stopping existing containers..."
docker-compose down

# Démarrage des nouveaux containers
echo "🎯 Starting new deployment..."
docker-compose pull
docker-compose up -d

# Health check
echo "🏥 Performing health check..."
sleep 30
curl -f http://localhost:8080/monitoring/health || {
    echo "❌ Health check failed"
    exit 1
}

echo "✅ Déploiement terminé avec succès!"