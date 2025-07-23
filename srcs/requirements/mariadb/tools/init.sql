-- Créer la base de données
CREATE DATABASE IF NOT EXISTS `${MARIADB_DATABASE}`;

-- Créer l'utilisateur pour tous les hosts possibles (accès à distance et local)
CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}'; 
CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'localhost' IDENTIFIED BY '${MARIADB_PASSWORD}';

-- Donner tous les privilèges
GRANT ALL PRIVILEGES ON `${MARIADB_DATABASE}`.* TO '${MARIADB_USER}'@'%';
GRANT ALL PRIVILEGES ON `${MARIADB_DATABASE}`.* TO '${MARIADB_USER}'@'localhost';

-- Configuration root
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';

-- Nettoyer et activer
DELETE FROM mysql.user WHERE User='';
FLUSH PRIVILEGES;
