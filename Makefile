srcs := ./srcs
tools_path = $(srcs)/requirements/tools
make_domain_sh = setup.sh
delete_domain_sh = delete_domain.sh

DC := cd $(srcs) && docker-compose

volume_path = `grep "VOLUME_PATH=" ./srcs/.env | sed -e "s/^.*=//"`

wp_volume_name = `grep "WP_VOLUME_NAME=" ./srcs/.env | sed -e "s/^.*=//"`
db_volume_name = `grep "DB_VOLUME_NAME=" ./srcs/.env | sed -e "s/^.*=//"`

wp_volume_path = $(volume_path)/$(wp_volume_name)
db_volume_path = $(volume_path)/$(db_volume_name)

.PHONY:	all
all: setup volume upd

.PHONY: setup
setup:
	sudo bash $(tools_path)/$(make_domain_sh)

.PHONY: volume
volume:
	sudo mkdir -p $(wp_volume_path)
	sudo mkdir -p $(db_volume_path)

.PHONY:	up
up:
	$(DC) up -d

.PHONY: upd
upd:
	$(DC) up -d --build

.PHONY: down
down:
	$(DC) down -v

.PHONY: clean
clean:	down

.PHONY: fclean
fclean:
	$(DC) down --rmi all --volumes --remove-orphans
	sudo rm -rf $(volume_path)
	sudo bash $(tools_path)/$(delete_domain_sh)

# utils rule
.PHONY: logs
logs:
	$(DC) logs

.PHONY: ps
ps:
	$(DC) ps


.PHONY: re
re:	fclean all