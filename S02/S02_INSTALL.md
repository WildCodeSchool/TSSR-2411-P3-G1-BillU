## Lier le server core au domaine BILLU.lan et le promouvoir en DC RODC (lecture seule)

**Sur le serveur Core :**

1. Configuration de l’adresse IPv4ex avec la commande Powershell :

`Set-NetIPAddress -IPAddress "172.18.0.4" -PrefixLength 24 -InterfaceAlias "Ethernet 2"`

En effet, la modification de l’adresse IPv4 via le menu ne suffisait pas.

3. Test de ping sur le serveur BILLU1
4. Pour lier le serveur core au domaine BILLU.lan, on a utilisé la commande :

`Add-Computer -DomainName "BILLU.lan" -Credential BILLU\Administrator`<br>
5. Une fois la commande exécutée, on redémarre le serveur Core avec `Restart-Computer`

6. Rendez-vous ensuite sur le serveur principal

Sur le Serveur principal

7. Contrôler que le SVR2BILLU fait bien partie du domaine :
<br><p align="center"><img src="https://github.com/user-attachments/assets/58dc247c-152d-4bc3-bc7f-94955d2f49d1)alt=""></p><br>

8. Ajouter le serveur dans le gestionnaire de serveurs :
<br><p align="center"><img src="https://github.com/user-attachments/assets/e15262a8-7c4a-4dfc-aa46-de75c0a737e7" alt=""></p><br>
<br><p align="center"><img src="https://github.com/user-attachments/assets/73834b49-4e36-40e7-abbd-75dbab327cd7" alt=""></p><br>
<br><p align="center"><img src="https://github.com/user-attachments/assets/bc1684f6-c8e4-4eb2-ab4d-d16c4ba54388" alt=""></p><br>
9. Ajouter le rôle RODC au SVR2BILLU, avec l’assistant Ajout de rôles et de fonctionnalités :
<br><p align="center"><img src="https://github.com/user-attachments/assets/20f7e3fb-c478-40e9-8a5c-dfa679975830" alt=""></p><br>
<br><p align="center"><img src="https://github.com/user-attachments/assets/bd502b6e-845b-47ae-8a37-b0ce031beaef" alt=""></p><br>
<br><p align="center"><img src="https://github.com/user-attachments/assets/cc2d7b83-fb80-4abe-b3a8-f4d60508c84a" alt=""></p><br>
<br><p align="center"><img src="https://github.com/user-attachments/assets/df63af56-3f81-4688-93cf-8e1f93e4e997" alt=""></p><br>
<br><p align="center"><img src="https://github.com/user-attachments/assets/8c811898-320e-41e1-aefe-c857f9e7b408" alt=""></p><br>
<br><p align="center"><img src="https://github.com/user-attachments/assets/e0b65983-7775-43c4-964f-b2fa00d110a6" alt=""></p><br>
<br><p align="center"><img src="https://github.com/user-attachments/assets/382c597b-ccee-4e62-9a04-3994226f02af" alt=""></p><br>
<br><p align="center"><img src="https://github.com/user-attachments/assets/7d0b3a6a-49f8-47db-8c4d-86e9f0162c1c" alt=""></p><br>
<br><p align="center"><img src="https://github.com/user-attachments/assets/81020ae5-063d-40f1-9656-75ea80b6254a" alt=""></p><br>
On retourne sur le SVR2BILLU pour vérifier que tout est OK et qu’il est bien en lecture seule :
Avec la commande 
`Get-ADDomainController -Filter * | Where-Object { $_.Name -eq "SVR2BILLU" }`
<br><p align="center"><img src="https://github.com/user-attachments/assets/6f85ec68-b0d4-4946-a855-2cf0f5151cd5" alt=""></p><br>


# 🎯 Objectifs Secondaires DEFIS - Réalisations Importantes

## 1. **Connexion RDP Externe**
Nous avons réussi à établir une **connexion RDP** (Remote Desktop Protocol) depuis l'extérieur de **Proxmox**. Cette configuration permet d'accéder à nos serveurs du projet à distance, offrant ainsi une gestion plus souple et sécurisée des environnements sans nécessiter une connexion directe à la machine physique.

### 🔑 Points Clés :
- **Accès distant sécurisé** aux serveurs via RDP
- **Simplification de la gestion** des serveurs en dehors de l'infrastructure physique

---

## 2. **Installation du Conteneur AzVec Debian avec Juju
Avec l'aide de **Juju**, nous avons réussi à installer d'un conteneur Avec Debian. Ce conteneur s'intègre parfaitement dans l'architecture du projet, et son déploiement a été facilité grâce à la puissance de l'outil Juju pour gérer les configurations et les déploiements.

### 🔧 Configuration de la Machine en DHCP de Secours
Une fois le conteneur installé, nous avons configuré la machine en tant que **DHCP de secours**. Cela permet d'assurer une continuité de service en cas de défaillance du serveur principal DHCP, garantissant ainsi la **fiabilité** et la **résilience** de notre réseau.

### 🛠️ Points Clés :
- **Déploiement rapide et automatisé du conteneur grâce à Juju
- **DHCP de secours** pour maintenir la connectivité réseau en cas de problème

---

Ces objectifs secondaires sont des étapes cruciales pour garantir la **disponibilité**, la **flexibilité** et la **robustesse** de l'infrastructure réseau du projet.
