#!/bin/bash

# Demander l'adresse IP ou le nom de domaine pour le ServerAlias
read -p "Entrez l'adresse IP ou le nom de domaine pour le ServerAlias : " SERVER_ALIAS

# Mettre à jour le système
apt update && apt upgrade -y

# Installer Apache, PHP et MariaDB
apt install apache2 php mariadb-server -y

# Installer les extensions PHP nécessaires
apt install php-{mysql,mbstring,curl,gd,xml,intl,ldap,apcu,xmlrpc,zip,bz2,imap} -y

# Sécuriser MariaDB
mysql_secure_installation

# Créer la base de données pour GLPI
mysql -u root -p <<EOF
CREATE DATABASE db_glpi;
GRANT ALL PRIVILEGES ON db_glpi.* TO 'admindb_glpi'@'localhost' IDENTIFIED BY '123';
FLUSH PRIVILEGES;
EXIT;
EOF

# Télécharger et extraire GLPI
cd /tmp
wget https://github.com/glpi-project/glpi/releases/download/10.0.17/glpi-10.0.17.tgz

# Vérifier l'intégrité du fichier téléchargé
if tar -tzf glpi-10.0.17.tgz > /dev/null 2>&1; then
    tar -xvzf glpi-10.0.17.tgz -C /var/www/html
else
    echo "Erreur : Le fichier téléchargé est corrompu ou incomplet."
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
systemctl restart apache2

echo "Installation de GLPI terminée. Accédez à http://$SERVER_ALIAS/glpi pour finaliser la configuration."
