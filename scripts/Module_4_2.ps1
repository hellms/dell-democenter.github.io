# MODULE 4 - PROTECT SQL DATABASES
# Script Version
## LESSON 2 - PROTECT SQL DATABASES

$SQL_HOSTNAME="sql-02.demo.local"
$PolicyName="SQL PROD DATABASE"
$VMname="LINUX-01"
$PolicyDescription="SQL DB Backups"
$StorageName="ddve-01.demo.local"
Write-Host "Getting discovered Databases for Host $SQL_HOSTNAME"
$Assets=Get-PPDMassets -type MICROSOFT_SQL_DATABASE -filter "details.database.clusterName eq `"$SQL_HOSTNAME`""  6>$null
Write-Host "Checkiung Stream Count for SQL Assets on  $SQL_HOSTNAME"

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
And Create a new Protection Policy from the 3 Variables
$Policy=New-PPDMSQLBackupPolicy -Schedule $Schedule -Name $PolicyName -Description $PolicyDescription -skipUnprotectableState -dbCID $CREDS.id -StorageSystemID $StorageSystem.id
$Assets=Get-PPDMassets -type MICROSOFT_SQL_DATABASE -filter 'details.database.clusterName eq "sql-02.demo.local" and name lk "SQLPROD%"'
$Assets+=Get-PPDMassets -type MICROSOFT_SQL_DATABASE -filter 'details.database.clusterName eq "sqlaag-01.demo.local" and name lk "DemoDB-0%"'

$Assignemnt=Add-PPDMProtection_policy_assignment -id $Policy.id -AssetID $Assets.id
$Policy | Get-PPDMprotection_policies



Review them with


Get-PPDMactivities -PredefinedFilter SYSTEM_JOBS -pageSize 3


And now we are good to start the Policy AdHoc:


Start-PPDMprotection_policies -id $Policy.id -BackupType FULL -RetentionUnit DAY -RetentionInterval 5


Now, we can Monitory the Protection Job 


Get-PPDMactivities -PredefinedFilter PROTECTION_JOBS -pageSize 1
And the Asset Activities


Get-PPDMactivities -PredefinedFilter ASSET_JOBS -pageSize 4

