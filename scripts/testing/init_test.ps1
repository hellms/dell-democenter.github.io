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
git checkout 19.15
ipmo ./PPDM-pwsh -force 
Write-Host "Testing Module 1, Overview of PowerProtect User Interface"
$DownloadScript="https://dell-democenter.github.io/scripts/Module_1.ps1"
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString($DownloadScript))
Write-Host "Turning On strict API Validation"
$Settings=Get-PPDMcommon_settings -id REST_API_SETTING
Set-PPDMcommon_settings -id REST_API_SETTING -Properties $Settings
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString($DownloadScript))

Write-Host "Testing Module 2, MULTI FACTOR AUTHENTICATION USING RSA"
$DownloadScript="https://dell-democenter.github.io/scripts/Module_2.ps1"
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString($DownloadScript))

Write-Host "Testing Module 3.1, DISCOVER VIRTUAL MACHINES"
$DownloadScript="https://dell-democenter.github.io/scripts/Module_3_1.ps1"
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString($DownloadScript))

Write-Host "Testing Module 3.2, PROTECT VIRTUAL MACHINES USING TRANSPARENT SNAPSHOT DATA MOVER(CRASH CONSISTENT)"
$DownloadScript="https://dell-democenter.github.io/scripts/Module_3_2.ps1"
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString($DownloadScript))

Write-Host "Testing Module 3.3, PROTECT SQL VIRTUAL MACHINES USING PRE-CREATED/EXISTING STORAGE UNIT(APPLICATION AWARE) "
$DownloadScript="https://dell-democenter.github.io/scripts/Module_3_3.ps1"
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString($DownloadScript))

Write-Host "Testing Module 3.4, CENTRALIZED RESTORE- SQL DATABASE"
$DownloadScript="https://dell-democenter.github.io/scripts/Module_3_4.ps1"
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString($DownloadScript))

Write-Host "Testing Module 3.5, CENTRALIZED INSTANT ACCESS RESTORE OF VM ASSET "
$DownloadScript="https://dell-democenter.github.io/scripts/Module_3_5.ps1"
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString($DownloadScript))

Write-Host "Testing Module 4.1, DISCOVER SQL DATABASES"
$DownloadScript="https://dell-democenter.github.io/scripts/Module_4_1.ps1"
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString($DownloadScript))

Write-Host "Testing Module 4.2, PROTECT SQL DATABASES"
$DownloadScript="https://dell-democenter.github.io/scripts/Module_4_2.ps1"
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString($DownloadScript))