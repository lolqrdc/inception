#!/bin/sh
set -e

echo "==> Initializing MariaDB..."

# DEBUG : Vérifier l'état du système
echo "==> Checking initialization status..."
echo "Directory /var/lib/mysql contents:"
ls -la /var/lib/mysql/ || echo "Directory doesn't exist"
echo "File .initialized exists: $([ -f "/var/lib/mysql/.initialized" ] && echo "YES" || echo "NO")"

# Si pas encore initialisé
if [ ! -f "/var/lib/mysql/.initialized" ]; then
    echo "==> First run - setting up database..."
    
    # Vérifier que le répertoire est vide ou presque
    echo "==> Checking if MariaDB data directory is empty..."
    
    # Initialiser MariaDB
    echo "==> Running mariadb-install-db..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
    
    # Générer le script SQL avec les vraies variables
    echo "==> Generating SQL script..."
    envsubst < /tools/init.sql > /tmp/init_final.sql
    
    # DEBUG : Afficher le contenu
    echo "==> Generated SQL content:"
    cat /tmp/init_final.sql
    echo "==> End of SQL content"
    
    # Démarrer avec le script d'initialisation
    echo "==> Starting MariaDB with init file..."
    mariadbd --user=mysql --init-file=/tmp/init_final.sql &
    MYSQL_PID=$!
    
    # Attendre que l'initialisation soit terminée
    echo "==> Waiting for initialization to complete..."
    sleep 15
    
    # Arrêter le processus temporaire
    echo "==> Stopping temporary MariaDB process..."
    kill $MYSQL_PID 2>/dev/null || true
    wait $MYSQL_PID 2>/dev/null || true
    
    # Marquer comme initialisé
    touch /var/lib/mysql/.initialized
    echo "==> Database initialized successfully"
else
    echo "==> Database already initialized - file .initialized exists"
fi

echo "==> Starting MariaDB..."
exec mariadbd --user=mysql