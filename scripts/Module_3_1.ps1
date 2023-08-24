$VCENTER_HOST="vcsa-7.demo.local"
$Securestring=ConvertTo-SecureString -AsPlainText -String "Password123!" -Force
$username="administrator@vsphere.local"
$Credential = New-Object System.Management.Automation.PSCredential($username, $Securestring)
$CREDS=New-PPDMcredentials -type VCENTER -name $username -credentials $Credential
Get-PPDMcertificates -newhost $VCENTER_HOST -port 443 | Approve-PPDMcertificates | out-string
Write-Host "Adding Inventory Source $VCENTER_HOST"
$INVENTORY_SOURCE=Add-PPDMinventory_sources -Hostname $VCENTER_HOST -port 443 -Type VCENTER -isHostingvCenter -isAssetSource -ID $CREDS.id -Name "DEMO VCENTER"
Write-Host "Waiting for Initial Discovery to complete"
do {
sleep 5
$INVENTORY_SOURCE=$INVENTORY_SOURCE | Get-PPDMInventory_sources
}
until ($INVENTORY_SOURCE.lastDiscoveryResult.status -eq "OK")

Write-Host "Doing Full Discovery"
$DISCOVERY=$INVENTORY_SOURCE | Start-PPDMdiscoveries -level DataCopies -start inventory-sources 
do { 
    Sleep 5
    $Activity=$DISCOVERY | Get-PPDMactivities 6>$null
    write-host -NoNewline "$($Activity.progress)% "} 
until ($Activity.state -eq "COMPLETED")

Write-Host "VM Backup Settings"
Get-PPDMvm_backup_setting | Out-String
Write-Host "Modifying VM Backup Settings"
$VMsettings=Get-PPDMvm_backup_setting
$VMsettings.properties
$VMsettings.properties[0].value=10
$VMsettings.properties[1].value=5
Set-PPDMvm_backup_setting -vm_backup_setting $VMsettings | Out-String
