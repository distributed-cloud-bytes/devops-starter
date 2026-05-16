# devops-starter

Generic **event-driven DevOps** starter from [Distributed Cloud Bytes](https://github.com/distributed-cloud-bytes). Run a local messaging and data plane without shipping application code in this repository.

## Standalone or combined?

| Mode | What you do | Needs the other repo? |
|------|-------------|------------------------|
| **Standalone** | Clone this repo → `make up` → connect your apps to Kafka/Postgres | **No** |
| **With observability** | Start this repo, then follow [docs/integrate-observability.md](docs/integrate-observability.md) | Optional — only if you want Prometheus/Grafana |

Each repository is independent. Nothing in Compose requires [observability-starter](https://github.com/distributed-cloud-bytes/observability-starter).

## Clone

```bash
git clone https://github.com/distributed-cloud-bytes/devops-starter.git
cd devops-starter
```

## Prerequisites

- Docker Desktop or Docker Engine with Compose v2
- ~4 GB free RAM

## Quick start

```bash
make up
# or: cd environments/dev/compose && docker compose up -d
```

Verify Schema Registry:

```bash
curl -s http://localhost:18081/subjects
```

## What runs

| Service | Host port | Notes |
|---------|-----------|--------|
| PostgreSQL 16 | 5433 | DB `platform`, user/password `platform` |
| Redpanda (Kafka API) | 19092 | Local broker |
| Schema Registry | 18081 | Confluent-compatible API |
| kafka-init | — | Creates topics **only if you define them** (see [docs/messaging-topics.md](docs/messaging-topics.md)) |

## Connect your applications

From the host machine:

| Variable | Example |
|----------|---------|
| Kafka bootstrap | `localhost:19092` |
| Schema Registry | `http://localhost:18081` |
| JDBC | `jdbc:postgresql://localhost:5433/platform` |

Spring Boot example:

```properties
spring.kafka.bootstrap-servers=localhost:19092
spring.datasource.url=jdbc:postgresql://localhost:5433/platform
```

## Repository layout

```text
environments/dev/compose/   Docker Compose stack
platform/messaging/kafka/   Your topic catalog (empty by default) and optional DLQ
loadtests/                  k6 smoke test (Schema Registry)
scripts/                    Health and resilience helpers
```

## Define Kafka topics

No domain topics are pre-created. Add yours in `platform/messaging/kafka/topics/topic-definitions.yaml` and follow **[docs/messaging-topics.md](docs/messaging-topics.md)**.

## Commands

| Command | Action |
|---------|--------|
| `make up` | Start dev stack |
| `make down` | Stop stack |
| `make topics-init` | Re-run topic creation after YAML changes |
| `make validate` | Validate Compose config |
| `make health` | Schema Registry (+ optional Postgres) check |

## Optional: run with observability-starter

1. Start this repo: `make up`
2. Follow [docs/integrate-observability.md](docs/integrate-observability.md) (clone observability-starter second)
3. Or use the full walkthrough: [docs/getting-started-full-stack.md](docs/getting-started-full-stack.md)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Open issues and pull requests in this repository.

## License

[Apache License 2.0](LICENSE)
