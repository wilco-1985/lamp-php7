FROM php:7.4-apache

RUN apt-get update && apt-get install -y default-mysql-client -y \
zlib1g-dev libzip-dev libxml2-dev curl git unzip -y \
subversion vim wget msmtp libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
nodejs libc-client-dev libkrb5-dev iputils-ping

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -r
RUN apt-get install -y nodejs

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=1.8.6


RUN pecl channel-update pecl.php.net
RUN pecl install -o -f redis \
&& rm -rf /tmp/pear \
&& docker-php-ext-enable redis

RUN pecl install xdebug-3.0.2 && docker-php-ext-enable xdebug 

RUN docker-php-ext-configure gd \ 
--with-freetype=/usr/include/ \
--with-jpeg=/usr/include/ 

RUN docker-php-ext-install gd 

COPY ./cert/ssl.crt /etc/apache2/ssl/ssl.crt
COPY ./cert/ssl.key /etc/apache2/ssl/ssl.key

RUN a2enmod rewrite macro
RUN docker-php-ext-install mysqli  \
&& docker-php-ext-install zip \
&& docker-php-ext-install soap \
&& docker-php-ext-install pdo pdo_mysql \
&& docker-php-ext-install bcmath

RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
docker-php-ext-install imap

COPY lamp.ini /usr/local/etc/php/conf.d/lamp.ini
#COPY ssmtp.conf /etc/ssmtp/ssmtp.conf
COPY .vimrc /root/.vimrc
COPY .vim/ /root/.vim/

ADD apache-config.conf /etc/apache2/sites-enabled/000-default.conf
RUN a2enmod ssl
RUN a2enmod vhost_alias
#RUN a2enmod proxy
#RUN a2enmod proxy_http
#RUN a2enmod proxy_connect
RUN service apache2 restart

RUN mkdir -p /home/www-data
RUN chown -R www-data:www-data /home/www-data
USER www-data
ENV HOME /home/www-data
COPY ./.gitconfig /home/www-data/.gitconfig


