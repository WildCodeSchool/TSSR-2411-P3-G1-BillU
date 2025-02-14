# 🌟 Explication détaillée du script `scriptGLPIv2build1ok.sh`

Ce script Bash automatise l'installation de **GLPI** sur un serveur Linux avec **Apache**, **PHP**, et **MariaDB**. Il configure également les permissions et optimise le serveur pour l'exécution de GLPI.

---

## 🚀 1. Vérification des privilèges root
```bash
if [[ $EUID -ne 0 ]]; then
   echo "Ce script doit être exécuté en tant que root"
   exit 1
fi
```
🔹 Vérifie si l'utilisateur exécutant le script est **root** (`EUID = 0`).  
🔹 Si ce n'est pas le cas, il affiche un message et **stoppe** l'exécution.

---

## 🌐 2. Demande du ServerAlias
```bash
read -p "Entrez l'adresse IP ou le nom de domaine pour le ServerAlias : " SERVER_ALIAS
if [ -z "$SERVER_ALIAS" ]; then
    echo "Erreur : L'adresse IP ou le nom de domaine est requis"
    exit 1
fi
```
🔹 Demande une **adresse IP** ou un **nom de domaine** pour la configuration Apache.  
🔹 Vérifie que la valeur n'est pas vide.

---

## 🔄 3. Mise à jour du système
```bash
if ! apt update && apt upgrade -y; then
    echo "Erreur lors de la mise à jour du système"
    exit 1
fi
```
🔹 Met à jour les paquets du système avec `apt update && apt upgrade -y`.  
🔹 Arrête le script en cas d'échec.

---

## 🛠️ 4. Installation des logiciels requis
```bash
if ! apt install apache2 php mariadb-server -y; then
    echo "Erreur lors de l'installation des packages principaux"
    exit 1
fi
```
🔹 Installe **Apache**, **PHP** et **MariaDB**.  
🔹 Arrête le script si une erreur survient.

### 📌 Installation des extensions PHP
```bash
if ! apt install php-{mysql,mbstring,curl,gd,xml,intl,ldap,apcu,xmlrpc,zip,bz2,imap} -y; then
    echo "Erreur lors de l'installation des extensions PHP"
    exit 1
fi
```
🔹 Installe les **extensions PHP** nécessaires pour GLPI.

---

## 🔒 5. Sécurisation de MariaDB
```bash
mysql_secure_installation
```
🔹 Lance l'assistant **mysql_secure_installation** pour sécuriser MariaDB.

---

## 💽 6. Configuration de la base de données
```bash
read -p "Entrez le nom de la base de données (par défaut: db_glpi): " DB_NAME
DB_NAME=${DB_NAME:-db_glpi}

read -p "Entrez le nom d'utilisateur de la base de données (par défaut: admindb_glpi): " DB_USER
DB_USER=${DB_USER:-admindb_glpi}

read -s -p "Entrez le mot de passe pour l'utilisateur de la base de données: " DB_PASSWORD
echo
DB_PASSWORD=${DB_PASSWORD:-123}
```
🔹 Demande le **nom de la base**, **nom d'utilisateur**, et **mot de passe** (avec valeurs par défaut).

### 📌 Création de la base de données et assignation des droits
```bash
mysql -u root -p <<EOF
CREATE DATABASE ${DB_NAME};
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';
FLUSH PRIVILEGES;
EXIT;
EOF
```
🔹 Crée la base **GLPI** et donne tous les privilèges à l'utilisateur.

---

## 💾 7. Installation de GLPI
```bash
cd /tmp || exit 1
if ! wget https://github.com/glpi-project/glpi/releases/download/10.0.17/glpi-10.0.17.tgz; then
    echo "Erreur lors du téléchargement de GLPI"
    exit 1
fi
```
🔹 Télécharge GLPI depuis GitHub.

---

## 🔧 8. Configuration Apache
```bash
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
```
🔹 Crée une configuration Apache pour GLPI.

---

## 👉 9. Redémarrage et vérifications
```bash
a2enmod rewrite
a2dissite 000-default.conf
a2ensite glpi.conf
systemctl restart apache2
```
🔹 Active `mod_rewrite` et redémarre Apache.

---

## 🚀 10. Accès final
```bash
echo "Installation de GLPI terminée avec succès."
echo "Accédez à http://$SERVER_ALIAS/glpi pour finaliser la configuration."
echo "Base de données : $DB_NAME"
echo "Utilisateur DB : $DB_USER"
exit 0
```
🔹 Affiche les informations d'accès à GLPI.

---

## 🎡 Conclusion
🏆 Ce script automatise **totalement** l'installation de GLPI. Il gère :
✔️ Installation des dépendances  
✔️ Configuration de la base de données  
✔️ Paramétrage Apache et PHP  

🎉 **Après l'exécution, ouvrez** `http://<IP_SERVEUR>/glpi` pour finaliser l'installation via l'interface web.
