# 📅 **Journal de Bord - Semaine 6**

## 🎯 **Objectif de la semaine**

- 📝 Mise en place d'une gestion centralisée des logs
- 💻 Journalisation des scripts PowerShell
- 🔍 Supervision de l'infrastructure réseau
- 🔐 Surveillance du pare-feu pfSense
- 👥 Mise à jour des utilisateurs Active Directory (AD) suite aux changements RH
- 📊 Mise en place d'une GPO pour la télémétrie

---

## 📂 **1. Journalisation - Gestion des logs centralisée**

### ✅ **Réalisé**

- **Système utilisé :** Graylog ([https://github.com/Graylog2/graylog2-server](https://github.com/Graylog2/graylog2-server))
- **Installation sur VM (non-dédié) ou CT :** Terminée
- **Gestion des logs des serveurs :** En cours

### 🚧 **Prochaines étapes**

- Finaliser la gestion des logs des serveurs

---

## 💾 **2. Journalisation des scripts PowerShell**

### ✅ **Réalisé**

- Début de la mise en place d'une journalisation dédiée aux scripts PowerShell

### 🚧 **En cours**

- Adapter les logs pour qu'ils soient lisibles par :
  - 🪟 Observateur d’événements Windows
  - 📑 CMTRACE ([https://www.tech2tech.fr/cmtrace-lire-vos-fichiers-logs-facilement/](https://www.tech2tech.fr/cmtrace-lire-vos-fichiers-logs-facilement/))

### 📅 **À faire**

- Modifier les scripts PowerShell pour intégrer la journalisation
- Définir un répertoire spécifique pour les logs
- Veiller à ce qu'un seul log soit généré par script

---

## 📡 **3. Supervision de l'infrastructure réseau**

### ✅ **Réalisé**

- Utilisation de **ZABBIX** ([https://www.zabbix.com/](https://www.zabbix.com/))
- Installation sur VM/CT dédié
- Supervision des éléments de l'infrastructure

### 🚧 **En cours**

- Création des dashboards pour une meilleure visibilité des métriques

### 📅 **Prochaines étapes**

- Finaliser les dashboards ZABBIX

---

## 🔥 **4. Surveillance du pare-feu pfSense**

### ✅ **Réalisé**

- Surveillance générale mise en place par Philippe et Karim

### 📅 **À faire**

- Mise en place d'un dashboard dédié
- Ajouter et modifier les widgets pour un suivi optimisé

---

## 👥 **5. Mise à jour des utilisateurs AD**

### ✅ **Réalisé**

- Intégration des nouveaux utilisateurs
- Modifications RH appliquées :
  - 🚪 Départ de Yacine Hamad, remplacé par Jean Leclerc
  - 🆕 Changement de nom du "Département Juridique" en "Service Juridique"
  - 👩‍💼 Remplacement de Fauve Hôlth par Jacqueline André
  - ❌ Désactivation des comptes des collaborateurs partis
  - ✨ Création de poste : Loic Blanc en tant que "Responsable marques"
  - 🔄 Changements de services pour Remi Advezekt et Nina Ledoux
  - 🏢 Création du "Département Juridique et Ressources Humaines" sous la direction de Sylvain Krajycëk

### 💡 **Remarques**

- Les règles de pare-feu doivent encore être affinées suite aux modifications RH.

---

## 📊 **6. Mise en place d'une GPO pour la télémétrie**

### ✅ **Réalisé**

- Création d'une GPO dédiée à la collecte de données de télémétrie
- Application de la GPO sur les postes utilisateurs et serveurs

### 📅 **Prochaines étapes**

- Vérifier la remontée des données dans les outils de supervision
- Adapter les configurations si nécessaire

---

## 🧠 **Conclusion**

La semaine 6 a permis d'avancer significativement sur plusieurs volets critiques de l'infrastructure. La centralisation des logs, la supervision du réseau, la mise à jour des comptes AD et la configuration de la GPO pour la télémétrie renforcent la sécurité et la gestion des ressources.

Les tâches en cours devront être finalisées dans la semaine suivante, notamment concernant la journalisation PowerShell, la création de dashboards sur ZABBIX et pfSense, ainsi que l'optimisation de la télémétrie.

---

## ⏭️ **Prochaines actions**

- Poursuivre la gestion des logs des serveurs via Graylog
- Intégrer la journalisation dans les scripts PowerShell
- Finaliser les dashboards sur ZABBIX et pfSense
- Optimiser les règles de pare-feu
- Suivre la remontée de la télémétrie via la GPO
