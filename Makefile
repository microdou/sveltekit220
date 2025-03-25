dev:
	@docker compose -f ./docker-compose.dev.yml build --no-cache
	@docker compose -f ./docker-compose.dev.yml up
prod:
	@docker compose -f ./docker-compose.prod.yml build --no-cache
	@docker compose -f ./docker-compose.prod.yml up
