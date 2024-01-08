# **INSTALL GUIDE Infrastructure sécurisée pour BillU**

## _Semaine_S8_

_Date de documentation: 03/01/2024_
__________

## **Besoins initiaux : besoins du projet:**

## **Choix techniques:**

# **Étapes d'installation et de configuration : instruction étape par étape:**

# Installation de LAPS (Local Administrator Password Solution) :

## Pré-requis :

afin d'être sûr d'utiliser LAPS et non LAPS legacy nos machines doivent au minimum avoir les mise a jour de sécurité suivantes :

        Win10 : KB5025221
        Win11 : KB5025224
        Winsrv22 : KB5025230

### installation et configuration de LAPS :

Pour installer et configurer LAPS on va passer par powershell en mode administrateur et lancer les commandes suivantes :

    - import-module LAPS : importer le module LAPS ds le serveur
    - get-command -module LAPS : vérifie que le module LAPS est bien installer

![img 1](https://github.com/michaelc31/Projet-image/blob/main/LAPS%20-%20Zimbra/IMG1.JPG?raw=true)

    - update-LapsADSchema -verbose : MAJ de LAPS
    - set-lapsadcomputerselfpermission -identity "OU=Ordinateurs,DC=Billu;DC=lan" : Autorisation de données et/ou modifier le mot de passe pour les Ordinateur présent dans l'OU Ordinateurs

![img 2](https://github.com/michaelc31/Projet-image/blob/main/LAPS%20-%20Zimbra/IMG2.JPG?raw=true)

Ceci fait on va :

    - copier les fichier LAPS.admx et LAPS.adml dans le dossier sysvol/domain/policyDefinition.
    - Créé la GPO nommé LAPS et configurer la GPO avec les paramètre voulu

![img 3](https://github.com/michaelc31/Projet-image/blob/main/LAPS%20-%20Zimbra/IMG3.JPG?raw=true)

![img 4](https://github.com/michaelc31/Projet-image/blob/main/LAPS%20-%20Zimbra/IMG4.JPG?raw=true)

![img 5](https://github.com/michaelc31/Projet-image/blob/main/LAPS%20-%20Zimbra/IMG5.JPG?raw=true)

et vous trouverez le mot de passer crée par LAPS dans le gestion des utilisateur AD dans l'OU ordinateurs en cliquant sur les propriete du PC

![img 6](https://github.com/michaelc31/Projet-image/blob/main/LAPS%20-%20Zimbra/IMG6.JPG?raw=true)

### Test :

on va prendre un Ordinateur client qui est déjà présent dans l'AD, dans l'OU ordinateurs, ou la GPO est active, et on va tester de se connecter au compte Administrateur local de la machine avec le mot de passe d'origine, l'accès nous est refuser car le mot de passe n'est pas correcte.

![img 7](https://github.com/michaelc31/Projet-image/blob/main/LAPS%20-%20Zimbra/IMG7.JPG?raw=true)

on va vérifier le mot de passe généré par lAPS et on va essayer de se connecter avec, "connexion réussi", LAPS gère bien son mot de passe Administrateur Local.

![img 8](https://github.com/michaelc31/Projet-image/blob/main/LAPS%20-%20Zimbra/IMG8.JPG?raw=true)

_______________________
________________________

# Installation de Zimbra 8.8.15 :

## Préparation avant Installation de Zimbra :

### Préparation du Serveur AD pour le DNS :

Ouvrir le gestionnaire de dns afin de créer un nouvelle Hôte (A ou AAAA) et nouveau serveur de messagerie (MX) :

    - clique droit nouvel hôte (A ou AAAA) : pour le nom mettre le nom du serveur Zimbra "ex : srvzimbra" et indiquer son adresse IP "ex : 172.20.0.100"

    - clique droit nouveau serveur de messagerie (MX) : nommé le pareil que l'hôte créé précédemment et pour le FQDN faite un clique droit sur parcourir et rechercher l'hôte créé précédemment

Testé avec la commande `nslookup srvzimbra.billu.lan`

### Préparation du serveur Linux :

Zimbra 8.8.15 est compatible avec UBUNTU 18.04 LTS du coup nous allons récupérer un ISO de LINUX UBUNTU 18.04 LTS via ce lien :

https://releases.ubuntu.com/18.04/

Faire une installation de Linux classique. une fois l'OS installé nous allons configurer le serveur afin qu'il soit prêt à installer Zimbra pour cela nous allons :

    - Faire un Update/Upgrade du système : commande `apt update && apt upgrade -y`

    - Installer Apt Ifupdown : commande `apt install ifupdown`

    - Configurer la carte réseau interne pour lui mettre une IP correspondante au Projet : commande `nano /etc/network/interfaces` afin de modifier le fichier interfaces et entre les information adéquate : (exemple à adapter)

                auto lo
                iface lo inet loopback

                auto enp0s3
                iface enp0s3 inet dhcp

                auto enp0s8
                iface enp0s8 inet static
                address 172.20.0.100
                netmask 255.255.255.0
                network 172.20.0.0
                broadcast 172.20.0.255
                dns-nameserver 172.20.0.5
                dns-search billu.lan

![img 9](https://github.com/michaelc31/Projet-image/blob/main/LAPS%20-%20Zimbra/IMG9.JPG?raw=true)

    - Configurer le fichier Hostname : commande `nano /etc/hostname` afin de modifier ou vérifier le nom du serveur "ex : Srvzimbra.billu.lan"

    - Configurer le fichier Hosts : commande `nano /etc/hosts` afin de modifier le fichier interfaces et entre les information adequate : "ex : 172.20.0.100    srvzimbra.billu.lan     srvzimbra"

    - Configurer le fichier resolv.conf : commande `nano /etc/resolv.conf`

                nameserver 172.20.0.5
                nameserver 1.1.1.1
                search billu.lan

![img 10](https://github.com/michaelc31/Projet-image/blob/main/LAPS%20-%20Zimbra/IMG10.JPG?raw=true)

Pensez à rebooter le PC autant que nécessaire afin que les paramètres soient bien pris en compte.

Ceci fait faire un ping en IPv4 et avec dns "ex : ping 172.20.0.5 ; ex : ping srvzimbra.billu.lan"

![img 11](https://github.com/michaelc31/Projet-image/blob/main/LAPS%20-%20Zimbra/IMG11.JPG?raw=true)

![img 11'](https://github.com/michaelc31/Projet-image/blob/main/LAPS%20-%20Zimbra/IMG11'.JPG?raw=true)

## Installation de Zimbra : Configuration et Utilisation

### 1ere partie : configuration

Le serveur Linux est maintenant prêt à accueillir Zimbra on va commencer par installer les apts nécessaires

Commande : `apt install netcat-traditional libidn11-dev libgmp10 sysstat sqlite3 libaio1 unzip pax -y`

On va arrêter le service apparmor et désactiver le redémarrage auto :

Commande : `service apparmor stop` ; `service apparmor teardown` ; `update-rc.d -f apprmor remove`

On va telecharger le zip comprenant Zimbra commande `wget https://files.zimbra.com/downloads/8.8.15_GA/zcs-8.8.15_GA_3869.UBUNTU18_64.20190918004220.tgz`

![img 12](https://github.com/michaelc31/Projet-image/blob/main/LAPS%20-%20Zimbra/IMG12.JPG?raw=true)

On va decompresser le fichier telecharger `tar xvzf zcs-8.8.15_GA_3869.UBUNTU18_64.20190918004220.tgz`

Se déplacer dans le dossier "zcs-8.8.15_GA_3869.UBUNTU18_64.20190918004220" et lancer l'install commande `./install.sh`

Répondre "OUI" à toutes les questions sauf install zimbra-dnscache ; install zimbra-proxy ; install zimbra-imapd

![img 13](https://github.com/michaelc31/Projet-image/blob/main/LAPS%20-%20Zimbra/IMG13.JPG?raw=true)

![img 14](https://github.com/michaelc31/Projet-image/blob/main/LAPS%20-%20Zimbra/IMG14.JPG?raw=true)

Le logiciel installé, nous reste la dernière phase de configuration avant de pouvoir accéder à l'interface graphique de Zimbra. il faut régler le mot de passe admin de zimbra . option 6 et option 4 afin de changer le mot de passe.

le mot de passe changé on peut appliquer et finir l'installation en revenant en arrière avec "r" et en appliquant les changement avec "a" répondre "Oui" à la 1ere question et "Non" à la dernière.

La configuration est terminée, on va rebooter le serveur.

### 2eme partie : Utilisation

Zimbra est installée, le serveur est rebooté, on va se connecter a l'utilisateur zimbra sur le serveur. pour cela, se connecter avec l'utilisateur classique, passer en root, et après passer en zimbra. ex: connecter vous avec user, passer en root avec `sudo su` une fois en root passer en zimbra avec `su zimbra`

Ceci fait, on va vérifier et démarrer si nécessaire les services du serveur.

commande : `zmcontrol status` : vérifier le status de tous les services de messagerie

![img 15](https://github.com/michaelc31/Projet-image/blob/main/LAPS%20-%20Zimbra/IMG15.JPG?raw=true)

commande : `zmcontrol start` : démarrera les service si nécessaire

Pour accéder à l'interface graphique se connecter a un client via l'adresse du serveur

        - Pour la console administrateur ex: https://172.20.0.100:7071

        - Pour la boite mail ex: https://172.20.0.100:8443

![img 16](https://github.com/michaelc31/Projet-image/blob/main/LAPS%20-%20Zimbra/IMG16.JPG?raw=true)

![img 17](https://github.com/michaelc31/Projet-image/blob/main/LAPS%20-%20Zimbra/IMG17.JPG?raw=true)

### 3eme partie : Créer une adresse mail pour un compte utilisateur de l'AD:
Dans la console administrateur de l'interface graphique de zimbra on va aller dans configurer/domaines, aller sur la roue de paramètre puis cliquer _Add a Domain Alias_.  
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/TutoZimbra/1_AddAlias.png?raw=true)

Le nommé par le nom de domaines du serveur AD.  
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/TutoZimbra/2_Cible.png?raw=true)

On va modifier le mode d'authentification du domaine du serveur zimbra. Faire un clic droit sur le nom du serveur et cliquer sur _Configure Authentication_.  
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/TutoZimbra/3_Authentication.png?raw=true)

Lui spécifier un active directory externe.  
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/TutoZimbra/4_Authtication.png?raw=true)

On va renseigner le domaine du serveur AD, son adresse IP, on va fournir l'utilisateur et le mot de passe permettant l'accès au domaine et tester voir si la liaison est réussie et on clique sur terminer.
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/TutoZimbra/4bis_Authentication.png?raw=true)

ceci fait on va créer un nouveau compte dans _Manage_/_Accounts. Cliquer sur la roue de paramètrage puis _New_.  
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/TutoZimbra/5_CreateUser.png?raw=true)

Pour la création du compte on va récupérer les renseignement d'un utilisateur AD existant ex: Pierre David du Dpt commercial pour créer un compte sur zimbra on lui indiquera le nom du compte égal au compte AD et on validera sans ajouter de mot de passe afin de vérifier que l'on peut se connecter avec le mot de passe de session utilisateurs.

        ex: pierre david sera :
            nom de compte : pdavid@srvzimbra.billu.lan
            nom de famille : pdavid

![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/TutoZimbra/6_CreateUser.png?raw=true)

Afin de tester que Pierre david puisse se connecter on va aller sur internet adresse https://172.20.0.100:8443 et on va se connecter avec le nom de compte pdavid mot de passe Azerty2* (mdp pour se connecter à un PC client)

![img 18](https://github.com/michaelc31/Projet-image/blob/main/LAPS%20-%20Zimbra/IMG18.JPG?raw=true)

A l'heure actuel, les comptes seront créés manuellement afin d'être sûr des informations.

# **Difficultés rencontrées : problèmes techniques rencontrés:**

# **Solutions trouvées : Solutions et alternatives trouvées:**
_____________
_____________

# **Installation de Windows Server Update Services:**
## **Pré-requis :**

Le serveur WSUS est à installer sur un os SERVER windows. Dans ce tuto il s'agit d'un Windows Server 2022.  
Ce serveur doit avoir un espace de stockage libre pour stocker les mises à jours.  
Il doit être renommer, faire partie du réseau du domaine et intégrer à ce domaine.  
Dans cette notice le serveur s'appelle **SRV-WSUS**, son adresse IP est **172.18.1.10** avec comme DNS le serveur AD du domaine **172.18.1.1**. Il est intégrer au domaine BillU.lan.

## **Installation et configuration de WSUS :**
### **Sur le serveur WSUS**:
- Partitionner l'espace de stockage avec l'outil _Computer Management_.
- Dans cette notice le volume est libellé _Save_Updates_ avec comme lettre de lecteur **E:\\**
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/Tuto_WSUS/1_Partition.png?raw=true)

________

- Dans le menu _Local Server_, cliquer sur _Add roles and features_, cliquer _NEXT_ jusqu'a arriver sur la fenêtre _Server Roles_.
- Cocher le service _Windows Server Update Services_ puis _Next_.
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/Tuto_WSUS/2_Roles.png?raw=true)
- Cliquer _add features_ puis _Next_. Dans la fenêtre de fonctionnalitées cliquer _Next_.

_________

- Arriver à la fenêtre _Role Services_, cocher _WID Connectivity_ et _WSUS Services_ puis _Next_.  
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/Tuto_WSUS/3_WID.png?raw=true)

_________

- Renseigner le path de l'espace de stockage qui sera utilisé pour les mise à jour, E:\\ dans cette notice, puis _Next_
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/Tuto_WSUS/4_Path.png?raw=true)

__________

- Cliquer sur _Install_ sur la fenêtre de récapitulatifs.
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/Tuto_WSUS/5_INstall.png?raw=true)

________

- Une fois l'installation terminée, cliquer sur le flag en haut de la fenêtre _Local Server_.
- Cliquer sur _Launch Post-Installation tasks_
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/Tuto_WSUS/6_Flag.png?raw=true)

_______

- Ouvrir la console Windows Server Update Services via le menu _Windows Administrative Tools_ ou TOOLS du _Local Server_.
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/Tuto_WSUS/7_Console%20WSUS.png?raw=true)

________

- A l'ouverture de la console, WSUS lance le menu de configuration. _Il sera possible de revenir à ces options après si nécessaire via le menu Options de la console WSUS_.
- Cliquer sur _Next_ jusqu'a la fenêtre _Upstream Server_.  
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/Tuto_WSUS/8_ConfigWSUS.png?raw=true)

_________

- Dans cette fenêtre cocher _Synchronize from Microsoft Update_, afin que le serveur se synchronise aux serveur de Microsoft Update. L'autre option est à cocher si le serveur installer n'est pas le premier et qu'il se connecte à un serveur synchronisé à Microsoft Update.  
- Cliquer sur _Next_.  
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/Tuto_WSUS/9_Synchronize.png?raw=true)

___________

- La prochaine fenêtre est la connection au serveur de mise à jour qui permet de télécharger les mise à jour. Cliquer sur _Start Connecting_. _Cette opération peut-être assez longue, elle peut être arrêtée pour faire le reste des configurations, mais devra être relancée manuellement dans le menu de la console WSUS avant la synchronisation des machines du parc_.
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/Tuto_WSUS/10_StartConnecting.png?raw=true)

____________

# **Difficultés rencontrées : problèmes techniques rencontrés:**

# **Solutions trouvées : Solutions et alternatives trouvées:**
