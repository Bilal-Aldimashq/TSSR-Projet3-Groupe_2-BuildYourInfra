# **INSTALL GUIDE Infrastructure sécurisée pour BillU**
## _Semaine_S5_
_Date de documentation: 07/12/2023_

## **Besoins initiaux : besoins du projet**

Réalisation d'une infrastructure sécurisé pour l'entreprise BillU. Un domaine AD a été installé et complété par un serveur de gestion de mot de passe pas encoree opérationnel ainsi qu'un deuxième serveur DC avec réplication. Gestion automatique des salariés de la société dans le répertoire AD.   
A ce jour un serveur GLPI doit être mis en place afin de gérer le parc informatique et le ticketing pour la maintenance. Une dizaine de GPO sera créées dans l'AD.

## **Choix techniques**

## Script telemetry

le script de telemetry a etait crée et sauvegarder sur un serveur, l'acces se fait via un dossier partager. le lancement se fait automatiquement a chaque connection d'utilisateur via un GPO (voir S11) créé sur le AD pour l'execution sur different post en auto.

Se script réalise les taches suivantes: 
 - verifie les registre et les cle de registre afin de les créé, modifier
 - il va desactiver telemetrie, adverting ID, SmartScreen, OneDrive, DiagTrack, la géolocalisation ...
 - il va desactiver les sevices : skype, cortana, GrooveMusic, Film et TV ...

## Script AD

Mise a jour du script pour grouper les utilisateurs en fonction de leur service et/ou departement. 

les mises a jours 




 
## **Difficultés rencontrées : problèmes techniques rencontrés**

PING persistant (proxmox)

## **Solutions trouvées : Solutions et alternatives trouvées**

installation d'un nouveau PFSENSE

## **Tests réalisés : description des tests de performance, de sécurité, etc.**


## **Résultats obtenus : ce qui a fonctionné**


## **Améliorations possibles : suggestions d’améliorations futures**
