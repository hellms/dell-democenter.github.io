# MODULE 3 - PROTECT VMWARE VIRTUAL MACHINES
# Scripted Version
## LESSON 5 - CENTRALIZED INSTANT ACCESS RESTORE OF VM ASSET
$vcenterName="vcsa-7.demo.local"
$RestoreHost="esxi03-7.demo.local"
$OriginalVM="LINUX-01"
Write-Host "Reading Inventory Source for $vcenterName"
$InventorySource=Get-PPDMinventory_sources -Type VCENTER -filter "address eq `"$vcenterName`"" 6>$null
Write-Host "Reading the Datacenter Moref for $vcenterName"
$Datacenter=$InventorySource | Get-PPDMvcenterDatacenters
$Datacenter | Out-String
Write-Host "Reading Host Information for $RestoreHost"
$ESXHOST=Get-PPDMhosts -type ESX_HOST -filter "`'name eq `"$RestoreHost`"`'" 6>$null
Write-Host "Get the Moref´s of the Host $RestoreHost"
$HostMorefs=Get-PPDMvcenterMorefs -ID $InventorySource.ID -hostMoref $ESXHOST.details.esxHost.hostMoref
$HostMorefs | Out-String 
Write-Host "Reading the Original Asset for $OriginalVM"
$Asset=Get-PPDMassets -filter "`'name eq `"$OriginalVM`"`'" 6>$null
Write-Host "Get the latest Copy for the Asset $($Asset.name)"
$LatestCopy=Get-PPDMlatest_copies -assetID $Asset.id
$Restore=Restore-PPDMVMAsset -INSTANT_ACCESS -CopyObject $LatestCopy `
-NewVMName INSTANT_1 `
-InventorySourceId $InventorySource.id `
-dataCenterMoref $Datacenter.moref `
-hostMoref $HostMorefs.moref `
-Description "from Powershell"


$Restore | Get-PPDMactivities -filter $Filter -pageSize 1 6>$null
Write-Host "Monitoring Restore Progress"
do { 
    Sleep 5;
    $Activity=$Restore | Get-PPDMactivities -filter $Filter -pageSize 1 6>$null
    write-host -NoNewline "$($Activity.progress)% "
    }
until ($Activity.state -eq "COMPLETED")
