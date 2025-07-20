NAME = inception

all:
	@docker compose -p $(NAME) -f srcs/docker-compose.yml up -d --build

down: 
	@docker compose -p $(NAME) -f srcs/docker-compose.yml down

clean: down
	@docker volume prune -f

fclean: clean
	@docker system prune -a -f

re: fclean all

.PHONY: all down clean fclean re