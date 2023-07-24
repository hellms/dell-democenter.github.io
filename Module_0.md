# Prerequisites

We need to prepare Host to install the Powershell Modules from Powershell Gallery.

## Start a Powershell Session

Click on the start Button (Windows Icon) in the lower lect of the screen  
![image](https://github.com/dell-democenter/dell-democenter.github.io/assets/8255007/af061171-7837-4325-938e-17874a5a9ad7)

Type *Powershell*  
![image](https://github.com/dell-democenter/dell-democenter.github.io/assets/8255007/af11bd07-7294-4b30-8a4e-dba1717bbd51)

Click on the Powershell icon.
Powershell windows should open.  

![image](https://github.com/dell-democenter/dell-democenter.github.io/assets/8255007/5746bdca-92c4-4dd0-bc23-5a76f0fa2b4e)

To access the PowerShell Gallery, you must use Transport Layer Security (TLS) 1.2 or higher. Use the following command to enable TLS 1.2 in your PowerShell session.  

Paste the following into the powershell window:  

```Powershell
[Net.ServicePointManager]::SecurityProtocol =
    [Net.ServicePointManager]::SecurityProtocol -bor
    [Net.SecurityProtocolType]::Tls12
```

And hit enter  
Powershell should now run with TLS 1.2  
![image](https://github.com/dell-democenter/dell-democenter.github.io/assets/8255007/cf012473-bd0b-4909-8a34-9efd5dbdf949)

Install the PPDM-pwsh Powershell Module from the Powershell Gallery using the Command *Install-Module*  

```Powershell
Install-Module ppdm-pwsh -MinimumVersion 19.14.20.15 -Force
```

Show the Module is installed using:

```Powershell
Get-Module -ListAvailable PPDM-pwsh
```

*Note: The Version might already be a newer one
![image](https://github.com/dell-democenter/dell-democenter.github.io/assets/8255007/28b26ce5-2dad-4061-9c48-f988f241319e)

To see all commands the Module provides, type 

```Powershell
Get-Command -Module PPDM-pwsh
```

![image](https://github.com/dell-democenter/dell-democenter.github.io/assets/8255007/17d58ca8-2b21-46f9-b10e-c36f9ad093f3)

If you ever need to update the Module to a newer Version, run

```Powershell
Remove-Module ppdm-pwsh
Uninstall-Module ppdm-pwsh -AllVersions
Install-Module ppdm-pwsh -MinimumVersion 19.14.20.15 -Force
```

[<<Index](./README.md)This Concludes Module 0 [>>Module 1](./Module_1.md)