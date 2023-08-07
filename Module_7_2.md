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
$ExPolicy=New-PPDMExchangeBackupPolicy -Schedule $ExSchedule -Name "Exchange Backups" -StorageSystemID -StorageSystemID $StorageSystem.id -Description "Exchange Database Backups" -enabled
$ExPolicy
```




