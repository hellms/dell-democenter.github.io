# MODULE 5 - PROTECT & RESTORE ORACLE DATABASE FROM POWERSHELL

## LESSON 4 - PROTECT ORACLE DATABASES USING ORACLE INCREMENTAL MERGE

In this lesson we are going to protect Oracle Database using the new Oracle Incremental Feature.
Pre-requirement for this feature would be boostfs to be installed on the oracle server manually 

## Step 0 Reading the Oracle Asset

As we are moving the Asset to an Incremental Merge Policy, we first need to unassign the Asset from the previous Policy.

If you still in the same Powershell Session fron Previous lesson, you already have the Policy as $Policy and the Oracle Asset as $Asset
and the Storage System as $Storage System
If you have not Done Lesson 3, do below to read the Objects and Continue to Step22

```Powershell
$Asset=Get-PPDMassets -type ORACLE_DATABASE -filter 'details.database.clusterName eq "oracle01.demo.local" and name eq "orcl"'
$StorageSystem=Get-PPDMStorage_systems -Type DATA_DOMAIN_SYSTEM -Filter {name eq "ddve-01.demo.local"}
```

![image](https://github.com/dell-democenter/dell-democenter.github.io/assets/8255007/1964e2f4-efe7-4a9d-ab03-8eeb19147f47)

## Step 1 Remove the Asset Assignment using (Only Required after Lesson 5.3)

```Powershell
Remove-PPDMProtection_policy_assignment -protectionPolicyId $Policy.id -AssetID $Asset.id
```
![Alt text](image-83.png)

## Step 2 Creating a new Oracle Incremental merge Policy

Now we are going to create a new Oracle Incremental Merge Policy using the following Parameters

>Name:  Oracle Backup OIM
>Description: Oracle Backup - OIM
>Type: Oracle  & then Select - Oracle Incremental Merge Backup

First we start with creating a new Schedule for the Policy

```Powershell
$OIMSchedule=New-PPDMDatabaseBackupSchedule -hourly -CreateCopyIntervalHrs 1 -RetentionUnit DAY -RetentionInterval 5
```

Next, we create a OIM Policy
```Powershell
$OIMPolicy=New-PPDMOracleBackupPolicy -Schedule $OIMSchedule -Name "Oracle Backup OIM" -Description "Oracle Backup - OIM" -dbCID $OraCreds.id -StorageSystemID $StorageSystem.id -backupMechanism OIM
```

## Assign Assets and Configure Prottocol to be used ( NFS/BOOST )

We Assign our Asset
```Powershell
Add-PPDMProtection_policy_assignment -id $OIMPolicy.id -AssetID $Asset.id
```

![image](https://github.com/dell-democenter/dell-democenter.github.io/assets/8255007/d4be49ac-31a2-4264-a888-dc8ebf98b604)

And set the Protection Protocol to NFS on the Asset.
This is an Asset Level Setting and can be changed by Modifiying te Asset Configuration.
This will trigger a asset reconfiguration and sets the Mount Paths to the Boost NFS Exports in the Clients COnfiuration.

```Powershell
$Asset | Set-PPDMOIMProtocol -ProtectionProtocol NFS
```


Watch the Activities

```Powershell
Get-PPDMactivities -PredefinedFilter SYSTEM_JOBS -pageSize 2
```

## Starting a Backup

We Just need to Pipe the Policy into *Start-PPDMprotection_policies* to get started with the Backup

```Powershell
$OIMPolicy | Start-PPDMprotection_policies
```

```Powershell
(Get-PPDMactivities -PredefinedFilter PROTECTION_JOBS -pageSize 1).steps
```
