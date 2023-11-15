# TSSR : Projet 3 : Construction d’une infrastructure réseau

_(Date de documentation 08 Novembre 2023)_
# Sommmaire

[1 : Besoin Initiaux :]()

[2 : Roles par Semaine :]()

[3 : Objectif semaine :]()

[4 : Choix techniques :]()

[5 : Difficultées rencontrées :]()

[6 : Solutions :]()


## Besoins Initiaux

BillU est une filiale du groupe international RemindMe, qui a plus de 10000 collaborateurs dans le monde.
Elle est spécialisée dans le développement de logiciels, entre-autre de facturation.
Le groupe prévoit un budget conséquent pour développer cette filiale. Elle a 2 sites, l'un à Paris (20èm) et l'autre à Lyon
L'infrastructure réseaux doit être adapté aux besoins de l'entreprise et sécurisé.



##  Rôles par semaine

### Semaine 2 
| NOM | Roles | Taches éffectuées |
| :-- |:----- | :---------- |
| Valentin | Scrum Master | Recherche et script powershell pour enregistrer dans l'AD DS les salariés de l'entreprise. |
| Jerome  |  Product Owner | Réalisation de la structure AD |
| Bilal | Crew | Réalisation de la structure AD |
| Michael | Crew |Recherche et script powershell pour enregistrer dans l'AD DS les salariés de l'entreprise.|
| Equipe | Workflow | Prise en main de AD DS. Création d'un domaine AD DS. Renseigner base de données d'AD DS |

## Objectif semaine

Organiser une structure Active Directory et y intégrer les salariés de l'entreprise


##  Choix Techniques

Le Domaine AD aura pour nom BillU et sera structuré suivant les besoins de gestions.
##  Les difficultées rencontrées

Manque de sécuritée sur le réseau tel que  connexions sans mot de passe, messagerie en Cloud sur le Web,
pas de serveur d'administration et accès internet en wifi dans toute l'entreprise via des répétiteurs. Données sauvegardées sur un NAS grand public, sans rétention ni redondance. 

##  Les solutions 

Pour Sécuriser le réseaux des serveurs seront installés. Parmis ceux-là un serveur Active Directory pour la gestion sécurisée du domaine informatique. Une sécurité d'identité sera mise en place afin de péréniser les connexion au réseaux de l'entreprise. Le réseaux sera configuré afin d'apporter une connexion sécurisée, entre autre avec l'installation d'un Firewall. Un serveur DHCP et un serveur DNS, seront configurés afin de contrôler en interne la gestion du réseaux.
Un serveur de messagerie sécurisé sera installé afin de remplacer celui en cloud sur le web. Un serveur de stockage sera installé afin de sécuriser les données de l'entreprise et permettre une redondance de celles-ci et fiabiliser les sauvegardes. Afin que les deux sites puissent accéder aux serveurs suivant leur besoins, des routeurs et des VLAN seront installés sur le réseaux. Les VLAN permettront de sécuriser les bases de données en limitant leurs accès par services (Droits des différents services à définir par la direction de BillU)


