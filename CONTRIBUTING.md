# Contributing

Thank you for improving **devops-starter**.

1. Fork `distributed-cloud-bytes/devops-starter`
2. Create a branch from `main`
3. Keep changes generic (no product-specific domains or secrets)
4. Run `docker compose -f environments/dev/compose/docker-compose.yml config` before opening a PR
5. Open a pull request with a clear description and test notes
6. When you change ports, networks, Make targets, or user-facing behavior, update the root [README](README.md) and the relevant guide under [docs/README.md](docs/README.md)

## Scope

In scope: Compose, Kafka topic catalog, scripts, docs, CI.

Out of scope: Application microservice source code (belongs in your app repository).
