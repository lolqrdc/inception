FROM alpine:3.21.2

# Installation de PHP et les mise à jour
RUN apk update && apk add --no-cache \
    php82 \
    php82-fpm \
    php82-mysqli \
    php82-json \
    php82-curl \
    php82-dom \
    php82-exif \
    php82-fileinfo \
    php82-mbstring \
    php82-openssl \
    php82-xml \
    php82-zip \
    php82-phar \
    wget \
    curl \
    mariadb-client

# Installer WP-CLI
RUN curl -L https://raw.githubusercontent.com/wp-cli/wp-cli/v2.8.1/bin/wp-cli.phar -o wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Créer un utilisateur www-data
RUN if ! getent group www-data > /dev/null 2>&1; then \
        addgroup -S www-data; \
    fi && \
    if ! getent passwd www-data > /dev/null 2>&1; then \
        adduser -S -G www-data www-data; \
    fi

# Créer le dossier pour wordpress
RUN mkdir -p /var/www/wordpress

# Configuration PHP-FPM
RUN sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/' /etc/php82/php-fpm.d/www.conf && \
    sed -i 's/user = nobody/user = www-data/' /etc/php82/php-fpm.d/www.conf && \
    sed -i 's/group = nobody/group = www-data/' /etc/php82/php-fpm.d/www.conf && \
    sed -i 's/;clear_env = no/clear_env = no/' /etc/php82/php-fpm.d/www.conf

# Copier la configuration WordPress dans /tmp
COPY conf/wp-config.php /tmp/wp-config.php

# Copier et rendre exécutable le script d'initialisation
COPY tools/init.sh /tools/init.sh
RUN chmod +x /tools/init.sh

# Créer le dossier tools et donner les permissions
RUN mkdir -p /tools && chown -R www-data:www-data /tools


# Permettre à nginx de communiquer avec PHP-FPM
EXPOSE 9000

# Démarrer avec le script d'initialisation
CMD ["/tools/init.sh"]
