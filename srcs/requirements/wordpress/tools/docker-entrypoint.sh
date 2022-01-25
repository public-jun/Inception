#!/bin/sh

if [ "$(getent group www-data | cut -f 1 -d ":")" = "www-data" ]; then
	echo "www-data group found"
else
	echo "www-data group not found... add now"
	addgroup -g 82 -S www-data
	echo "www-data group added"
fi

if [ "$(getent passwd www-data | cut -f 1 -d ":")" = "www-data" ]; then
	echo "www-data user found"
else
	echo "www-data user not found... add now"
	adduser -u 82 -D -S -G www-data www-data
	echo "www-data user added"
fi
chown www-data:www-data /var/www/html

echo "wordpress download now"
wp core download --force --path="${WORDPRESS_PATH}" --locale=ja
chmod -R 777 /var/www/html/wp-content

echo "Waiting for database"
until mysql -h"${WORDPRESS_DB_HOST}" -u"${WORDPRESS_DB_USER}" -p"${WORDPRESS_DB_PASSWORD}" &> /dev/null; do
	>&2 echo -n "."
	sleep 1
done
>&2 echo "Database is up"


wp config create --force --dbname="${WORDPRESS_DB_NAME}" --dbuser="${WORDPRESS_DB_USER}" --dbpass="${WORDPRESS_DB_PASSWORD}" --dbhost="${WORDPRESS_DB_HOST}" --path="${WORDPRESS_PATH}"
echo "config ceate"

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

chown -R www-data:www-data /var/www/html

exec $@