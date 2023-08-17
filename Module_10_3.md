# MODULE 10 - DYNAMIC NAS PROTECTION

## LESSON 2 - PROTECT CIFS SHARE USING POWERPROTECT DATA MANAGER WITH INDEXING ENABLED




## Search for files in on NAS

The *Get-PPDMfile_instances* can search VM Indexes for Specific Files.

The Command can Construct Complex Search queries as in the UI. For VM´s the Following syntax ios available:

```Powershell
Get-PPDMfile_instances -NAS [-ShareProtocol {CIFS | NFS}] [-BackupState {Skipped | BackedUp}] [-name <Object>] [-location <Object>]
[-filesonly] [-filetype <Object>] [-minsize <Object>] [-minsizeUnit {KB | MB | GB | TB}] [-maxsize <Object>] [-maxsizeUnit {KB | MB |
GB | TB}] [-CreatedAtStart <datetime>] [-CreatedAtEnd <datetime>] [-modifiedAtStart <datetime>] [-modifiedAtEnd <datetime>]
[-LastBackupOnly] [-BackupAtStart <datetime>] [-BackupAtEnd <datetime>] [-SourceServer <string>] [-AssetID <string>] [-pageSize
<Object>] [-page <Object>] [-body <hashtable>] [-PPDM_API_BaseUri <Object>] [-apiver <Object>]  [<CommonParameters>]
```

As per Lab Guide, we need to search the following Spec:

> Key in "file0" in the File/Folder Name

```Powershell
Get-PPDMfile_instances -name file1 -VirtualMachine -SourceServer vcsa-7.demo.local -AssetID $Asset.id
```

![Alt text](image-47.png)

[<<Module 8 Lesson 2](./Module_8_2.md) This Concludes Module 9 Lesson 1 [Module 10 Lesson 1 >>](./Module_10_1.md)





[<<Module 9 Lesson 1](./Module_9_1.md) This Concludes Module 10 Lesson 1 [Module 10 Lesson 1 >>](./Module_10_2.md)
