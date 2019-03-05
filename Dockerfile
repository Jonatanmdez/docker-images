FROM php:7.2-fpm

RUN mkdir -p /usr/share/man/man1/ /usr/share/man/man3/ /usr/share/man/man7/
RUN apt-get update \
	&& docker-php-ext-install pdo && docker-php-ext-install pdo_mysql sockets\
	&& docker-php-ext-install pcntl && apt-get install -y libpq-dev git postgresql-client-9.6  unzip zip\ 
    && docker-php-ext-install pdo_pgsql

RUN echo "memory_limit=-1" > /usr/local/etc/php/conf.d/memory-limit.ini


RUN pecl install xdebug && docker-php-ext-enable xdebug


RUN apt-get update && apt-get --no-install-recommends -y install curl software-properties-common gnupg libpng-dev \
      libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
      libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
      libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 \
      libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
      libnss3
RUN curl -sL https://deb.nodesource.com/setup_11.x |  bash -
RUN apt-get install -y nodejs


RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

