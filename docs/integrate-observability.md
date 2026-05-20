# Integrate observability-starter

1. Start this stack (creates Docker network `platform-dev`):

   ```bash
   make up
   ```

2. Clone [observability-starter](https://github.com/distributed-cloud-bytes/observability-starter).

3. Start observability on the same network:

   ```bash
   docker compose -f docker-compose.yml -f docker-compose.platform-network.yml up -d
   ```

4. Add scrape jobs — see the observability documentation [index](https://github.com/distributed-cloud-bytes/observability-starter/blob/main/docs/README.md) and [scrape targets](https://github.com/distributed-cloud-bytes/observability-starter/blob/main/docs/scrape-targets.md).

Define Kafka topics first: [messaging-topics.md](messaging-topics.md).
