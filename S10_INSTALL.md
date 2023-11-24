
# **INSTALL GUIDE Infrastructure sécurisée pour BillU**
## _Semaine_10_


## **Besoins initiaux : besoins du projet**

Réalisation d'une infrastructure sécurisé pour l'entreprise BillU. Un domaine AD a été installé et sera complété par un serveur de gestion de mot de passe et un deuxième serveur DC
avec réplication. Gestion automatique des salariés de la société dans le répertoire AD.


## **Choix techniques**

Utilisation de Windows Server 2022 pour le DC supplémentaire. 
Utilisation de Bitwarden pour gérer les mots de passe. 
Utilisation de powershell afin d'automatiser la gestion des utilisateurs AD BillU, OU et groupe.

## **Étapes d'installation et de configuration : instruction étape par étape**

# Installation Bitwarden :
ressources pour installer à partir de proxmox sud Debian format LXC : Docker puis Bitwarden

installer d'abord Docker:

https://docs.docker.com/engine/install/debian/#install-from-a-package

installer ensuite Bitwarden :

https://bitwarden.com/help/install-on-premise-linux/

login : bitwarden

password : Billu2023!

# Installation et configuration du serveur core :

renommer, config réseau ip statique, peut se faire à partir de Sconfig

installer les rôles du serveur :


```batch
Install-WindowsFeature -Name RSAT-AD-Tools -IncludeManagementTools -IncludeAllSubFeature

Install -WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -IncludeAllSubFeature

install-WindowsFeature -Name DNS -IncludeManagementTools -IncludeAllSubFeature
```
ajout du contrôleur de domaine :

```batch
Install-ADDSDomainController -DomainName "billu.lan" -Credential (Get-Credential)
```

test :
```batch
Get-ADDomainController -Identity <server_name>
```

# **Script Powershell gestionad.ps1**

### _Présentation:_ 
Le script gestionad.ps1 permet de créer et gérer le domaine AD de la société BillU.  
Il gère la création d'utilisateur, d'OU, de sous-OU ainsi que des groupes. 
Les Utilisateurs sont automatiquement dirigés dans l'OU dont ils dépendent. 
Il permet également de prendre en compte les informations des utilisateurs et de les renseigner dans la fiche profil.  
Tout ceci est pris en compte suivant les fichiers CSV que le service DRH de l'entreprise fourni .  
Les mise à jour des salariés rentrant et sortant sont aussi géré par le script gestionad.ps1 via le fichier de mise à jour fourni par le service DRH de BillU.

### _Pré-requis:_ 
Pour le bon fonctionnement du script les fichiers csv du service DRH seront stockés sur C:\Users\Administrator\Desktop.

### _Utilisation:_ 
Lancer le script depuis la console Powershell. Il traîtera les fichiers renseigner dans les variables **$path1** et **$path2**.  
La variable **$path1** aura comme chemin le fichier csv en cours d'actualité, et la variable **$path2** aura le chemin du fichier csv de mise à jour.
Le MAIN du script est composé des fonctions utiles au script:   
- _Verif AD_: Contrôle l'activation du service AD.
- _CreateADForest_: Créé la fôret du domaine.  
- _Create1erOU_: Créé les OU principaux de l'organisation AD.
- _FormatCsv_: Utilise 2 fonctions, NormalizeCsv et RemplaceMot, afin de formater les fichiers csv au format nécessaire à l'utilisation du script.  
- _CreateOU_: Créé les OU intermédiare de l'organisation AD.  
- _DptSrv_: Traîte le champs service qui n'est pas toujours utilisé suivant les utilisateurs.  
- _CreateSousOU_: Créé les sous OU.  
- _CreateSousOUFunction_: Créé les OU les plus bas de l'organisation AD.  
- _Creategrp1_: Créé les groupes 1 de la hiérarchie (Managers et direction).  
- _Creategrp2_: Créé les groupes des différent services.  
- _CreateUser_: Créé les utilisateurs dans AD.   


 
## **Difficultés rencontrées : problèmes techniques rencontrés**

- installation de serveur windows core an tant que controlleur de domaine
  
- configuration de Debian LXC comme serveur Bitwarden

## **Solutions trouvées : Solutions et alternatives trouvées**



## **Tests réalisés : description des tests de performance, de sécurité, etc.**


## **Résultats obtenus : ce qui a fonctionné**


## **Améliorations possibles : suggestions d’améliorations futures**
- Journalisation des actions du script AD.

