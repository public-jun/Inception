FROM alpine:3.15

# php php-fpm build
RUN apk add --update --no-cache \
		php7 \
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
		php7-pdo_mysql \
	&& rm -rf /var/cache/apk/*

COPY ./tools/php-fpm.d/www.conf /etc/php7/php-fpm.d/www.conf


RUN addgroup -S nginx \
	&& adduser -S nginx -G nginx; \
	[ ! -d /var/www/html ]; \
	mkdir -p /var/www/html/; \
	chmod 777 /var/www/html

WORKDIR /var/www/html

RUN wget https://wordpress.org/wordpress-5.8.3.tar.gz \
	&& tar -zxf wordpress-5.8.3.tar.gz \
	&& rm -f wordpress-5.8.3.tar.gz

CMD [ "/usr/sbin/php-fpm7", "--nodaemonize"]

