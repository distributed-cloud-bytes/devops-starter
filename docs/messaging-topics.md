# Define your own Kafka topics

This starter **does not ship domain topics**. The broker starts without application topics until you add them. That keeps the template generic and avoids unwanted topics in Docker Compose.

## Files to edit

| File | Purpose |
|------|---------|
| `platform/messaging/kafka/topics/topic-definitions.yaml` | Topics `kafka-init` creates |
| `platform/messaging/kafka/topics/topic-definitions.example.yaml` | Examples (not applied automatically) |
| `platform/messaging/kafka/dlq/dlq-topics.yaml` | Optional DLQ topics |
| `platform/messaging/kafka/schemas/registry-config/config.yaml` | Schema Registry subject notes |
| `platform/messaging/kafka/acl/service-acl.md` | ACL template for production |

## Step 1 — Add main topics

Edit `platform/messaging/kafka/topics/topic-definitions.yaml`:

```yaml
defaultPartitions: 3
defaultReplicationFactor: 1

topics:
  - name: billing.invoice.created.v1
  - name: billing.invoice.paid.v1
```

Use your own domain names (`billing.`, `shipping.`, etc.) and a version suffix (`.v1`).

See `topic-definitions.example.yaml` for a fuller sample.

## Step 2 — Create topics on the broker

```bash
cd environments/dev/compose
docker compose up -d
```

`kafka-init` runs once and creates **only** the topics you listed.

**Added topics after the stack is already up?**

```bash
cd environments/dev/compose
docker compose run --rm kafka-init
```

**Verify:**

```bash
docker exec dcb-redpanda rpk topic list --brokers localhost:9092
```

## Step 3 — Start with no topics (default)

The repo ships with:

```yaml
topics: []
```

`kafka-init` skips creation and exits successfully. Postgres, Redpanda, and Schema Registry still start.

## Step 4 — Optional DLQ topics

Edit `platform/messaging/kafka/dlq/dlq-topics.yaml`.

**Auto DLQ for every main topic:**

```yaml
dlqSuffix: .dlq
autoFromMainTopics: true
topics: []
```

**Explicit DLQ names only:**

```yaml
dlqSuffix: .dlq
autoFromMainTopics: false
topics:
  - billing.invoice.created.v1.dlq
```

Re-run `docker compose run --rm kafka-init` after changes.

## Step 5 — Schema Registry (optional)

Document subject compatibility in `platform/messaging/kafka/schemas/registry-config/config.yaml`:

```yaml
compatibility: BACKWARD
subjects:
  - name: billing.invoice.created.v1-value
    compatibility: BACKWARD
```

Register schemas from your application; this file is a team catalog.

## Step 6 — ACLs (production)

Local dev uses PLAINTEXT Kafka (no ACL enforcement). Plan production ACLs in `platform/messaging/kafka/acl/service-acl.md`.

## Connect your application

```properties
spring.kafka.bootstrap-servers=localhost:19092
# schema.registry.url=http://localhost:18081
```

Publish/consume only the topic names you defined.

## Troubleshooting

| Issue | What to do |
|-------|------------|
| No topics appear | Confirm `topics:` entries use `- name: your.topic.v1` |
| Topics missing after edit | Run `docker compose run --rm kafka-init` |
| Remove a test topic | `docker exec dcb-redpanda rpk topic delete your.topic.v1 --brokers localhost:9092` |
| Reset everything | `docker compose down -v` (destroys Postgres data) |
