clear
$Users = Import-Csv -Path C:\Users\Administrator\Documents\BillU.csv.csv 
#$Users
$list = foreach ($entry in $users) {
     $($entry.Nom), $($entry.Prenom), $($entry.Site), $($entry.Département), $($entry.fonction)
    # Vous pouvez également effectuer d'autres opérations avec ces données ici
}
#$list
#$FilePath = [System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)

### Parametre(s) à modifier

#$File     = "$FilePath\USER_Creation_auto_Liste.txt"
#$FileCsv  = "$FilePath\USER_Creation_auto_ListeDoublons.csv"

### Main program

Clear-Host
Import-Csv -Path  $list | Sort-Object -Property Nom | Export-Csv -Path $ -Force
$Csv = Import-Csv $FileCsv
Compare-Object $Csv $($Csv | Select-Object -Property Nom -Unique) -Property Nom