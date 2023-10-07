up:
	docker compose up -d

start: up

exec:
	docker exec -it gitea sh

down:
	docker-compose down

stop: down

delete: down
	docker volume rm gitea_gitea
