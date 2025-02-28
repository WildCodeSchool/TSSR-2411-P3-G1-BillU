
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
  bindIp: 127.0.0.1
```
![image](https://github.com/user-attachments/assets/2e99d65d-2f93-49c5-850e-ee905ac38779)

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
![image](https://github.com/user-attachments/assets/588ba1dd-f5dd-44da-b372-79ec9a9cb193)

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
![Capture d’écran 2025-02-26 143155](https://github.com/user-attachments/assets/c98549ae-79c6-4574-bd6c-d1f9dd476be4)

![Capture d’écran 2025-02-26 144207](https://github.com/user-attachments/assets/34749782-ea0b-43f6-a5da-1c542687c388)


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

![Capture d’écran 2025-02-26 151029](https://github.com/user-attachments/assets/406b0b79-34cd-4e6e-be9a-597cbf5a38b2)


# 🛠️ Configuration d'un Input dans Graylog et Installation de NXLog sur Windows

Ce guide vous explique comment configurer un **input GELF UDP** dans Graylog et installer **NXLog** sur un serveur Windows pour envoyer des logs vers Graylog.

---

## 🌐 Étape 1 : Configuration d'un Input dans Graylog

1. **Connectez-vous à l'interface web de Graylog** :
   - Accédez à l'URL de votre serveur Graylog (par exemple : `http://<IP>:9000`).
   - Connectez-vous avec vos identifiants administrateur.

2. **Accédez à la section Inputs** :
   - Dans le menu supérieur, cliquez sur **System** > **Inputs**.

3. **Créer un nouvel Input** :
   - Cliquez sur le bouton vert **Launch new input**.
   - Dans la liste déroulante, sélectionnez **GELF UDP**.

4. **Configurer l'Input GELF UDP** :
   - Remplissez les champs comme suit :
     - **Title** : `Graylog_UDP_NXLogs_Windows` (ou un autre nom descriptif).
     - **Bind address** : `0.0.0.0` (pour écouter sur toutes les interfaces réseau).
     - **Port** : `12201` (port standard pour GELF UDP).
     - **Receive Buffer Size** : `262144` (valeur par défaut recommandée).
     - **No. of worker threads** : `4` (ou ajustez selon vos besoins).
     - **Encoding** : `UTF-8`.
   - Laissez les autres champs par défaut.

5. **Démarrer l'Input** :
   - Cliquez sur **Save** pour créer l'Input.
   - Assurez-vous que l'Input est actif (indiqué par une icône verte).

---
![Capture d’écran 2025-02-26 154206](https://github.com/user-attachments/assets/32e87182-4cfb-4c5a-a205-e43afe60dc23)


![Capture d’écran 2025-02-26 154510](https://github.com/user-attachments/assets/c8450ac0-c2ad-4b1a-9cae-730a85dc28af)



## 🖥️ Étape 2 : Installation de NXLog sur un serveur Windows

### 1. Télécharger NXLog

- Rendez-vous sur le site officiel de **NXLog** : [https://nxlog.co/products/nxlog-community-edition/download](https://nxlog.co/products/nxlog-community-edition/download).
- Téléchargez la version **Community Edition** pour Windows.

### 2. Installer NXLog

1. Exécutez le fichier d'installation téléchargé.
2. Suivez les étapes de l'assistant d'installation :
   - Acceptez les termes de la licence.
   - Choisissez le répertoire d'installation (par défaut : `C:\Program Files (x86)\nxlog`).
   - Terminez l'installation.

![Capture d’écran 2025-02-26 154618](https://github.com/user-attachments/assets/63056393-b9c2-4f79-9231-50914f71ff2c)


### 3. Configurer NXLog

1. **Ouvrir le fichier de configuration** :
   - Accédez au répertoire d'installation de NXLog (par défaut : `C:\Program Files (x86)\nxlog\conf`).
   - Ouvrez le fichier `nxlog.conf` avec un éditeur de texte (par exemple, Notepad++).


![Capture d’écran 2025-02-26 154922](https://github.com/user-attachments/assets/b4991138-e743-4c40-a0f0-b2683ee6b315)



2. **Modifier la configuration** :
   - Remplacez le contenu par la configuration suivante :

     ```plaintext
     ## NXLog Configuration File

     <Extension _gelf>
         Module      xm_gelf
     </Extension>

     <Input in>
         Module      im_msvistalog
         # Collecte les logs des journaux d'événements Windows
     </Input>

     <Output out>
         Module      om_udp
         Host        <IP_DE_GRAYLOG>
         Port        12201
         OutputType  GELF
     </Output>

     <Route 1>
         Path        in => out
     </Route>
     ```

     - **Host** : Remplacez `<IP_DE_GRAYLOG>` par l'adresse IP de votre serveur Graylog.
     - **Port** : Assurez-vous que le port correspond à celui configuré dans l'Input GELF UDP (par défaut : `12201`).


![Capture d’écran 2025-02-26 155511](https://github.com/user-attachments/assets/dbc0c38b-e570-4e6b-85a5-dbffc569f39a)


3. **Enregistrer les modifications** :
   - Sauvegardez le fichier `nxlog.conf`.

### 4. Démarrer le service NXLog

1. Ouvrez une invite de commande en tant qu'administrateur.
2. Exécutez la commande suivante pour démarrer le service NXLog :

   ```cmd
   net start nxlog
   ```

3. Vérifiez que le service est en cours d'exécution :

   ```cmd
   sc query nxlog
   ```

---

## 🔍 Étape 3 : Vérification des logs dans Graylog

1. **Accédez à l'interface web de Graylog**.
2. Allez dans **Search** (menu supérieur).
3. Recherchez les logs envoyés par NXLog :
   - Utilisez un filtre comme : `source:<NOM_DU_SERVEUR_WINDOWS>`.

   Exemple : Si le nom de votre serveur Windows est `WindowsServer01`, utilisez :

   ```plaintext
   source:WindowsServer01
   ```

4. Si les logs apparaissent, la configuration est réussie ! 🎉




![Capture d’écran 2025-02-26 165012](https://github.com/user-attachments/assets/bcba0a6a-2305-4267-ab19-41e12c6df6ae)


---

## 🛠️ Dépannage

### Problème : Aucun log n'apparaît dans Graylog
- **Vérifiez la connectivité réseau** :
  - Assurez-vous que le serveur Windows peut atteindre le serveur Graylog sur le port `12201` (utilisez `ping` ou `telnet`).
- **Vérifiez la configuration NXLog** :
  - Assurez-vous que l'adresse IP et le port dans `nxlog.conf` sont corrects.
- **Vérifiez les journaux NXLog** :
  - Les journaux NXLog se trouvent par défaut dans `C:\Program Files (x86)\nxlog\data\nxlog.log`.

### Problème : L'Input GELF UDP n'est pas actif
- Redémarrez le service Graylog Server :

  ```bash
  sudo systemctl restart graylog-server
  ```

---

## 🎉 Félicitations !

Vous avez configuré un Input dans Graylog et installé NXLog sur un serveur Windows pour transmettre des logs. Vous pouvez maintenant analyser vos journaux dans Graylog et configurer des tableaux de bord pour une meilleure visibilité. 🚀
```


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
