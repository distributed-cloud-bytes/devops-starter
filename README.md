# devops-starter

[![View on KikPlate](https://img.shields.io/static/v1?label=KikPlate&message=event-driven-devops-starter&color=0366d6&style=flat-square)](https://kikplate.dev/plates/event-driven-devops-starter)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)

Generic **event-driven DevOps** starter from [Distributed Cloud Bytes](https://github.com/distributed-cloud-bytes). Run a local messaging and data plane without shipping application code in this repository.

## Overview

| Topic | Description |
|-------|-------------|
| **Standalone use** | Clone this repo, run `make up`, and connect your apps to Kafka and PostgreSQL. No other repository required. |
| **Combined with observability-starter** | Start this stack first, then follow [Integrate observability-starter](docs/integrate-observability.md) for Prometheus and Grafana on `platform-dev`. |
| **PostgreSQL** | Local relational store on host port `5433` (database and role `platform` by default). |
| **Redpanda** | Kafka-compatible broker on host port `19092`. |
| **Schema Registry** | Confluent-compatible API on host port `18081`. |
| **Topic catalog** | No domain topics pre-created; define yours in `platform/messaging/kafka/topics/topic-definitions.yaml`. |
| **kafka-init** | One-shot Compose job that creates topics from your YAML catalog when the stack starts or when you run `make topics-init`. |

---

## Quick Start

The fastest way to run the platform locally is with Docker Compose.

```sh
git clone https://github.com/distributed-cloud-bytes/devops-starter.git
cd devops-starter

make up
# or: cd environments/dev/compose && docker compose up -d
```

Verify Schema Registry:

```sh
curl -s http://localhost:18081/subjects
```

| Service | Host port | Notes |
|---------|-----------|--------|
| PostgreSQL 16 | 5433 | DB `platform`, user/password `platform` |
| Redpanda (Kafka API) | 19092 | Local broker |
| Schema Registry | 18081 | Confluent-compatible API |
| kafka-init | — | Creates topics only if defined in YAML |

Connect from the host:

| Variable | Example |
|----------|---------|
| Kafka bootstrap | `localhost:19092` |
| Schema Registry | `http://localhost:18081` |
| JDBC | `jdbc:postgresql://localhost:5433/platform` |

**Prerequisites:** Docker Desktop or Docker Engine with Compose v2, and about 4 GB free RAM.

Install the CLI to scaffold this plate from a terminal.

## Install CLI

### macOS/Linux via Homebrew tap

```sh
brew tap kikplate/homebrew-kikplate
brew install kikplate
```

### Windows via Scoop

```powershell
scoop bucket add kikplate https://github.com/kikplate/scoop-bucket.git
scoop install kikplate
```

### Manual install from release archives (all platforms)

```sh
# Linux/macOS
tar -xzf kikplate-<version>-linux-amd64.tar.gz
sudo install kikplate-<version>-linux-amd64 /usr/local/bin/kikplate

# macOS example
tar -xzf kikplate-<version>-darwin-arm64.tar.gz
sudo install kikplate-<version>-darwin-arm64 /usr/local/bin/kikplate
```

```powershell
# Windows (PowerShell)
Expand-Archive .\kikplate-<version>-windows-amd64.zip -DestinationPath .
Move-Item .\kikplate-<version>-windows-amd64.exe kikplate.exe
# Add the folder containing kikplate.exe to PATH
```

### Build from source

```sh
go install github.com/kikplate/kikplate/cli@latest
```

Quick sanity check:

```sh
kikplate --help
kikplate config init
kikplate login
kikplate search --category devops
kikplate scaffold distributed-cloud-bytes/event-driven-devops-starter my-platform
```

---

## Documentation

| Document | Description |
|----------|-------------|
| [Architecture](docs/architecture.md) | Postgres, Redpanda, Schema Registry, kafka-init, and Docker network `platform-dev` |
| [Configuration](docs/configuration.md) | Compose path, environment variables, and port or credential overrides |
| [Messaging topics](docs/messaging-topics.md) | Topic catalog YAML, DLQ options, Schema Registry notes, verification |
| [Operations](docs/operations.md) | Make targets, health checks, logs, topic re-init, troubleshooting |
| [Development](docs/development.md) | Compose validation, CI, scripts, load tests, contribution workflow |
| [Integrate observability-starter](docs/integrate-observability.md) | Optional Prometheus/Grafana on the shared platform network |
| [Full stack walkthrough](docs/getting-started-full-stack.md) | Order of operations for devops-starter plus observability-starter |
| [Contributing](CONTRIBUTING.md) | Fork, branch, PR expectations, and doc maintenance |

---

## Repository Layout

```
environments/dev/compose/   Docker Compose stack
platform/messaging/kafka/   Topic catalog (empty by default) and optional DLQ
docs/                       Documentation
loadtests/                  k6 smoke test (Schema Registry)
scripts/                    Health and resilience helpers
.github/                    CI workflows
```

---

## License

[LICENSE](LICENSE)
