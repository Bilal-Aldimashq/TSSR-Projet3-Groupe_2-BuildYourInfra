
# **INSTALL GUIDE Infrastructure sécurisée pour BillU**
## _Semaine_10_


## **Besoins initiaux : besoins du projet**



## **Choix techniques**



## **Étapes d'installation et de configuration : instruction étape par étape**

# Installation Bitwarden :
ressources pour installer à partir de proxmox sud Debian format LXC : Docker puis Bitwarden

installer d'abord Docker:

https://docs.docker.com/engine/install/debian/#install-from-a-package

installer ensuite Bitwarden :

https://bitwarden.com/help/install-on-premise-linux/

# Installation et configuration du serveur core :

renommer, config réseau ip statique, peut se faire à partir de Sconfig

installer les rôles du serveur :


```batch
Install-WindowsFeature -Name RSAT-AD-Tools -IncludeManagementTools -IncludeAllSubFeature

Install -WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -IncludeAllSubFeature

install-WindowsFeature -Name DNS -IncludeManagementTools -IncludeAllSubFeature
```
ajout du contrôleur de domaine :

```batch
Install-ADDSDomainController -DomainName "billu.lan" -Credential (Get-Credential)
```

test :
Get-ADDomainController -Identity <server_name>
 
## **Difficultés rencontrées : problèmes techniques rencontrés**

- installation de serveur windows core an tant que controlleur de domaine
  
- configuration de Debian LXC comme serveur Bitwarden

## **Solutions trouvées : Solutions et alternatives trouvées**



## **Tests réalisés : description des tests de performance, de sécurité, etc.**


## **Résultats obtenus : ce qui a fonctionné**


## **Améliorations possibles : suggestions d’améliorations futures**

