#!/bin/bash
IMAGES=(
    "redis:redis"
    "hasher:dockercoins/hasher:v0.1"
    "rng:dockercoins/rng:v0.1"
    "webui:dockercoins/webui:v0.1"
    "worker:dockercoins/worker:v0.1"
)

for item in "${IMAGES[@]}"; do
    NAME=${item%%:*}
    IMAGE=${item#*:}
    echo "Deploying $NAME with image $IMAGE..."
    minikube kubectl -- create deployment $NAME --image=$IMAGE --dry-run=client -o yaml | minikube kubectl -- apply -f -
done
