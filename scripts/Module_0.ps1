[Net.ServicePointManager]::SecurityProtocol =
    [Net.ServicePointManager]::SecurityProtocol -bor
    [Net.SecurityProtocolType]::Tls12
$Zonemaps = ("HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains")
$DOMAIN=New-Item -Path $Zonemaps -Name "github.io\dell-democenter" -Force
$DOMAIN | New-ItemProperty -Name "https" -PropertyType DWORD -Value  "2"
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force
Remove-Module ppdm-pwsh -force -ErrorAction SilentlyContinue | out-null
Uninstall-Module ppdm-pwsh -AllVersions -ErrorAction SilentlyContinue | out-null
Install-Module ppdm-pwsh -MinimumVersion 19.14.20.76 -Force -ErrorAction SilentlyContinue | out-null