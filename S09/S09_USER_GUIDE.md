
٩(◕‿◕｡)۶ 


⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⣾⣿⣿⣿⣷⣶⣦⣄⡀⣀⣤⣶⣶⣿⣿⣿⣿⣶⣶⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⢀⣤⣶⣶⣶⣶⣄⡀⠀⠀⠀⠀⠀⢀⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⢀⣤⣶⣶⣶⣶⣤⡀⠀⠀
⠀⣴⣿⣿⣿⣿⠿⢿⣿⣿⡄⠀⠀⠀⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⣰⣿⣿⡿⢿⣿⣿⣿⣿⣄⠀
⢸⣿⣿⣿⡟⠀⠀⠀⠈⢿⡿⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⡀⠀⣿⡟⠁⠀⠀⠈⢿⣿⣿⣿⡄
⢸⣿⣿⣿⣇⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠁⠀⠀⠈⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣀⠀⠀⠀⠀⠀⣼⣿⣿⣿⡇
⠘⣿⣿⣿⣿⣷⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣶⣿⣿⣿⣿⡿⠀
⠀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀
⠀⠀⠀⠈⠙⠻⠿⠿⣿⣿⣿⡿⠿⠿⠟⠛⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠙⠛⠿⠿⠿⣿⣿⣿⣿⡿⠿⠟⠋⠁⠀⠀⠀  ⠀⠀⠀⠀⠀⠀
  

# **📅 Journal de Bord – Semaine 9**

# 💖🤝 COLLABORATION AVEC ECOTECH-SOLUTION 🤝💖

Nous avons travaillé en étroite collaboration avec nos collègues de EcoTech-Solution depuis notre partenariat avec eux. Cette coopération nous a permis d’optimiser nos processus et d’atteindre nos objectifs plus efficacement. 🚀

## **📞 Mise en place du serveur VoIP**
Nous avons débuté la semaine avec la mise en place d’un serveur de téléphonie sur IP en utilisant **FreePBX** (version 16) sur une **machine virtuelle** dédiée. 🖥️ L’installation s’est déroulée sans encombre et nous avons rapidement pu configurer les premières lignes VoIP.

📱 Après la configuration des lignes VoIP, nous avons installé **3CXPhone** sur les postes clients pour réaliser des tests de communication. Les premiers appels ont été effectués avec succès entre plusieurs membres de l’équipe. ✅ Nous avons également exploré la possibilité d’une intégration LDAP/AD, mais cette tâche reste optionnelle pour le moment.

🛡️ Dans une infrastructure réelle, le serveur VoIP serait placé dans une **DMZ** pour assurer une séparation sécurisée entre le réseau interne et externe, protégeant ainsi les communications téléphoniques contre d’éventuelles menaces extérieures.

## **🌐 Mise en place du serveur Web**
Nous avons déployé un **serveur web** utilisant **NGINX**. 🖥️ L’objectif était d’héberger deux sites : 
- 🌍 L’un accessible uniquement en interne
- 🌎 L’autre potentiellement disponible depuis l’extérieur (optionnel)

🛡️ Comme pour le serveur VoIP, dans une infrastructure réelle, le **serveur web** serait également placé en **DMZ**, garantissant une meilleure isolation et sécurité du réseau. Cela permettrait d’exposer le site externe sans compromettre le réseau interne de l’entreprise.

Les tests d’accessibilité ont été menés avec succès :
- ✅ Le site interne est accessible depuis le réseau local sans problème.
- 🔄 La mise en place de l’accès externe est en attente d’une validation supplémentaire.

🔧 Nous avons également pris du temps pour peaufiner la configuration du serveur et ajuster les paramètres de sécurité.

## **🏆 Bilan et finalisation des objectifs**
Nous avons consacré la fin de la semaine à la validation finale des installations. Aucun problème majeur n’a été rencontré, et toute l’équipe – **Barbara, Philippe, Karim, Juju et Xavier** – a travaillé efficacement en collaboration. 🤝

### **✅ Objectifs atteints**
✔ **📞 Serveur VoIP opérationnel** avec FreePBX 16 et simulation d’une installation en DMZ
✔ **📲 Tests de communication réussis** via 3CXPhone
✔ **💻 Serveur Web fonctionnel** utilisant NGINX avec placement en DMZ simulé
✔ **🌐 Sites hébergés et accessibles en interne**

## **🎯 Conclusion**
Une semaine productive et sans accroc ! 💪 Nous avons réussi à atteindre tous les objectifs fixés en travaillant efficacement en équipe. 👏 Prochaine étape : finaliser les détails pour l’éventuel accès externe du serveur web et explorer d’autres optimisations. 🔍

🚀 **Mission accomplie !** 🏁🎉

⠀⠀![flat,750x,075,f-pad,750x1000,f8f8f8 u2](https://github.com/user-attachments/assets/010915b8-a496-4ec2-bda9-ccf366a2c893)

