
# 🏆 Objectifs S03

## 🔒 1. GPO de sécurité

Création d'au moins 5 GPO, dont au moins 3 parmi la liste ci-dessous :

1. **Politique de mot de passe** 🔑
   - Définition de la complexité requise
   - Longueur minimale
   - Expiration et historique des mots de passe
2. **Verrouillage de compte** 🔐
   - Blocage après un certain nombre d'échecs d'authentification
   - Durée de verrouillage
3. **Restriction d'installation de logiciel** 🚫
   - Blocage pour les utilisateurs non-administrateurs
   - Liste blanche des logiciels autorisés
4. **Gestion de Windows Update** 🔄
   - Définition des horaires de mise à jour
   - Délai avant installation
5. **Blocage de l'accès à la base de registre** 🛑
6. **Blocage complet ou partiel au panneau de configuration** ⚙️
7. **Restriction des périphériques amovibles** 💾
8. **Gestion d'un compte du domaine administrateur local des machines** 👤
9. **Gestion du pare-feu** 🔥
10. **Écran de veille avec mot de passe en sortie** 🖥️
11. **Forçage du type d'utilisation sécurisée du bureau à distance** 🏠
12. **Limitation des tentatives d'élévation de privilèges** 🚷
13. **Définition de scripts de démarrage pour les machines et/ou les utilisateurs** 📜
14. **Politique de sécurité PowerShell** 🛡️

---

## 📏 2. GPO standard

Création d'au moins 5 GPO, dont 3 parmi la liste ci-dessous :

1. **Fond d'écran** 🖼️
2. **Mappage de lecteurs** 💾
3. **Gestion de l'alimentation** 🔋
4. **Déploiement (publication) de logiciels** 📦
5. **Redirection de dossiers (Documents, Bureau, etc.)** 📂
6. **Configuration des paramètres du navigateur (Firefox ou Chrome)** 🌐

---

## 🖥️ 3. Serveur de gestion de parc - Installation de GLPI

1. **Sur un serveur Debian (CLI) VM ou CT** 🖧
2. **Synchronisation AD** 🔄
3. **Gestion de parc : Inclusion des objets AD (utilisateurs, groupes, ordinateurs)** 🏢
4. **Gestion des incidents : Mise en place d'un système de ticketing** 🎟️
5. **Accès et gestion à partir d'un client** 🖥️

---

## 🤖 4. Automatisation par script Shell - Installation de GLPI

1. **Sur un serveur Debian (CLI) déjà installé (VM ou CT)** 📡
2. **Utilisation d'un fichier de configuration** 📜
   - Contenant : Nom de la base de données, nom du compte, etc.

---

## ⚡ 5. Automatisation par script PowerShell - Installation d'un AD-DS

1. **Sur un Windows Server Core (CLI) déjà installé** 🏢
2. **Installation du rôle AD-DS et ajout à un domaine existant** 🔄
3. **Utilisation d'un fichier de configuration** 📜
   - Contenant : Nom du serveur, adresse IP du DNS, nom du domaine, etc.

---

# 📖 Documentation

Si un objectif de GPO est choisi, la configuration de chacune des GPO doit être clairement expliquée avec des exemples et captures d'écran si nécessaire.

