# devops-starter

Generic **event-driven DevOps** starter from [Distributed Cloud Bytes](https://github.com/distributed-cloud-bytes). Run a local messaging and data plane without shipping application code in this repository.

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
cd environments/dev/compose
docker compose up -d
docker compose ps
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

## Companion starter

Metrics and dashboards: [observability-starter](https://github.com/distributed-cloud-bytes/observability-starter)

Integration guide: [docs/integrate-observability.md](docs/integrate-observability.md)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Open issues and pull requests in this repository.

## License

[Apache License 2.0](LICENSE)
