NAME =	inception

DOCKER_COMPOSE_CMD = docker compose
DOCKER_COMPOSE_PATH = srcs/docker-compose.yml

# Build et démarre les conteneurs
all:
	@if [ -f "./srcs/.env" ]; then \
		mkdir -p /home/loribeir/data/mariadb; \
		mkdir -p /home/loribeir/data/wordpress; \
		$(DOCKER_COMPOSE_CMD) -p $(NAME) -f $(DOCKER_COMPOSE_PATH) up --build -d; \
	else \
		echo "No .env file found in srcs folder, please create one before running make"; \
	fi

# Stoppe les conteneurs sans les supprimer
stop:
	$(DOCKER_COMPOSE_CMD) -p $(NAME) -f $(DOCKER_COMPOSE_PATH) stop

# Supprime les conteneurs, réseau et volumes associés
down:
	$(DOCKER_COMPOSE_CMD) -p $(NAME) -f $(DOCKER_COMPOSE_PATH) down -v

# Redémarre tout proprement
restart: down all

# DEBUG : afficher les logs de tous les conteneurs
logs:
	$(DOCKER_COMPOSE_CMD) -p $(NAME) -f $(DOCKER_COMPOSE_PATH) logs -f

# Afficher l'état des conteneurs
ps:
	$(DOCKER_COMPOSE_CMD) -p $(NAME) -f $(DOCKER_COMPOSE_PATH) ps

.PHONY: all stop down restart