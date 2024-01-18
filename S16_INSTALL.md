## INSTALL GUIDE Infrastructure sécurisée pour BillU

Date de documentation: 17/01/2024

## Configuration d'un VPN sur PFsense :

Objectif : établir une interconnexion de réseau entre notre site de Lyon et Paris.

Utilisation de Pfsense et configurer le VPN en IPsec :
Menu VPN -> IPsec

![pfsense vpn 1](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/assets/146104077/8d51e585-f5a4-4561-a67c-937ca0e44c24)

cliquer sur bouton vert "addP1".

Première étape : Edit Phase 1 : renseigner les éléments pour définir que l'interface WAN de Lyon a une passerelle correspondant au port WAN de PFsense Paris.
Définir une clè dans le champs "Pre-Shared Key" que nous utiliserons pour la configuration du VPN Paris-Lyon.

![pfsense vpn 2](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/assets/146104077/0ef7b691-ce35-4ad5-bdd2-e17cd881fb08)

Laisser les autres éléments par défaut puis sauvegarder.

Passer à la phase 2 : donner une description, puis renseigner que l'adresse IP du réseau LAN de Paris pour que les réseaux LAN communiquent entre eux

![pfsense vpn 3](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/assets/146104077/c3bc9315-80b2-415c-ba04-e254643f9ed4)

sauvegarder

Faire exactement la même démarche de Paris vers Lyon avec les adresses IP adéquates et ajouter la clé défnie plus haut.

Créer une nouvelle règle pour activer le VPN : Firewall->Rules-IPsec puis cliquer sur Add

![pfsense vpn 4](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/assets/146104077/048ec43e-c260-44b3-b6b5-07fdb4830b8f)


Attendre au moins 1 minute pour que Pfsense active cette règle et vérifier si active :
Status->IPsec : established = opérationnel

![pfsense vpn 5](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/assets/146104077/2dd18f6b-64d6-43ab-b580-9387136e4588)

Vpn configuré, vérifier un ping entre machine clientes entre Paris et lyon : opérationnel.

![ping ](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/assets/146104077/2f273ef0-4619-41bd-83c1-02831750e825)

## Installation PRTG :

PRTG est un outil de supervision qui sera installé sur un Windows Server 22 indépendant pour analyser le parc informatique du réseau Billu. l'hôte A sera renseigné dans le dns

Pour l'installation aller sur internet et taper PRTG network monitor dans la barre de recherche et téléchargez le lien que vous trouver sur l'url suivant `https://www.paessler.com/fr/prtg`

![img1](https://github.com/michaelc31/Projet-image/blob/main/PRTG/Capture1.JPG?raw=true)

Le logiciel téléchargé, installez le, sélectionner le langage :

![img2](https://github.com/michaelc31/Projet-image/blob/main/PRTG/Capture2.JPG?raw=true)

Accepter les terme de la licence

![img3](https://github.com/michaelc31/Projet-image/blob/main/PRTG/Capture3.JPG?raw=true)

Entrer un adresse Mail afin de recevoir les notification,

![img4](https://github.com/michaelc31/Projet-image/blob/main/PRTG/Capture4.JPG?raw=true)

choisissez le mode d'installation, pour pas s'embeter prendre d'installation rapide

![img5](https://github.com/michaelc31/Projet-image/blob/main/PRTG/Capture5.JPG?raw=true)

![img6](https://github.com/michaelc31/Projet-image/blob/main/PRTG/Capture6.JPG?raw=true)

Vous voila a la page de connection a PRTG les identifiant par défaut seront renseignées automatiquement a la premiere connection

![img7](https://github.com/michaelc31/Projet-image/blob/main/PRTG/Capture7.JPG?raw=true)

Page d'accueil de PRTG :

![img8](https://github.com/michaelc31/Projet-image/blob/main/PRTG/Capture8.JPG?raw=true)

## Utilisation de PRTG :



## Installation FreePBX :

Recuperer l'iso de FreePBX ici https://www.freepbx.org/downloads/ et l'installer dans une nouvelle VM en Linux RedHat l'iso télécharger

Au démarrage de la VM, dans la liste, choisir la version recommandée.

![img9](https://github.com/michaelc31/Projet-image/blob/main/PRTG/Capture9.JPG?raw=true)

Puis sélectionnez Graphical Installation - Output to VGA.

![img10](https://github.com/michaelc31/Projet-image/blob/main/PRTG/Capture10.JPG?raw=true)

Enfin choisir FreePBX Standard

![img11](https://github.com/michaelc31/Projet-image/blob/main/PRTG/Capture11.JPG?raw=true)

Pendant l'installation, il faut configurer le mot de passe root (Root password is not set s'affiche).

![img12](https://github.com/michaelc31/Projet-image/blob/main/PRTG/Capture12.JPG?raw=true)

Cliquez sur ROOT PASSWORD et entrez un mot de passe pour le compte root.

`Attention :` le clavier est en QWERTY du coup faire attention au mot de passe mis en place

![img13](https://github.com/michaelc31/Projet-image/blob/main/PRTG/Capture13.JPG?raw=true)

le mot de passe renseigner, l'installation continue et se termine. Redémarrer la VM en enlevant l'ISO avant le redémarrage.

Se connecter en root et mettre son clavier en Francais car au commande suivante :

        localectl set-locale LANG=fr_FR.utf8
        localectl set-keymap fr
        localectl set-x11-keymap fr

vérifier que le clavier est en francais avec la commande localectl

![img14](https://github.com/michaelc31/Projet-image/blob/main/PRTG/Capture14.JPG?raw=true)

## Configuration et Mise à jour des Modules FreePBX :

Par l'interface web accessible depuis un client, connecte-toi en root avec le mot de passe associé et cliquez sur Setup System

Dans la fenêtre, clique sur FreePBX Administration et reconnecte-toi en root. Clique sur Skip pour sauter l'activation du serveur et toutes les offres commerciales qui s'affichent. Laisser les langages par défaut et à la fenêtre d'activation du firewall, cliquez sur Abort :

![img15](https://github.com/michaelc31/Projet-image/blob/main/PRTG/Capture15.JPG?raw=true)

A la fenêtre de l'essai de SIP Station cliquez sur Not No. Arriver sur le tableau de bord, cliquez sur Apply Config (en rouge) pour valider tout ce que tu viens de faire

![img16](https://github.com/michaelc31/Projet-image/blob/main/PRTG/Capture16.JPG?raw=true)

Ceci fait on va activer le serveur (cette activation n'est pas obligatoire), mais elle permet d'avoir accès à l'ensemble des fonctionnalités du serveur.
Dans le menu Admin puis System Admin.

Cliquez sur Activation puis Activate. Dans la fenêtre qui s'affiche, cliquez sur Activate

![img17](https://github.com/michaelc31/Projet-image/blob/main/PRTG/Capture17.JPG?raw=true)

Entre une adresse email et attendre quelques instants. Dans la fenêtre qui s'affiche, renseignez les différentes informations, et :

        - Pour Which best describes you mets I use your products and services with my Business(s) and do not want to resell it
        - Pour Do you agree to receive product and marketing emails from Sangoma ? cochez No

Clique sur Create

![img18](https://github.com/michaelc31/Projet-image/blob/main/PRTG/Capture18.JPG?raw=true)

Dans la fenêtre d'activation, cliquez sur Activate et attendez que l'activation se fasse. Pour les fenêtres qui s'affichent, cliquez sur Skip.

La fenêtre de mise-à-jour des modules va s'afficher automatiquement.
Clique sur Update Now. Attendre la mise-à-jour de tous les modules.

![img19](https://github.com/michaelc31/Projet-image/blob/main/PRTG/Capture19.JPG?raw=true)

Une fois que tout est terminé, clique sur Apply config.

        Il peut y avoir des erreurs sur le serveurs suite à la mise-à-jour des modules et dans ce cas, l'accès au serveur ne se fait pas.
        Les modules incriminés sont précisés et il faut les réinstaller et les activer.
        Dans ce cas, sur le serveur en CLI, exécute les commandes suivantes :

                fwconsole ma install <nom du module>
                fwconsole ma upgradeall (pour mettre a jour les dernier module)

Va sur le serveur en CLI et exécute la commande yum update pour faire la mise-à-jour du serveur. Répondre "y" lorsque cela sera demandé. Et Redémarrer le serveur

## Création ligne utilisateur :

Par l'interface web accessible depuis un client, Va dans le menu Applications puis Poste, tu arrives sur cette fenêtre :

![img20](https://github.com/michaelc31/Projet-image/blob/main/PRTG/Capture20.JPG?raw=true)

Va sur sur l'onglet Poste SIP [chan_pjsip] et clique sur le bouton +Ajout nouveau Poste SIP [chan_pjsip] et La fenêtre suivante va s'afficher

![img21](https://github.com/michaelc31/Projet-image/blob/main/PRTG/Capture21.JPG?raw=true)

Pour créer la 1ère ligne, celle de Marie Dupont, renseigne les informations suivante :

        User Extension : 80100
        Display Name : Camille Martin
        Secret : Azerty1*
        Password For New User : Azerty1*

Tu dois avoir les informations comme ceci :

![img22](https://github.com/michaelc31/Projet-image/blob/main/PRTG/Capture22.JPG?raw=true)

Clique sur le bouton Submit puis Apply Config pour enregistrer ton utilisateur.

## Installation C3Xphone :

Prendre la source ici. (https://3cxphone.software.informer.com/download/)

Télécharge la version x86/x64 sur le site de et installe-là sur les 2 clients Windows (pour le test)

## association ligne utilisateurs

Sur le Client N°1 a l'écran du SIP phone, clique sur Set account pour avoir la fenêtre Accounts.

![img23](https://github.com/michaelc31/Projet-image/blob/main/PRTG/Capture23.JPG?raw=true)

![img24](https://github.com/michaelc31/Projet-image/blob/main/PRTG/Capture24.JPG?raw=true)

En cliquant sur New, la fenêtre de création de compte Account settings apparaît :
Pour configurer la ligne de l'utilisatrice Marie Dupont, rentre les informations comme ceci :

    Account Name : Camille Martin
    Caller ID : 80100
    Extension : 80100
    ID : 80100
    Password : Azerty1*
    I am in the office - local IP : l'adresse IP du serveur soit 172.18.1.204 (adresse serveur FreePBX)

Cliquer sur Ok tu dois avoir cette fenêtre :

![img25](https://github.com/michaelc31/Projet-image/blob/main/PRTG/Capture25.JPG?raw=true)

Faire de même avec un autre compte utilisateur pour le Clients 2

## test Communication :

Sur le client 1, tape sur le clavier du SIP phone le numéro 80101 et clique sur la touche d'appel (la touche verte). et sur le client 2 on voit l'appel arriver. On peut répondre en cliquant sur le bouton vert ou refuser l'appel en cliquant sur le bouton rouge

![img26](https://github.com/michaelc31/Projet-image/blob/main/PRTG/Capture26.JPG?raw=true)

## Installation et configuration Iredmail

Prérequis : préparation de l'accueil du serveur dans notre DNS :

créer un Host name A :  mail : 172.18.1.220
Créer un MX : mail : 172.18.1.220

Monter un conteneur de type serveur Debian 12 sur Proxmox.
Faire les mises à jour update && upgrade

Mettre en place la configuration réseau  Ip statique, passerelle, et DNS de notre environnement.

Modifier le fichier /etc/hostname
mettre le nom en FQDN : Full Qualified Domain Name
nous mettons : mail.billu.lan

Modifier le fichier /etc/hosts : 
127.0.0.1 mail.billu.lan localhost

### Installation de iRedMail

commande :

```shell
wget https://github.com/iredmail/iRedMail/archive/refs/tags/1.6.8.tar.gz
```

Extraire avec la commande suivante :

```shell
tar -zxf 1.6.8.tar.gz
```

Se rendre dans le dossier "**iRedMail-1.6.8**" et lancer le script "**iRedMail.sh**".

```shell
cd iRedMail-1.6.8
bash iRedMail.sh
```

Suivre indications du script en mode graphique :
renseigner les champs importants :
notamment le champs du nom de notre domaine comme extension mail  : billu.lan

![iredmail 01](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/assets/146104077/54b2da4b-192a-4170-8811-ed0e2a3e9d5b)

![iredmail 02](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/assets/146104077/f63bbbbc-729b-4d5a-afb3-56ff623b347e)

![iredmail 03](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/assets/146104077/ac3c3bb1-216c-42dc-8e48-fc00263c47f8)

![iredmail 04](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/assets/146104077/0509264e-0ecc-488c-a621-e3251c59e9da)

![iredmail 05](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/assets/146104077/edae8c40-7494-4fe2-9479-a9edf5a482b3)

![iredmail 06](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/assets/146104077/4f035af9-e36b-4e1d-866f-27cadc942871)

![iredmail 07](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/assets/146104077/f5b3d965-ef1c-4810-9e6d-8a680ff5949b)

![iredmail 08](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/assets/146104077/5aa264a9-25d6-4b54-89f7-eb555bc55a57)

![iredmail 09](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/assets/146104077/056f2467-49f9-4c21-b4a0-b4bf54dfc783)

Se connecter à l'interface graphique sur un client sur l'adresse 172.18.1.220
login : postmaster@billu.lan password : Azerty1*

![iredmail 10](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/assets/146104077/08ff6657-b567-4447-bec9-8f229d6875cc)

