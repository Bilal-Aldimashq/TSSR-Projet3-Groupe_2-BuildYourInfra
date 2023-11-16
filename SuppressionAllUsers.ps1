##################################
#                                #
#   Suppression USER dans l'AD   #
#                                #
##################################

### Main program

Clear-Host
$ADUsers = Get-ADUser -Filter *
$ADUsers | where {$_.Name -ne "Administrator"} | `            where {$_.Name -ne "Guest"} | `            where {$_.Name -ne "DefaultAccount"} | `            Remove-ADUser -Confirm:$false