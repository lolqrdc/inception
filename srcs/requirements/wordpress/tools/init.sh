#!/bin/sh
set -e

echo "==> Checking WordPress installation..."

# Creer le dossier /run/php
if [ ! -d /run/php ]; then
    mkdir -p /run/php
fi

# Attendre MariaDB
while ! mariadb -h mariadb -u${MARIADB_USER} -p${MARIADB_PASSWORD} -e "SELECT 1" > /dev/null 2>&1; do
    sleep 2
done

# Si WordPress n'est pas installé dans le volume
if [ ! -f /var/www/wordpress/wp-config.php ] || ! wp core is-installed --allow-root --path=/var/www/wordpress 2>/dev/null; then
    echo "==> Installing WordPress..."
    
# Télécharger WordPress avec WP-CLI
    cd /var/www/wordpress
    wp core download --allow-root --force
    
    # Copier la configuration
    cp /tmp/wp-config.php /var/www/wordpress/wp-config.php
    
    # Installer WordPress avec la configuration initiale
    echo "==> Configuring WordPress..."
    wp core install \
        --url="https://${WORDPRESS_URL}" \
        --title="${WORDPRESS_TITLE}" \
        --admin_user="${WORDPRESS_ADMIN_USER}" \
        --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
        --admin_email="${WORDPRESS_ADMIN_EMAIL}" \
        --allow-root
    wp user create \
        "${WORDPRESS_USER}" \
        "${WORDPRESS_USER_EMAIL}" \
        --role=editor \
        --user_pass="${WORDPRESS_USER_PASSWORD}" \
        --allow-root
        
    echo "==> WordPress configuration complete."
else 
    echo "==> WordPress already configured"
fi

# Corriger les permissions (utiliser l'UID/GID directement)
echo "==> Setting permissions..."
chown -R www-data:www-data/var/www/wordpress
chmod -R 755 /var/www/wordpress
chmod 775 /var/www/wordpress/wp-content

echo "==> Starting PHP-FPM..."
exec php-fpm82 -F
