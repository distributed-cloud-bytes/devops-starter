# Configuration

## Compose entrypoint

The development stack is defined in:

`environments/dev/compose/docker-compose.yml`

The [Makefile](../Makefile) sets `COMPOSE_FILE` to this path for `make validate` and related commands.

## Environment variables

Optional overrides live in `environments/dev/compose/.env` (not committed). Copy values from the repository [`.env.example`](../.env.example) as a starting point.

| Variable | Typical value | Purpose |
|----------|-----------------|---------|
| `POSTGRES_DB` | `platform` | Database name created for local dev |
| `POSTGRES_USER` | `platform` | Database role |
| `POSTGRES_PASSWORD` | `platform` | Database password (**change for anything beyond single-user local dev**) |
| `KAFKA_HOST_PORT` | `19092` | Host port for Kafka-compatible API |
| `SCHEMA_REGISTRY_PORT` | `18081` | Host port for Schema Registry HTTP API |
| `POSTGRES_HOST_PORT` | `5433` | Host port for PostgreSQL |

## Platform catalog files

| Path | Purpose |
|------|---------|
| `platform/messaging/kafka/topics/topic-definitions.yaml` | Topics created by `kafka-init` |
| `platform/messaging/kafka/dlq/dlq-topics.yaml` | Optional dead-letter topics |
| `platform/messaging/kafka/schemas/registry-config/config.yaml` | Registry-oriented metadata |
| `platform/messaging/kafka/acl/service-acl.md` | ACL notes for stricter environments |

See [messaging-topics.md](messaging-topics.md) for end-to-end topic workflow.

## Stage and production

Higher environments are placeholders only:

- [`environments/stage/README.md`](../environments/stage/README.md)
- [`environments/prod/README.md`](../environments/prod/README.md)

Adapt Compose, secrets, and networking for your organization before promoting beyond local development.
