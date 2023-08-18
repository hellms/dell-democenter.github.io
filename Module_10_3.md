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
$files=@()
$files=$files + (Get-PPDMfile_instances  -name "file02" -ShareProtocol CIFS -NAS -AssetID $Asset.id -BackupState BackedUp)
$files=$files + (Get-PPDMfile_instances  -name "file01" -ShareProtocol CIFS -NAS -AssetID $Asset.id -BackupState BackedUp)
```


```Powershell

$RestoreAsset=Get-PPDMassets -type NAS_SHARE -filter 'name eq "ifs"'
```


```Powershell
$FileBackups=Request-PPDMfile_backups -fileinstance $files
$BackupID=$FileBackups[0].backups[0].backupId
```



PS C:\Users\Administrator> Restore-PPDMNasFiles -copyID $BackupID -Fileobject $files -AssetID $RestoreAsset.id -Verbose -targetdirectory "ifs" -
credentials $credential

PS C:\Users\Administrator> Restore-PPDMNasFiles -copyID $BackupID -Fileobject $files -AssetID $RestoreAsset.id -Verbose -targetdirectory "ifs" -
credentials $credential  -restoreTopLevelACLs

![Alt text](image-47.png)


[<<Module 9 Lesson 1](./Module_9_1.md) This Concludes Module 10 Lesson 1 [Module 10 Lesson 1 >>](./Module_10_2.md)
