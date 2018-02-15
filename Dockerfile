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

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install nodejs
RUN npm i -g m2-builder

COPY app app

RUN find . -user root | xargs chown www-data:www-data \
    && chmod +x bin/magento

RUN chmod +x bin/magento

RUN chmod -R 777 /var/www/var
RUN chmod -R 777 /var/www/generated

VOLUME ["/var/www/app/etc"]
VOLUME ["/var/www/pub"]
VOLUME ["/var/www/setup"]
VOLUME ["/var/www/var"]

ENTRYPOINT ["/usr/local/bin/docker-configure"]
CMD ["php-fpm"]
