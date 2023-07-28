# MODULE 5 - PROTECT & RESTORE ORACLE DATABASE FROM POWERSHELL

## LESSON 3 - PERFORM CENTRALIZED ORACLE DATABASE RESTORE


## IMPORTANT FOLLLOW THE LAB GUIDE TO PREPARE THE  ORACLE Server:

- click on the Royal TS icon located on the Desktop
- Connect to oracle01.demo.local
- Double-click on oracle01 to connect to oracle01.demo.local
- 'su - oracle' to switch to oracle use wirh Password123!
- 'sqlplus "/as sysdba" and wait for the SQL> prompt
- select status from v$instance;
- shutdown immediate;
- startup nomount;


## Identify our Asset

>DatabaseName: oracl

```Powershell
$Asset=Get-PPDMassets -type ORACLE_DATABASE -filter 'name eq "orcl"'
$Asset
# Note you can also add the Server name if you have multiple DB Assets with te same Name...
# $Asset=Get-PPDMassets -type ORACLE_DATABASE -filter 'details.database.clusterName eq "oracle01.demo.local" and name eq "orcl"'
```

![Alt text](image-78.png)

## Get your Asset Copies

To get all Copies of an asset, or use custom filters, use *Get-PPDMassetcopies*

```Powershell
$Asset | Get-PPDMassetcopies | ft
```

![Alt text](image-79.png)

For the latest copy of an asset, use

```Powershell
$Asset | Get-PPDMlatest_copies
```

![Alt text](image-80.png)



Restore-PPDMOracle_copies -copyobject $CopyObject -appServerID $Asset.details.database.appServerId -HostID e21abba-f9d7-43b8-9c6b-42d9e678d451  -Verbose -crossCheckBackup -OraCredObject $OraCreds



[<<Module 5 Lesson 1](./Module_5_1.md) This Concludes Module 5 Lesson 2 [Module 5 Lesson 3>>](./Module_5_3.md)
