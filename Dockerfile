FROM php:7.2-fpm

RUN mkdir -p /usr/share/man/man1/ /usr/share/man/man3/ /usr/share/man/man7/
RUN apt-get update \
	&& docker-php-ext-install pdo && docker-php-ext-install pdo_mysql sockets\
	&& docker-php-ext-install pcntl && apt-get install -y libpq-dev git postgresql-client-9.6  unzip zip\ 
    && docker-php-ext-install pdo_pgsql

RUN echo "memory_limit=-1" > /usr/local/etc/php/conf.d/memory-limit.ini


RUN pecl install xdebug && docker-php-ext-enable xdebug 


RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

