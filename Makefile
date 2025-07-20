NAME = inception

# PATH vers le docker compose, alias pour le fichier env
DOCKER_COMPOSE = srcs/docker-compose.yml
ENV_FILE = srcs/.env

# Build et lancer tous les containers (Mariadb, wordpress, nginx)
all:
	@if [ ! -f $(ENV_FILE) ]; then \
		echo "Please add a .env file inside the srcs folder."; \
		exit 1; \
	fi
	@docker compose -p $(NAME) -f $(DOCKER_COMPOSE) up -d --build

# Stopper et enlever les containers
down: 
	@docker compose -p $(NAME) -f $(DOCKER_COMPOSE) down

# Supprimer les volumes
clean: down
	@volumes=$$(docker volume ls -q | grep $(NAME)_ 2>/dev/null || true); \
	if [ -n "$$volumes" ]; then \
		docker volume rm $$volumes; \
	fi

# Supprimer les images custom
fclean: clean
	@images=$$(docker images -q $(NAME)_* 2>/dev/null || true); \
	if [ -n "$$images" ]; then \
		docker rmi $$images; \
	fi

# tout clean up et relancer proprement
re: fclean all

.PHONY: all down clean fclean re