# MODULE 10 - DYNAMIC NAS PROTECTION

## LESSON 1 - REVIEW NAS PROXY AND ASSETS

## Viewing NAS Assets and Asset Sources

View explicit Powerstore NAS system with Name isilon.demo.local:

```Powershell
Get-PPDMAssetSource -Type POWERSCALEMANAGEMENTSERVER -filter 'name eq "isilon.demo.local"'
```

![Alt text](image-49.png)

View all NAS Assets

```Powershell
Get-PPDMassets -type NAS_SHARE | ft name, id, status, protectionStatus
```

![Alt text](image-50.png)

## View NAS Proxies

The Provies are managed via the embedded Protection Engine, the VPE
First, we get the VPE with its ID:

```Powershell
$VPE=Get-PPDMprotection_engines
$VPE
```

![Alt text](image-51.png)

Next, we get the NAS Protection Engine Proxies  with:

```Powershell
$Proxies=Get-PPDMprotectionEngineProxies -VPE $VPE.id -ProtectionTypes NAS
```

View the Status of the Proxies(s)

```Powershell
$Proxies.Status
```

![Alt text](image-52.png)

View the Configuration of the Proxies(s)

```Powershell
$Proxies.Config
```

![Alt text](image-53.png)

[<<Module 9 Lesson 1](./Module_9_1.md) This Concludes Module 10 Lesson 1 [Module 10 Lesson 1 >>](./Module_10_2.md)
