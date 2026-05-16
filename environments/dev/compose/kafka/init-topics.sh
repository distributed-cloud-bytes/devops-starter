#!/usr/bin/env bash
set -euo pipefail

BROKER="${KAFKA_BROKER:-redpanda:9092}"
TOPIC_FILE="${TOPIC_DEFINITIONS_FILE:-/topics/topic-definitions.yaml}"
DLQ_FILE="${DLQ_TOPICS_FILE:-/topics/dlq-topics.yaml}"

until rpk topic list --brokers "$BROKER" >/dev/null 2>&1; do
  echo "Waiting for broker at $BROKER..."
  sleep 2
done

if [[ ! -f "$TOPIC_FILE" ]]; then
  echo "Topic file not found ($TOPIC_FILE). Skipping topic creation."
  exit 0
fi

read_yaml_default() {
  local key="$1" fallback="$2"
  local v
  v="$(grep -E "^${key}:" "$TOPIC_FILE" | head -1 | sed -E "s/^${key}:[[:space:]]*//;s/\r$//")"
  if [[ -n "$v" ]]; then
    echo "$v"
  else
    echo "$fallback"
  fi
}

DEFAULT_PARTITIONS="$(read_yaml_default defaultPartitions "${KAFKA_DEFAULT_PARTITIONS:-3}")"
DEFAULT_REPLICATION="$(read_yaml_default defaultReplicationFactor "${KAFKA_DEFAULT_REPLICATION:-1}")"

mapfile -t TOPICS < <(grep -E '^\s+- name:\s+' "$TOPIC_FILE" | sed -E 's/^\s+- name:\s*//;s/\s+#.*$//;s/\r$//')

if [[ ${#TOPICS[@]} -eq 0 ]]; then
  echo "No topics in $TOPIC_FILE — skipping creation."
  echo "Add topics under 'topics:' then run: docker compose run --rm kafka-init"
  exit 0
fi

create_topic() {
  local name="$1"
  rpk topic create "$name" --brokers "$BROKER" \
    --partitions "$DEFAULT_PARTITIONS" --replicas "$DEFAULT_REPLICATION" || true
  echo "Created topic: $name"
}

for t in "${TOPICS[@]}"; do
  [[ -n "$t" ]] && create_topic "$t"
done

if [[ -f "$DLQ_FILE" ]]; then
  DLQ_SUFFIX="$(grep -E '^dlqSuffix:\s*' "$DLQ_FILE" | head -1 | sed -E 's/^dlqSuffix:\s*//;s/\r$//')"
  DLQ_SUFFIX="${DLQ_SUFFIX:-.dlq}"
  AUTO_DLQ="$(grep -E '^autoFromMainTopics:\s*' "$DLQ_FILE" | head -1 | sed -E 's/^autoFromMainTopics:\s*//;s/\r$//')"

  if [[ "$AUTO_DLQ" == "true" ]]; then
    for t in "${TOPICS[@]}"; do
      [[ -n "$t" ]] && create_topic "${t}${DLQ_SUFFIX}"
    done
  fi

  mapfile -t DLQ_TOPICS < <(awk '/^topics:/{flag=1;next} /^[a-zA-Z]/ && !/^  - /{if(flag) exit} flag && /^  - /{print $2}' "$DLQ_FILE" | sed 's/\r$//')
  for t in "${DLQ_TOPICS[@]}"; do
    [[ -n "$t" ]] && create_topic "$t"
  done
fi

echo "kafka-init finished."
