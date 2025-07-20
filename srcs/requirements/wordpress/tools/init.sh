#!/bin/sh
set -e

echo "==> Checking WordPress installation..."

# Si WordPress n'est pas installé dans le volume
if [ ! -f /var/www/wordpress/wp-config.php ]; then
    echo "==> Installing WordPress..."
    
    # Télécharger WordPress
    cd /var/www/wordpress
    wget https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz --strip-components=1
    rm latest.tar.gz
    
    # Copier la configuration
    cp /tmp/wp-config.php /var/www/wordpress/wp-config.php
    
    echo "==> WordPress installation complete"
fi

# Corriger les permissions
echo "==> Setting permissions..."
chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress
chmod 775 /var/www/wordpress/wp-content

echo "==> Starting PHP-FPM..."
exec php-fpm82 -F
