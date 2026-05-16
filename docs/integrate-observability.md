# Integrate observability-starter

1. Clone [observability-starter](https://github.com/distributed-cloud-bytes/observability-starter)
2. Start this dev stack: `cd environments/dev/compose && docker compose up -d`
3. Start observability: `docker compose up -d` in the observability repo
4. In `prometheus/prometheus.yml`, scrape your app or broker metrics on published host ports

Shared Docker network (optional): create an external network and attach both compose files to `platform-dev`.
