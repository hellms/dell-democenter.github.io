# MODULE 7 - PROTECT MICROSOFT EXCHANGE WORKLOADS

## LESSON 1- REVIEW AND DISCOVER EXCHANGE DATABASES

Revie the Exchange Infrastructure Sourec(es)


```Powershell
Get-PPDMhosts -type APP_HOST -filter 'details.appHost.subTypes eq "MICROSOFT_ECHANGE_DATABASE_SYSTEM"'
```