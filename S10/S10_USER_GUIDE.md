

![ascii-art](https://github.com/user-attachments/assets/05cee77d-007b-4700-a7a7-7aefc0e488d3)

# Journal de Bord - Semaine 10 🚀🔒

## Objectif Principal : Mise en Place du PC d'Administration 💻

### 1. Préparation du PC d'Administration 🖥️

#### Contexte et Objectifs
- Création d'un PC dédié à l'administration informatique 🛡️
- Système d'exploitation : Windows 10/11 ou Ubuntu LTS
- Accès strictement limité aux utilisateurs habilités IT 🔐

#### Caractéristiques Clés
- Machine centralisée pour la gestion de l'infrastructure réseau et systèmes 🌐
- Configuration basée sur le document `s10_preparation_pcAdministration.md`
- Objectif : Centraliser les outils et logiciels de sécurité 🧰

### 2. Audits de Sécurité Réalisés 🧕‍♀️

#### 2.1 Audit Active Directory - PurpleKnight 🏰
- **Progression du Score :**
  - Score Initial : 76%
  - Score Actuel : 78%
- **Actions Principales :**
  - Modifications de configuration du registre 🔧
  - Travail sur la politique de mots de passe 🔑
- **Prochaines Étapes :**
  - Continuer les ajustements pour tendre vers 100% 📈

#### 2.2 Audit Serveurs Linux - Lynis 🐧
- **Progression du Score :**
  - Score Initial : 65%
  - Score Actuel : 76%
- **Actions Réalisées :**
  - Mise en place de modifications de sécurité 🛡️
  - Amélioration de la configuration système ⚙️

#### 2.3 Audit Serveurs Windows - SysInternals 🧏‍♂️
- **Outils Utilisés :**
  1. AccessChk : Analyse des niveaux d'accès utilisateurs 🔍
  2. AccessEnum : Audit détaillé des accès 🗋
  3. ShareEnum : Tentative d'audit des partages de fichiers (problème rencontré sur le serveur) ⚠️

#### 2.4 Audit Serveur Web - Nikto 🌐
- **Objectifs :**
  - Scanner de vulnérabilités 🕳️
  - Identification et correction des failles de sécurité 🛠️

#### 2.5 Serveur pfsense - Portail Captif 🌐🔒
- **Configuration sur pfSense :**
  - Mise en place d'un portail captif robuste et sécurisé 🏁
  - **Fonctionnalités Principales :**
    1. Système d'authentification centralisé 🔐
    2. Gestion granulaire des accès utilisateurs 👥
    3. Contrôle d'accès par groupe et politique réseau 🌐

##### Détails du Portail Captif sur pfSense
- Utilisation de pfSense comme plateforme de sécurité réseau 🛡️
- Configuration d'un portail captif qui permet :
  - Authentification obligatoire avant accès internet 🔑
  - Contrôle précis des droits d'accès 🚪
  - Séparation des utilisateurs par groupes de sécurité 📊

### 3. Audit SCRIPTS POWERSHELL - Utilisation de **PSScriptAnalyzer**
- [Documentation officielle](https://learn.microsoft.com/fr-fr/powershell/module/psscriptanalyzer/?view=ps-modules)
- **Objectifs :**
  1. Vérification de la qualité du code (bonnes pratiques)
  2. Correction des scripts PowerShell selon les résultats obtenus

### 4. Défis et Points d'Amélioration 🧙‍♂️
- Résolution des problèmes de configuration du registre 🔧
- Poursuite de l'optimisation de la sécurité des systèmes 🛡️


### 5. Prochaines Étapes 🚀
- Continuer l'amélioration des scores de sécurité 📈
- Finaliser la configuration avancée du portail captif RADIUS 🌐
- Approfondir l'audit et la sécurisation des systèmes 🧕‍♀️

### Conclusion 🏁
Une semaine productive centrée sur la sécurisation et l'optimisation de notre infrastructure informatique, avec des progrès significatifs dans l'audit et la configuration de nos systèmes. La mise en place du portail captif sur pfSense représente une avancée majeure dans notre stratégie de sécurité réseau ! 💪🔒🌐

