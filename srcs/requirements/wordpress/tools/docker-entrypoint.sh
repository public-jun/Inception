#!/bin/sh
set -eu

if [ "$1" = '/usr/sbin/php-fpm7' ]; then
	uid="$(id -u)"
	gid="$(id -g)"
	if [ "$uid" = '0' ]; then
		user='www-data'
		group='www-data'
	else
		user="$uid"
		group="$gid"
	fi

	if [ ! -e "${WORDPRESS_PATH}/index.php" ] && [ ! -e "${WORDPRESS_PATH}/wp=includes/version.php" ]; then
		if [ "$uid" = '0' ] && [ "$(stat -c '%u:%g' .)" = '0:0' ]; then
			chown "$user:$group" "${WORDPRESS_PATH}"
		fi

		echo >&2 "Wordpress not found in ${WORDPRESS_PATH}... download now"
		wp core download \
			--path="${WORDPRESS_PATH}" \
			--locale=ja \
			--version=5.8.3
		echo >&2 "Complete! WordPress has been successfully copied to ${WORDPRESS_PATH}"

		echo "Waiting for database"
		until mysql -h"${WORDPRESS_DB_HOST}" \
					-u"${WORDPRESS_DB_USER}" \
					-p"${WORDPRESS_DB_PASSWORD}" &> /dev/null; do >&2 echo -n "."
			sleep 1
		done
		>&2 echo "Database is up"

		echo "Generating wp-config.php "
		wp config create \
			--force \
			--dbname="${WORDPRESS_DB_NAME}" \
			--dbuser="${WORDPRESS_DB_USER}" \
			--dbpass="${WORDPRESS_DB_PASSWORD}" \
			--dbhost="${WORDPRESS_DB_HOST}" \
			--path="${WORDPRESS_PATH}"
		echo "DONE!"

		echo "Runs the standard WordPress installation process."
		wp core install \
			--url=https://"${DOMAIN_NAME}" \
			--title="${TITLE}" \
			--admin_user="${WORDPRESS_ADMIN_USER}" \
			--admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
			--admin_email="${WORDPRESS_ADMIN_EMAIL}" \
			--path="${WORDPRESS_PATH}" \
			--allow-root
		echo "Wordpress INFO
URL:https://${DOMAIN_NAME}
TITLR:${TITLE}
ADMIN_USER:${WORDPRESS_ADMIN_USER}
ADMIN_PASSWORD:xxx"

		echo "Creates a new user."
		wp user create "${WORDPRESS_EDITOR_USER}" \
			"${WORDPRESS_EDITOR_EMAIL}" \
			--user_pass="${WORDPRESS_EDITOR_PASSWORD}" \
			--role="${WORDPRESS_EDITOR_ROLE}" \
			--path="${WORDPRESS_PATH}" \
			--allow-root
		echo "New user info
LOGIN:${WORDPRESS_EDITOR_USER}
ROLE:${WORDPRESS_EDITOR_ROLE}"

	chown -R www-data:www-data "${WORDPRESS_PATH}"
	chmod 600 "${WORDPRESS_PATH}"/wp-config.php

	fi
fi

exec $@