# Journal de Bord - Semaine 8

## 1. Objectifs de la semaine

| Domaine | Objectif | Description |
|---------|----------|-------------|
| 🔒 Sécurité | Mise en place du serveur WSUS | Installation et configuration d'un serveur WSUS pour optimiser la gestion des mises à jour au sein de notre infrastructure, assurant ainsi la sécurité et la stabilité des systèmes tout en ayant un contrôle granulaire sur le déploiement des correctifs. |
| 🏛️ Active Directory | Rôles FSMO | S'assurer que notre infrastructure AD repose sur une base solide avec une bonne répartition des rôles FSMO entre plusieurs contrôleurs de domaine, afin d'améliorer la résilience et la continuité des services. |

**📌 Bilan BillU :** Les objectifs individuels liés à FSMO et WSUS ont été réalisés avec succès. WSUS est opérationnel et les rôles FSMO sont bien distribués entre les contrôleurs de domaine.

## 2. Difficultés rencontrées

| Problème | Description | Solution |
|----------|-------------|----------|
| ⏳ Durée de synchronisation des mises à jour WSUS | Le processus de synchronisation des mises à jour WSUS a pris plus de temps que prévu, ce qui a retardé les premiers tests de déploiement. | Nous avons constaté que la bande passante et les paramètres de proxy pouvaient affecter la vitesse de téléchargement des mises à jour. |
| ✍️ VPN site-à-site | L'un des principaux défis de la semaine a été la mise en place du VPN site-à-site entre BillU et EcoTechSolutions. | 🔍 Identification du problème : Une carte réseau vmbr4 était activée, et la route passait par cette carte, empêchant la connexion correcte du VPN.<br>🔧 Solution : Une fois cette carte désactivée et la route corrigée, la connexion VPN a pu être établie avec succès ! ✅ |

## 3. Partenariat d'Entreprise - BillU & EcoTechSolutions

### 3.1 Processus de décision

| Critère | Description |
|---------|-------------|
| Définition des objectifs | Les objectifs sont définis par les 2 groupes de projet 🏢🤝🏢 |
| Sélection | Chaque objectif sélectionné doit être commun aux deux entreprises 🔄 |
| Priorisation | • Objectif Principal : à réaliser avant la fin du sprint 🚀<br>• Objectif Secondaire : au plus tard la semaine prochaine ⏳ |

**📌 État actuel :** Les objectifs communs entre nos deux entreprises étaient en attente en raison des problèmes de connexion VPN, mais ceux-ci sont désormais résolus.

### 3.2 Configuration VPN actuelle

| Paramètre | Valeur |
|-----------|-------|
| Protocole utilisé | IPSec site-to-site |
| Type d'authentification | AES |

| Version IP | IPv4 |
| État actuel | ✅ Connexion établie et fonctionnelle 🎉 |

## 4. Points positifs

- Heureux du partenariat et de l'intégration avec un autre groupe 🤝🎉
- Bonne communication entre les équipes 🔗
- Résolution efficace du problème VPN 🔄

## 5. Prochaines étapes

| Priorité | Tâche |
|----------|-------|
| 1 | Choix des objectifs communs pour chaque entreprise afin d'avancer ensemble 🚀 |
| 2 | Validation du bon fonctionnement de WSUS 🔄 |
| 3 | Tests approfondis du VPN site-à-site entre les deux entreprises 🔒 |
| 4 | Mise en place des rôles FSMO et documentation 📖 |
