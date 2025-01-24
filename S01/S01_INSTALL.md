
# 🌐 Proposition de Infrastructure Réseau Professionnelle

## 🎯 1. Objectifs Généraux

| Objectif | Description |
|----------|-------------|
| 🏗️ **Structurer le réseau** | Passer d'un réseau basé sur une box et des répéteurs Wi-Fi à un réseau local sécurisé avec des équipements professionnels |
| 👥 **Centraliser l'administration** | Mettre en place un domaine Active Directory pour gérer les utilisateurs, leurs permissions et leurs appareils |
| 🔒 **Améliorer la sécurité** | Renforcer la protection des données, l'accès réseau et la sécurité des équipements |
| ⚡ **Garantir la disponibilité** | Introduire des solutions redondantes pour éviter les pertes de données et les interruptions de service |

## 🖥️ 2. Infrastructure Réseau Proposée

### 🌍 Équipements Réseau

#### 1. Pare-feu pfSense 🛡️
- **Matériel recommandé** : Protectli Vault (4 ports)
- **Fonction** : Gestion des règles de sécurité, routage inter-VLAN et accès Internet
- **Coût estimé** : ~400 €

#### 2. Switch Central 🔀
- **Modèle** : TP-Link JetStream TL-SG3428MP (24 ports Gigabit + PoE)
- **Utilisation** : Connecter les points d'accès et autres équipements réseau
- **Coût estimé** : 450 €

#### 3. Points d'Accès Wi-Fi 📡
- **Modèle** : 18 Ubiquiti UniFi 6 Lite (2 par département)
- **Objectif** : Réseau sans fil performant avec isolation des utilisateurs par VLAN
- **Coût estimé** : 2 160 € (120 €/unité)

## 💰 Détail Estimatif des Coûts

### 1. Matériel Réseau 🖧

| Équipement | Détails | Coût |
|------------|---------|------|
| Pare-feu (pfSense) | [Protectli Vault 4 ports (VP2410)](https://eu.protectli.com/product/vp2410/) | 400 € |
| Switch central | [TP-Link JetStream TL-SG3428](https://www.tp-link.com/fr/business-networking/managed-switch/tl-sg3428/) | 350 € |
| Switchs départementaux | 9 x [TP-Link TL-SG2218](https://www.omadanetworks.com/fr/business-networking/omada-switch-smart/tl-sg2218/) | 1 800 € |
| Routeur | Non nécessaire (pfSense) | 0 € |
| **Sous-total** | | **2 550 €** |

### 2. Serveurs 🖲️

| Serveur | Détails | Coût |
|---------|---------|------|
| DNS/DHCP/AD/DC | HPE ProLiant DL20 Gen10 | 1 500 € |
| Licence Windows Server 2022 Standard | | 1 200 € |
| Licences CAL (35 CAL pour 167 utilisateurs) | | 2 135 € |
| Serveur GLPI | Dell PowerEdge T40 | 800 € |
| NAS pour sauvegarde | Synology DS1522+ | 700 € |
| Disques durs | 4 x Seagate IronWolf 4 To | 480 € |
| **Sous-total** | | **6 815 €** |

### Autres Sections de Coûts 💡

(Les autres sections de coûts sont structurées de manière similaire)

## 💸 Résumé Final des Coûts

| Catégorie | Coût Total (€) |
|-----------|----------------|
| Matériel Réseau | 2 550 |
| Serveurs | 6 815 |
| Postes Utilisateurs | 52 260 |
| Logiciels | 4 175 |
| Onduleurs | 1 950 |
| **Total Global (HT)** | **67 750 €** |

## 📝 Remarques Importantes 🔍

1. 💡 Cette estimation reste indicative, car les prix peuvent varier selon les fournisseurs.
2. 💶 Pensez à ajouter la TVA si elle s'applique.
3. 🛠️ Les coûts d'installation, de maintenance ou de formation ne sont pas inclus.
4. 💰 Vous pouvez encore réduire les coûts en optant pour des équipements d'occasion ou reconditionnés.

**👉 Conseil Pro** : N'hésitez pas à demander plusieurs devis et à négocier avec les fournisseurs ! 🤝
