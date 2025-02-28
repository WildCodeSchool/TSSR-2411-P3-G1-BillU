
# 🚀 Guide d'installation et de configuration de Graylog sur Ubuntu

Ce guide détaillé vous accompagne pas à pas dans l'installation et la configuration d'un nœud Graylog unique sur Ubuntu. Nous allons mettre en place les trois composants principaux : MongoDB, Elasticsearch/OpenSearch et Graylog Server.

## 📋 Prérequis

Avant de commencer l'installation, assurez-vous que :

* Vous disposez d'un serveur Ubuntu 22.04 LTS ou 24.04 LTS
* Les ports nécessaires sont ouverts (désactivez temporairement les pare-feux si nécessaire)
* Le système de fichiers XFS est utilisé pour le stockage (recommandé)
* Vous avez configuré le fuseau horaire du serveur en UTC

Pour configurer le fuseau horaire :

```bash
sudo timedatectl set-timezone UTC
```

## 🗄️ Installation de MongoDB

MongoDB est utilisé comme base de données pour stocker les métadonnées de Graylog.

### 1. Installer les dépendances

```bash
sudo apt-get install gnupg curl
```

### 2. Importer la clé MongoDB

```bash
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
--dearmor
```

### 3. Créer un fichier de liste pour MongoDB

```bash
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
```

### 4. Mettre à jour la base de données des paquets

```bash
sudo apt-get update
```

### 5. Installer MongoDB

```bash
sudo apt-get install -y mongodb-org
```

### 6. Verrouiller la version installée

```bash
sudo apt-mark hold mongodb-org
```

### 7. Configurer MongoDB

Ouvrez le fichier de configuration :

```bash
sudo nano /etc/mongod.conf
```

Modifiez la section réseau pour écouter sur toutes les interfaces :

```yaml
net:
  port: 27017
  bindIpAll: true
```

### 8. Démarrer et activer MongoDB

```bash
sudo systemctl daemon-reload
sudo systemctl enable mongod.service
sudo systemctl start mongod.service
```

## 🔍 Installation du Data Node (OpenSearch/Elasticsearch)

Le Data Node gère l'ingestion, le traitement et l'indexation des journaux.

### 1. Installer le paquet Data Node

```bash
wget https://packages.graylog2.org/repo/packages/graylog-6.1-repository_latest.deb
sudo dpkg -i graylog-6.1-repository_latest.deb
sudo apt-get update
sudo apt-get install graylog-datanode
```

### 2. Configurer vm.max_map_count

Vérifiez la valeur actuelle :

```bash
cat /proc/sys/vm/max_map_count
```

Augmentez la valeur à au moins 262144 :

```bash
echo 'vm.max_map_count=262144' | sudo tee -a /etc/sysctl.d/99-graylog-datanode.conf
sudo sysctl --system
```

### 3. Générer un password_secret

Ce secret sera utilisé pour chiffrer les données sensibles :

```bash
< /dev/urandom tr -dc A-Z-a-z-0-9 | head -c${1:-96};echo;
```

### 4. Configurer le Data Node

Ouvrez le fichier de configuration :

```bash
sudo nano /etc/graylog/datanode/datanode.conf
```

Ajoutez les paramètres suivants :

```properties
# Ajoutez le password_secret généré précédemment
password_secret = VOTRE_PASSWORD_SECRET

# Configurez la mémoire heap (la moitié de la RAM disponible, max 31GB)
opensearch_heap = 8g

# Configurez la connexion MongoDB
mongodb_uri = mongodb://localhost:27017/graylog
```

### 5. Ajuster les paramètres JVM

Modifiez le fichier jvm.options :

```bash
sudo nano /etc/graylog/datanode/jvm.options
```

Ajustez les paramètres de mémoire :

```
-Xms1g
-Xmx1g
```

### 6. Démarrer et activer le Data Node

```bash
sudo systemctl daemon-reload
sudo systemctl enable graylog-datanode.service
sudo systemctl start graylog-datanode
```

## 🖥️ Installation de Graylog Server

### 1. Installer Graylog Server

```bash
sudo apt-get install graylog-server
```

### 2. Créer un mot de passe root SHA2

```bash
echo -n "VotreMotDePasse" | sha256sum | cut -d" " -f1
```

### 3. Configurer Graylog Server

Ouvrez le fichier de configuration :

```bash
sudo nano /etc/graylog/server/server.conf
```

Ajoutez ou modifiez les paramètres suivants :

```properties
# Définir ce nœud comme leader
is_leader = true

# Chemin vers le fichier d'ID du nœud
node_id_file = /etc/graylog/server/node-id

# Utiliser le même password_secret que pour le Data Node
password_secret = VOTRE_PASSWORD_SECRET

# Mot de passe root SHA2 généré précédemment
root_password_sha2 = VOTRE_MOT_DE_PASSE_SHA2

# Fuseau horaire
root_timezone = UTC

# Adresse d'écoute pour l'interface web
http_bind_address = 0.0.0.0:9000

# Connexion à Elasticsearch/OpenSearch
elasticsearch_hosts = http://localhost:9200

# Connexion à MongoDB
mongodb_uri = mongodb://localhost:27017/graylog

# Répertoire de données
data_dir = /var/lib/graylog-server

# Configuration du journal des messages
message_journal_max_size = 4gb
```

### 4. Ajuster les paramètres JVM pour Graylog

Modifiez le fichier de service :

```bash
sudo nano /etc/default/graylog-server
```

Ajustez les paramètres de mémoire :

```
GRAYLOG_SERVER_JAVA_OPTS="-Xms2g -Xmx2g -server -XX:+UseG1GC -XX:-OmitStackTraceInFastThrow"
```

### 5. Démarrer et activer Graylog Server

```bash
sudo systemctl daemon-reload
sudo systemctl enable graylog-server.service
sudo systemctl start graylog-server.service
```

## 🔒 Configuration HTTPS (Optionnel)

Pour sécuriser l'interface web avec HTTPS, ajoutez ces paramètres dans `server.conf` :

```properties
# Activer HTTPS
http_enable_tls = true

# Chemin vers le certificat
http_tls_cert_file = /path/to/graylog.crt

# Chemin vers la clé privée
http_tls_key_file = /path/to/graylog.key

# Mot de passe de la clé privée (si nécessaire)
http_tls_key_password = secret
```

## 🌐 Accès à l'interface web

1. Ouvrez votre navigateur et accédez à l'URL suivante :
   ```
   http://VOTRE_IP:9000
   ```

2. Connectez-vous avec les identifiants par défaut :
   * Nom d'utilisateur : `admin`
   * Mot de passe : celui que vous avez défini avec `root_password_sha2`

## 📥 Configuration des entrées (Inputs)

Pour commencer à collecter des logs, vous devez configurer des entrées :

1. Dans l'interface web, allez dans **System** > **Inputs**
2. Cliquez sur **Launch new input**
3. Sélectionnez le type d'entrée (par exemple, GELF UDP)
4. Configurez les paramètres :
   * **Title** : Nom descriptif (ex: Graylog_UDP_NXLogs_Windows)
   * **Bind address** : 0.0.0.0 (pour écouter sur toutes les interfaces)
   * **Port** : 12201 (port standard pour GELF)
   * **Receive Buffer Size** : 262144
   * **No. of worker threads** : 4
   * **Encoding** : UTF-8

## 🔍 Vérification de l'installation

Vérifiez l'état des services :

```bash
systemctl status graylog-server
systemctl status mongod
systemctl status graylog-datanode
```

## 🛠️ Dépannage

### Problèmes de connexion à MongoDB

Si vous rencontrez des problèmes de connexion à MongoDB, vérifiez que le port 27017 est accessible :

```bash
nc -vz localhost 27017
```

### Problèmes avec Elasticsearch/OpenSearch

Vérifiez les journaux :

```bash
journalctl -u graylog-datanode
```

### Problèmes avec Graylog Server

Vérifiez les journaux :

```bash
journalctl -u graylog-server
```

## 🎉 Félicitations !

Vous avez maintenant un système Graylog fonctionnel prêt à collecter et analyser vos logs. Explorez l'interface web pour configurer des tableaux de bord, des alertes et des extracteurs pour tirer le meilleur parti de votre installation.
