# MODULE 2 - MULTI FACTOR AUTHENTICATION USING RSA


## Verify RSA SecurID Configuration

```Powershell
Get-PPDMmfa_securids
```

Disable MFA
```Powershell
Get-PPDMmfa_securids | Set-PPDMmfa_securids -is_enabled:$false
```
At this Point, you cannot re-enable it as you will not have the token to access


## BYPASS MULTIFACTOR AUTHENTICATION
First, we need to get the IdentityProvider having the users we want to disable MFA for.
In Our Case it is the local Provider

```Powershell
Get-PPDMidentity_providers -type local
```

To disable MFA for a local user, we need to provide the accountname 

```Powershell
Get-PPDMidentity_providers -type local | Set-PPDMmfa_bypass_accounts -accountname admin
```

List the Account bypass for local user admin  
```Powershell
Get-PPDMmfa_bypass_accounts -filter 'selector eq "local" and subject eq "admin"'
```

Remove the BypPass for an account
```Powershell
Get-PPDMmfa_bypass_accounts -filter 'selector eq "local" and subject eq "admin"' |  Remove-PPDMmfa_bypass_accounts
```








