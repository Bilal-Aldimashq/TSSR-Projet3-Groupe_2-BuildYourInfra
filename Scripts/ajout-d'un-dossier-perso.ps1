    $users = Get-ADUser -filter *

    foreach ($user in $users)
    {
    $cheminDossierPartage = "\\SRVWINP3\PersonalFolders\$($user.SamAccountName)"
       #ajouter de la ligne \srwin\personnalFolders\le nom de l'utilsateur
        Set-ADUser $user -HomeDirectory $cheminDossierPartage -HomeDrive "I:"
       #créé le nouveau repertoire pour le laison avec l'ajout de commande
        New-Item $cheminDossierPartage -ItemType Directory 
       # Ajoutez l'utilisateur au dossier avec des autorisations spécifiques (par exemple, contrôle total)
        Add-NTFSAccess -Path $cheminDossierPartage -Account $($user.SamAccountName) -AccessRights FullControl

        Write-Host "le dossier personnel à été crée et à été ajouté au lecteur logique I: et les droit d'acces ont ete ajouter" -ForegroundColor Green 
    }