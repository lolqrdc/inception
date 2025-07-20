#!/bin/sh
set -e # Le script s'arrêtera qu'en cas d'erreur

echo "==> Checking if MariaDB needs initialization..."

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "==> Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
    
    echo "==> Running SQL initialization script..."
    echo "==> Available environment variables:"
    env | grep MARIADB || echo "No MARIADB variables found!"
    
    envsubst < /tools/init.sql > /tmp/init_processed.sql
    echo "==> Processed SQL file:"
    cat /tmp/init_processed.sql
    
    mysqld --user=mysql --bootstrap < /tmp/init_processed.sql
    echo "==> MariaDB initial setup complete."
else
    echo "==> MariaDB already initialized, skipping setup"
fi

echo "==> Starting MariaDB server..."
exec mysqld --user=mysql
