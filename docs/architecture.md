# Architecture (local dev)

```text
┌─────────────┐     ┌──────────────┐     ┌─────────────────┐
│ Your apps   │────▶│   Redpanda   │────▶│ Schema Registry │
│ (external)  │     │  (Kafka API) │     │                 │
└──────┬──────┘     └──────────────┘     └─────────────────┘
       │
       ▼
┌─────────────┐
│  PostgreSQL │
└─────────────┘

Optional: observability-starter (Prometheus/Grafana) on shared Docker network `platform-dev`.
```

## Components

| Component | Role |
|-----------|------|
| PostgreSQL | Relational store for services using JDBC |
| Redpanda | Kafka-compatible event broker |
| Schema Registry | Avro/JSON schema compatibility (Confluent API) |
| kafka-init | One-shot job; creates topics from your YAML catalog |

## Network

Compose creates Docker network **`platform-dev`** so [observability-starter](https://github.com/distributed-cloud-bytes/observability-starter) can scrape services by container name when both stacks run.

See [getting-started-full-stack.md](getting-started-full-stack.md).
