
# 📜 Journal de Bord - Saison 3

## 🔄 Reprise à Zéro : Problème de Renommage des VM

Suite à un problème de renommage des machines virtuelles sur **Proxmox**, nous avons pris la décision de **tout recommencer de zéro**. Nous avons repris notre schéma d'origine où les départements étaient bien séparés afin d'assurer une meilleure organisation et gestion.

Nous avons pris soin de revoir notre approche en matière de gestion des noms des machines virtuelles, en établissant des conventions strictes pour éviter tout conflit futur. Chaque département disposera désormais d'un préfixe spécifique afin de faciliter l'identification et la maintenance des VM.

## 🌐 Réseau et Plan d'Adressage

Étant donné que nous **ne pouvons pas configurer de VLAN sous Proxmox**, nous avons choisi une approche alternative en segmentant logiquement le réseau :
- **Passage des serveurs en /16** 🏢 afin de permettre une large allocation d'adresses IP.
- **Séparation des départements en /24** 📌 pour assurer une organisation claire et éviter toute saturation du sous-réseau.
- **Attribution de plages spécifiques à chaque département** 🔢 afin de simplifier la gestion des règles de pare-feu et les permissions d'accès.

Chaque serveur et poste client sera attribué à son sous-réseau respectif en fonction de son département, garantissant ainsi une séparation logique et une meilleure sécurité.

## 🛠️ Installation de GLPI

- Le **script d'installation de GLPI** a été **développé et testé** ✅ dans un environnement contrôlé.
- Il a été **validé dans un laboratoire virtuel** 🧪 pour s'assurer de son bon fonctionnement sur différentes configurations.
- Le script inclut :
  - **Installation automatisée** de GLPI et de ses dépendances 🏗️.
  - **Configuration de la base de données** avec un fichier prérempli 📜.
  - **Synchronisation avec Active Directory** pour la gestion des utilisateurs 🔄.
- Il sera prêt à être **déployé dès l'activation des serveurs** 🚀.

## 🔐 Déploiement des GPO

- La **mise en place des GPO** a été **testée dans un environnement dédié** 🖥️ afin d'identifier d'éventuelles incohérences avant l'implémentation finale.
- Les GPO mises en place couvrent les aspects suivants :
  - **Sécurisation des postes utilisateurs** 🔐 (mot de passe, verrouillage automatique, restrictions d'accès).
  - **Déploiement d'applications** via stratégie de groupe 📦.
  - **Mappage des lecteurs réseaux** en fonction des services 📁.
  - **Configuration des mises à jour Windows** pour uniformiser les correctifs de sécurité 🔄.
  - **Restrictions d'accès aux périphériques USB** pour éviter tout risque de fuite de données 🚫.
- Une fois validées, ces stratégies seront **déployées de manière définitive** sur l’ensemble des infrastructures 💾.

---

📌 **Prochaines étapes** :
- **Finalisation de la configuration réseau** 🔧 avec l’application des règles de pare-feu et la validation des sous-réseaux.
- **Déploiement effectif de GLPI et des GPO** 🏗️ en production.
- **Vérification des performances et ajustements** 📊 afin d’optimiser la stabilité et la sécurité de l’infrastructure.

🚀 **Nous avançons vers une infrastructure plus stable et optimisée !**

