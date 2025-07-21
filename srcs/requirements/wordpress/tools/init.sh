#!/bin/sh
set -e

echo "==> Checking WordPress installation..."

# Créer le dossier /run/php s'il n'existe pas
if [ ! -d /run/php ]; then
    mkdir -p /run/php
fi

# Attendre que MariaDB soit prêt
echo "==> Waiting for database..."
while ! mariadb -h${DB_HOST} -u${DB_USER} -p${DB_PASSWORD} -e "SELECT 1" > /dev/null 2>&1; do
    sleep 2
done
echo "==> Database is ready!"

# Si WordPress n'est pas installé dans le volume
if [ ! -f /var/www/wordpress/wp-config.php ]; then
    echo "==> Installing WordPress..."
    
    # Télécharger WordPress avec WP-CLI
    cd /var/www/wordpress
    wp core download --allow-root
    
    # Copier la configuration
    cp /tmp/wp-config.php /var/www/wordpress/wp-config.php
    
    # Attendre un peu pour s'assurer que la DB est vraiment prête
    sleep 5
    
    # Installer WordPress avec la configuration initiale
    echo "==> Configuring WordPress..."
    wp core install \
        --url="${DOMAIN_NAME}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --allow-root
    
    # Créer un utilisateur supplémentaire
    echo "==> Creating additional user..."
    wp user create \
        "${WP_USER}" \
        "${WP_USER_EMAIL}" \
        --role=editor \
        --user_pass="${WP_USER_PASSWORD}" \
        --allow-root
    
    echo "==> WordPress configuration complete!"
else
    echo "==> WordPress already installed"
fi

# Corriger les permissions (utiliser l'UID/GID directement)
echo "==> Setting permissions..."
chown -R 82:82 /var/www/wordpress
chmod -R 755 /var/www/wordpress
chmod 775 /var/www/wordpress/wp-content

echo "==> Starting PHP-FPM..."
exec php-fpm82 -F
