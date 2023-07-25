
$Policy=Get-PPDMprotection_policies -filter 'name eq "Linux VM"'

$Policy.stages[0].target.dataTargetId






$Credentials=New-PPDMcredentials -type OS -name windows -authmethod BASIC 
$StorageSystem=Get-PPDMStorage_systems -Type DATA_DOMAIN_SYSTEM -Filter {name eq "ddve-01.demo.local"}
$DBSchedule=New-PPDMDatabaseBackupSchedule -hourly -CreateCopyIntervalHrs 8 -RetentionUnit DAY -RetentionInterval 5
New-PPDMSQLBackupPolicy -Schedule $DBSchedule -Name MMSSQL_APPAWARE -AppAware -dbCID 2511db3a-5cd4-4463-b745-4facbe5169f2 -StorageSystemID $StorageSystem.id -DataMover SDM -SizeSegmentation FSS