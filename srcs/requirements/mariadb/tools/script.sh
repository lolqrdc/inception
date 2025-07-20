#!/bin/sh
set -e

# Vérifier si MariaDB est déjà complètement configuré
if [ ! -f "/var/lib/mysql/.init_done" ]; then
    echo "==> Removing any existing data..."
    rm -rf /var/lib/mysql/*
    
    echo "==> Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

    echo "==> Running SQL initialization script..."
    envsubst < /tools/init.sql | mysqld --user=mysql --bootstrap
    
    echo "==> Creating init marker..."
    touch /var/lib/mysql/.init_done
    echo "==> MariaDB initial setup complete."
else
    echo "==> MariaDB already initialized."
fi

echo "==> Starting MariaDB server..."
exec mysqld --user=mysql
