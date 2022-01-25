#!/bin/sh

wp core download --force --path="${WORDPRESS_PATH}" --locale=ja
echo "wordpress download"
chmod -R 777 /var/www/html/wp-content

until mysql -h"${WORDPRESS_DB_HOST}" -u"${WORDPRESS_DB_USER}" -p"${WORDPRESS_DB_PASSWORD}" &> /dev/null; do
	>&2 echo -n "."
	sleep 1
done
>&2 echo "Database is up"


wp config create --force --dbname="${WORDPRESS_DB_NAME}" --dbuser="${WORDPRESS_DB_USER}" --dbpass="${WORDPRESS_DB_PASSWORD}" --dbhost="${WORDPRESS_DB_HOST}" --path="${WORDPRESS_PATH}"
echo "config ceate"

wp core install \
	--url=https://"${DOMAIN_NAME}" \
	--title="${TITLE}" \
	--admin_user="${WORDPRESS_ADMIN_USER}" \
	--admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
	--admin_email="${WORDPRESS_ADMIN_EMAIL}" \
	--path="${WORDPRESS_PATH}" \
	--allow-root
echo "admin user wordpress "

wp user create "${WORDPRESS_EDITOR_USER}" \
	"${WORDPRESS_EDITOR_EMAIL}" \
	--user_pass="${WORDPRESS_EDITOR_PASSWORD}" \
	--role="${WORDPRESS_EDITOR_ROLE}" \
	--path="${WORDPRESS_PATH}" \
	--allow-root

chown -R nginx:nginx /var/www/html

exec $@