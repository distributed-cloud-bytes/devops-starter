# Full stack: devops + observability

## 1. Start devops-starter

```bash
git clone https://github.com/distributed-cloud-bytes/devops-starter.git
cd devops-starter
# optional: add topics in platform/messaging/kafka/topics/topic-definitions.yaml
make up
```

## 2. Start observability-starter on the same network

```bash
git clone https://github.com/distributed-cloud-bytes/observability-starter.git
cd observability-starter
docker compose -f docker-compose.yml -f docker-compose.platform-network.yml up -d
```

## 3. Configure scrape targets

Copy jobs from `prometheus/prometheus.example.yml` into `prometheus/prometheus.yml`, then reload Prometheus or restart the stack.

## 4. Open Grafana

http://localhost:3000 (default `admin` / `admin`)
