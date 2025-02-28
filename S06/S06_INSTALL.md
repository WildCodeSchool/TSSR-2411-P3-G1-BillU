1. [Installation de Veeam](#1-Installation-de-Veeam)
2. [Installation du partage de dossier et des droits d'accès](#2-Installation-du-partage-de-dossier-et-des-droits-daccès)
3. [Installation et configuration de GLPI Agent](#3-Installation-et-configuration-de-GLPI-Agent)
4. [Installation et configuration de LAPS](#4-Installation-et-configuration-de-LAPS)
5. [Installation de l'agent Zabbix sur PfSense](#5-Installation-de-lagent-Zabbix-sur-PfSense)


# 1. Installation de Veeam
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/424c7bb6-87a5-4060-9f7f-146a74ba2457" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/e07cf8b3-86dc-4702-8d1a-3697ec59fd1d" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/1f7dc2ad-22ea-4ef6-a840-0c0b44f37d87" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/f611492d-e333-4df4-ac95-ebcec3badc8d" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/dca94429-03e4-496e-ae6e-ad2d160e8e62" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/44dcc193-3832-4742-b54f-0f701bfa624f" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/3ede9d20-c5ab-41f3-8a7a-1701678dad26" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/ebfc1dae-1d86-45c8-821b-cf784f38753d" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/77914083-60f2-4b60-9a19-c6d0f26abcef" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/a5c9d988-8c43-4dcd-9777-6b1230c33ec8" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/93535246-2771-4d81-b834-37e303f42048" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/1a720384-7de1-4f99-a615-3e8b873d24f1" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/f02b5f6d-98b3-483f-9486-b5b485f613f4" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/d07f396f-62d5-4988-bdd1-08285b9798b2" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/2b551865-4dd2-4aff-9686-24cbf648655f" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/dc724fa1-717b-4d61-b6b1-cf291d70b32d" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/f63c5d73-2b99-4641-a75d-16be2d96d276" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/f3f7697c-a308-4426-87eb-ef80ca49bdf7" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/6ee2396c-32ec-42cd-8480-50a9e56a572e" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/1c405149-a751-4695-a641-629e83626d40" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/dfc58945-e74c-43e8-b2e5-30165591209b" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/74af82c8-7189-4c09-bf65-17fcd3333f3b" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/836d3182-b123-4998-af5d-da32c642e3fe" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/3cbb7c9d-deb7-42b9-af75-6db8880fd94a" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/33d52501-180e-4be1-84d2-a1273501a942" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/e6338751-3e4a-496f-b328-d3700703be3f" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/37f57717-871f-4e61-b6d0-ff50bcec899b" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/5405ba67-c2da-49f2-be50-4e37739f864d" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/5e3c1bb6-3341-453a-aaf7-424672f7217e" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/c6669921-7a23-46ea-b7ea-9d57810c92c1" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/8dd7034e-d1e6-4cea-91b8-d96e65116b13" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/dd6591c1-31f4-49e5-847c-a84f48f12d7c" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/c03b98d9-fb74-4ee0-982c-023ae0bb2d05" alt=""></p>

# 2. Installation du partage de dossier et des droits d'accès
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/e94f6a51-d02a-49ba-b391-5fe686315532" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/1fbd30ec-837a-427c-8bca-86d8c8554412" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/cdebca30-65dd-4c5d-9988-93e8a20ab24c" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/79d73e7b-7761-4abe-941f-683793d1827d" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/5b67b39a-a62c-46a6-a4bb-5106461a7895" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/dfac6a71-0b27-4ee6-8161-7272666bbc41" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/d338130e-6738-4ac0-8278-a3efc88ee738" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/60bd57b8-d6e3-4e55-ad86-24ca92710c81" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/63cfa4b6-1bb9-4987-ae9c-b9da70d78a5f" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/dcea1cf0-f462-4b2c-9fa5-577fc94d5576" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/26a8023f-1b8b-4e09-a810-e5ec488d06df" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/20b90cda-7fc7-4f8c-8656-488866d791ed" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/dc431a0f-871a-4546-964e-efe43ef5002f" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/10f585ad-d58b-4652-9e0e-d3d8a07cf3cb" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/e3cf762d-e971-45f4-9caa-d491446abf6f" alt=""></p>


# 3. Installation et configuration de GLPI Agent

<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/4c2eebd5-279f-403a-83db-abb78d89e95c" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/76601b5c-b11b-4540-8551-3255cc8ab923" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/f134260c-b17f-418e-b7ca-1385aad5b402" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/b46f6fd0-d2fb-4e69-bb94-ba552a1b5a59" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/07b7c916-2e76-4617-8754-d2833a7706e4" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/9ff7d0d7-bbcc-406e-a76f-03e88767789f" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/83835cdf-2f08-454e-a9b7-55aba3b005b6" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/bc78dc36-0383-48ad-835b-f58d54cfdd2e" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/174e4588-4b4a-4915-aaeb-e000683f2359" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/7cab1558-1c55-49a5-bd1c-2d467c00c0ee" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/4134c7ff-b190-49ae-8642-3ffbe3e479e9" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/e96ca25f-9ad4-4be4-bbf8-d86687d76a30" alt=""></p>
<br><p align="center"><img width="70%" src="https://github.com/user-attachments/assets/40fe8e71-b0c5-4b92-972c-fc0ecc3d90f8" alt=""></p>


# 4. Installation et configuration de LAPS

![installation et paramétrage - LAPS - 1](https://github.com/WildCodeSchool/TSSR-2411-P3-G1-BillU/blob/main/S06/RESSOURCES/installation%20et%20param%C3%A9trage%20-%20LAPS%20-%201.jpg)
![installation et paramétrage - LAPS - 2](https://github.com/WildCodeSchool/TSSR-2411-P3-G1-BillU/blob/main/S06/RESSOURCES/installation%20et%20param%C3%A9trage%20-%20LAPS%20-%202.jpg)
![installation et paramétrage - LAPS - 3](https://github.com/WildCodeSchool/TSSR-2411-P3-G1-BillU/blob/main/S06/RESSOURCES/installation%20et%20param%C3%A9trage%20-%20LAPS%20-%203.jpg)
![installation et paramétrage - LAPS - 4](https://github.com/WildCodeSchool/TSSR-2411-P3-G1-BillU/blob/main/S06/RESSOURCES/installation%20et%20param%C3%A9trage%20-%20LAPS%20-%204.jpg)
![installation et paramétrage - LAPS - 5](https://github.com/WildCodeSchool/TSSR-2411-P3-G1-BillU/blob/main/S06/RESSOURCES/installation%20et%20param%C3%A9trage%20-%20LAPS%20-%205.jpg)
![installation et paramétrage - LAPS - 6](https://github.com/user-attachments/assets/5b4f0559-191f-4c19-9afc-b50dce046006)
![installation et paramétrage - LAPS - 7](https://github.com/user-attachments/assets/22a471ee-690a-42bd-8032-36deb3cf7fbd)
![installation et paramétrage - LAPS - 8](https://github.com/user-attachments/assets/d5a69b05-71a4-48f3-8c11-35834343ee5f)
![installation et paramétrage - LAPS - 9](https://github.com/user-attachments/assets/c7aa845f-3a42-45a7-85bd-a3e926b780a0)
![installation et paramétrage - LAPS - 10](https://github.com/user-attachments/assets/47ff6a28-f121-4744-90ca-aed6dcca4fed)
![installation et paramétrage - LAPS - 11](https://github.com/user-attachments/assets/bbf4783a-9cef-4ab6-8c9c-eba83a2c8d64)
![installation et paramétrage - LAPS - 12](https://github.com/user-attachments/assets/a02903d8-6f77-4e3b-a7c2-4ddbfacfb662)
![installation et paramétrage - LAPS - 13](https://github.com/user-attachments/assets/80529e7f-3658-4246-84ad-5ceb4a74b13f)
![installation et paramétrage - LAPS - 14](https://github.com/user-attachments/assets/47b5a619-fb3b-4a59-9f40-57c707a37475)
![installation et paramétrage - LAPS - 15](https://github.com/user-attachments/assets/76e3f195-d724-48f6-8d4a-ef626a858cc9)

# 5. Installation de l'agent Zabbix sur PfSense

![installation de l'agent Zabbix](https://github.com/WildCodeSchool/TSSR-2411-P3-G1-BillU/blob/main/S06/RESSOURCES/install-zabbix-agent-sur-pfsense-1.jpg)
![installation de l'agent Zabbix](https://github.com/WildCodeSchool/TSSR-2411-P3-G1-BillU/blob/main/S06/RESSOURCES/install-zabbix-agent-sur-pfsense-2.jpg)
![installation de l'agent Zabbix](https://github.com/WildCodeSchool/TSSR-2411-P3-G1-BillU/blob/main/S06/RESSOURCES/install-zabbix-agent-sur-pfsense-3.jpg)
![installation de l'agent Zabbix](https://github.com/WildCodeSchool/TSSR-2411-P3-G1-BillU/blob/main/S06/RESSOURCES/install-zabbix-agent-sur-pfsense-4.jpg)
![installation de l'agent Zabbix](https://github.com/WildCodeSchool/TSSR-2411-P3-G1-BillU/blob/main/S06/RESSOURCES/install-zabbix-agent-sur-pfsense-5.jpg)
![installation de l'agent Zabbix](https://github.com/WildCodeSchool/TSSR-2411-P3-G1-BillU/blob/main/S06/RESSOURCES/install-zabbix-agent-sur-pfsense-6.jpg)
![installation de l'agent Zabbix](https://github.com/WildCodeSchool/TSSR-2411-P3-G1-BillU/blob/main/S06/RESSOURCES/install-zabbix-agent-sur-pfsense-7.jpg)
![installation de l'agent Zabbix](https://github.com/WildCodeSchool/TSSR-2411-P3-G1-BillU/blob/main/S06/RESSOURCES/install-zabbix-agent-sur-pfsense-8.jpg)
![installation de l'agent Zabbix](https://github.com/WildCodeSchool/TSSR-2411-P3-G1-BillU/blob/main/S06/RESSOURCES/install-zabbix-agent-sur-pfsense-9.jpg)
![installation de l'agent Zabbix](https://github.com/WildCodeSchool/TSSR-2411-P3-G1-BillU/blob/main/S06/RESSOURCES/install-zabbix-agent-sur-pfsense-10.jpg)
![installation de l'agent Zabbix](https://github.com/WildCodeSchool/TSSR-2411-P3-G1-BillU/blob/main/S06/RESSOURCES/install-zabbix-agent-sur-pfsense-11.jpg)
![installation de l'agent Zabbix](https://github.com/WildCodeSchool/TSSR-2411-P3-G1-BillU/blob/main/S06/RESSOURCES/install-zabbix-agent-sur-pfsense-12.jpg)
![installation de l'agent Zabbix](https://github.com/WildCodeSchool/TSSR-2411-P3-G1-BillU/blob/main/S06/RESSOURCES/install-zabbix-agent-sur-pfsense-13.jpg)
![installation de l'agent Zabbix](https://github.com/WildCodeSchool/TSSR-2411-P3-G1-BillU/blob/main/S06/RESSOURCES/install-zabbix-agent-sur-pfsense-14.jpg)
![installation de l'agent Zabbix](https://github.com/WildCodeSchool/TSSR-2411-P3-G1-BillU/blob/main/S06/RESSOURCES/install-zabbix-agent-sur-pfsense-15.jpg)
