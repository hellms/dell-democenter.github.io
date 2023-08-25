# MODULE 3 - PROTECT VMWARE VIRTUAL MACHINES
# Scripted Version
## LESSON 5 - CENTRALIZED INSTANT ACCESS RESTORE OF VM ASSET


$vcenterName="vcsa-7.demo.local"
$RestoreHost="esxi03-7.demo.local"
$OriginalVM="LINUX-01"
Write-Host "Reading Inventory Source for $vcenterName"
$InventorySource=Get-PPDMinventory_sources -Type VCENTER -filter "`'name eq `"$vcenterName`"`'"


Read the Datacenter Moref


$Datacenter=$InventorySource| Get-PPDMvcenterDatacenters
$Datacenter


![Alt text](./images/image-41.png)

Get Information on the ESX Host we want to restore


$ESXHOST=Get-PPDMhosts -type ESX_HOST -filter "`'name eq `"$RestoreHost`"`'"


Get the Moref´s of the Host


$HostMorefs=Get-PPDMvcenterMorefs -ID $InventorySource.ID -hostMoref $ESXHOST.details.esxHost.hostMoref
$HostMorefs


![Alt text](./images/image-42.png)

Read the Original Asset


$Asset=Get-PPDMassets -filter "`'name eq `"$OriginalVM`"`'"


Get the latest Copy for the Asset


$LatestCopy=Get-PPDMlatest_copies -assetID $Asset.id


And finally run the Restore


Restore-PPDMVMAsset -INSTANT_ACCESS -CopyObject $LatestCopy `
-NewVMName INSTANT_1 `
-InventorySourceId $InventorySource.id `
-dataCenterMoref $Datacenter.moref `
-hostMoref $HostMorefs.moref `
-Description "from Powershell"
Get-PPDMRestoredCopies


![Alt text](./images/image-43.png)

Now See the Status of the Instant Access Sewssion


Get-PPDMRestoredCopies -pagesize 1


![Alt text](./images/image-44.png)

[TLDR](./scripts/Module_3_5.ps1)

[<<Module 3 Lesson 4](./Module_3_4.md) This Concludes Module 3 [Module 4 Lesson 1>>](./Module_4_1.md)