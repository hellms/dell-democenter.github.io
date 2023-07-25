# MODULE 3 - PROTECT VMWARE VIRTUAL MACHINES

## LESSON 4 - CENTRALIZED RESTORE- SQL DATABASE

```Powershell
$RestoreFromHost = "sql-03.demo.local"
$RestoreToHost_Name = "sql-03.demo.local"
$AppServerName = "MSSQLSERVER"
$DataBaseName = "SQLDB_01"
```

## Read our Restore Host

```Powershell
$RestoreHostFilter = 'attributes.appHost.applicationsOfInterest.type eq "MSSQL" and not (lastDiscoveryStatus eq "DELETED") and details.appHost.os eq "WINDOWS" and hostname eq "' + $RestoreToHost_Name + '"'
$RestoreToHost = Get-PPDMhosts -filter $RestoreHostFilter
$RestoreToHost
```
![Alt text](image-36.png)

## Read the Asset to restore to identify the Asset Copies

```Powershell
$RestoreAssetFilter = 'type eq "MICROSOFT_SQL_DATABASE" and protectionStatus eq "PROTECTED" and details.database.clusterName eq "' + $RestoreFromHost + '"' + ' and details.database.appServerName eq "' + $AppServerName + '"'
$RestoreAssets = Get-PPDMAssets -Filter $RestoreAssetFilter
$RestoreAssets = $RestoreAssets | Where-Object name -Match $DataBaseName
# Optionally, look at the CopyMap
# $Copymap=$RestoreAssets | Get-PPDMcopy_map
```

## Selecting the Asset Copy to Restore
we have multiple options to select a Copy.....

### Using the latest copy

```Powershell
Get-PPDMlatest_copies -assetID $RestoreAssets.id
```

![Alt text](image-38.png)

### by Filering for a Date Range ...
```Powershell
write-host "Selecting Asset-copy for $DataBaseName"
$myDate = (get-date).AddDays(-1)
$usedate = get-date $myDate -Format yyyy-MM-ddThh:mm:ssZ
$RANGE_FILTER = 'startTime ge "' + $usedate + '"state eq "IDLE"'
# $RestoreAssets | Get-PPDMassetcopies -filter $RANGE_FILTER
$RestoreAssetCopy = $RestoreAssets | Get-PPDMassetcopies -filter $RANGE_FILTER | Select-Object -First 1
```

For now, we use the Latest Copy Function 

```Powershell
$RestoreAssetCopy = Get-PPDMlatest_copies -assetID $RestoreAssets.id
```



## Run the Restore

```Powershell
$Parameters = @{
  HostID                  = $RestoreToHost.id 
  appServerId             = $RestoreAssets.details.database.appServerId
  copyObject              = $RestoreAssetCopy
  enableDebug             = $false
  disconnectDatabaseUsers = $true
  restoreType             = "TO_ALTERNATE" 
  CustomDescription       = "Restore from Powershell"
  Verbose                 = $false
}

$Restore = Restore-PPDMMSSQL_copies @Parameters
```

## Monitor the Restore

```Powershell
$Restore | Get-PPDMRestored_copies
$Restore | Get-PPDMactivities
```

![Alt text](image-39.png)

![Alt text](image-40.png)