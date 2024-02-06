$PPDM_FQDN="ppdm-01.demo.local"
$Securestring=ConvertTo-SecureString -AsPlainText -String "Password123!" -Force
$username="admin"
$Credential = New-Object System.Management.Automation.PSCredential($username, $Securestring)
Write-Host "connecting to $PPDM_FQDN"
$PPDM=Connect-PPDMsystem -fqdn $PPDM_FQDN -trustCert -Credential $Credential

Write-Host "Getting Protection Jobs"

$PROTECTION_JOBS=Get-PPDMactivities -PredefinedFilter PROTECTION_JOBS
$PROTECTION_JOBS | ft | Out-String

Write-Host "Getting Asset Jobs"
$ASSET_JOBS=Get-PPDMactivities -PredefinedFilter ASSET_JOBS
$ASSET_JOBS | ft | Out-String

Write-Host "Getting System Jobs"
$SYSTEM_JOBS=Get-PPDMactivities -PredefinedFilter SYSTEM_JOBS
$SYSTEM_JOBS | ft | Out-String
$SYSTEM_JOBS[0]  | Get-PPDMactivities | Out-String

Write-Host "Getting Metrics" 
Get-PPDMactivity_metrics | Out-String
Get-PPDMactivity_metrics -states  | Out-String

