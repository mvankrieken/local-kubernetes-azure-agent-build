#!/bin/bash
set -e

docker build --tag "local/az-local-agent:v1.5.15" --file "image/azure-agent.dockerfile" --platform linux/x86_64 image

echo "Image build locally as local/az-local-agent:v1.5.15"