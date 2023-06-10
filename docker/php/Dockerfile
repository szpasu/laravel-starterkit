FROM php:8.1-apache

RUN id -u www-datae &>/dev/null || useradd www-data


# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    nodejs \
    vim

# nvm environment variables
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 16.18.1

# install nvm
# https://github.com/creationix/nvm#install-script
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash

# install node and npm
RUN . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use --delete-prefix default

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql exif pcntl bcmath gd zip

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html


COPY ./src/package.json .
COPY ./src/package-lock.json .
COPY ./src/composer.json .
COPY ./src/composer.lock .
COPY ./src/. .

COPY ./docker/php/deployment.sh /usr/local/bin
RUN chmod 755  /usr/local/bin/deployment.sh

COPY ./docker/php/local.ini /usr/local/etc/php/conf.d/local.ini
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# 3. mod_rewrite for URL rewrite and mod_headers for .htaccess extra headers like Access-Control-Allow-Origin-
RUN a2enmod rewrite headers

RUN chown -R www-data:www-data /var/www/html

#Composer install
RUN if [ "${ENVIRONMENT}" == "production" ]; then COMPOSER_MEMORY_LIMIT=-1 composer install --optimize-autoloader--no-dev ; else COMPOSER_MEMORY_LIMIT=-1 composer install --optimize-autoloader; fi

RUN npm install
RUN npm run build

RUN touch .setup_complete
RUN rm .setup_complete

ENTRYPOINT ["/usr/local/bin/deployment.sh"]

EXPOSE 80
CMD ["apache2-foreground"]
