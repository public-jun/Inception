FROM alpine:3.15

RUN apk add --update --no-cache nginx

#EXPOSE 443

RUN mkdir -p /var/www/html

COPY ./tools/index.html /var/www/html/
COPY ./conf/default.conf /etc/nginx/http.d/default.conf

#ENTRYPOINT /usr/sbin/nginx -g "daemon off;" -c /etc/nginx/nginx.conf
CMD nginx -g "daemon off;"