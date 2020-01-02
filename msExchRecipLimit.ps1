#Establecimiento de msexchRecipLimit para los usuarios que no tienen ningún valor establecido

$resultSize = "Unlimited"
$targetRecip = 15

$mailBoxes = Get-Mailbox -ResultSize $resultSize | Select-Object Alias

foreach($mb in $mailBoxes)
{
    try
    {
        $u = Get-ADUser $mb.Alias -Properties msexchRecipLimit
        $limit = $u.msexchRecipLimit
        
        if (!$limit)
        {
            echo "Estableciendo valor para $mb"
            Set-ADUser -Identity $mb.Alias -Add @{msexchRecipLimit=$targetRecip}
        }
    }
    catch
    {
        $ex = "No encontrado: " + $mb.Alias
        write-warning $ex
    }
}
