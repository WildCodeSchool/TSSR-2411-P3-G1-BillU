
![ascii-art (1)](https://github.com/user-attachments/assets/9e0d80b1-af80-48ff-bf38-5f55941e65cd)

# 🚀 Évolution de l'infrastructure informatique de BillU  

## 🖥️ 1. Matériel informatique  
🔴 **Avant** : Parc hétérogène de PC portables sans gestion centralisée.  
🟢 **Amélioration** :  
- ✅ Plan de **renouvellement progressif** des PC (**1/3 du parc à la fois**) pour uniformiser le matériel.  
- ✅ Gestion centralisée des postes via **Active Directory**.  
- ✅ Déploiement d’un **serveur WDS** pour l’**installation automatisée des futures machines**.  

---

## 🏢 2. Évolution de la société  
🔴 **Avant** : Pas d’évolution prévue.  
🟢 **Amélioration** :  
- ✅ Partenariat avec la société **EcoTechSolution** pour des échanges techniques et collaboratifs.  

---

## 🌐 3. Réseau  
🔴 **Avant** :  
- Réseau WiFi basé sur une **box FAI avec répéteurs**, sans protection avancée.  

🟢 **Amélioration** :  
- ✅ Mise en place d’un **réseau câblé performant**.  
- ✅ Installation de **serveurs** pour un domaine **billu.lan**.  
- ✅ Déploiement d’un **pare-feu** pour sécuriser l’accès Internet. 🔥  
- ✅ Création d’une **DMZ** avec :  
  - 🌍 **Un serveur web** pour héberger le site de l’entreprise.  
  - 📡 **Un portail captif** pour le WiFi des clients extérieurs.  
- ✅ **Redondance réseau et matérielle** pour assurer la continuité des services. 🔄  

---

## 📧 4. Messagerie  
🔴 **Avant** : Messagerie cloud sans contrôle interne.  
🟢 **Amélioration** :  
- ✅ Installation d’un **serveur iRedMail** dans la **DMZ** pour un meilleur contrôle des emails internes et externes. 📬  

---

## 🛠️ 5. Gestion du parc informatique & supervision  
🔴 **Avant** : Aucun suivi du matériel ni de gestion des incidents.  
🟢 **Amélioration** :  
- ✅ Déploiement d’un **serveur GLPI** pour la **gestion du parc et du ticketing**. 🎫  
- ✅ Installation d’un **serveur Zabbix** pour la **supervision du réseau et des serveurs**. 📊  
- ✅ Déploiement de **Guacamole** pour la **gestion des accès distants**. 🥑  
- ✅ Intégration de **Homarr** pour une **interface centralisée et simplifiée** des services internes. 🏠  
- ✅ Mise en place d’un **serveur Graylog** pour la **gestion centralisée des logs**. 📜  

---

## 🔒 6. Sécurité & gestion des utilisateurs  
🔴 **Avant** :  
- PC en **workgroup**, aucune sécurité d’identité.  
- Connexion sans mot de passe.  

🟢 **Amélioration** :  
- ✅ Installation d’un **serveur Active Directory (AD-DS)** pour **centraliser la gestion des utilisateurs** et du domaine **billu.lan**. 🏢  
- ✅ Mise en place d’une **authentification renforcée** avec **mot de passe sécurisé** et politique de gestion des accès. 🔑  
- ✅ Déploiement d’un **serveur Bitwarden** pour la **gestion sécurisée des mots de passe**. 🔐  
- ✅ **Application d’une stratégie GPO** pour **limiter les droits de certains utilisateurs** et sécuriser l’environnement. 📜  
- ✅ **Création de différentes OU** pour structurer l’AD selon les **départements** de l’entreprise. 🏢  

---

## 💾 7. Stockage & données  
🔴 **Avant** :  
- Un **NAS grand public** sans **redondance ni sauvegarde**.  

🟢 **Amélioration** :  
- ✅ Mise en place d’un **système de stockage redondant** pour **garantir la sécurité des données**. 🔄  
- ✅ Stratégie de **sauvegarde et de rétention des données** pour éviter toute perte critique. 🗄️  

---

## 📞 8. Téléphonie  
🔴 **Avant** : Solutions fixes et mobiles **non standardisées**.  
🟢 **Amélioration** :  
- ✅ Déploiement d’un **serveur de ToIP avec FreePBX** pour une téléphonie **centralisée et unifiée**. 📞  

---

## 🌍 9. Nomadisme & connexions sécurisées  
🔴 **Avant** : Aucun accès distant sécurisé.  
🟢 **Amélioration** :  
- ✅ Mise en place d’un **VPN sous pfSense** pour les employés en mobilité et la **connexion sécurisée avec EcoTechSolution**. 🔐  

---

## 📦 10. Gestion des mises à jour  
🔴 **Avant** : Mises à jour effectuées manuellement sur chaque machine.  
🟢 **Amélioration** :  
- ✅ Mise en place d’un **serveur WSUS** pour la **gestion centralisée et optimisée des mises à jour Windows**. 💻  

---

## 🎯 Conclusion  
Grâce à ces améliorations, **BillU** dispose désormais d’une infrastructure **sécurisée, performante et évolutive** :  
- 💡 **Meilleure gestion et supervision** grâce à **GLPI, Zabbix, Guacamole, Homarr et Graylog**.  
- 🔒 **Sécurité renforcée** avec **pare-feu, AD-DS, Bitwarden, GPO et VPN**.  
- 🌍 **Infrastructure web avec un serveur dédié** en DMZ.  
- 🔄 **Redondance et haute disponibilité** des services.  
- 📡 **Un réseau optimisé et structuré**, prêt pour l’avenir. 🚀  

---

✨ Une transformation complète qui apporte **efficacité, sécurité et modernité** à l’infrastructure de BillU ! 🚀🔥  
