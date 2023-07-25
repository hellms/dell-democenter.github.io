# MODULE 3 - PROTECT VMWARE VIRTUAL MACHINES

## LESSON 3 - PROTECT SQL VIRTUAL MACHINES USING PRE-CREATED/EXISTING STORAGE UNIT(APPLICATION AWARE)

As we will re-use the StorageUnit (also refreed to as DataTarget) from Lesson 2, we read the Plolicy Properties with

```Powershell
$Policy=Get-PPDMprotection_policies -filter 'name eq "Linux VM"'
```

The DataTarget is stored in *$Policy.stages[0].target.dataTargetId*

```Powershell
$Policy.stages[0].target.dataTargetId
```

We also need to create the following Credetials:

>Credential Name: windows
>User Name: administrator@demo
>Password: Password123!

```Powershell
$Credentials=New-PPDMcredentials -type OS -name windows -authmethod BASIC 
```

Again, we read our Storage System

```Powershell
$StorageSystem=Get-PPDMStorage_systems -Type DATA_DOMAIN_SYSTEM -Filter {name eq "ddve-01.demo.local"}
```

Next, we need to create a Database Backup Schedule:

```Powershell
$DBSchedule=New-PPDMDatabaseBackupSchedule -hourly -CreateCopyIntervalHrs 8 -RetentionUnit DAY -RetentionInterval 5
```

Finally, we create a Policy 

>Name: SQL Virtual Machines
>Description: App Aware Policy
>Type: Virtual Machine


New-PPDMSQLBackupPolicy -Schedule $DBSchedule -Name "SQL Virtual Machines" -Description "SQL Virtual Machines"  -AppAware -dbCID $Credentials.id -StorageSystemID $StorageSystem.id -DataMover SDM -SizeSegmentation FSS