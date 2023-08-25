# MODULE 4 - PROTECT SQL DATABASES
# Script Version
## LESSON 2 - PROTECT SQL DATABASES

$SQL_HOSTNAME="sql-02.demo.local"
$PolicyName="SQL PROD DATABASE"
$PolicyDescription="SQL DB Backups"
$StorageName="ddve-01.demo.local"
Write-Host "Getting discovered Databases for Host $SQL_HOSTNAME"
$Assets=Get-PPDMassets -type MICROSOFT_SQL_DATABASE -filter "details.database.clusterName eq `"$SQL_HOSTNAME`""  6>$null
Write-Host "Checking Stream Count for SQL Assets on  $SQL_HOSTNAME"

$Assets.backupDetails | out-string
Write-Host "Setting Stream Count for SQL Assets on  $SQL_HOSTNAME"
$Assets | Set-PPDMMSSQLassetStreamcount -LogStreamCount 10 -FullStreamCount 10 -DifferentialStreamCount 10
($Assets | Get-PPDMassets).backupDetails | out-string
Write-Host "Creating a Backup Schedule"
$Schedule=New-PPDMDatabaseBackupSchedule -hourly -CreateCopyIntervalHrs 1 -DifferentialBackupUnit MINUTELY -DifferentialBackupInterval 30 -RetentionUnit DAY -RetentionInterval 5

$StorageSystem=Get-PPDMStorage_systems -Type DATA_DOMAIN_SYSTEM -Filter "name eq `"$StorageName`""
$CREDS=Get-PPDMcredentials -filter 'name eq "windows"'
if (!$CREDS) {
    $Securestring=ConvertTo-SecureString -AsPlainText -String "Password123!" -Force
    $Credential = New-Object System.Management.Automation.PSCredential($username, $Securestring)
    Write-Host "Creating Credentials for SQL user"
    $CREDS=New-PPDMcredentials -type OS -name $Credential_Name -authmethod BASIC -credentials $Credential

}
$Policy=New-PPDMSQLBackupPolicy -Schedule $Schedule -Name $PolicyName -Description $PolicyDescription -skipUnprotectableState -dbCID $CREDS.id -StorageSystemID $StorageSystem.id -enabled
$Assets=Get-PPDMassets -type MICROSOFT_SQL_DATABASE -filter 'details.database.clusterName eq "sql-02.demo.local" and name lk "SQLPROD%"'
$Assets+=Get-PPDMassets -type MICROSOFT_SQL_DATABASE -filter 'details.database.clusterName eq "sqlaag-01.demo.local" and name lk "DemoDB-0%"'
Add-PPDMProtection_policy_assignment -id $Policy.id -AssetID $Assets.id | out-string
# $Policy | Get-PPDMprotection_policies

Get-PPDMactivities -PredefinedFilter SYSTEM_JOBS -filter 'name eq "Configuring SQL Databases - SQL PROD DATABASE - PROTECTION"' -pageSize 3 6>$null | out-string
Write-Host "Waiting for activity to complete"
do { 
    Sleep 5;
    $Activity=Get-PPDMactivities -PredefinedFilter SYSTEM_JOBS -filter 'name eq "Configuring SQL Databases - SQL PROD DATABASE - PROTECTION"' -pageSize 3 6>$null
    write-host -NoNewline "$($Activity.progress)% "
    }
until ($Activity.state -eq "COMPLETED")


Start-PPDMprotection_policies -id $Policy.id -BackupType FULL -RetentionUnit DAY -RetentionInterval 5

Get-PPDMactivities -pageSize 1 -filter 'name eq "Manually Protecting SQL Databases - SQL PROD DATABASE - PROTECTION - Full"' | out-string
do { 
    Sleep 5;
    $Activity=Get-PPDMactivities -pageSize 1 -filter 'name eq "Manually Protecting SQL Databases - SQL PROD DATABASE - PROTECTION - Full"' 6>$null
    write-host -NoNewline "$($Activity.progress)% "
    }
until ($Activity.state -eq "COMPLETED")


