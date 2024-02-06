Write-Host "# MODULE 3 - PROTECT VMWARE VIRTUAL MACHINES
## LESSON 3 - PROTECT SQL VIRTUAL MACHINES USING PRE-CREATED/EXISTING STORAGE UNIT(APPLICATION AWARE)"

$Policy=Get-PPDMprotection_policies -filter 'name eq "Linux VM"' 6> $null
$Policy.stages[0].target.dataTargetId | out-string
$StorageUnitID=$Policy.stages[0].target.dataTargetId
$StorageSystemID=$Policy.stages[0].target.storageSystemId
## Creating SQL Credentials 
$Credential_Name="windows"
$Username="demo\administrator"
$PolicyName="SQL Virtual Machines"
$VMname="SQL-03"
$PolicyDescription="SQL Virtual Machines"
$Securestring=ConvertTo-SecureString -AsPlainText -String "Password123!" -Force
$Credential = New-Object System.Management.Automation.PSCredential($username, $Securestring)
Write-Host "Creating Credentials for SQL user"
$CREDS=New-PPDMcredentials -type OS -name $Credential_Name -authmethod BASIC -credentials $Credential
$DBSchedule=New-PPDMDatabaseBackupSchedule -hourly -CreateCopyIntervalHrs 8 -RetentionUnit DAY -RetentionInterval 5 -starttime 8:00PM -endtime 6:00AM
$Policy=New-PPDMSQLBackupPolicy -Schedule $DBSchedule -Name $PolicyName -Description $PolicyDescription -AppAware -dbCID $CREDS.id -StorageSystemID $StorageSystemID -DataMover SDM -SizeSegmentation VSS -enabled -StorageUnitID $StorageUnitID
$Asset=Get-PPDMassets -type VMWARE_VIRTUAL_MACHINE -filter "name eq `"$VMname`"" 6> $null
Write-Host "Assigning $VMname to Policy"
$Policy | Add-PPDMProtection_policy_assignment -AssetID $Asset.id 
Write-Host "Waiting for Policy Assigment"  
do { 
    Sleep 5
    $Activity=Get-PPDMactivities -PredefinedFilter SYSTEM_JOBS -filter "name lk `"Configuring protection for VM under Policy - $($Policy.Name)%`"" -pageSize 1 6> $null
    write-host -NoNewline "$($Activity.progress)% "} 
until ($Activity.state -eq "COMPLETED")
Write-Host
$Activity | Out-String
$Asset=$Asset | Get-PPDMassets
# Reading Policy ID From Asset top be safe its assigned
$Policy=Get-PPDMprotection_policies -id $Asset.protectionPolicy.id
Write-Host "Starting ProtectionPolicy $($Policy.name)"
Start-PPDMprotection_policies -id $Policy.id -BackupType FULL -RetentionUnit DAY -RetentionInterval 2
do { 
    Sleep 5;
    $Activity=Get-PPDMactivities -filter "category eq `"protect`" and name lk `"%$($Policy.Name)%`"" -pagesize 1 6>$null
    write-host -NoNewline "$($Activity.progress)% "
    }
until ($Activity.state -eq "COMPLETED")
Write-Host
$Activity | Out-String