FROM bluestreak/deps:latest

COPY app app

RUN find . -user root | xargs chown www-data:www-data \
    && chmod +x bin/magento

RUN chmod -R 777 /var/www/var
RUN chmod -R 777 /var/www/generated

VOLUME ["/var/www"]
ENTRYPOINT ["/usr/local/bin/docker-configure"]
CMD ["php-fpm"]
