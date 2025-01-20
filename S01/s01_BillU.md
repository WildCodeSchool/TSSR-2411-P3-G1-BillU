
# 1. L'entreprise

**BillU** est une filiale du groupe international RemindMe, qui a plus de 2000 collaborateurs dans le monde. Elle est spécialisée dans le développement de logiciels, entre-autre de facturation. Le groupe prévoit un budget conséquent pour développer cette filiale. Le siège Français se situe à Paris (dans le 20 eme arrondissement).
Avec une équipe talentueuse de développeurs et d'experts en finance, elle est déterminée à fournir des logiciels de pointe qui simplifient les processus financiers et améliorent l'efficacité opérationnelle pour ses clients.
BillU comprend actuellement 167 personnes.
L'ensemble du personnel est réparti dans 9 services (appelés "départements").
Des personnels extérieurs travaillent ponctuellement ou à temps plein avec certains services.

# 2. Le groupe de projet 

Vous faites parti de la société BillU.
Votre formateur/formatrice joue le rôle du DSI de cette société.
Votre objectif final est de mettre en place une nouvelle infrastructure réseau.

# 3. Détails techniques et fonctionnels

## a. Les utilisateurs

Dans le fichier fourni en annexe.
Vous ajouterez vos propres comptes à ce fichier.

## b. Départements

- Communication et Relations publiques
- Département Juridique
- Développement logiciel
- Direction
- DSI
- Finance et comptabilité
- QHSE (Qualité, Hygiène, Sécurité et Environnement)
- Service Commercial
- Service recrutement

## c. Sites

Un seul site dans le 20ème arrondissement à Paris.

## d. Matériel client

100 % de PC portables de marques très hétérogènes.

## e. Matériel d'administration

Aucun serveur ni matériel réseau.

## f. Evolution de la société

Pas d'information.

## g. Réseau

Pour les utilisateurs interne, réseau en wifi fourni par une box FAI et des répéteurs wifi.
Le réseau est en 172.18.1.0/24

## h. Messagerie

La messagerie est hébergée en cloud sur le web.
Le format est `prenom.nom@billu.com`.

## i. Sécurité

Pas de matériel spécifique.
Pas de sécurité d'identité.
Tous les PC sont en workgroups avec une connexion sans mot de passe.

## j. Stockage de données

Un NAS indépendant grand public stock des données.
Pas de retentions et pas de redondance.

## k. Téléphonie

Téléphonie fixe et mobile aléatoire suivant les utilisateurs.

## l. Nomadisme

Pas de nomadisme, pas de télétravail.

# 4. Objectifs

Votre objectif final de fin de projet est de mettre en place une nouvelle infrastructure réseau.
Au fur-et-à-mesure de l'avancé du projet, des éléments matériels et logiciels vont venir s'ajouter, de même que vos connaissances et compétences personnelles.
Vous devrez régulièrement évaluer ce qui doit être fait, ainsi que (probablement) réévaluer ce qui a été fait dans les sprint précédents, afin d'améliorer votre infrastructure.
Cet objectif final va être découpé en sprint d'1 semaine.

Les éléments ci-dessous, vont servir à gérer les différents besoins et objectifs liés à l'ensemble du projet :
- Informations sur la société
- Fichiers annexes
- Contenu des projets 1 et 2
- Planning de formation dans Odyssey

Pour cette 1ère semaine de projet, exceptionnellement, les objectifs 1 et 2 sont **obligatoires** : 

1. Faire une proposition d'objectif par sprint pour l'ensemble de la formation
	1. Détails de chaque semaine
	2. Détails de chaque objectifs
2. Établir un schéma réseau prévisionnel de l'infrastructure
	1. Matériel réseau
	2. Serveur
	3. Adresse de réseau
3. Si nécessaire, établir les tables de routage des routeurs
4. Si nécessaire, établir une convention de nommage

# 5. Mise en place du suivi des objectifs du projet

## a. Le fichier

Tableau Google sheet **Suivi des objectifs de projet - Gx** (disponible sur le drive) dans lequel on trouve plusieurs templates :
- 3 templates d'objectifs, à choisir, ou pour vous inspirer !
- 3 templates de suivi individuel, à choisir ou pour vous inspirer !
- 1 Template PRA, pour plus tard dans la formation ...

Choisir 1 template de chaque et s'en servir pendant toute la durée du projet.

### i. Onglet Objectifs

À remplir toutes les semaines.

- Contient la liste des objectifs principaux, secondaires, et optionnels par sprint
	- Objectifs principaux :
		- Doivent être fait obligatoirement sur le sprint
		- Le groupe de projet s'engage à ce qu'ils soient fait sur le sprint
	- Objectifs secondaires :
		- Doivent fait avant la fin du projet
		- Le groupe s'engage à ce qu'ils doivent être fait avant la fin de la formation
	- Objectifs optionnels :
		- Peuvent ou non être fait avant la fin de la formation
		- Aucun engagement de la part du groupe de projet
- Les numéros de semaine de formation associés aux objectifs
- Le statut de chaque objectif :
	- `Non-Fait` : Aucun travail n'a été fait sur l'objectif
	- `En cours - 25 %` : 1/4 de l'objectif réalisé
	- `En cours - 50 %` : moitié de l'objectif réalisé
	- `En cours - 75 %` : 3/4 de l'objectif réalisé
	- `Terminé` : L'objectif est complètement fonctionnel avec documentation, etc.
- La date de réalisation à 100 %
- Les raisons pour lesquelles l'objectif n'a pas été terminé (si c'est le cas)

### ii. Onglet Suivi individuel

À remplir toutes les semaines.
Contient les tâches hebdomadaires de chaque membre du groupe.

### iii. Onglet PRA

Pour plus tard dans la formation ...

## b. Début de sprint

Remplissage du fichier :
- Onglet **Objectifs** :
	- Objectifs de la semaine mis dans les différentes catégories
	- Le groupe de projet s'engage à la réalisation des objectifs fixés
- Onglet **Suivi individuel** :
	- Tâches de chacun des membres du groupe de projet sur le sprint
	- Chaque membre du groupe s'engage individuellement à réaliser ses tâches

## c. Validation par votre formateur/formatrice

Dès que le fichier de suivi d'objectifs est rempli, point à faire entre le PO et le formateur/la formatrice.
Suite discussion ensemble, validation ou non du fichier.
⚠️ Aucun travail ne doit être commencé avant validation des objectifs !

## d. Product Owner

Il doit y avoir au minimum 1 point technique sur le projet avec le formateur/la formatrice.

## e. Fin de sprint

Présentation à la fin du bilan de projet des objectifs de la semaine (réalisés, non-réalisés, etc.).

# 6. Réalisation du projet

L'infrastructure réseau complète est réalisée sous l'hyperviseur Proxmox fourni par la Wild Code School.
Les fichiers nécessaires à la mise en place de infrastructure réseau sont stockés de la manière suivante :
- Sur le drive du groupe de projet : sources, exécutable
- Sur le dépôt Github du groupe de projet : documentations (avec lien internet des sources et autres fichiers à télécharger sur Internet)

# 7. Annexes

Sont fournis sur le drive les fichiers suivants :
- **Suivi des objectifs de projet - Gx** : pour le suivi des objectifs de projet
- **s01_<Société>** : contient la liste des utilisateurs de la société et autres informations
- **s01_conventionDeNommage** : pour illustrer ce qu'est une convention de nommage
- **s01_exemplesObjectifsPossibles** : des exemples d'objectifs pour le projet (liste non-exhaustive)