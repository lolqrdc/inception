NAME = inception

all:
	@docker compose -p $(NAME) -f srcs/docker-compose.yml up -d --build

down: 
	@docker compose -p $(NAME) -f srcs/docker-compose.yml down

logs: 
	@docker compose -p $(NAME) -f srcs/docker-compose.yml logs
clean: down
	@docker volume prune -f

fclean: clean
	@docker system prune -a -f
	@docker volume rm $(shell docker volume ls -q | grep $(NAME)) 2>/dev/null || true

re: fclean all

.PHONY: all down clean fclean re