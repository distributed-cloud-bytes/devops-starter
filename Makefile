.PHONY: up down ps health topics-init validate

COMPOSE_FILE := environments/dev/compose/docker-compose.yml

up:
	cd environments/dev/compose && docker compose up -d

down:
	cd environments/dev/compose && docker compose down

ps:
	cd environments/dev/compose && docker compose ps

health:
	bash scripts/stack-health.sh

topics-init:
	cd environments/dev/compose && docker compose run --rm kafka-init

validate:
	docker compose -f $(COMPOSE_FILE) config >/dev/null
	@echo "Compose config OK"
