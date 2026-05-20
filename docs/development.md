# Development

## Validate Compose

```bash
make validate
```

This expands `environments/dev/compose/docker-compose.yml` locally without starting containers.

## Continuous integration

[`.github/workflows/ci-validate.yml`](../.github/workflows/ci-validate.yml) runs the same validation on push and pull request.

## Scripts and helpers

| Path | Role |
|------|------|
| [`scripts/stack-health.sh`](../scripts/stack-health.sh) | Used by `make health` |
| [`scripts/dev-up.sh`](../scripts/dev-up.sh) | Optional helper for local workflows |
| [`scripts/resilience/chaos-broker-restart.sh`](../scripts/resilience/chaos-broker-restart.sh) | Experimental broker restart scenario |

## Load testing

[`loadtests/k6-broker-smoke.js`](../loadtests/k6-broker-smoke.js) contains a small k6 smoke script aimed at Schema Registry. Run k6 locally when you have it installed; this repository does not require k6 for the default Compose flow.

## Scope and contributing

Application microservice source code belongs in your services repositories, not in this starter. See [CONTRIBUTING.md](../CONTRIBUTING.md) for scope, branch expectations, and the [pull request template](../.github/pull_request_template.md).

When you change ports, Makefile targets, or stack behavior, update the root [README](../README.md) and the relevant section in [docs/README.md](README.md).
