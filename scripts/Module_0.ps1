[Net.ServicePointManager]::SecurityProtocol =
    [Net.ServicePointManager]::SecurityProtocol -bor
    [Net.SecurityProtocolType]::Tls12
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force
Remove-Module ppdm-pwsh -force -ErrorAction SilentlyContinue | out-null
Uninstall-Module ppdm-pwsh -AllVersions -ErrorAction SilentlyContinue | out-null
Install-Module ppdm-pwsh -MinimumVersion 19.14.20.76 -Force -ErrorAction SilentlyContinue | out-null