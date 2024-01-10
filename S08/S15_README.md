# TSSR : Projet 3 : Construction d’une infrastructure réseau

_Semaine7_  
_(Date de documentation 03 janvier 2024)_
________


## **Besoins Initiaux:**

Réalisation d'une infrastructure sécurisé pour l'entreprise BillU. Un domaine AD a été installé et complété par un serveur de gestion de mot de passe pas encore opérationnel ainsi qu'un deuxième serveur DC avec réplication. Gestion automatique des salariés de la société dans le répertoire AD. Un serveur GLPI est en place ainsi qu'une dizaine de GPO. Des pare-feu PFSense sont installés sur les deux sitesLa télémérie des postes clients à été traitée. Pour compléter cette infrastructure, il a été demandé de journaliser les scripts Powershell, installer  le logicie de supervision Zabbix et d'intégrer les ordinateurs à l'Active Directory. Mise en Place d'un serveur de messagerie Zimbra qui pourra nous aidder a finir le serveur de gestionnaire de mot de passe et d'un serveur WSUS qui lui gérera le developpement des MAJ sur le Parc informatique. 
_________
## **Rôles par semaine:**

### Semaine 7 
| NOM | Rôles | Taches effectuées |
| :-- |:----- | :---------- |
| Valentin | Crew |  Mise en place, installation et configuration du serveur WSUS|
| Jérôme  | Scrum Master | Mise en place, installation et configuration du serveur Zimbra |
| Bilal | Crew | Mise en place, installation et configuration du serveur WSUS |
| Michael | Product Owner | Mise en place, installation et configuration du serveur Zimbra |
| Equipe |  | Recherche et mise en place des serveurs en lab et sur Proxmox, édition des livrables, Préparation Canva et Demo tech |

__________

## **Objectifs principaux de la semaine:**

- Mettre en place un serveur de messagerie zimbra
	- Création de compte mail lié aux Utilisateurs AD
	- Connection a la boite mail par LAN uniquement pour l'instant

 
- Mise en place d un serveur WSUS
	- Gestion des mise a jour via le serveur 
	- detection des machines du parc

- Création d'un schema de l'infrastructure du Parc
____________      


## **Choix Techniques:**

- Serveur de messagerie Zimbra imposer. installation de la version 8.8.15 car des la version 9 le logiciel est payant. le serveur sera installer sur la derniere version de ubuntu gerer soit la 18.04
- installation d'un nouveau serveur win22 pour l'installation du role WSUS  
________________


## **Les difficultées rencontrées:** 

- la gestion du central pour les paquets admx ; adml car on arriver pas a avoir les parametre necessaire pour cree les GPO 

## **Les solutions:** 

- Crée notre propre Administrative Template afin d'avoir les option neccessaire a la création des GPO voulu

## **FAQ:**
