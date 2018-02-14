FROM alpine:latest
RUN mkdir -p /var/www

COPY app/code /var/www/app/code
COPY app/design /var/www/app/design

VOLUME /var/www/app/code
VOLUME /var/www/app/design

CMD ["echo", "hello world"]
