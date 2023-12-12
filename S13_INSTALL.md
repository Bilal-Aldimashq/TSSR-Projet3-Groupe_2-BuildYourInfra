# **INSTALL GUIDE Infrastructure sécurisée pour BillU**
## _Semaine_S6_
_Date de documentation: 11/12/2023_

# **Étapes d'installation et de configuration : instruction étape par étape:**
# Mise en place du RAID1 sur le volume systeme de l'AD PARIS

Ajouter un nouveau disque dur (taille minimal equivalente a celle du disque systeme) au serveur afin de mettre en place le systeme RAID.

Ceci fait on va demarrer le serveur, aller sur computer manager le nouveau disque devrait etre visible.

on va faire un clique droit sur le disque systeme est le passer en dynamique. On va faire de meme sur le 2eme Disque. 

une fois les 2 disque en dynamique on va faire un clique droit sur le disque systeme et faire "add mirror" et lui indiquer le 2eme disque pour le miroir.

les disques vont passer en mirrored volumed et se synchroniser.

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/RAID.JPG?raw=true)

# Mettre en place des dossiers réseaux pour les utilisateurs

## Dossier individuelle.

Pre-requis : les dossier personnel devront etre stocker sur un autre disque, et avoir créé un dossier partager "PersonnalFolders" dedans

Afin de créé et partager via le reseau le dossier personnel de chaque utilisateur on va modifier dans le profile utilisateur AD les champs suivants: Home folder connect I: to \\SRVWIN1\PersonnalFolders\%username%

%username% represente le nom de l utilisateur AD 

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/DP.JPG?raw=true)


pour nous besoin nous avons plus 100 utilisateur AD nous passerons par un script qui modifira les donnees sur les utilisateur AD en ajoutant le chemin pour le dossier partagé. 

en faisant ceci nous nous sommes apercu que le champs se remplisser bien mais ne créé pas le dossier partagé. donc nous avons rajouter au script la creation des dossier personnel manuellement.

    Commande utiliser :

        $users = Get-ADUser -filter *

        foreach ($user in $users)
        {
        $cheminDossierPartage = "\\SRVWIN\PersonnalFolders\$($user.SamAccountName)"
            Set-ADUser $user -HomeDirectory $cheminDossierPartage -HomeDrive "I:"
            New-Item $cheminDossierPartage -ItemType Directory 
            Write-Host "le dossier personnel à été crée et à été ajouté au lecteur logique I:" -ForegroundColor Green 
        }

pour les tests nous avons demarer differents clients afin de voir si notre dossier est bien un dossier nominatif et placer sur I:

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/Dp2.JPG?raw=true)

## Dossier Service.

Pré-requis : reprendre le disque dur des dossiers personnel et créé tout les dossier necessaire. Dans notre cas on va créé les dossiers de touts les departement et des ses dossiers on va 
ajouter les dossier des services.

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/DS.JPG?raw=true)

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/DS2.JPG?raw=true)

on fois ceci fait, on va commencer le partage des fichier et attribuer les droit au groupe AD voulu. pour la document je prendrais le cas du departement Juridique.

on partage le dossier DPTJuridique en ajoutant le groupe DPTjurique a Read seulement le dossier.

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/DS3.JPG?raw=true)

![img](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/DS4.JPG?raw=true)

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

cette commande permet modifier tout les utilisateurs AD en modifant la plage horaire de connection. du lundi au samedi de 7h a 20h et se traduit par une modification de se tableau.

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



