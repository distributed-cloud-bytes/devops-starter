# Operations

## Make targets

| Command | Action |
|---------|--------|
| `make up` | Start the dev Compose stack (`environments/dev/compose`) |
| `make down` | Stop the stack |
| `make ps` | List Compose services |
| `make health` | Run `scripts/stack-health.sh` (Schema Registry and optional Postgres checks) |
| `make topics-init` | Re-run `kafka-init` after changing topic YAML |
| `make validate` | Validate `docker-compose.yml` syntax |

## Verify Schema Registry

```bash
curl -s http://localhost:18081/subjects
```

Adjust the port if you override `SCHEMA_REGISTRY_PORT` in `.env`.

## Logs

```bash
cd environments/dev/compose
docker compose logs -f
```

Filter to a specific service using the service name from `docker-compose.yml` (for example the broker or Postgres).

## Topics lifecycle

- First `make up` runs `kafka-init` based on your `topic-definitions.yaml`.
- After editing topic YAML while the stack is running, apply changes with `make topics-init`.

See [messaging-topics.md](messaging-topics.md) for verification commands (`rpk`, etc.).

## Resource expectations

The README recommends **about 4 GB free RAM** for a comfortable local experience with Postgres, Redpanda, and Schema Registry together.

## Troubleshooting

| Symptom | Things to check |
|---------|------------------|
| Port already in use | Adjust host ports in `environments/dev/compose/.env` |
| Schema Registry empty or errors | Broker readiness, logs from Schema Registry and Redpanda |
| `make health` fails | URLs and ports in `scripts/stack-health.sh` vs your `.env` overrides |
| Cannot reach broker from host | Use `localhost:${KAFKA_HOST_PORT}` from the README defaults |

For security assumptions and reporting issues, see [SECURITY.md](../SECURITY.md).
