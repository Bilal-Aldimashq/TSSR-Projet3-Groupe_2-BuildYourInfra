<#
Pour se Script nous sont parti sur un script a argument mais pour etre sur de ne pas en oublier leur du lancement du script nous les initiliseront avec un read-host


le script se lance en demandant plusieurs renseignement qui serviront d'arguments, tel que le nom de serveur, @IP, @IP de la Gateway et le nom de domaine a rejoindre.
dela il va renommer le Serveur, changer l'@IP en renseignant la gateway, elle défini l'adresse de serveur DNS 
elle va installer tout différents rôles et fonctionnalités sur un serveur Windows à l'aide de la cmdlet Install-WindowsFeature.
elle installe un nouveau contrôleur de domaine Active Directory sur le serveur Windows,
et récupère des informations sur un contrôleur de domaine spécifique dans Active Directory
et redemarre le serveur afin d'appliquer les changements.


il nous reste a traiter les erreurs, en regardant comment faire les verifs necessaires (verif IP, verif Nom,...) et synthaxer le script correctement.
#>



###################################################################  Initialisation Variable  ##########################################################################



$arg1 = read-host "Donner un nom au serveur CORE" 

$arg2 = read-host "Donner une adresse IP" 

$arg3 = read-host "Donner l'adresse IP de la Gateway"

$arg4 = read-host "Renseigner le nom de Domaine"



#############################################################################  MAIN  ###################################################################################



Rename-Computer -NewName $arg1 -Force

New-NetIPAddress -IPAddress "$arg2" -PrefixLength "24" -InterfaceIndex (Get-NetAdapter).ifIndex -DefaultGateway "$arg3"

Set-DnsClientServerAddress -InterfaceIndex (Get-NetAdapter).ifIndex -ServerAddresses ("$arg4")

Install-WindowsFeature -Name RSAT-AD-Tools -IncludeManagementTools -IncludeAllSubFeature

Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -IncludeAllSubFeature

install-WindowsFeature -Name DNS -IncludeManagementTools -IncludeAllSubFeature

Install-ADDSDomainController -DomainName "$arg4" -Credential (Get-Credential)

Get-ADDomainController -Identity $arg1

Restart-Computer


