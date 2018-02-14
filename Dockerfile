FROM bluestreak/php:latest

WORKDIR /var/www

RUN [ ! -d pub ] && mkdir pub
RUN [ ! -d var ] && mkdir var
RUN [ ! -d app/etc ] && mkdir -p app/etc

COPY composer.json composer.lock auth.json ./
COPY .docker/composer-cache .docker/composer-cache

RUN chsh -s /bin/bash www-data \
    && chown -R www-data:www-data ./

RUN su - www-data -c "COMPOSER_CACHE_DIR=.docker/composer-cache composer update --no-dev --no-interaction --prefer-dist -o"

RUN chmod +x bin/magento

RUN chmod -R 777 /var/www/var
RUN chmod -R 777 /var/www/generated

VOLUME ["/var/www"]
ENTRYPOINT ["/usr/local/bin/docker-configure"]
CMD ["php-fpm"]
