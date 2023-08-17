# MODULE 10 - DYNAMIC NAS PROTECTION

## LESSON 2 - PROTECT CIFS SHARE USING POWERPROTECT DATA MANAGER WITH INDEXING ENABLED

## Create a Protection Policy

## Create a Policy

We use a Helper Fuction *New-PPDMBackupSchedule* to Create a Stage0 Backup Schedule Object that we will use in the Protection Policy

>Recurrence: Hourly  
>Create Copy: 8 Hours  
>Keep For: 5 Days  
>Start Time: 08:00 PM  
>End Time: 06:00 AM  

```Powershell
$Schedule=New-PPDMBackupSchedule -hourly -CreateCopyIntervalHrs 8 -RetentionUnit DAY -RetentionInterval 5
```

In addition, we need to identify the StorageSystem to backup to.

```Powershell
$StorageSystem=Get-PPDMStorage_systems -Type DATA_DOMAIN_SYSTEM -Filter {name eq "ddve-01.demo.local"}
```

And also, we need the already existing Credentials:

$Creds=Get-PPDMcredentials -type nas -filter 'name eq"Isilon"'

Once we identified and created the Ressources aligned to the Policy, we create the Policy with

>Name: NAS Backup
>Description: Protect NAS Data
>Type: NAS  

```Powershell
$PolicyName="NAS Backup"
$PolicDescription="Protect NAS Data"
$Policy=New-PPDMNASBackupPolicy -Schedule $Schedule `
-Name $PolicyName `
-Description $PolicDescription `
-StorageSystemID $StorageSystem.id `
-indexingEnabled `
-enabled `
-NASCid $Creds.id `
-ContinueOn ACL_ACCESS_DENIED,DATA_ACCESS_DENIED
$Policy

```


[<<Module 9 Lesson 1](./Module_9_1.md) This Concludes Module 10 Lesson 1 [Module 10 Lesson 1 >>](./Module_10_2.md)
