#!/bin/bash

set -e

# Build the Docker images in the correct order
echo "Building cluster-base image..."
docker build -t cluster-base -f cluster-base.Dockerfile .

echo "Building spark-base image..."
docker build -t spark-base -f spark-base.Dockerfile .

echo "Building spark-master image..."
docker build -t spark-practice-master -f spark-master.Dockerfile .

echo "Building spark-worker image..."
docker build -t spark-practice-worker -f spark-worker.Dockerfile .

echo "Building jupyterlab image..."
docker build -t spark-practice-jupyterlab -f jupyterlab.Dockerfile .

echo "All images built successfully!"
echo "Run 'docker-compose up -d' to start the cluster." 