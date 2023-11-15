
# **INSTALL GUIDE Infrastructure sécurisée pour BillU**
## _Semaine_09_


## **Besoins initiaux : besoins du projet**

BillU est une filiale du groupe international RemindMe, qui a plus de 10000 collaborateurs dans le monde.  
L'infrastructure réseaux doit être adapté aux besoins de l'entreprise et sécurisé.
Pour la Semaine_09 l'installation d'un serveur Active Directory.



## **Choix techniques**

Suite à nos observations du réseaux informatique de l'entreprise BillU, il a été relevé des risque de sécuritée.
Active Directory sera sous le Domaine BillU et sera organisé avec les Organization Unit suivant l'organisation nécessaire à sa gestion.   


## **Étapes d'installation et de configuration : instruction étape par étape**



 
## **Difficultés rencontrées : problèmes techniques rencontrés**

Il a été constaté le manque de sécuritée tel que les connexions sans mot de passe, la messagerie en Cloud sur le Web,  
pas de serveur d'administration et l'accès internet en wifi dans toute l'entreprise via des répétiteurs. Toutes ces configurations rendent vulnérable le réseaux l'entreprise aux intrusions.  
Les données sont sauvegardées sur un NAS grand public, sans rétention ni redondance. La perte de données seraient irrémédiablement perdus si ces NAS s’avère défectueux. 



## **Solutions trouvées : Solutions et alternatives trouvées**

Pour Sécuriser le réseaux des serveurs seront installés. Parmis ceux-là un serveur Active Directory pour la gestion sécurisée du domaine informatique.
Une sécurité d'identité sera mise en place afin de péréniser les connexion au réseaux de l'entreprise.
Le réseaux sera configuré afin d'apporter une connexion sécurisée, entre autre avec l'installation d'un Firewall.
Un serveur DHCP et un serveur DNS, seront configurés afin de contrôler en interne la gestion du réseaux.  
Un serveur de messagerie sécurisé sera installé afin de remplacer celui en cloud sur le web.
Un serveur de stockage sera installé afin de sécuriser les données de l'entreprise et permettre une redondance de celles-ci et fiabiliser les sauvegardes.
Afin que les deux sites puissent accéder aux serveurs suivant leur besoins, des routeurs et des VLAN seront installés sur le réseaux. 
Les VLAN permettront de sécuriser les bases de données en limitant leurs accès par services (Droits des différents services à définir par la direction de BillU)


## **Tests réalisés : description des tests de performance, de sécurité, etc.**


## **Résultats obtenus : ce qui a fonctionné**


## **Améliorations possibles : suggestions d’améliorations futures**

  
