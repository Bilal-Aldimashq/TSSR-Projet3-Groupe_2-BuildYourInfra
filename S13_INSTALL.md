# **INSTALL GUIDE Infrastructure sécurisée pour BillU**
## _Semaine_S6_
_Date de documentation: 11/12/2023_

# **Étapes d'installation et de configuration : instruction étape par étape:**


## Mise en place du RAID 1 sur le volume systeme de l'AD PARIS

Ajouter un nouveau disque dur **(taille minimal equivalente a celle du disque systeme)** au serveur afin de mettre en place le systeme RAID 1.

Puis démarrer le serveur, aller sur _computer manager_, le nouveau disque devrait être visible.

Faire un clic droit sur le disque système et le mettre en mode dynamique. Faire de même sur le deuxième disque. 

Une fois les deux disques en mode dynamique, faire un clic droit sur le disque système et faire "_add mirror_" puis lui indiquer le deuxième disque pour le miroir.

Les disques sont dorénavant en mode : _mirrored volumed_ et se synchronisent.

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/RAID.JPG?raw=true)

## Mettre en place des dossiers réseaux pour les utilisateurs

## Dossier individuel.

Pré-requis: Les dossiers personnels sont stockés sur un nouveau disque dur ajouté à notre serveur AD dans lequel est créé un dossier partagé "PersonnalFolders" qui acceuillera l'ensemble des dossiers personnels.  

Afin de créer et partager via le reseau le dossier personnel de chaque utilisateur, le profil utilisateur dans l'AD est modifié dans le champs : "Home folder" en faisant un clic droit sur l'utilisateur et aller sur propriétés :

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

Dans le dossier "DptJuridique" se trouve deux autre dossiers "ProtectionIntellectuelle" et "ProtesctionDesDonneesEtConformite"

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/DS5.JPG?raw=true)

Partage du dossier "ProtectionIntellectuelle" en ajoutant le groupe ProtectionIntellectuelle et en désactivant les droits héréditaires du dossier "DPTjuridique". 
Faire de même avec le dossier "ProtesctionDesDonneesEtConformite" en ajoutant le bon groupe.

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/DS6.JPG?raw=true)

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/DS7.JPG?raw=true)

Tests réalisés en se connectant avec les utilisateurs de l'AD suivants : h.cault et y.boye. Chaque utilisateur de l'AD ne voit que le dossier de son service.

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/DS8.JPG?raw=true)

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/DS9.JPG?raw=true)

# RESTRICTION D'UTILISATION DES MACHINES - restriction horaire

Pour cet objectif deux actions à réaliser :

**Premierement** : régler la plage horaire pour chaque utilisateur dans l'AD, action effectuée par commande powershell :

`Get-ADUser -SearchBase "OU=Utilisateurs,DC=billu,DC=lan" -Filter *| Set-LogonHours -TimeIn24Format @(7,8,9,10,11,12,13,14,15,16,17,18,19,20) -Monday -Tuesday -Wednesday -Thursday -Friday -Saturday -NonSelectedDaysare NonWorkingDays`

Cette commande permet de modifier la plage horaire de connection de tous les utilisateurs AD du lundi au samedi de 7h a 20h. 
Modification du tableau comme indiqué ci-dessous.

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/RU.JPG?raw=true)

Pour tous les administrateurs AD modification manuelle afin qu'ils ne soient pas affectés par la GPO qui sera créé et qu'ils n'aient pas de restriction horaire.

**Deuxiemement** : Créer une GPO Ordinateur qui va deconnecter et empecher la connection en dehors de la plage horaire attribuée.

Création : dans Group Policy Management -> nouvelle GPO -> nommée "COMPUTER_Restriction" qui sera appliquée sur l'OU ordinateur, et on s'assure que GPO Staus soit bien "User configuration settings disabled".

Edition de la GPO : 

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/RU2.JPG?raw=true)

Dans le chemin "Computer configuration / Policies / Windows Settings / Security Settings / Local Policies / Security Option" sélectionner "Microsoft network server: Disconnect Client when Logon Hours Expire" et l'activer "Enabled",valider puis appliquer la GPO.

Pour les tests, réglage de l'heure pour un utilisateur AD afin qu'il ne puisse pas se connecter peu importe l'heure et un autre utilistauer AD qui accède à sa cession jusqu'a 20h.

le premier utilisateur ne peut se connecter alors que le deuxieme le peut.

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/RU3.JPG?raw=true)



