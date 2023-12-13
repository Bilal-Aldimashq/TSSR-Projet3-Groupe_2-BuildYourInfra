# **INSTALL GUIDE Infrastructure sécurisée pour BillU**
## _Semaine_S6_
_Date de documentation: 11/12/2023_

# **Étapes d'installation et de configuration : instruction étape par étape:**


## Mise en place du RAID1 sur le volume systeme de l'AD PARIS

Ajouter un nouveau disque dur **(taille minimal equivalente a celle du disque systeme)** au serveur afin de mettre en place le systeme RAID.

Ceci fait, démarrer le serveur, aller sur _computer manager_, le nouveau disque devrait être visible.

Faire un clic droit sur le disque système et le mettre en mode dynamique. Faire de même sur le deuxième disque. 

Une fois les deux disques en mode dynamique, faire un clic droit sur le disque système et faire "_add mirror_" puis lui indiquer le deuxième disque pour le miroir.

Les disques sont dorénanavant en mode : _mirrored volumed_ et se synchronisent.

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/RAID.JPG?raw=true)

## Mettre en place des dossiers réseaux pour les utilisateurs

## Dossier individuel.

Pré-requis: Les dossiers personnels sont stockés sur un nouveau disque dur ajouté à notre serveur AD dans lequel est créé un dossier partagé "PersonnalFolders".  

Afin de créer et partager via le reseau le dossier personnel de chaque utilisateur, le profil utilisateur dans l'AD est modifié dans le champs : Home folder en faisant un clic droit sur l'utilisateur et aller sur propriétés :

connect I: to \\SRVWIN1\PersonnalFolders\%username%  

_%username% represente le nom de l utilisateur AD_  

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/DP.JPG?raw=true)


Pour nos besoins nous avons plus de 100 utilisateurs AD, nous passerons par un script qui modifiera les données sur les utilisateurs AD en ajoutant le chemin pour le dossier partagé. 

Les tests révèlent que le champs se rempli correctement mais ne crée pas le dossier partagé. Il a été rajouté au script à la création des dossiers personnels manuellement.

    Commande utiliser :

        $users = Get-ADUser -filter *

        foreach ($user in $users)
        {
        $cheminDossierPartage = "\\SRVWIN\PersonnalFolders\$($user.SamAccountName)"
            Set-ADUser $user -HomeDirectory $cheminDossierPartage -HomeDrive "I:"
            New-Item $cheminDossierPartage -ItemType Directory 
            Write-Host "le dossier personnel à été crée et à été ajouté au lecteur logique I:" -ForegroundColor Green 
        }

Après des tests sur différents clients windows 10 le dossier créé par le script est bien un dossier nominatif et placé sur I:

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/Dp2.JPG?raw=true)

## Dossier Service.

Pré-requis : création manuelle de l'ensemble des dossiers partagés de départements et services dans un dossier nommé "DptFolders" sur le nouveau disque dur implanté dans notre serveur AD dans lequel sont déjà stockés les dossiers personnels. (voir exemple)

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/DS.JPG?raw=true)

Le dossier DptCommercial contient les dossiers de chaque service (voir exemple)

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/DS2.JPG?raw=true)

A la suite de cette opération il est nécessaire d'attribuer les droits spécifiques au groupe AD pour accéder à son propre dossier de service et/ou département. 
Exemple de traitement avec le département Juridique ci-dessous :

Partage du dossier "DptJuridique" en ajoutant le groupe Dptjurique en mode lecture uniquement.

![dptjuridique1](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/assets/146104077/d03bbc9a-23a9-4846-b5d4-867083710bdf)

![dptjuridique2](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/assets/146104077/bb249e86-a73d-4f96-81e5-297766042c49)

dans le dossier DPTJuridique se trouve 2 autre dossiers ProtectionIntellectuelle et ProtesctionDesDonneesEtConformite

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/DS5.JPG?raw=true)

nous allons partager le dossier ProtectionIntellectuelle en ajoutant le groupe ProtectionIntellectuelle et en desactivant les droit hereditaire du dossier DPTjuridique. 
et la meme avec le dossier ProtesctionDesDonneesEtConformite en ajoutant le bon groupe

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/DS6.JPG?raw=true)

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/DS7.JPG?raw=true)

pour les test nous avons connecter h.cault et y.boyer qui sont 2 client des 2 services qui nous concerne et on vois bien que h.cault ne vois que le dossier ProtectionIntellectuelle
et que y.boyer ne vois que le dossier ProtesctionDesDonneesEtConformite

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/DS8.JPG?raw=true)

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/DS9.JPG?raw=true)

# RESTRICTION D'UTILISATION DES MACHINES - restriction horaire

Pour cet objectif nous avons 2 chose a faire

**Premierement** : regler la plage horaire sur chaque utilisateur dans l'AD pour cela nous avons trouver une commande powershell

`Get-ADUser -SearchBase "OU=Utilisateurs,DC=billu,DC=lan" -Filter *| Set-LogonHours -TimeIn24Format @(7,8,9,10,11,12,13,14,15,16,17,18,19,20) -Monday -Tuesday -Wednesday -Thursday -Friday -Saturday -NonSelectedDaysare NonWorkingDays`

cette commande permet modifier tout les utilisateurs AD en modifant la plage horaire de connection. du lundi au samedi de 7h a 20h du lundi au samedi et se traduit par une modification de se tableau.

ceci fait faut penser a remodifier manuellement tout les administrateurs AD afin qui ne soit pas affecte par la GPO qui sera créé .

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/RU.JPG?raw=true)

**Deuxiemement** : créé une GPO Ordinateur qui va deconnecter ou empecher la connection si vous n'etes pas dans la plage d'horaire voulu.

pour créé cette GPO on va dans Group Policy Management on créé une nouvelle GPO pour nous nommé COMPUTER_Restriction. qui sera appliquer sur l'OU ordinateur, et on s'assure que "configuration setting disabled " est bien mis

et on va editer la GPO :: 

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/RU2.JPG?raw=true)

Dans Computer configuration / Policies / Windows Settings / Security Settings / Local Policies / Security Option on va chercher Microsoft network server: Disconnect Client when Logon Hours Expire et on va le mettre sur Enabled valider et appliquer la GPO

Pour les test nous avons regler l'heure pour un client afin qu'il ne puisse pas se connecter peu importe l'heure et un autre ou il peut acceder jusqu'a 20h comme voulu dans le projet

le 1er ne peut pas se connecter alors que le deuxieme oui .

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/RU3.JPG?raw=true)



