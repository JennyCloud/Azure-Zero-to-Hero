# Convert plain text password to SecureString
$Password = ConvertTo-SecureString "P@ssword1234" -AsPlainText -Force

# Create user
$domain = (Get-AzTenant).Domains[0]
$upn = "labuser1@$domain"

New-AzADUser `
    -DisplayName "LabUser1" `
    -UserPrincipalName $upn `
    -Password $Password `
    -MailNickname "labuser1" `
    -ForceChangePasswordNextLogin:$true
