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
    wget \
    curl \
    mariadb-client

# Créer un utilisateur www-data
RUN if ! getent group www-data > /dev/null 2>&1; then \
        addgroup -S www-data; \
    fi && \
    if ! getent passwd www-data > /dev/null 2>&1; then \
        adduser -S -G www-data www-data; \
    fi

# Créer le dossier pour wordpress
RUN mkdir -p /var/www/wordpress /run/php

# Télécharger et installer wordpress
WORKDIR /var/www/wordpress
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz --strip-components=1 && \
    rm latest.tar.gz && \
    chown -R www-data:www-data /var/www/wordpress

# Configuration PHP-FPM
RUN sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/' /etc/php82/php-fpm.d/www.conf && \
    sed -i 's/user = nobody/user = www-data/' /etc/php82/php-fpm.d/www.conf && \
    sed -i 's/group = nobody/group = www-data/' /etc/php82/php-fpm.d/www.conf && \
    sed -i 's/;clear_env = no/clear_env = no/' /etc/php82/php-fpm.d/www.conf

# Copier la configuration WordPress
COPY conf/wp-config.php /var/www/wordpress/wp-config.php

# Vérification des permissions
RUN chmod -R 755 /var/www/wordpress && \
    chmod 775 /var/www/wordpress/wp-content


# Permettre à nginx de communiquer avec PHP-FPM
EXPOSE 9000

# Démarrer PHP-FPM
CMD ["php-fpm82", "-F"]
