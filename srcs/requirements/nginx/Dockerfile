FROM alpine:3.15

RUN apk add --update --no-cache \
		nginx \
		openssl \
	&& rm -rf /var/cache/apk/*

EXPOSE 443

RUN mkdir -p /var/www/html

COPY ./conf/default.conf /etc/nginx/http.d/default.conf
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

COPY ./tools/docker-entrypoint.sh /var/tmp

RUN mv /var/tmp/docker-entrypoint.sh /usr/local/bin; \
	chmod +x /usr/local/bin/docker-entrypoint.sh;

ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "/usr/sbin/nginx", "-g", "daemon off;"]
