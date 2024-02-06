Write-Host "# MODULE 4 - PROTECT SQL DATABASES
# Scripted Version
## LESSON 3 - RECOVER SQL DATABASES"
Write-Host "Preparing to perform a Centralized Restore"
$RestoreFromHost = "sql-02.demo.local"
$RestoreToHost_Name = "sql-02.demo.local"
$AppServerName = "MSSQLSERVER"
$DataBaseName = "SQLPROD-01"
Write-Host "Read our Restore Host"
$RestoreHostFilter = 'attributes.appHost.applicationsOfInterest.type eq "MSSQL" and not (lastDiscoveryStatus eq "DELETED") and details.appHost.os eq "WINDOWS" and hostname eq "' + $RestoreToHost_Name + '"'
$RestoreToHost = Get-PPDMhosts -filter $RestoreHostFilter 6>$null
$RestoreToHost
Write-Host "Read the Asset to restore to identify the Asset Copies"
$RestoreAssetFilter = 'type eq "MICROSOFT_SQL_DATABASE" and protectionStatus eq "PROTECTED" and details.database.clusterName eq "' + $RestoreFromHost + '"' + ' and details.database.appServerName eq "' + $AppServerName + '"'
$RestoreAssets = Get-PPDMAssets -Filter $RestoreAssetFilter 6>$null
$RestoreAssets = $RestoreAssets | Where-Object name -Match $DataBaseName 
Write-Host "Selecting the Asset Copy to Restore"
$RestoreAssets | ft |  out-string
### by Filering for a Date Range ...
#write-host "Selecting Asset-copy for $DataBaseName"
#$myDate = (get-date).AddDays(-1)
#$usedate = get-date $myDate -Format yyyy-MM-ddThh:mm:ssZ
#$RANGE_FILTER = 'startTime ge "' + $usedate + '"state eq "IDLE"'
# $RestoreAssets | Get-PPDMassetcopies -filter $RANGE_FILTER
#$RestoreAssetCopy = $RestoreAssets | Get-PPDMassetcopies -filter $RANGE_FILTER | Select-Object -First 1
# For now, we use the Latest Copy Function 
$RestoreAssetCopy = Get-PPDMlatest_copies -assetID $RestoreAssets.id
$Parameters = @{
  HostID                  = $RestoreToHost.id 
  appServerId             = $RestoreAssets.details.database.appServerId
  copyObject              = $RestoreAssetCopy
  enableDebug             = $false
  enableCompressedRestore = $true
  fileRelocationOptions   = "ORIGINAL_LOCATION"
  restoreType             = "TO_ALTERNATE" 
  CustomDescription       = "Restore from Powershell"
  Verbose                 = $false
}
Write-Host "starting the Restore Job:"
$Restore = Restore-PPDMMSSQL_copies @Parameters
$Restore | Get-PPDMRestored_copies
$Restore | Get-PPDMactivities
Write-Host "Waiting for Activity to complete"
do { 
    Sleep 5
    $Activity=$Restore | Get-PPDMactivities
    write-host -NoNewline "$($Activity.progress)% "
    } 
until ($Activity.state -eq "COMPLETED")

