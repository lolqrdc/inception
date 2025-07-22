FROM alpine:3.21.2

# Installer PHP et ses extensions
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

# Créer un utilisateur www-data de manière sécurisée
RUN if ! getent group www-data > /dev/null 2>&1; then \
        addgroup -S www-data; \
    fi && \
    if ! getent passwd www-data > /dev/null 2>&1; then \
        adduser -S -G www-data www-data; \
    fi

# Créer le dossier pour WordPress (correspondant au docker-compose)
RUN mkdir -p /var/www/wordpress

# Télécharger et installer WordPress
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

# Copier un fichier de configuration WordPress
COPY ./conf/wp-config.php /var/www/wordpress/wp-config.php

# Permissions
RUN chown -R www-data:www-data /var/www/wordpress && \
    chmod -R 755 /var/www/wordpress && \
    chmod 777 /var/www/wordpress/wp-content

# Exposer le port PHP-FPM
EXPOSE 9000

# Démarrer PHP-FPM avec l'utilisateur www-data
CMD ["php-fpm82", "-F"]