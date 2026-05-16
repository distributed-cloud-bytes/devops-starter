#!/usr/bin/env bash
set -euo pipefail

BROKER="${KAFKA_BROKER:-redpanda:9092}"

until rpk topic list --brokers "$BROKER" >/dev/null 2>&1; do
  echo "Waiting for broker at $BROKER..."
  sleep 2
done

TOPICS=(
  order.created.v1 order.cancelled.v1 inventory.reserved.v1 payment.captured.v1
  order.created.v1.dlq order.cancelled.v1.dlq inventory.reserved.v1.dlq payment.captured.v1.dlq
)

for t in "${TOPICS[@]}"; do
  rpk topic create "$t" --brokers "$BROKER" --partitions 3 --replicas 1 || true
done

echo "Topics created or already exist."
