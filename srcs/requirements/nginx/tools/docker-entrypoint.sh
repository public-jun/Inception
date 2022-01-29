#!/bin/sh

echo ">> Docker-ENTRYPOINT: GENERATING SSL CERT"

mkdir -p /etc/nginx/ssl/self
openssl genrsa \
	-out /etc/nginx/ssl/self/server.key 2048
openssl req -new \
	-subj "/C=JP/ST=Tokyo/L=Roppongi/O=42Tokyo/CN=localhost" \
	-key /etc/nginx/ssl/self/server.key \
	-out /etc/nginx/ssl/self/server.csr
openssl x509 -req \
	-in /etc/nginx/ssl/self/server.csr \
	-days 3650 \
	-signkey /etc/nginx/ssl/self/server.key \
	-out /etc/nginx/ssl/self/server.crt

echo ">> DOCKER-ENTRYPOINT: GERNRATING SSL CERT...DONE"
echo ">> DOCKER-ENTRYPOINT: EXECUTING CMD"

exec "$@"
