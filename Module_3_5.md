# MODULE 3 - PROTECT VMWARE VIRTUAL MACHINES

## LESSON 5 - CENTRALIZED RESTORE- SQL DATABASE

```Powershell
$vcenterName="vcsa-7.demo.local"
$RestoreHost="esxi03-7.demo.local"
$OriginalVM="LINUX-01"
```

Read out Target Datacenter nventory Source

```Powershell
$InventorySource=Get-PPDMinventory_sources -Type VCENTER -filter "`'name eq `"$vcenterName`"`'"
```

Read the Datacenter Moref

```Powershell
$Datacenter=$InventorySource| Get-PPDMvcenterDatacenters
$Datacenter
```

```Powershell
$ESXHOST=Get-PPDMhosts -type ESX_HOST -filter "`'name eq `"$RestoreHost`"`'"
```

```Powershell
$HostMorefs=Get-PPDMvcenterMorefs -ID $InventorySource.ID -hostMoref $ESXHOST.details.esxHost.hostMoref
$HostMorefs
```

```Powershell
$Asset=Get-PPDMassets -filter "`'name eq `"$OriginalVM`"`'"
```

```Powershell
$LatestCopy=Get-PPDMlatest_copies -assetID $Asset.id
```
