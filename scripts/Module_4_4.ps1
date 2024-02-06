Write-Host "# MODULE 4 - PROTECT SQL DATABASES
# Scripted Version
## LESSON 4 - RECOVER SQL DATABASES TO AAG ( TO ALL REPLICAS )"
Write-Host "This will perform a Centralized Restore of SQL DATABASES TO AAG ( TO ALL REPLICAS )"
$RestoreFromHost = "sqlaag-01.demo.local"
$RestoreToHost_Name = "sqlaag-01.demo.local"
$AppServerName = "AAG-Demo"
$DataBaseName = "DemoDB-01"
Write-Host "Read our Restore Host"
$RestoreHostFilter = 'attributes.appHost.applicationsOfInterest.type eq "MSSQL" and not (lastDiscoveryStatus eq "DELETED") and details.appHost.os eq "WINDOWS" and hostname eq "' + $RestoreToHost_Name + '"'
$RestoreToHost = Get-PPDMhosts -filter $RestoreHostFilter 6>$null
$RestoreToHost | out-string
Write-Host "Read the Asset to restore to identify the Asset Copies"
$RestoreAssetFilter = 'type eq "MICROSOFT_SQL_DATABASE" and protectionStatus eq "PROTECTED" and details.database.clusterName eq "' + $RestoreFromHost + '"' + ' and details.database.appServerName eq "' + $AppServerName + '"'  + ' and name eq "' + $DataBaseName + '"'
$RestoreAssets = Get-PPDMAssets -Filter $RestoreAssetFilter 6>$null
Get-PPDMlatest_copies -assetID $RestoreAssets.id
write-host "Selecting Asset-copy for $DataBaseName"
$RestoreAssetCopy = Get-PPDMlatest_copies -assetID $RestoreAssets.id
Write-Host "Starting restore"
$Parameters = @{
  HostID                  = $RestoreToHost.id 
  appServerId             = $RestoreAssets.details.database.appServerId
  copyObject              = $RestoreAssetCopy
  performTailLogBackup    = $true
  enableDebug             = $false
  enableCompressedRestore = $true
  fileRelocationOptions   = "ORIGINAL_LOCATION"
  restoreType             = "TO_ALTERNATE" 
  CustomDescription       = "Restore from Powershell"
  aagRestoreType          = "RESTORE_TO_ALL"
  Verbose                 = $false
}
$Restore = Restore-PPDMMSSQL_copies @Parameters
$Restore | Get-PPDMRestored_copies
$Restore | Get-PPDMactivities
Write-Host "Waiting for Restore Activity to complete"

do { 
    Sleep 5
    $Activity=$Restore | Get-PPDMactivities
    write-host -NoNewline "$($Activity.progress)% "
    } 
until ($Activity.state -eq "COMPLETED")
