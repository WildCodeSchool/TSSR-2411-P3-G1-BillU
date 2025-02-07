#!/bin/bash

# Vérifier les privilèges root
if [[ $EUID -ne 0 ]]; then
   echo "Ce script doit être exécuté en tant que root"
   exit 1
fi

# Demander l'adresse IP ou le nom de domaine pour le ServerAlias
read -p "Entrez l'adresse IP ou le nom de domaine pour le ServerAlias : " SERVER_ALIAS
if [ -z "$SERVER_ALIAS" ]; then
    echo "Erreur : L'adresse IP ou le nom de domaine est requis"
    exit 1
fi

# Mettre à jour le système
if ! apt update && apt upgrade -y; then
    echo "Erreur lors de la mise à jour du système"
    exit 1
fi

# Installer Apache, PHP et MariaDB
if ! apt install apache2 php mariadb-server -y; then
    echo "Erreur lors de l'installation des packages principaux"
    exit 1
fi

# Installer les extensions PHP nécessaires
if ! apt install php-{mysql,mbstring,curl,gd,xml,intl,ldap,apcu,xmlrpc,zip,bz2,imap} -y; then
    echo "Erreur lors de l'installation des extensions PHP"
    exit 1
fi

# Sécuriser MariaDB
mysql_secure_installation

# Demander les informations de la base de données
read -p "Entrez le nom de la base de données (par défaut: db_glpi): " DB_NAME
DB_NAME=${DB_NAME:-db_glpi}

read -p "Entrez le nom d'utilisateur de la base de données (par défaut: admindb_glpi): " DB_USER
DB_USER=${DB_USER:-admindb_glpi}

read -s -p "Entrez le mot de passe pour l'utilisateur de la base de données: " DB_PASSWORD
echo
DB_PASSWORD=${DB_PASSWORD:-123}

# Créer la base de données pour GLPI
mysql -u root -p <<EOF
CREATE DATABASE ${DB_NAME};
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';
FLUSH PRIVILEGES;
EXIT;
EOF

# Télécharger et extraire GLPI
cd /tmp || exit 1
if ! wget https://github.com/glpi-project/glpi/releases/download/10.0.17/glpi-10.0.17.tgz; then
    echo "Erreur lors du téléchargement de GLPI"
    exit 1
fi

# Vérifier l'intégrité du fichier téléchargé
if ! tar -tzf glpi-10.0.17.tgz > /dev/null 2>&1; then
    echo "Erreur : Le fichier téléchargé est corrompu ou incomplet"
    exit 1
fi

if ! tar -xvzf glpi-10.0.17.tgz -C /var/www/html; then
    echo "Erreur lors de l'extraction de GLPI"
    exit 1
fi

# Définir les permissions
chown -R www-data:www-data /var/www/html/glpi

# Créer et configurer le répertoire de configuration
mkdir /etc/glpi
cat <<EOL > /etc/glpi/local_define.php
<?php
define('GLPI_VAR_DIR', '/var/lib/glpi');
define('GLPI_LOG_DIR', '/var/log/glpi');
EOL

mv /var/www/html/glpi/config /etc/glpi
chown -R www-data:www-data /etc/glpi

# Déplacer les fichiers et créer les logs
mv /var/www/html/glpi/files /var/lib/glpi
mkdir /var/log/glpi
chown www-data:www-data /var/log/glpi

# Modifier downstream.php
cat <<EOL > /var/www/html/glpi/inc/downstream.php
<?php
define('GLPI_CONFIG_DIR', '/etc/glpi/');
if (file_exists(GLPI_CONFIG_DIR . '/local_define.php')) {
    require_once GLPI_CONFIG_DIR . '/local_define.php';
}
EOL

# Configurer PHP
sed -i 's/^session.cookie_httponly =.*/session.cookie_httponly = on/' /etc/php/8.2/apache2/php.ini

# Configurer Apache
cat <<EOL > /etc/apache2/sites-available/glpi.conf
<VirtualHost *:80>
    ServerAlias $SERVER_ALIAS
    DocumentRoot /var/www/html
    Alias "/glpi" "/var/www/html/glpi/public"
    <Directory /var/www/html/glpi>
        Require all granted
        RewriteEngine On
        RewriteCond %{REQUEST_FILENAME} !-f
        RewriteRule ^(.*)$ index.php [QSA,L]
    </Directory>
</VirtualHost>
EOL

# Activer le module rewrite et configurer le site
a2enmod rewrite
a2dissite 000-default.conf
a2ensite glpi.conf

# Redémarrer Apache
if ! systemctl restart apache2; then
    echo "Erreur lors du redémarrage d'Apache"
    exit 1
fi

# Vérifier que Apache est bien en cours d'exécution
if ! systemctl is-active --quiet apache2; then
    echo "Erreur : Apache n'est pas en cours d'exécution"
    exit 1
fi

echo "Installation de GLPI terminée avec succès."
echo "Accédez à http://$SERVER_ALIAS/glpi pour finaliser la configuration."
echo "Base de données : $DB_NAME"
echo "Utilisateur DB : $DB_USER"
exit 0
