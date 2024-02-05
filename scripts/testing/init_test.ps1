[Net.ServicePointManager]::SecurityProtocol =
    [Net.ServicePointManager]::SecurityProtocol -bor
    [Net.SecurityProtocolType]::Tls12
$Zonemaps = ("HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains")
$DOMAIN=New-Item -Path $Zonemaps -Name "github.io\dell-democenter" -Force
$DOMAIN | New-ItemProperty -Name "https" -PropertyType DWORD -Value  "2"
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force

Install-Script -Name install-gitscm -Force
Install-gitscm
git clone https://github.com/bottkars/ppdm-pwsh.git
set-location ppdm-pwsh
ipmo ./PPDM-pwsh -force 
Write-Host "Testing Module 1"
$DownloadScript="https://dell-democenter.github.io/scripts/Module_1.ps1"
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString($DownloadScript))
Write-Host "Turning On strict API Validation"
$Settings=Get-PPDMcommon_settings -id REST_API_SETTING
Set-PPDMcommon_settings -id REST_API_SETTING -Properties $Settings
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString($DownloadScript))

Write-Host "Testing Module 2"
$DownloadScript="https://dell-democenter.github.io/scripts/Module_2.ps1"
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString($DownloadScript))

Write-Host "Testing Module 3 1"
$DownloadScript="https://dell-democenter.github.io/scripts/Module_3_1.ps1"
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString($DownloadScript))

Write-Host "Testing Module 3 2"
$DownloadScript="https://dell-democenter.github.io/scripts/Module_3_2.ps1"
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString($DownloadScript))