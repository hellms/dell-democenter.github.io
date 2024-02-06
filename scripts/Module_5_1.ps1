Write-Host "# MODULE 5 - PROTECT & RESTORE ORACLE DATABASE FROM POWERSHELL
# Scripted Version
## LESSON 1 - PROTECT ORACLE DATABASES"


$username="oracle"
$credentialname="oracle"
$password="Password123!"
$PolicyName="Oracle DEV"
$PolicyDescription="Oracle DB Backup"

$Securestring=ConvertTo-SecureString -AsPlainText -String $Password -Force
$Credentials = New-Object System.Management.Automation.PSCredential($username, $Securestring)
$OraCreds=New-PPDMcredentials -type OS -name $credentialname -authmethod BASIC -credentials $Credentials
$OraCreds | Out-String
Write-Host "Getting Storage System"
$StorageSystem=Get-PPDMStorage_systems -Type DATA_DOMAIN_SYSTEM -Filter {name eq "ddve-01.demo.local"}
$StorageSystem | Out-String
Write-Host "Creating Backup Schedule"
$OraSchedule=New-PPDMDatabaseBackupSchedule -hourly -CreateCopyIntervalHrs 1 -RetentionUnit DAY -RetentionInterval 5 -starttime 8:00PM -endtime 6:00AM -LogBackupUnit MINUTELY -LogBackupInterval 15
Write-Host "Creating Oracle Policy"
$Policy=New-PPDMOracleBackupPolicy -Schedule $OraSchedule -Name $PolicyName -Description $PolicyDescription -dbCID $OraCreds.id -StorageSystemID $StorageSystem.id
$Policy | Out-String
$Asset=Get-PPDMassets -type ORACLE_DATABASE -filter 'details.database.clusterName eq "oracle01.demo.local" and name eq "orcl"' 6>$null
$Asset | Out-String
Add-PPDMProtection_policy_assignment -id $Policy.id -AssetID $Asset.id
$Policy | Get-PPDMprotection_policies | Out-String

Get-PPDMactivities -PredefinedFilter SYSTEM_JOBS -filter 'name lk "%Configuring Oracle Databases - Oracle DEV%"' -pageSize 3 6>$null | out-string
Write-Host "Waiting for activity to complete"
do { 
    Sleep 5;
    $Activity=Get-PPDMactivities -PredefinedFilter SYSTEM_JOBS -filter '%name lk "Configuring Oracle Databases - Oracle DEV%"' -pageSize 3 6>$null
    write-host -NoNewline "$($Activity.progress)% "
    }
until ($Activity.state -eq "COMPLETED")



$Protection=Start-PPDMprotection -AssetIDs $Asset.id -StageID $Policy.stages[0].id -PolicyID $Policy.id


$Protection.Results | Get-PPDMactivities 

do { 
    Sleep 5;
    $Activity=$Protection.Results | Get-PPDMactivities 
    write-host -NoNewline "$($Activity.progress)% "
    }
until ($Activity.state -eq "COMPLETED")
