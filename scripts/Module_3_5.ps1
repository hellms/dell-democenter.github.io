# MODULE 3 - PROTECT VMWARE VIRTUAL MACHINES
# Scripted Version
## LESSON 5 - CENTRALIZED INSTANT ACCESS RESTORE OF VM ASSET
$vcenterName="vcsa-7.demo.local"
$RestoreHost="esxi03-7.demo.local"
$OriginalVM="LINUX-01"
Write-Host "Reading Inventory Source for $vcenterName"
$InventorySource=Get-PPDMinventory_sources -Type VCENTER -filter "address eq `"$vcenterName`""
Write-Host "Reading the Datacenter Moref for $vcenterName"
$Datacenter=$InventorySource | Get-PPDMvcenterDatacenters
$Datacenter | Out-String
Write-Host "Reading Host Information for $RestoreHost"
$ESXHOST=Get-PPDMhosts -type ESX_HOST -filter "`'name eq `"$RestoreHost`"`'"
Write-Host "Get the MorefÂ´s of the Host $RestoreHost"
$HostMorefs=Get-PPDMvcenterMorefs -ID $InventorySource.ID -hostMoref $ESXHOST.details.esxHost.hostMoref
$HostMorefs | Out-String 
Write-Host "Reading the Original Asset for $OriginalVM"
$Asset=Get-PPDMassets -filter "`'name eq `"$OriginalVM`"`'"
Write-Host "Get the latest Copy for the Asset $($Asset.name)"
$LatestCopy=Get-PPDMlatest_copies -assetID $Asset.id
Restore-PPDMVMAsset -INSTANT_ACCESS -CopyObject $LatestCopy `
-NewVMName INSTANT_1 `
-InventorySourceId $InventorySource.id `
-dataCenterMoref $Datacenter.moref `
-hostMoref $HostMorefs.moref `
-Description "from Powershell"

$Filter='category eq "RESTORE" and subcategory eq "INSTANT_ACCESS" and name lk "%' + $LatestCopy.id + '%"' 
Get-PPDMactivities -filter $Filter -pageSize 1
Write-Host "Monitoring Restore Progress"
do { 
    Sleep 5;
    $Activity=Get-PPDMactivities -filter $Filter -pageSize 1 6>$null
    write-host -NoNewline "$($Activity.progress)% "
    }
until ($Activity.state -eq "COMPLETED")
