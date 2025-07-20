#!/bin/sh
set -e # Le script s'arrêtera qu'en cas d'erreur

echo "==> Forcing MariaDB initialization..."

# TOUJOURS forcer la réinitialisation
echo "==> Initializing MariaDB data directory..."

# Supprimer TOUS les anciens fichiers
rm -rf /var/lib/mysql/* /var/lib/mysql/.* 2>/dev/null || true

mariadb-install-db --user=mysql --datadir=/var/lib/mysql

echo "==> Running SQL initialization script..."
echo "==> Available environment variables:"
env | grep MARIADB || echo "No MARIADB variables found!"

envsubst < /tools/init.sql > /tmp/init_processed.sql
echo "==> Processed SQL file:"
cat /tmp/init_processed.sql

mysqld --user=mysql --bootstrap < /tmp/init_processed.sql

echo "==> MariaDB initial setup complete."

echo "==> Starting MariaDB server..."
exec mysqld --user=mysql
