Import-Module ActiveDirectory

$users = Import-Csv -Path "C:\path\to\users.csv"

foreach ($user in $users) {
    New-ADUser -Name $user.Name -GivenName $user.FirstName -Surname $user.LastName -SamAccountName $user.Username -UserPrincipalName $user.Email -Path "OU=$user.Role,DC=example,DC=com" -AccountPassword (ConvertTo-SecureString $user.Password -AsPlainText -Force) -Enabled $true
}