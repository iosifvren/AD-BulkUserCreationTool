Install-Module -Name Microsoft.Graph -Scope CurrentUser
Import-Module Microsoft.Graph

Connect-MgGraph -Scopes "User.ReadWrite.All"

$users = Import-Csv -Path "C:\path\to\users.csv"

foreach ($user in $users) {
    $userBody = @{
        accountEnabled = $true
        displayName = "$($user.FirstName) $($user.LastName)"
        mailNickname = $user.Username
        userPrincipalName = $user.Email
        passwordProfile = @{
            forceChangePasswordNextSignIn = $true
            password = $user.Password
        }
    }

    New-MgUser -BodyParameter $userBody
}