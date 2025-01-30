## Lier le server core au domaine BILLU.lan et le promouvoir en DC RODC (lecture seule)

**Sur le serveur Core :**

1. Configuration de l’adresse IPv4ex avec la commande Powershell :

`Set-NetIPAddress -IPAddress "172.18.0.4" -PrefixLength 24 -InterfaceAlias "Ethernet 2"`

EN effet, la modification de l’adresse IPv4 via le menu ne suffisait pas.

1. Test de ping sur le serveur BILLU1
2. Pour lier le serveur core au domaine BILLU.lan, on a utilisé la commande :

`Add-Computer -DomainName "BILLU.lan" -Credential BILLU\Administrator`
4. Une fois la commande exécutée, on redémarre le serveur Core avec `Restart-Computer`

1. Rendez-vous ensuite sur le serveur principal

Sur le Serveur principal

1. Contrôler que le SVR2BILLU fait bien partie du domaine :
![image (4)](https://github.com/user-attachments/assets/58dc247c-152d-4bc3-bc7f-94955d2f49d1)

2. Ajouter le serveur dans le gestionnaire de serveurs :
![image (5)](https://github.com/user-attachments/assets/e15262a8-7c4a-4dfc-aa46-de75c0a737e7)
![image (6)](https://github.com/user-attachments/assets/73834b49-4e36-40e7-abbd-75dbab327cd7)
![image (7)](https://github.com/user-attachments/assets/bc1684f6-c8e4-4eb2-ab4d-d16c4ba54388)
3. Ajouter le rôle RODC au SVR2BILLU, avec l’assistant Ajout de rôles et de fonctionnalités :
![image (8)](https://github.com/user-attachments/assets/20f7e3fb-c478-40e9-8a5c-dfa679975830)
![image (9)](https://github.com/user-attachments/assets/bd502b6e-845b-47ae-8a37-b0ce031beaef)
![image (10)](https://github.com/user-attachments/assets/cc2d7b83-fb80-4abe-b3a8-f4d60508c84a)
![image (11)](https://github.com/user-attachments/assets/df63af56-3f81-4688-93cf-8e1f93e4e997)
![image (12)](https://github.com/user-attachments/assets/8c811898-320e-41e1-aefe-c857f9e7b408)
![image (13)](https://github.com/user-attachments/assets/e0b65983-7775-43c4-964f-b2fa00d110a6)
![image (14)](https://github.com/user-attachments/assets/382c597b-ccee-4e62-9a04-3994226f02af)
![image (15)](https://github.com/user-attachments/assets/7d0b3a6a-49f8-47db-8c4d-86e9f0162c1c)
![image (16)](https://github.com/user-attachments/assets/81020ae5-063d-40f1-9656-75ea80b6254a)
On retourne sur le SVR2BILLU pour vérifier que tout est OK et qu’il est bien en lecture seule :
Avec la commande 
`Get-ADDomainController -Filter * | Where-Object { $_.Name -eq "SVR2BILLU" }`
![image (17)](https://github.com/user-attachments/assets/6f85ec68-b0d4-4946-a855-2cf0f5151cd5)
