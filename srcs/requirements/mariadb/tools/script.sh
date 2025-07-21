#!/bin/sh
set -e

echo "==> Initializing MariaDB..."

# Si pas encore initialisé
if [ ! -f "/var/lib/mysql/.initialized" ]; then
    echo "==> First run - setting up database..."
    
    # Initialiser MariaDB
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
    
    # Générer le script SQL avec les vraies variables
    envsubst < /tools/init.sql > /tmp/init_final.sql
    
    # Démarrer avec le script d'initialisation
    mariadbd --user=mysql --init-file=/tmp/init_final.sql &
    MYSQL_PID=$!
    
    # Attendre que l'initialisation soit terminée
    sleep 10
    
    # Arrêter le processus temporaire
    kill $MYSQL_PID 2>/dev/null || true
    wait $MYSQL_PID 2>/dev/null || true
    
    # Marquer comme initialisé
    touch /var/lib/mysql/.initialized
    echo "==> Database initialized successfully"
fi

echo "==> Starting MariaDB..."
exec mariadbd --user=mysql