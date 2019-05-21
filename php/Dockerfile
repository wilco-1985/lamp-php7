FROM php:7.3.3-apache

RUN apt-get update && apt-get install -y mysql-client \
zlib1g-dev libzip-dev libxml2-dev ca-certificates curl git subversion vim wget ssmtp libfreetype6-dev libjpeg62-turbo-dev libpng-dev

RUN pecl install xdebug-2.7.0 && docker-php-ext-enable xdebug 

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ 
RUN docker-php-ext-install gd 

RUN a2enmod rewrite macro
RUN docker-php-ext-install mysqli  \
&& docker-php-ext-install zip \
&& docker-php-ext-install soap

COPY lamp.ini /usr/local/etc/php/conf.d/lamp.ini
#COPY ssmtp.conf /etc/ssmtp/ssmtp.conf
COPY .vimrc /root/.vimrc
COPY .vim/ /root/.vim/

ADD apache-config.conf /etc/apache2/sites-enabled/000-default.conf

RUN service apache2 restart