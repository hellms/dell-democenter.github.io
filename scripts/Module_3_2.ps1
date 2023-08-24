# Scripted Version
# MODULE 3 - PROTECT VMWARE VIRTUAL MACHINES
# LESSON 2 - USING PROTECT VIRTUAL MACHINES USING TRANSPARENT SNAPSHOT DATA MOVER(CRASH CONSISTENT)
$PolicyName="Linux VM"
$VMname="LINUX-01"
$PolicyDescription="Protect Linux VM"
$StorageName="ddve-01.demo.local"
$Schedule=New-PPDMBackupSchedule -hourly -CreateCopyIntervalHrs 8 -RetentionUnit DAY -RetentionInterval 2
$SLA=New-PPDMBackupService_Level_Agreements -NAME PLATINUM -RecoverPointObjective -RecoverPointUnit HOURS -RecoverPointInterval 24 -DeletionCompliance -ComplianceWindow -ComplianceWindowCopyType ALL
$StorageSystem=Get-PPDMStorage_systems -Type DATA_DOMAIN_SYSTEM -Filter {name eq "$StorageName"}
Write-Host "Creating Policy $PolicyName"
$Policy=New-PPDMVMBackupPolicy -Schedule $Schedule -Name $PolicyName -Description $PolicyDescription -backupMode FSS -StorageSystemID $StorageSystem.id -SLAId $SLA.id
$Asset=Get-PPDMassets -type VMWARE_VIRTUAL_MACHINE -filter {name eq "$VMname"}
$Policy | Add-PPDMProtection_policy_assignment -AssetID $Asset.id
Write-Host "Waiting for Policy Assigment"  
do { 
    Sleep 5
    $Activity=Get-PPDMactivities -PredefinedFilter SYSTEM_JOBS -filter "name lk `"%$($Policy.Name)%`"" -pageSize 3 6> $null
    write-host -NoNewline "$($Activity.progress)% "} 
until ($Activity.state -eq "COMPLETED")
$Asset=$Asset | Get-PPDMassets
# Reading Policy ID From Asset top be safe its assigned
$Policy=Get-PPDMprotection_policies -id $Asset.protectionPolicy.id
Write-Host "Starting ProtectionPolicy $(Policy.name)"
Start-PPDMprotection -PolicyObject $Policy -AssetIDs $Asset.id | out-string
do { 
    Sleep 5;
    $Activity=Get-PPDMactivities -filter "category eq `"protect`" and name lk `"%$($Policy.Name)%`"" 6>$null
    write-host -NoNewline "$($Activity.progress)% "
    }
until ($Activity.state -eq "COMPLETED")
