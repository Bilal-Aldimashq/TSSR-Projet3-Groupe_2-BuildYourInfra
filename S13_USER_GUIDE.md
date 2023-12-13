# TSSR-Projet3-Groupe_2-BuildYourInfra
## User-guid BillU 
### _Semaine_S6_
### _(Date de documentation: 11 Décembre 2023)_

# **NomDuProduit**

### **_Présentation_**:
________


### **_Pré-requis_**:
________


### **_Utilisation_**:
________


### _**FAQ**_:
________

| **Problèmes** | **Solutions** |
|-----|--------|

____________


# **Restauration sauvegarde dossiers partagés**

### **_Présentation_**:

Le rôle Windows Server Backup du serveur permet la sauvegarde programmé des données et leur restauration.
La sauvegarde des dossiers partagés, _PersonalFolders_ sur le réseau I:, et _DPTFolders_ sur le réseaud M:, sont sauvegardés sur le serveur dans le volume F: _ShareFolderBackup_.  
Les sauvegardes ont lieu tout les jours à 23:00 et permettent la restauration des fichiers et dossiers si besoin.
Cette notice permet la restauration d'un dossier (_TEMP dans cette exemple_) suite à une suppression, grâce à une sauvegarde palanifiée.
________


### **_Pré-requis_**:

- Connaître le nom du dossier, le jour et l'heure de suppression de celui-ci si possible.
- Avoir accès au serveur gérant les sauvegardes: _SRVWIN1_
________


### **_Utilisation_**:

- Dans ce dossier _SharedFolders_ le dossiet TEMP a été supprimé. Cependant, des données qui y étaient présentes sont nécessaires pour le service. Il sera restauré.
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/TutoSauvegarde/14bis.DeleteFolder.png?raw=true)

____________
- Ouvrir l'outil _Windows Server Backup_, cliquer sur _Local Backup_ situé dans la colonne de gauche de la fenêtre. Cliquer ensuite sur _Recover_ situé dans la colonne de droite de cette fenêtre puis _NEXT_. Dans la fenêtre suivante, par défaut le serveur est coché, si ce n'est pas le cas, cocher le et appuyer sur _NEXT_.    
  
- Choisir la date de la sauvegarde souhaitée sur le tableau calendrier et l'heure dans le déroulé à côté (_Sauf cas exceptionnel, une seule heure est disponible par jour par défaut._), puis _NEXT_.  
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/TutoSauvegarde/15.SelectDate.png?raw=true)

_____________
- Sélectionner le type de restauration. Cocher _Files and folders_. L'autre option concerne la restauration complète du volume, pour l'exemple seul le dossier TEMP est concerné. Cliquer _NEXT_.
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/TutoSauvegarde/16.RecoveryType.png?raw=true)

_____________
- Sélectionner l'objet à restaurer puis cliquer sur _NEXT_.
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/TutoSauvegarde/17.ItemRecover.png?raw=true)
_____________

- Spécifier les options de restauration. Il y a 2 options: L'emplacement et le traitement de l'objet restauré. L'emplacement par défaut est celui d'origine du dossier, il est possible de la modifier en cochant _Another location_ si nécessaire. Pour la 2ème option, cocher celle du bas: _Do not recover the items that already exist on the recovery destination_, cela restaurera uniquement les données manquantes du dossier.   
La première option crée une copie du dossier avant la restauration pour avoir deux versionsde ce dossier.   
La deuxième option écrase la version existante par la version restaurer.  
Cliquer sur _NEXT_
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/TutoSauvegarde/18.RecoveryOption.png?raw=true)
_____________

- Confirmer la restauration dans la fenêtre de récapitulation en appuyant sur _RECOVER_.
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/TutoSauvegarde/19.Confirmation.png?raw=true)
_____________

- Une fois la restauration terminer cliquer sur _Close_.
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/TutoSauvegarde/20.CompleteResto.png?raw=true)
_____________

- Le dossier _TEMP_ à bien été restauré à son emplacement d'origine.
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/TutoSauvegarde/21.RecoveryTemp.png?raw=true)


________


### _**FAQ**_:
________

| **Problèmes** | **Solutions** |
|-----|--------|
