# **INSTALL GUIDE Infrastructure sécurisée pour BillU**
## _Semaine_S7_
_Date de documentation: 18/12/2023_
__________

## **Besoins initiaux : besoins du projet:**
installer un serveur Zabbix pour la supervision des serveurs du parc informatique
___________

## **Choix techniques:**

_______________
# **Étapes d'installation et de configuration : instruction étape par étape:**

## Mise en place de l'agent Zabbix 2 sur les serveurs du Parc
### **Pré-requis**
Avoir téléchargé l'agent Zabbix pour les serveurs Windows sur https://www.zabbix.com/fr/download_agents et selectionner le bon fichier en fonction de la version de Zabbix choisi pendant l'installation pour nous ca sera l'agent zabbix 2 v6.4.10

#### Mise en place pour un serveur Windows

Apres avoir télécharger l'agent lancer l'installation, cliquer sur Next, accepter les term de licence et cliquer sur next (voir image 1 et 2)

![img1](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/Zabbix1.JPG?raw=true)

![img2](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/Zabbix2.JPG?raw=true)

La prochain fenetre vous propose de selectionner l'emplacement de l'installer laisser par defaut et cliquer sur Next 

![img3](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/Zabbix3.JPG?raw=true)

La fenetre de configuration de l'agent arrive et vous demandera le nom de votre machine et l'adresse IP du serveur Zabbix entre les information demander et cliquer sur next puis Install et Finish

![img4](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/Zabbix4.JPG?raw=true)

Une fois l'agent installer on va verifier le fichier zabbix_agent2.conf qui se trouve dans c:\programme files\Zabbix Agent2\Zabbix_agent2.conf

Afin de s'assure que les lignes suivant sont correctes :

    Server=@IP_serveur_Zabbix
    ServerActive=127.0.0.1
    Hostname=nom de la machine ou l'agent Zabbix est installer

Une fois le fichier bien configurer on va vérifier, arreter et relancer le service Agent Zabbix2 en powershell avec les commandes suivantes

  `get-service -name Agent Zabbix 2`
  
  `Stop-service -name Agent Zabbix 2`
  
  `Start-service -name Agent Zabbix 2`

  `get-service -name Agent Zabbix 2`

Le service etant bien en Running notre configuration client est fini.

#### Mise en place pour un serveur Ubuntu et Debian
*Mise en place ubuntu :*

Lancer la liste de commande suivante afin d'installer l'agent:
  
    sudo apt update
    wget https://repo.zabbix.com/zabbix/6.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.4-1+ubuntu$(lsb_release -rs)_all.deb
    sudo dpkg -i zabbix-release_6.4-1+ubuntu$(lsb_release -rs)_all.deb
    sudo apt update
    sudo apt install zabbix-agent2

Une fois installer on va configurer le fichier zabbix_agent2.conf avec la commande suivante :

    sudo nano /etc/zabbix/zabbix_agent2.conf

On va modifier les parametres suivants :

	    Server=@IP serveur Zabbix
 	    ServerActive=127.0.0.1
	    Hostname=nom de la machine ou l'agent est installer

Ceci fait on va relancer le service Zabbix Agent 2 avec les commande suivantes :

    sudo systemctl start zabbix-agent2
    sudo systemctl enable zabbix-agent2
    sudo systemctl status zabbix-agent2

Le service etant bien en Running notre configuration client est fini.

*Mise en place Debian :*

Lancer la liste de commande suivante afin d'installer l'agent:

    sudo apt update
    wget https://repo.zabbix.com/zabbix/6.4/debian/pool/main/z/zabbix-release/zabbix-release_6.4-1+debian$(lsb_release -rs)_all.deb
    sudo dpkg -i zabbix-release_6.4-1+debian$(lsb_release -rs)_all.deb
    sudo apt update
    sudo apt install zabbix-agent2

Une fois installer on va configurer le fichier zabbix_agent2.conf avec la commande suivante :

    sudo nano /etc/zabbix/zabbix_agent2.conf

On va modifier les parametres suivants :

	    Server=@IP serveur Zabbix
 	    ServerActive=127.0.0.1
	    Hostname=nom de la machine ou l'agent est installer
 
Ceci fait on va relancer le service Zabbix Agent 2 avec les commande suivantes :

    sudo systemctl start zabbix-agent2
    sudo systemctl enable zabbix-agent2
    sudo systemctl status zabbix-agent2

Le service etant bien en Running notre configuration client est fini.

## Configuration sur le Serveur Zabbix pour la surveillance du Client.

Une fois l'Agent Zabbix installer et configurer on va passer sur la parti graphique du serveur Zabbix afin de configurer le client.

Connecter vous l'interface graphique de Zabbix et aller sur l'onglet "Collecte de données/hotes" 

![img5](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/Zabbix5.JPG?raw=true)

On va créé un nouvel hote et vous lui renseigner tout les elements permetant la surveillance de celui ci

![img6](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/Zabbix6.JPG?raw=true)

En reseignement : on va lui indiquer le nom de l'hote (machine ou l'agent Zabbix est installer) le modeles "windows by Zabbix Agent", le groupe d'hote auquel il va etre affecter et l'interface en cliquant sur ajouter type "Agent" @IP "IP du serveur a sureveiller"  et on valide.

Apres quelques minute le nouvel Hote devrait aparaitre en disponible et les information surveiller se trouve dans la parti surveillance

![img7](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/Zabbix7.JPG?raw=true)

![img8](https://github.com/michaelc31/Projet-image/blob/main/Nouveau%20dossier/Zabbix8.JPG?raw=true)
