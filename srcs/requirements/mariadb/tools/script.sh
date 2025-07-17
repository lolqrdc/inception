#!/bin/sh
set -e # Le script s'arrêtera qu'en cas d'erreur

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "==> Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql # 

    echo "==> Running SQL initialization script..."
    mysqld --user=mysql --bootstrap < /tools/init.sql
    echo "==> MariaDB initial setup complete."
fi

echo "==> Starting MariaDB server..."
exec mysqld --user=mysql
