FROM php:8.1-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libicu-dev \
    libxml2-dev \
    libzip-dev \
    unzip \
    git \
    cron \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        mysqli \
        intl \
        zip \
        soap \
        gd \
        opcache \
    && a2enmod rewrite \
    && rm -rf /var/lib/apt/lists/*

# PHP configuration
COPY php.ini /usr/local/etc/php/

# Download Moodle (LTS recommended)
WORKDIR /var/www/html
RUN git clone -b MOODLE_401_STABLE https://github.com/moodle/moodle.git .

# Moodle data directory
RUN mkdir /var/www/moodledata \
    && chown -R www-data:www-data /var/www

# Apache configuration
ENV APACHE_DOCUMENT_ROOT=/var/www/html
RUN sed -ri \
    -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' \
    /etc/apache2/sites-available/*.conf

EXPOSE 80
