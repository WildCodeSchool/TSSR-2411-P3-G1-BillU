
# 📊 Journal de bord semaine 4 du projet BILLU
![image](https://github.com/user-attachments/assets/e967e89b-724d-4686-819c-08a026e71875)
## ✅ Tâches Accomplies

###  🏷️ Gestion des Machines

Mise en place complète de la documentation des machines
Implémentation du système de tags pour l'environnement et la criticité
Standardisation des notes dans Proxmox selon le template fourni

### 🔒 Gestion des GPO

Déploiement des stratégies de groupe comme planifié la semaine précédente
Configuration et tests des politiques de sécurité

## 🖥️ Déploiement GLPI

Installation réussie sur la machine Debian  
Établissement de la liaison avec l'AD du domaine BillU  
Défis rencontrés:  

Tentatives d'importation via Data Injection avec des fichiers CSV  
En cours de résolution pour une meilleure intégration du parc informatique  
Beaucoup de difficultés pour faire ces importations et comprendre le système de  Glpi


## 🛡️ Configuration pfSense

Début de la mise en place des règles de pare-feu  
Configuration initiale des interfaces réseau  

## 📱 Télémétrie Windows

Tests et renseignement sur la procedure pour   
effectués la gestion de la télémétrie sur Windows 10/11  
Expérimentation avec les scripts PowerShell En cour de création  
Mise en place des tâches planifiées (AT)  

## 🌐 Infrastructure Réseau

Documentation et recherche sur les procedure pour  
Intégration des routeurs VyOS  
Adaptation selon le schéma réseau initial  
Tests de connectivité à effectués  

🚧 Prochaines Étapes

Finalisation de l'importation des données dans GLPI  
Optimisation des règles pfSense  
Perfectionnement de la solution de télémétrie  

différentes difficultés techniques.


| Système       | Problème                                      | Impact                                           |
|--------------|-----------------------------------------------|--------------------------------------------------|
| GPO          | Problèmes d'enregistrement de certaines GPO   | Possible incohérence dans l'application des politiques de groupe sur le réseau |
| PfSense      | Difficultés d'application des restrictions    | Potentielle faille dans la sécurité du réseau ou problèmes d'accès |
| GLPI         | Problèmes d'importation des données          | Inventaire et gestion des actifs IT potentiellement incomplets ou désorganisés |





