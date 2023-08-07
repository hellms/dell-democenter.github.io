# MODULE 7 - PROTECT MICROSOFT EXCHANGE WORKLOADS

## LESSON 2 - PROTECT EXCHANGE DATABASES

In this Lesson we shall create a Centralized Protection Policy and protect Microsoft Exchange Databases

## CREATE POLICY

If not already done from Previous Module, read the Storage System

```Powershell
$StorageSystem=Get-PPDMStorage_systems -Type DATA_DOMAIN_SYSTEM -Filter {name eq "ddve-01.demo.local"}
```

As usual, we create a Database Schedule

>Recurrence: Hourly
>Create Copy : 8 Hours
>Keep For : 5 Days
>Start Time: 08:00 PM
>End Time: 06:00 AM

```Powershell
$ExSchedule=New-PPDMDatabaseBackupSchedule -hourly -CreateCopyIntervalHrs 8 -RetentionUnit DAY -RetentionInterval 5
```

Next, we crdeate a Policy with the following Parameters

>Name: Exchange Backups
>Description: Exchange Database Backups
>Type: Microsoft Exchange Database

```Powershell
$ExPolicy=New-PPDMExchangeBackupPolicy -Schedule $ExSchedule -Name "Exchange Backups" -StorageSystemID $StorageSystem.id -Description "Exchange Database Backups" -enabled
$ExPolicy
```

![Alt text](image-13.png)

Next, we neet to read the Assets, "Test_DB_001" to "Test_DB_002". The example COde represents a Range

```Powershell
$EXAssets=Get-PPDMassets -type MICROSOFT_EXCHANGE_DATABASE  -filter 'details.database.clusterName eq "exchange.demo.local" and (name ge "Test_DB_001" and name le "Test_DB_002")'
```

And assign the Assets to the Policy:

```Powershell
Add-PPDMProtection_policy_assignment -AssetID $EXAssets.id -PLC $ExPolicy.id
```

![Alt text](image-14.png)

## Monitor the Configuration Jobs:

```Powershell
Get-PPDMactivities -PredefinedFilter SYSTEM_JOBS -filter 'name lk "%Exchange Backups%"' -pageSize 3 | ft
```

![Alt text](image-15.png)

And Finally start the Backup with:

```Powershell
$ExPolicy | Start-PPDMprotection_policies -BackupType FULL -RetentionUnit DAY -RetentionInterval 5
```

Monitor the Backups with:

```Powershell
Get-PPDMactivities -PredefinedFilter PROTECTION_JOBS -filter 'name lk "%Exchange Backups%"' -pageSize 3
```

![Alt text](image-16.png)
[<<Module 7 Lesson 1](./Module_7_1.md) This Concludes Module 7 Lesson 2 [Module 8 Lesson 1>>](./Module_8_1.md)