NAME =	inception

DOCKER_COMPOSE_CMD = docker compose
DOCKER_COMPOSE_PATH = srcs/docker-compose.yml

all:
	@if [ -f "./srcs/.env" ]; then \
		mkdir -p /home/loribeir/data/mariadb; \
		mkdir -p /home/loribeir/data/wordpress; \
		$(DOCKER_COMPOSE_CMD) -p $(NAME) -f $(DOCKER_COMPOSE_PATH) up --build -d; \
	else \
		echo "No .env file found in srcs folder, please create one before running make"; \
	fi

stop:
	$(DOCKER_COMPOSE_CMD) -p $(NAME) -f $(DOCKER_COMPOSE_PATH) stop

down:
	$(DOCKER_COMPOSE_CMD) -p $(NAME) -f $(DOCKER_COMPOSE_PATH) down -v

restart: down all

logs:
	$(DOCKER_COMPOSE_CMD) -p $(NAME) -f $(DOCKER_COMPOSE_PATH) logs -f

ps:
	$(DOCKER_COMPOSE_CMD) -p $(NAME) -f $(DOCKER_COMPOSE_PATH) ps

# Un shell "jetable" dans le conteneur alpine pour tester des cmds ou le réseau
test:
	docker run -it --rm alpine:3.21.2 sh

.PHONY: all stop down restart test