#!/bin/sh
set -e # Le script s'arrêtera qu'en cas d'erreur

echo "==> Checking if MariaDB needs initialization..."

# Forcer la réinitialisation si le fichier marqueur n'existe pas
if [ ! -f "/var/lib/mysql/.init_done" ]; then
    echo "==> Initializing MariaDB data directory..."
    
    # Supprimer les anciens fichiers si ils existent
    rm -rf /var/lib/mysql/* 2>/dev/null || true
    
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
    
    echo "==> Running SQL initialization script..."
    echo "==> Available environment variables:"
    env | grep MARIADB || echo "No MARIADB variables found!"
    
    envsubst < /tools/init.sql > /tmp/init_processed.sql
    echo "==> Processed SQL file:"
    cat /tmp/init_processed.sql
    
    mysqld --user=mysql --bootstrap < /tmp/init_processed.sql
    
    # Marquer l'initialisation comme terminée
    touch /var/lib/mysql/.init_done
    echo "==> MariaDB initial setup complete."
else
    echo "==> MariaDB already initialized, skipping setup"
fi

echo "==> Starting MariaDB server..."
exec mysqld --user=mysql
