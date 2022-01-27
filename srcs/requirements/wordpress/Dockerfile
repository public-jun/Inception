FROM alpine:3.15

RUN set -ux; \
	addgroup -g 82 -S www-data; \
	adduser -u 82 -D -S -G www-data www-data

# php php-fpm build
RUN apk add --update --no-cache \
		php7 \
		php7-bcmath \
		php7-iconv \
		php7-intl \
		php7-mcrypt \
		php7-simplexml \
		php7-sodium \
		php7-xmlreader \
		php7-ssh2 \
		php7-ftp \
		php7-sockets \
		php7-fpm \
		php7-json \
		php7-curl \
		php7-dom \
		php7-exif \
		php7-fileinfo \
		php7-imagick \
		php7-mbstring \
		php7-openssl \
		php7-bcmath \
		php7-gd \
		php7-xml \
		php7-zip \
		php7-mysqli \
		php7-phar \
		mysql-client \
	&& rm -rf /var/cache/apk/*

COPY ./tools/php-fpm.d/www.conf /etc/php7/php-fpm.d/www.conf

RUN set -eux \
	[ ! -d /var/www/html/wordpress ]; \
	mkdir -p /var/www/html/wordpress

WORKDIR /tmp

RUN set -eux; \
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
	chmod +x wp-cli.phar; \
	mv wp-cli.phar /usr/local/bin/wp; \
	wp --allow-root --version

COPY ./tools/docker-entrypoint.sh /var/tmp

RUN mv /var/tmp/docker-entrypoint.sh /usr/local/bin; \
	chmod +x /usr/local/bin/docker-entrypoint.sh;

ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "/usr/sbin/php-fpm7", "--nodaemonize"]

