FROM codecasts/alpine-3.7:php-7.2

RUN set -ex \
    && apk add --no-cache --update curl\
    vim \
    git \
    curl \
    bash \
    postgresql-dev


RUN apk add --update php-apache2@php  php-common@php php-pgsql@php php-pdo_pgsql@php php-pdo_mysql@php
RUN ln -s /usr/bin/php7 /usr/bin/php

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer


RUN sed -i '/LoadModule rewrite_module/s/^#//g' /etc/apache2/httpd.conf && \
    sed -i 's#AllowOverride [Nn]one#AllowOverride All#' /etc/apache2/httpd.conf  && \
    sed -i '/LoadModule expires_module/s/^#//g' /etc/apache2/httpd.conf && \
    sed -i '/LoadModule deflate_module/s/^#//g' /etc/apache2/httpd.conf && \
    sed -i '/LoadModule headers_module/s/^#//g' /etc/apache2/httpd.conf

RUN sed -ri -e 's!#ServerName www.example.com:80!ServerName localhost:80!g'  /etc/apache2/httpd.conf
RUN mkdir -p /run/apache2/


ADD 00_config.ini /etc/php7/conf.d/


# Bind logs to stdout
RUN ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log

COPY mpm.conf /etc/apache2/conf.d/mpm.conf