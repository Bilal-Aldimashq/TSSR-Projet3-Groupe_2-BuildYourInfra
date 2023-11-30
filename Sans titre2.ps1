
$arg1 = read-host "nommé le serveur CORE" 
$arg2 = read-host "donner une @IP" 
$arg3 = read-host "donner l'@IP de la Gateway"
$arg4 = read-host "rensiegner le nom de Domaine"



Rename-Computer -NewName $arg1 -Force

New-NetIPAddress -IPAddress "$arg2" -PrefixLength "24" -InterfaceIndex (Get-NetAdapter).ifIndex -DefaultGateway "$arg3"

Set-DnsClientServerAddress -InterfaceIndex (Get-NetAdapter).ifIndex -ServerAddresses ("$arg4")

Install-WindowsFeature -Name RSAT-AD-Tools -IncludeManagementTools -IncludeAllSubFeature

Install -WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -IncludeAllSubFeature

install-WindowsFeature -Name DNS -IncludeManagementTools -IncludeAllSubFeature

Install-ADDSDomainController -DomainName "$arg4" -Credential (Get-Credential)

Get-ADDomainController -Identity $arg1

Restart-Computer
