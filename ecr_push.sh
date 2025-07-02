#!/bin/bash
set -e  # Exit on error

# Get ECR repository URL from Terraform
REPO=$(terraform output -raw repository_url)
if [ -z "$REPO" ]; then
    echo "Error: Failed to get repository URL from Terraform"
    exit 1
fi

# Set tag using timestamp
TAG=$(date +%Y%m%d%H%M%S)

# Extract registry URL
REGISTRY_URL="${REPO%%/*}"

# Authenticate with ECR
echo "Logging into ECR..."
aws ecr get-login-password --region eu-west-1 | \
    docker login --username AWS --password-stdin "$REGISTRY_URL"

# Check for existing builder instance
echo "Setting up docker buildx..."
if docker buildx ls | grep -q "multi-arch-builder"; then
    echo "Builder instance 'multi-arch-builder' already exists. Reusing it..."
    docker buildx use multi-arch-builder
else
    echo "Creating new builder instance 'multi-arch-builder'..."
    docker buildx create --use --name multi-arch-builder
fi

# Build and push the image
echo "Building and pushing image..."
docker buildx build \
    --platform linux/amd64,linux/arm64 \
    -t "${REPO}:${TAG}" \
    -t "${REPO}:latest" \
    --push \
    ./src/api

echo "Successfully pushed image ${REPO}:${TAG}"