Write-Host "# MODULE 5 - PROTECT & RESTORE ORACLE DATABASE FROM POWERSHELL
## Scripted Version
## LESSON 4 - PROTECT ORACLE DATABASES USING ORACLE INCREMENTAL MERGE"

$Asset=Get-PPDMassets -type ORACLE_DATABASE -filter 'details.database.clusterName eq "oracle01.demo.local" and name eq "orcl"'
$StorageSystem=Get-PPDMStorage_systems -Type DATA_DOMAIN_SYSTEM -Filter {name eq "ddve-01.demo.local"}
$Policy=Get-PPDMassets -type ORACLE_DATABASE -filter 'name eq "orcl"'


$OraCreds=Get-PPDMcredentials -filter 'name eq "oracle"'


Write-Host "## Step 1 Remove the Asset Assignment using (Only Required after Lesson 5.3)"

Remove-PPDMProtection_policy_assignment -protectionPolicyId $Policy.id -AssetID $Asset.id
Write-Host "## Step 2 Creating a new Oracle Incremental merge Policy"

$OIMSchedule=New-PPDMDatabaseBackupSchedule -hourly -CreateCopyIntervalHrs 1 -RetentionUnit DAY -RetentionInterval 5

$OIMPolicy=New-PPDMOracleBackupPolicy -Schedule $OIMSchedule -Name "Oracle Backup OIM" -Description "Oracle Backup - OIM" -dbCID $OraCreds.id -StorageSystemID $StorageSystem.id -backupMechanism OIM
Add-PPDMProtection_policy_assignment -id $OIMPolicy.id -AssetID $Asset.id

$Asset | Set-PPDMOIMProtocol -ProtectionProtocol NFS

Get-PPDMactivities -PredefinedFilter SYSTEM_JOBS -pageSize 2
```

![Alt text](./images/image-84.png)

## Starting a Backup

We Just need to Pipe the Policy into *Start-PPDMprotection_policies* to get started with the Backup

```Powershell
$OIMPolicy | Start-PPDMprotection_policies
```

```Powershell
(Get-PPDMactivities -PredefinedFilter PROTECTION_JOBS -pageSize 1).steps
```

At this time we ask powershell to show as the Steps. this is made for demonstrating the "Steps" feature from the UI

![Alt text](./images/image-85.png)

Repeat Above command to Show The Progress, consider by tackling using the Job ID:

![Alt text](./images/image-87.png)

[<<Module 5 Lesson 3](./Module_5_3.md) This Concludes Module 5 Lesson 4 [Module 5 Lesson 5>>](./Module_5_5.md)

