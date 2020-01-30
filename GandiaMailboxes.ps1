$users = Get-Mailbox -ResultSize Unlimited | Select-Object DisplayName,PrimarySmtpAddress, EmailAddresses

foreach ($u in $users)
{
    if ($u.PrimarySmtpAddress.Domain -ceq 'cmgandia.com')
    {
        echo $u
    }
}
