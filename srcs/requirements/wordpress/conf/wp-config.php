<?php

// ** Configuration de la base de données MySQL
define('DB_NAME', $_ENV['MARIADB_DATABASE'] ?? 'wordpress');
define('DB_USER', $_ENV['MARIADB_USER'] ?? 'wpuser');
define('DB_PASSWORD', $_ENV['MARIADB_PASSWORD'] ?? 'wppass123');
define('DB_HOST', 'mariadb');
define('DB_CHARSET', 'utf8mb4');
define('DB_COLLATE', '');

// ** Clés uniques d'authentification et salage
define('AUTH_KEY',         'mettre_une_phrase_unique_ici');
define('SECURE_AUTH_KEY',  'mettre_une_phrase_unique_ici');
define('LOGGED_IN_KEY',    'mettre_une_phrase_unique_ici');
define('NONCE_KEY',        'mettre_une_phrase_unique_ici');
define('AUTH_SALT',        'mettre_une_phrase_unique_ici');
define('SECURE_AUTH_SALT', 'mettre_une_phrase_unique_ici');
define('LOGGED_IN_SALT',   'mettre_une_phrase_unique_ici');
define('NONCE_SALT',       'mettre_une_phrase_unique_ici');

// ** Préfixe des tables wordpress
$table_prefix  = 'wp_';

// ** Pour le debug en dev
define('WP_DEBUG', false);

// ** Chemin absolu vers le dossier wordpress
if ( !defined('ABSPATH') )
    define('ABSPATH', dirname(__FILE__) . '/');

// ** Charge les fichiers de settings wordpress
require_once(ABSPATH . 'wp-settings.php');


