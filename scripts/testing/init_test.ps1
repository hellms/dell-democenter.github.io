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
$DownloadString="https://dell-democenter.github.io/scripts/Module_1.ps1"
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('$DownloadString'))
