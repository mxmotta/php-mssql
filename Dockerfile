FROM alpine:3.12.3
LABEL Maintainer="Marcelo Motta <marcelo.motta@gmail.com>"

RUN apk --no-cache add php7 php7-fpm php7-pdo_dblib nginx supervisor

COPY nginx.conf /etc/nginx/conf.d/default.conf
RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN chown -R nginx.nginx /run && \
  mkdir /run/nginx && \
  chown -R nginx:nginx /var/lib/nginx && \
  chown -R nginx:nginx /var/log/nginx

RUN mkdir -p /var/www/html

WORKDIR /var/www/html

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
