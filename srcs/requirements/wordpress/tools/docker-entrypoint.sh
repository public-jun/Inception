#!/bin/sh

wp core download --force --path=/var/www/html/wordpress --locale=ja
echo "wordpress download"
chmod -R 777 /var/www/html/wordpress/wp-content

until mysql -h"${WORDPRESS_DB_HOST}" -u"${WORDPRESS_DB_USER}" -p"${WORDPRESS_DB_PASSWORD}" &> /dev/null; do
	>&2 echo -n "."
	sleep 1
done
>&2 echo "Database is up"


wp config create --force --dbname=db --dbuser=user --dbpass=pass --dbhost=mariadb --path=/var/www/html/wordpress
echo "config ceate"

wp core install \
	--url=https://jnakahod.42.fr \
	--title=inception \
	--admin_user=wordpress \
	--admin_password=wordpress \
	--admin_email=wp@example.com \
	--path=/var/www/html/wordpress \
	--allow-root
echo "admin user wordpress "

wp user create editor editor@example.com \
	--user_pass=editor \
	--role=editor \
	--path=/var/www/html/wordpress \
	--allow-root


# if [ -d "/var/www/html/wordpress" ]; then
# 	echo "[i] wordpress already present, skipping creation"
# else
# 	echo "[i] wordpress not found, creating....."
# 	wget https://wordpress.org/wordpress-5.8.3.tar.gz
# 	tar -zxf wordpress-5.8.3.tar.gz
# 	cp -r wordpress /var/www/html/
# 	rm -f wordpress-5.8.3.tar.gz
# fi
chown -R nginx:nginx /var/www/html

exec $@