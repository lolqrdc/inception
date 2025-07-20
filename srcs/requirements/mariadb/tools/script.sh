#!/bin/sh
set -e # Le script s'arrêtera qu'en cas d'erreur

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "==> Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql # 

    echo "==> Running SQL initialization script..."
    envsubst < /tools/init.sql | mysqld --user=mysql --bootstrap
    echo "==> MariaDB initial setup complete."
fi

echo "==> Starting MariaDB server..."
exec mysqld --user=mysql
