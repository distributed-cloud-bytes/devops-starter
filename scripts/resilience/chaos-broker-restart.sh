#!/usr/bin/env bash
set -euo pipefail

CONTAINER="${BROKER_CONTAINER:-dcb-redpanda}"

echo "Restarting broker container: $CONTAINER"
docker restart "$CONTAINER"
sleep 5
docker exec "$CONTAINER" rpk cluster health || true
echo "Broker restart complete."
