#!/usr/bin/env bash
set -e

echo "🚀 Starting Kubernetes deployment..."

# Run the deploy task
task deploy

echo "✅ Deployment complete. Keeping container alive..."
exec tail -f /dev/null  # Keeps the container running
