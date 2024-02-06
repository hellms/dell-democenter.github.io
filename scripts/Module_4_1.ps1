Write-Host "# MODULE 4 - PROTECT SQL DATABASES
# Scripted Version
## LESSON 1 - DISCOVER SQL DATABASES"
$SQL_HOSTNAME="sql-02.demo.local"
Write-Host "Reviewing the Agent Regitration Status."
Get-PPDMagent_registration_status  6>$null | out-string
Get-PPDMWhitelist  6>$null| Update-PPDMWhitelist -state APPROVED | out-string
Write-Host "Starting a discover for host $SQL_HOSTNAME"
$Discoveries=Get-PPDMhosts -filter "name eq `"$SQL_HOSTNAME`""  6>$null | Start-PPDMdiscoveries -level HOSTFULL -start hosts
do { 
    Sleep 5;
    $Activity=$Discoveries | Get-PPDMactivities  6>$null
    write-host -NoNewline "$($Activity.progress)% "
    }
until ($Activity.state -eq "COMPLETED")
Write-Host "Getting discovered Databases for Host $SQL_HOSTNAME"
Get-PPDMassets -type MICROSOFT_SQL_DATABASE -filter "details.database.clusterName eq `"$SQL_HOSTNAME`""  6>$null| ft | out-string
