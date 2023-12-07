# **INSTALL GUIDE Infrastructure sécurisée pour BillU**
## _Semaine_S4_
_Date de documentation: 27/11/2023_

## **Besoins initiaux : besoins du projet**

Réalisation d'une infrastructure sécurisé pour l'entreprise BillU. Un domaine AD a été installé et complété par un serveur de gestion de mot de passe pas encoree opérationnel ainsi qu'un deuxième serveur DC avec réplication. Gestion automatique des salariés de la société dans le répertoire AD.   
A ce jour un serveur GLPI doit être mis en place afin de gérer le parc informatique et le ticketing pour la maintenance. Une dizaine de GPO sera créées dans l'AD.

## **Choix techniques**

Le serveur Glpi sera installé sur un OS Ubuntu Server 22.04 et gérer graphiquement par le serveur AD. Son adresse Ip est 172.18.1.50, identifiants: glpi, Azerty1*   
Les GPO installées sont:  
1 - Politique de mot de passe : éxigé des mot de passe compliqué, qui auront une valider prédéfini.   
2 - Vérouillage de compte : bloque l'accès après plusieurs tentative de fraude.  
3 - Resteindre l'installation logiciel : Empêche l'installation aux utilisateur lambda.  
4 - Déploiement logiciel : Permet d'automatiser l'installation logiciel.  
5 - Windows update : Definir heure d'installation, delai avant installation.  
6 - Bloquer accès aux registres.  
7 - Moderer l'accès au panneaux de config.   
8 - Restreindre l'acces aux perifs amovible.  
9 - Créer un compte admin local sur les machines : définir un compte du domaine qui sera administrateur local des machines avec une GPO.  
10 - GPO ésthetique : (wallpaper fixe, raccourcies fixes, dossier partagé)
11 - Vérouilllage classique : Vérouillage session après un temps d'inutilité.  
12 - Gestion alimentation : PC portable.  
13 - Firewall : Désactiver les firewall le temps de pouvoir les configurés.  
14 - Mapper les lecteurs logique.  


# **Étapes d'installation et de configuration : instruction étape par étape**
 ## Installation GLPI:
 **Ubuntu server 22.04** 
 Avoir un accès Internet.  
 Attribuer une adresse IP fixe au serveur, dans ce cas _172.18.1.50_.  
 - Mettre à jour le serveur:
   ```bash
   sudo apt-get update && sudo apt-get upgrade
   ```
- Installer Apache2:
  ```bash
  sudo apt-get install apache2 -y
  ```
- Activer Apache2:
  ```bash
  sudo systemctl enable apache2
  ```
- Installer Mariadb comme base de données SQL:
  ```bash
  sudo apt-get install mariadb-server -y
  ```
- Installer PHP et ses dépendances:
  ```bash
  sudo apt-get install php libapache2-mod-php -y
  sudo apt-get install php-{ldap,imap,apcu,xmlrpc,curl,common,gd,json,mbstring,mysql,xml,intl,zip,bz2}
  sudo mysql_secure_installation
  ```
- Configurer la base de données mysql:
  ```bash
  sudo mysql -u root -p
  ```
  Le nom de base données est: **glpidb**  
  Le compte avec les droits d'accès est: **glpi**  
  Le mot de passe est: **Azerty1***  
  Dans la base de donnée Mariadb:
  ```bash
  create database glpidb character set utf8 collate utf8_bin;
  grant all privileges on glpidb.* to glpi@localhost identified by "Azerty1*";
  flush privileges;
  quit
  ```
- Récupérer le dossier GLPI:  
  ```bash
  wget https://github.com/glpi-project/glpi/releases/download/10.0.2/glpi-10.0.2.tgz
  ```
- Décompresser le dossier GLPI:  
  ```bash
  sudo tar -xvzf glpi-10.0.2.tgz
  ```
- Supprimer le index.php dans /var/www/html.
- Copier le dossier GLPI:
  ```bash
  sudo cp -R glpi/* /var/www/html
  ```
- Donner les droits aux fichiers:
  ```bash
  sudo chown -R www-data:www-data /var/www/html
  sudo chmod -R 775 /var/www/html
  ```
- Editer le fichier /etc/php/8.1/apache2/php.init et modifier les paramètres suivants:
  - memory_limit = 64M
  - file_uploads = on
  - max_execution_time = 600
  - session.auto_start = 0
  - session.use_trans_sid = 0
- Redémarrer la machine
- Se connecter depuis le serveur AD, qui est sur la même plage d'adresse, via une page web en rentrant http://172.18.1.50/glpi/glpi

- mise à jour du serveur GLPI sous Ubuntu vers la version glpi-10.0.10 :
```bash
  sudo wget https://github.com/glpi-project/glpi/releases/download/10.0.10/glpi-10.0.10.tgz
  sudo tar -xvzf glpi-10.0.2.tgz
  sudo cp -R glpi/* /var/www/html/glpi
  ```
cette mise à jour permet nottament d'activer l'inventaire

### **Connexion du serveur GLPI au serveur AD**

prérequis su le serveur SRVWIN1 gérant l'AD DS:
- création de l'OU "GLPI" dnas lequel nous mettons un groupe "user-GLPI"
- le goupe "user-GLPI" aura l'ensemble des utilisateurs de l'AD.
  
  ![config AD](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/assets/146104077/dc933138-c3db-4f36-841b-57bc7be32d99)

- un script automatise cette action :

```batch
Clear-Host
$usersAD = Get-ADUser -Filter *
foreach ($userAD in $usersAD)
{
Add-ADGroupMember -Identity "user-GLPI" -Members "$($userAD.SamAccountName)"
Write-Host "l'utilisateur $($userAD.Name) à été ajouté au groupe `"user-GLPI`""
}
```

- procédure pour configurer glpi ci-dessous :
  
[Support](https://remiflandrois.fr/2022/09/12/glpi-connexion-active-directory/)

capture d'écrans de notre configuration GLPI à partir de l'interface graphique :

![config glpi1](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/assets/146104077/e64c2ce2-9a86-4497-af35-29bb36c6c744)
![config glpi2](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/assets/146104077/84616bbe-f17c-4eb8-ba42-764a51ded0ff)

puis cliquer sur sauvegarder en bas à droite de cette page.

### **Installation de l'agent glpi sur les clients pour activer l'inventaire de GLPI**

installer la version ci-dessous et choisi la version adéquate en fonction du client :
!(https://glpi-project.org/fr/glpi-agent-1-6-1/)

choisir une installation "complete"
suivre pas à pas l'installation et renseigné 

 
## **Difficultés rencontrées : problèmes techniques rencontrés**

1. Problèmes de connections de l'ordinateur au domaine.

## **Solutions trouvées : Solutions et alternatives trouvées**

1. Sortir l'ordinateur du domaine et le réintégrer.

## **Tests réalisés : description des tests de performance, de sécurité, etc.**



## **Résultats obtenus : ce qui a fonctionné**



## **Améliorations possibles : suggestions d’améliorations futures**
