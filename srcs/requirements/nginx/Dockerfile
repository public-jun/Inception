FROM alpine:3.15

RUN apk add --update --no-cache \
		nginx \
		openssl \
	&& rm -rf /var/cache/apk/*

#EXPOSE 443

RUN mkdir -p /var/www/html

COPY ./tools/index.html /var/www/html/
COPY ./conf/default.conf /etc/nginx/http.d/default.conf

RUN mkdir -p /etc/nginx/ssl/self; \
	openssl genrsa \
		-out /etc/nginx/ssl/self/server.key 2048; \
	openssl req -new \
		-subj "/C=JP/ST=Tokyo/L=Roppongi/O=42Tokyo/CN=localhost" \
		-key /etc/nginx/ssl/self/server.key \
		-out /etc/nginx/ssl/self/server.csr; \
	openssl x509 -req \
		-in /etc/nginx/ssl/self/server.csr \
		-days 3650 \
		-signkey /etc/nginx/ssl/self/server.key \
		-out /etc/nginx/ssl/self/server.crt;

#COPY ./tools/docker-entrypoint.sh /var/tmp

#RUN mv /var/tmp/docker-entrypoint.sh /usr/local/bin; \
#	chmod +x /usr/local/bin/docker-entrypoint.sh;

#ENTRYPOINT [ "docker-entrypoint.sh" ]
#ENTRYPOINT /usr/sbin/nginx -g "daemon off;" -c /etc/nginx/nginx.conf
CMD [ "/usr/sbin/nginx", "-g", "daemon off;"]