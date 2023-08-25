# MODULE 4 - PROTECT SQL DATABASES
# Scripted Version
## LESSON 1 - DISCOVER SQL DATABASES
$SQLHST="sql-02.demo.local"
Write-Host "Reviewing the Agent Regitration Status."


Get-PPDMagent_registration_status | out-string


Get-PPDMWhitelist | Set-PPDMWhitelist -state APPROVED | out-string
Write-Host "Starting a discover for host $SQLHOST"


Get-PPDMhosts -filter "name eq `"$SQLHOST`"" | Start-PPDMdiscoveries -level HOSTFULL -start hosts

Get-PPDMactivities -taskid <Use TaskID from you discover to check the activity>

Write-Host "Getting discovered Databases for Host $SQLHOST"
Get-PPDMassets -type MICROSOFT_SQL_DATABASE -filter 'details.database.clusterName eq "sql-02.demo.local"' | ft | out-string
