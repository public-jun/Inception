FROM alpine:3.15

# install mariadb
RUN apk add --update --upgrade --no-cache \
		mariadb \
	&& rm -rf /var/cache/apk/*

ENV MYSQL_USER=user
ENV MYSQL_PASSWORD=pass
ENV MYSQL_DATABASE=db
ENV MYSQL_ROOT_PASSWORD=pass

COPY ./tools/docker-entrypoint.sh /var/tmp

RUN mv /var/tmp/docker-entrypoint.sh /usr/local/bin; \
	chmod +x /usr/local/bin/docker-entrypoint.sh;

EXPOSE 3306

ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "/usr/bin/mysqld", "--user=mysql", "--console", "--skip-name-resolve", "--skip-networking=0" ]