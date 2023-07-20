# Connect to PPDM and Explore the Status

```Powershell
Connect-PPDMsystem -fqdn ppdm-01.demo.local -trustCert
```
use *admin* and *Password123!* for connection
Review the PPDM Components state
```Powershell
Get-PPDMcomponents | ft
```

Review the PPDM Components state
```Powershell
Get-PPDMactivities -days 1 | ft
```
you will find that

Review the PPDM Components state
```Powershell
```
Review the PPDM Components state
```Powershell
```




Get-PPDMactivities -days 1 | ft