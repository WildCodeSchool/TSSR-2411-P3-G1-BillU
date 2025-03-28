# 🛡️ Audit et Sécurisation de l'Infrastructure

## 1️⃣ Audit Active Directory 🏢
### 🔍 PurpleKnight - Audit de configuration de l’AD

<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/3db04c31-13d3-459b-815a-76475116b0f6" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/4d62019d-c463-4237-b266-bf515d07a1b3" alt=""></p>

#### 📊 Analyse des résultats
- **Score initial : 76%**
- L’outil **PurpleKnight** permet d’identifier les vulnérabilités et failles de configuration au sein d’Active Directory.
- Il analyse plusieurs points clés comme :
  - Les mauvaises configurations de comptes et de groupes 🔄
  - Les vulnérabilités réseau (ex : protocole SMBv1) 🌐
  - Les failles liées aux politiques de sécurité 🔑

#### 🛠️ Actions correctives
- **Désactivation de SMBv1** :
  - Protocole obsolète et vulnérable aux attaques **Man-in-the-Middle**.
  - Utilisation de PowerShell :
    ```powershell
    Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force
    ```
  - Protection contre des exploits comme **EternalBlue** (utilisé par WannaCry).

- **Désactivation du service Spooler d’impression** :
  - Vulnérable à l’exploit **PrintNightmare**, permettant une exécution de code à distance.
  - Désactivation via PowerShell :
    ```powershell
    Stop-Service -Name Spooler -Force
    Set-Service -Name Spooler -StartupType Disabled
    ```

#### 🎯 Amélioration du score

<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/5c1aef9e-4bac-46c3-9ae8-73b4afca56c2" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/f296e15c-ddd1-4388-a12b-b4282f51e35f" alt=""></p>

- Score après corrections : **+2%** 📈
- Pour une amélioration plus significative :
  - **Renforcement des politiques de mots de passe** (longueur, complexité, expiration) 🔐
  - **Audit des permissions sur les objets AD**
  - **Désactivation des comptes inactifs** 🚫

---

## 2️⃣ Audit Serveurs Linux 🐧
### 🔍 Lynis - Audit de système Linux/Unix

#### 📊 Score
- **Avant : 68%**

<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/f55c1851-e487-47a7-93cf-d85ecd9deb51" alt=""></p>

- **Après corrections : 76%** ✅

<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/ff5eead8-f10c-46cd-ad4e-4bcf5c5ece0e" alt=""></p>

#### 📝 Modifications de fichiers critiques
- **`/etc/login.defs`** :
  - Définition des paramètres de sécurité des comptes utilisateurs.
  - Augmentation de la longueur minimale des mots de passe.
  - Exemple :
    ```bash
    PASS_MIN_LEN 12
    ```

- **`/etc/pam.d/common-password`** :
  - Utilisation de `pam_pwquality` pour renforcer les règles de mots de passe.

# 🔐 Résumé des paramètres du fichier `/etc/common-password`

## 🛡️ 1. Contrôle de la complexité du mot de passe  
- **`pam_pwquality.so retry=3 minlen=12`**  
  ✅ Exige une longueur minimale de **12 caractères**  
  🔄 Limite à **3 tentatives** en cas d'échec  

## 💾 2. Stockage et validation des mots de passe  
- **`pam_unix.so obscure use_authtok try_first_pass yescrypt`**  
  🔑 Utilise les mots de passe chiffrés avec **yescrypt**  
  🔍 Applique des règles de complexité supplémentaires (`obscure`)  
  🔄 Réutilise le mot de passe saisi en premier (`try_first_pass`)  

- **`pam_unix.so sha512 rounds=5000`**  
  🔐 Utilise **SHA-512** pour hacher les mots de passe avec **5000 itérations**  

## ✅ 3. Validation et autorisation  
- **`pam_permit.so`**  
  🟢 Garantit qu'au moins un module renvoie une validation positive pour éviter des erreurs  

## 🚨 4. Protection contre les tentatives de brute-force  
- **`pam_tally2.so deny=3 onerr=fail`**  
  🔒 Bloque un compte après **3 échecs de connexion**  
  ❌ Refuse l'accès en cas d'erreur système  

⚡ **Conclusion** : Ces paramètres renforcent la **sécurité des mots de passe** et limitent les risques d'attaques par force brute. 🚀  


- **`/etc/sudoers`** :
  - Restriction des droits sudo à des utilisateurs spécifiques.
  - Ajout de l’option **NOPASSWD** uniquement si nécessaire.
  - Audit des privilèges avec :
    ```bash
    sudo -l
    ```

#### 📦 Installation de paquets de sécurité
- **`apt-listbugs`** 🪲 : Alerte en cas de bugs critiques avant installation.
- **`apt-listchanges`** 📝 : Affiche les changements majeurs avant mise à jour.
- **`needrestart`** 🔄 : Identifie les services nécessitant un redémarrage après mise à jour.
- **`fail2ban`** 🔐 : Protège contre les attaques par force brute en bloquant les IP suspectes.
  - Exemple de configuration :
    ```bash
    [sshd]
    enabled = true
    maxretry = 3
    bantime = 600
    ```

---

## 3️⃣ Audit Scripts PowerShell ⚡
### 🔍 PSScriptAnalyzer - Vérification des scripts PowerShell

<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/deb05520-fd2a-4590-9bf9-c3724a10e437" alt=""></p>

#### ✅ Vérification de la qualité du code
- **Analyse des scripts de création d’utilisateurs et d’ajout de machines** 🏢💻.

<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/ab1fa607-f178-4f02-8e11-bd7894430fc7" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/cbcdb463-5aff-4014-af36-5331ab48b513" alt=""></p>

- **Recherche des erreurs de syntaxe et des violations des bonnes pratiques**.
- Exemple d’analyse :
  ```powershell
  Invoke-ScriptAnalyzer -Path .\mon_script.ps1 -Severity Warning
  ```

#### 🛠️ Corrections et intégration
- **Correction des erreurs identifiées** par PSScriptAnalyzer.
- **Ajout de commentaires et documentation** pour améliorer la lisibilité.
- **Intégration dans VSCode** avec l’extension PowerShell pour un développement plus structuré 🖥️.
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/60cc92ae-3361-496f-9435-8df3213524d8" alt=""></p>
---

## 4️⃣ Audit Serveurs Windows 🪟
### 🔍 Suite Sysinternals - Analyse des permissions et partages

#### 🛠️ Outils utilisés
- **AccessChk** 🔎 : Vérifie les niveaux d'accès des utilisateurs sur des fichiers/dossiers.
  ```powershell
  accesschk.exe -u utilisateur -f dossier
  ```
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/1ba35409-fec7-44c3-82fb-43df20f3d164" alt=""></p>

- **AccessEnum** 📂 : Liste les permissions sur les répertoires et registres sensibles.

<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/fb8bb7f8-9bae-4c81-ae1a-92e3a3641c1e" alt=""></p>

- **ShareEnum** ❌ : Échec de l’exécution (analyse à approfondir).

<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/49df0391-4068-4a4d-a77a-b898b1fde2a0" alt=""></p>

---

## 5️⃣ Audit Serveur Web 🌐
### 🔍 Nikto - Scanner de vulnérabilités web

#### 🛠️ Actions réalisées
- Scan de sécurité du serveur web avec **Nikto** ⚡
  ```bash
  nikto -h http://mon-serveur
  ```
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/31ffe601-c724-48b4-8065-10e6d9f04706" alt=""></p>
  
- Identification des vulnérabilités :
  - Headers de sécurité absents
  - Versions de logiciels obsolètes
  - Mauvaises configurations
- Corrections appliquées :
  - Ajout d’en-têtes HTTP sécurisés (CSP, HSTS, X-Frame-Options)
  - Mise à jour des versions Apache/Nginx et PHP
  - Restriction des permissions d’accès aux fichiers sensibles

---

## 🎯 Conclusion & Recommandations 🔐
✔️ **Améliorations significatives** sur la sécurité des systèmes ✅
✔️ **Durcissement des configurations** pour réduire les vulnérabilités 🏰
✔️ **Suivi continu** nécessaire pour atteindre un **score parfait** 🏆

🚀 **Prochaines étapes** :
- Mise en place de **politiques de sécurité avancées** 🔒
- Automatisation des audits avec des outils comme **OSSEC, Wazuh, ou Splunk**
- Mise en place d’une **surveillance proactive** avec alertes 📡


