INSTALL GUIDE Infrastructure sécurisée pour BillU

Date de documentation: 17/01/2024

Configuration d'un VPN sur PFsense :

Objectif : établir une interconnexion de réseau entre notre site de Lyon et Paris.

Utilisation de Pfsense et configurer le VPN en IPsec :
Menu VPN -> IPsec

![pfsense vpn 1](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/assets/146104077/8d51e585-f5a4-4561-a67c-937ca0e44c24)

cliquer sur bouton vert "addP1".

Première étape : Edit Phase 1 : renseigner les éléments pour définir que l'interface WAN de Lyon a une passerelle correspondant au port WAN de PFsense Paris.
Définir un clè dans le champs "Pre-Shared Key" que nous utiliserons pour la configuration du VPN Paris-Lyon.

![pfsense vpn 2](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/assets/146104077/0ef7b691-ce35-4ad5-bdd2-e17cd881fb08)

Laisser les autres éléments par défaut puis sauvegarder.

Passer à la phase 2 : donner une description, puis renseigner que l'adresse IP du réseau LAN de Paris pour que les réseaux LAN communiquent entre eux

![pfsense vpn 3](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/assets/146104077/c3bc9315-80b2-415c-ba04-e254643f9ed4)

sauvegarder

Faire exactement la même démarche de Paris vers Lyon avec les adresses IP adéquates

Créer une nouvelle règle pour activer le VPN : Firewall->Rules-IPsec puis cliquer sur Add

![pfsense vpn 4](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/assets/146104077/048ec43e-c260-44b3-b6b5-07fdb4830b8f)


Attendre au moins 1 minute pour que Pfsense active cette règle et vérifier si active :
Status->IPsec : established = opérationnel

![pfsense vpn 5](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/assets/146104077/2dd18f6b-64d6-43ab-b580-9387136e4588)

Vpn configuré, vérifier un ping entre machine clientes entre Paris et lyon : opérationnel.
