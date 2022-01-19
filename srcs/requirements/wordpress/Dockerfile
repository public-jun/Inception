FROM alpine:3.15

# php php-fpm build
RUN apk add --update --no-cache \
		php7 \
		php7-fpm \
	&& rm -rf /var/cache/apk/*

COPY ./tools/php-fpm.d/www.conf /etc/php7/php-fpm.d/www.conf

WORKDIR /tmp

RUN wget https://ja.wordpress.org/latest-ja.tar.gz

RUN addgroup -S nginx && adduser -S nginx -G nginx

CMD [ "/usr/sbin/php-fpm7", "--nodaemonize"]

