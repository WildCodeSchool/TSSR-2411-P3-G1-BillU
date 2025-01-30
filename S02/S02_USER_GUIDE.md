# Journal de bord : Projet BillU

## Semaine 2 : Configuration et Automatisation

## 1. **AD-DS - Création d'un domaine Active Directory**  
La première étape consiste à créer un domaine Active Directory (AD) en utilisant deux serveurs Windows Server 2022.

### 🖥️ Serveurs à Configurer :
- **Serveur 1** : Windows Server 2022 GUI avec les rôles suivants :
  - **AD-DS** (Active Directory Domain Services)
  - **DHCP**
  - **DNS**
- **Serveur 2** : Windows Server 2022 Core avec le rôle **AD-DS**
  
Les deux serveurs agiront en tant que **contrôleurs de domaine** (DC) et auront une **réplication complète** gérée automatiquement entre eux.

---

## 2. **AD-DS - Gestion de l'Arborescence Active Directory**

### 🗂️ Création des Unités Organisationnelles (OU)
Les **Unités Organisationnelles** (OU) sont créées de manière automatique via des scripts PowerShell pour organiser les utilisateurs et groupes dans l'AD de manière optimale.

### 👥 Création des Groupes
Les groupes sont également créés automatiquement par script PowerShell pour faciliter la gestion des permissions et des accès dans le domaine.

---

## 3. **AD-DS - Intégration des Utilisateurs**

### 📝 Intégration Automatique des Comptes Utilisateurs
L'intégration des utilisateurs dans l'AD se fait selon un fichier préexistant des utilisateurs, avec les actions suivantes :
- **Création des comptes utilisateurs**
- **Placement dans les groupes appropriés**
- **Placement dans les OU des départements/services correspondants**
- **Gestion des managers** (attribution des droits spécifiques)

Tout cela est automatisé grâce à des **scripts PowerShell**.

---

## 4. **Création d'une VM Serveur Linux Debian**

### 💻 Configuration Serveur Linux
Une machine virtuelle (VM) Debian est configurée en **CLI** (Interface en ligne de commande) et est intégrée au domaine **AD-DS**.

### 🔐 Accès SSH
Le serveur Linux est accessible en **SSH** par un groupe d'administrateurs du domaine, ce qui permet une gestion à distance sécurisée du serveur.

---

# 2. 🌐 **Réseau (Sous Proxmox)**

En raison de certaines erreurs dans les documents précédents, voici la mise à jour des informations réseau :

### 🛠️ Configuration du Réseau :
- **Plage d'adresses IP** : `172.18.0.0/16`
- **Passerelle** : `172.18.255.254`
- **Adresse IP DNS** : `172.18.255.254`

Les serveurs sont configurés pour utiliser cette plage et cette passerelle, garantissant ainsi la connectivité entre les différentes machines et l'intégration au domaine AD.

---

🔧 **En Cours** :  
La configuration de l'accès SSH pour le serveur Linux par les administrateurs du domaine est actuellement en cours de finalisation.

