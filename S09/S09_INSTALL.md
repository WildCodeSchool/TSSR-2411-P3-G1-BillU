
# 📚 Guide d'installation et de configuration de **FreePBX 16** sur **VirtualBox**  

## 🛠️ **Prérequis**
- **VirtualBox** installé 🖥️  
- **ISO de FreePBX 16** téléchargé 🔽  
- Un **réseau interne** avec le sous-réseau **172.18.0.0/24**  
- Un accès à **Internet** via une **interface en pont** 🌍  
- **3CXPhone** installé sur les PC clients 💻  

---

## 1️⃣ **Création de la VM sous VirtualBox**  

### 🔧 **Configuration matérielle**  
1. **Créer une nouvelle VM**  
   - **Nom** : `FreePBX16`  
   - **Type** : Linux  
   - **Version** : Red Hat (64-bit)  
   - **Mémoire RAM** : **2048 Mo** (minimum recommandé)  
   - **Processeurs** : **2** (minimum recommandé)  
   - **Stockage** : **20 Go** (ou plus selon vos besoins)  

2. **Configurer les interfaces réseau**  
   - **Adapter 1 (eth0)** : Réseau interne (`intnet`)  
   - **Adapter 2 (eth1)** : Mode **Pont** (pour accès Internet)  

3. **Monter l'ISO** de FreePBX 16 dans le lecteur CD/DVD  

---

## 2️⃣ **Installation de FreePBX 16**  
### 🔥 **Démarrer la VM et installer FreePBX**
1. Sélectionner **"Full Installation with Asterisk"**  
2. Laisser l'installation se dérouler **automatiquement** ⏳  
3. Une fois terminé, **retirer l'ISO** et redémarrer 🚀  
4. **Se connecter** en root avec le mot de passe défini  

---

## 3️⃣ **Configuration du réseau**  

### 🌐 **Définition d'une IP fixe pour eth0 (réseau interne)**
1. Éditer le fichier de configuration :  
   ```bash
   nano /etc/sysconfig/network-scripts/ifcfg-eth0
   ```
2. Modifier son contenu comme suit :  
   ```ini
   DEVICE=eth0
   BOOTPROTO=none
   ONBOOT=yes
   IPADDR=172.18.0.32
   NETMASK=255.255.255.0
   GATEWAY=172.18.0.1
   ```
3. **Redémarrer le service réseau** :  
   ```bash
   systemctl restart network
   ```

### 📶 **Vérifier la connectivité**
- Tester le réseau avec :  
  ```bash
  ip a
  ping 8.8.8.8
  ```

---

## 4️⃣ **Mise à jour de FreePBX**  

### 🔄 **Mettre à jour le système et FreePBX**
1. **Mettre à jour CentOS** (ou AlmaLinux/Rocky selon la version)  
   ```bash
   yum update -y
   ```
2. **Mettre à jour tous les modules FreePBX**  
   ```bash
   fwconsole ma upgradeall
   fwconsole reload
   ```
3. **Appliquer les mises à jour de sécurité**  
   ```bash
   fwconsole chown
   fwconsole restart
   ```

---

## 5️⃣ **Accéder à l'interface Web de FreePBX**  
- Ouvrir un navigateur et entrer :  
  ```
  http://172.18.0.32
  ```
- **Se connecter** et suivre l’assistant de configuration  

---

## 6️⃣ **Création des comptes SIP**  

### ➕ **Ajouter les utilisateurs**
1. Aller dans **Applications** > **Extensions**  
2. **Créer trois extensions SIP** :
   | Utilisateur      | Extension | Mot de passe  |
   |-----------------|-----------|--------------|
   | Camille Martin  | 80104     | ``* |
   | Anthony Noel    | 80105     | ``*  |
   | Mathys Mercier  | 80106     | ``*  |

3. **Sauvegarder et appliquer les modifications** ✅  

---

## 7️⃣ **Configuration de 3CXPhone** sur les PC clients  

### 🐅 **Installation de 3CXPhone**
1. Télécharger **3CXPhone** sur le site officiel  
2. Installer le programme et l’ouvrir  

### 🔧 **Ajouter un compte SIP dans 3CXPhone**
- **SIP Server** : `172.18.0.32`  
- **User** : *(choisir l’extension associée)*  
- **Password** : *(mot de passe correspondant)*  
- **Transport** : UDP  

Exemple pour **Camille Martin** :  
| Paramètre        | Valeur          |
|-----------------|----------------|
| **SIP Server**  | 172.18.0.32    |
| **User**        | 80104          |
| **Password**    |    *   |

---
*Password non afficher pour raison de confidentialité

## 8️⃣ **Tests et validation**  
- 🎢 **Passer un appel entre les utilisateurs**  
- ✅ **Vérifier que la communication fonctionne bien**  

---

🎉 **Félicitations ! Vous avez installé FreePBX 16, effectué les mises
