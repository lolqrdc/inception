#!/bin/sh
set -e

# Forcer l'initialisation si le volume est vide ou pas encore initialisé
if [ -z "$(ls -A /var/lib/mysql 2>/dev/null)" ] || [ ! -f "/var/lib/mysql/.initialized" ]; then
    # Nettoyer complètement le répertoire
    rm -rf /var/lib/mysql/*
    
    # Initialiser MariaDB
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

    # Démarrer serveur temporaire pour configuration
    mariadbd --user=mysql --skip-networking --socket=/tmp/mysql_init.sock &
    MYSQL_PID=$!
    
    # Attendre le démarrage
    sleep 5
    
    # Exécuter le script d'initialisation SQL
    envsubst < /tools/init.sql | mariadb --socket=/tmp/mysql_init.sock
    
    # Arrêter le serveur temporaire
    kill $MYSQL_PID
    wait $MYSQL_PID
    
    # Marquer comme initialisé
    touch /var/lib/mysql/.initialized
fi

# Démarrer MariaDB en mode production
exec mariadbd --user=mysql