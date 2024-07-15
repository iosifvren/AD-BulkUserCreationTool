
$users = Import-Csv -Path "C:\path\to\users.csv"

$roles = $users | Select-Object Role -Unique

foreach ($role in $roles) {
    $ouPath = "OU=$($role.Role),DC=example,DC=com"
    if (-not (Get-ADOrganizationalUnit -Filter "Name -eq '$($role.Role)'")) {
        New-ADOrganizationalUnit -Name $role.Role -Path "DC=example,DC=com"
    }

    $groupName = "$($role.Role) Group"
    if (-not (Get-ADGroup -Filter "Name -eq '$groupName'")) {
        New-ADGroup -Name $groupName -GroupScope Global -Path $ouPath
    }

    $usersInRole = $users | Where-Object { $_.Role -eq $role.Role }
    foreach ($user in $usersInRole) {
        Add-ADGroupMember -Identity $groupName -Members $user.Username
    }
}