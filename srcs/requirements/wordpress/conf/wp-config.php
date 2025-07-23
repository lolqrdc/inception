<?php

// ** Configuration de la base de données MySQL
define('DB_NAME', getenv('MARIADB_DATABASE'));
define('DB_USER', getenv('MARIADB_USER'));
define('DB_PASSWORD', getenv('MARIADB_PASSWORD'));
define('DB_HOST', 'mariadb');
define('DB_CHARSET', 'utf8mb4');
define('DB_COLLATE', '');

// ** Définition de clés uniques d'authentification et salage
define('AUTH_KEY',         '|ZCN&EM_+7||t6.+1e?Wf*)[rO@#Sj{ODE6%bAGf!qD<u&2gnwJu5_{B*(.VHOCb');
define('SECURE_AUTH_KEY',  '7]_a+=8~Cci!+|jpiQZ60$4+v1-^{_iG.@yk#L;ZmbZt)LUihD+x8w+A}xqG@Xm<');
define('LOGGED_IN_KEY',    'wIp:q-IAB<:X]0*Btz`h$c @:0)-k9PgxOY]Bccxd${CH53r>hOTYHAQ7c[](r{~');
define('NONCE_KEY',        'm_pclra}B(-`c0D5 OmP6-7og`J.xyGK*0a-#>Co2%|W^d?n%6MYRpFG{a;;A|k7');
define('AUTH_SALT',        '#|]%w{o,9M|z.Rf^GJprjVs,BHR`{!2XYb# sj-`CG1P^wnsb-2X[}!2!5@Bu%,c');
define('SECURE_AUTH_SALT', '|I5N<gsHbIE!qG=Dgay/KJ_5*5cRw,1@OZzk-Q8^G.uW^ 1U<?Y 6|U4S]ab*u,}');
define('LOGGED_IN_SALT',   '6Le+ *PT+PfnlQ*14rQ+EhW5`+,NA{@-5]xc_R-jEpE$`y^+5p;~@UeaqQ_7+>}8');
define('NONCE_SALT',       'hZk;i.o)U*9-$*_5E/BQV dIWoIL#q!2/e3GzTQPQw#-7S{QN%l {Y>!Uj*r%Y)9');

// ** Préfixe des tables wordpress
$table_prefix  = 'wp_';

// ** Pour le debug en dev
define('WP_DEBUG', false);

// ** Chemin absolu vers le dossier wordpress
if ( !defined('ABSPATH') )
    define('ABSPATH', dirname(__FILE__) . '/');

// ** Charger les fichiers de settings wordpress
require_once(ABSPATH . 'wp-settings.php');


