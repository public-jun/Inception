srcs := ./srcs
DC := cd $(srcs) && docker-compose

.PHONY:	all
all: upd

.PHONY:	up
up:
	$(DC) up -d

.PHONY: upd
upd:
	$(DC) up -d --build

.PHONY: down
down:
	$(DC) down -v

.PHONY: logs
logs:
	$(DC) logs

.PHONY: ps
ps:
	$(DC) ps

.PHONY: clean
clean:	down

.PHONY: fclean
fclean:
	$(DC) down --rmi all --volumes --remove-orphans
	sudo rm -rf /home/jnakahod/data/wp/* /home/jnakahod/data/db/*

.PHONY: re
re:	fclean all