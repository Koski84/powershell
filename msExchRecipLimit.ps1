#Establecimiento de msexchRecipLimit a 15 para los usuarios que no tienen ningún valor establecido

$mailBoxes = Get-Mailbox | Select-Object Alias -First 1

foreach($mb in $mailBoxes)
{
    try
    {
        $u = Get-ADUser $mb.Alias -Properties msexchRecipLimit
        $limit = $u.msexchRecipLimit
        $mb.Alias + " : " + $limit

        if (!$limit)
        {
            echo "**** hay que establecerlo! ****"
            #Set-ADUser -Identity $mb.Alias -Add @{msexchRecipLimit=15}
        }
    }
    catch
    {
        write-warning "No encontrado"
    }
}
