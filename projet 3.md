# Projet Réseau

## Mise en place d'une infrastructure réseau sécurisée

### __Propositions pour l'évolution des services__ 


*nomadisme* : Mettre en place un system de connection securisé a distance pour les commerciaux.


*utilisateur externe* : mise place d'un reseau securisé sans vision sur le reseau interne avec possibilite de connexion internet.

*materiel client* : homogeneïte des OS (Linunx - Windows)

*Materiel Administration* :Pour l'administration du réseau nous préconisons la mise en place de Serveur DHCP - DNS - AD.

*Evolution de la societe* : Mise en place d'un réseau communiquant entre paris et lyon ce qui permettra la communication avec x site si agrandissement.

*Reseau* : Mise en place d'un réseau interne filaire connécté à des switchs et des routeurs , on garde le FAI pour l'access NAT connécté en filaire au réseau permettant l'accès a l'exterieure , wifi possible FAI sans accès au réseau interne .

*Messagerie* : Installer un serveur de messagerie qui remplacera le stockage cloud actuel .

*Securité* :Grace a la mise en place d'un Serveur AD nous activerons les domaines et le rajout d'identification par mot de passe afin de sécuriser les accès aux terminaux.

*Stockage* :Mise en place d'un serveur de Stockage de donnée avec redondance et savegarde.

### __Propositions pour l'évolution du Reseaux__

Mise en place d'une infractruture reseaux qui comprendra routeurs et switchs par site.

Le tout relié à nos differents serveur DCHCP - DNS - MESSAGERIE - AD - STOCKAGE afin de centralisées les données et de permettre la liaison des 2 sites.



## Mise en place d'un plan d'adressage IP

Pour permettre un bon fonctionnement et de réglementé l'accès au différents services nous mettrons en place un plan d'adressage pour les différents services afin de les séparer (exemple le service juridique n'aura pas accèes au services comptabilité).

Au vu des services non homogènes en nombres nous avons opter pour un découpage réseau asymetrique .

   **Site de Paris : 172.16.1.0/24**

|services|adresse réseau|1ère adresse hotes|dernière adresse hotes|adresse broadcast|
|---|----|----|----|----|
|Développement logiciel|172.16.1.0/25|172.16.1.1|172.16.1.126|172.16.1.127|
|Relation publique|172.16.1.128/27|172.16.1.129|172.16.1.158|172.16.1.159|
|Commerciale|172.16.1.160/27|172.16.1.161|172.16.1.190|172.16.1.191|
|DSI|172.16.1.192/28|172.16.1.193|172.16.1.206|172.16.1.207|
|Finance et comptabilité|172.16.1.208/28|172.16.1.209|172.16.1.122|172.16.1.223|
|Juridique|172.16.1.224/29|172.16.1.225|172.16.1.230|172.16.1.231|
|Recrutement|172.16.1.232/29|172.16.1.233|172.16.1.238|172.16.1.239|
|QHSE|172.16.1.240/29|172.16.1.241|172.16.1.246|172.16.1.247|
|Direction|172.16.1.248/29|172.16.1.249|172.16.1.254|172.16.1.255|


   **Site de Lyon : 10.10.5.0/24** 

|services|adresse réseau|1ère adresse hotes|dernière adresse hotes|adresse broadcast|
|---|----|----|----|----|
|Développement logiciel|10.10.5.0/25|10.10.5.1|10.10.5.126|10.10.5.127|
|Relation publique|10.10.5.128/27|10.10.5.129|10.10.5.158|10.10.5.159|
|Commerciale|10.10.5.160/27|10.10.5.161|10.10.5.190|10.10.5.191|
|DSI|10.10.5.192/28|10.10.5.193|10.10.5.206|10.10.5.207|
|Finance et comptabilité|10.10.5.208/28|10.10.5.209|10.10.5.122|10.10.5.223|
|Juridique|10.10.5.224/29|10.10.5.225|10.10.5.230|10.10.5.231|
|Recrutement|10.10.5.232/29|10.10.5.233|10.10.5.238|10.10.5.239|
|QHSE|10.10.5.240/29|10.10.5.241|10.10.5.246|10.10.5.247|
|Direction|10.10.5.248/29|10.10.5.249|10.10.5.254|10.10.5.255|


## Plan schématique du futur réseau :

![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/exemple.PNG?raw=true)
