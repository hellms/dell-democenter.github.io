## Verify RSA SecurID Configuration
Get-PPDMmfa_securids
## Disable MFA
Get-PPDMmfa_securids | Set-PPDMmfa_securids -is_enabled:$false
## BYPASS MULTIFACTOR AUTHENTICATION
Get-PPDMidentity_providers -type local
## Check for any Bypassed (mfa disabled) user Account
Get-PPDMmfa_bypass_accounts | ft | out-string
Get-PPDMmfa_bypass_accounts -filter 'selector eq "local" and subject eq "admin"' |  Remove-PPDMmfa_bypass_accounts | out-string
## To disable MFA (Bypass) for a local user, we need to provide the accountname  
Get-PPDMidentity_providers -type local | Set-PPDMmfa_bypass_accounts -accountname admin | out-string
# List the Account bypass for local user admin  
Get-PPDMmfa_bypass_accounts -filter 'selector eq "local" and subject eq "admin"' | ft | out-string

