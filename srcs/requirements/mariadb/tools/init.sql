-- Création de la basse wordpress si elle n'existe pas
CREATE DATABASE IF NOT EXISTS `${MARIADB_DATABASE}`;

-- Création de l'utilisateur avec son password
CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';

-- Accorder les privilèges sur la base à l'utilisateur wordpress
GRANT ALL PRIVILEGES ON `${MARIADB_DATABASE}`.* TO '${MARIADB_USER}'@'%';

-- Définit le password du root 
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';

-- Rendre tous les nouveaux utilisateurs/password/privilèges actifs immédiatement
FLUSH PRIVILEGES;
