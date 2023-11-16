$Users = Import-Csv -Path C:\Users\Administrator\Documents\BillU.csv.csv 

$ADUsers = Get-ADUser -Filter * -Properties *
$count = 1
Foreach ($User in $Users)
{
    Write-Progress -Activity "Création des utilisateurs dans l'OU" -Status "%effectué" -PercentComplete ($Count/$Users.Length*100)
    $Name              = "$($User.Nom) $($User.Prenom)"
    $DisplayName       = "$($User.Nom) $($User.Prenom)"
    $SamAccountName    = $($User.Prenom.substring(0,1).tolower()) + $($User.Nom.ToLower())
    $UserPrincipalName = (($User.prenom.substring(0,1).tolower() + $User.nom.ToLower()) + "@" + (Get-ADDomain).Forest)
    $GivenName         = $User.Prenom
    $Surname           = $User.Nom
    #$OfficePhone       = $User.Tel
    #$EmailAddress      = $UserPrincipalName
                            if ($($user.Service) -eq $null){
                            $path = "ou=$($user.Département),ou=Bidon,dc=lab,dc=lan"
                            }
                            else
                            {
                            $path = "ou=$($User.service),ou=$($user.Département),ou=bidon,dc=lab,dc=lan"
                            }
    $Company           = "BillU"
    $Department        = "$($User.Département)"h
    $Service           = "$($User.service)"

     If (($ADUsers | Where {$_.SamAccountName -eq $SamAccountName}) -eq $Null)
    {
        New-ADUser -Name $Name -DisplayName $DisplayName -SamAccountName $SamAccountName -UserPrincipalName $UserPrincipalName `        -GivenName $GivenName -Surname $Surname `        -Path $Path -AccountPassword (ConvertTo-SecureString -AsPlainText Azerty1* -Force) -Enabled $True `        -OtherAttributes @{Company = $Company;Department = $Department} -ChangePasswordAtLogon $True                Write-Host "Création du USER $SamAccountName" -ForegroundColor Green    }
    Else
    {
        Write-Host "Le USER $SamAccountName existe déjà" -ForegroundColor Black -BackgroundColor Yellow
    }
    $Count++
    sleep -Milliseconds 100
}