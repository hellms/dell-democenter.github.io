# Prerequisites
We need to prepare Host to install the Powershell Modules from Powershell Gallery.
## Start a Powershell Session:
Click on the start Button (Windows Icon) in the lower lect of the screen  
![image](https://github.com/dell-democenter/dell-democenter.github.io/assets/8255007/af061171-7837-4325-938e-17874a5a9ad7)

Type *Powershell*  
![image](https://github.com/dell-democenter/dell-democenter.github.io/assets/8255007/af11bd07-7294-4b30-8a4e-dba1717bbd51)

Click on the Powershell icon.
Powershell windows soul open.  

![image](https://github.com/dell-democenter/dell-democenter.github.io/assets/8255007/5746bdca-92c4-4dd0-bc23-5a76f0fa2b4e)

To access the PowerShell Gallery, you must use Transport Layer Security (TLS) 1.2 or higher. Use the following command to enable TLS 1.2 in your PowerShell session.  

Paste the following intio the opowershell window:  

```Powershell
[Net.ServicePointManager]::SecurityProtocol =
    [Net.ServicePointManager]::SecurityProtocol -bor
    [Net.SecurityProtocolType]::Tls12
```
And hit enter  
Powershell should now run with TLS 1.2   
![image](https://github.com/dell-democenter/dell-democenter.github.io/assets/8255007/cf012473-bd0b-4909-8a34-9efd5dbdf949)

