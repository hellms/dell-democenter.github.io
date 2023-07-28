# MODULE 5 - PROTECT & RESTORE ORACLE DATABASE FROM POWERSHELL

## LESSON 2 - VIEW ORACLE COPIES

In this lesson, we will learn how to view and manage Oracle copies on the Protection Storage, including extending the retention period of an existing backup.

## Identify our Asset

>DatabaseName: oracl

```Powershell
$Asset=Get-PPDMassets -type ORACLE_DATABASE -filter 'name eq "orcl"'
$Asset
# Note you can also add the Server name if you have multiple DB Assets with te same Name...
# $Asset=Get-PPDMassets -type ORACLE_DATABASE -filter 'details.database.clusterName eq "oracle01.demo.local" and name eq "orcl"'
```

## Get your Asset Copies

```Powershell

``




























[<<Module 4 Lesson 4](./Module_4_4.md) This Concludes Module 5 Lesson 1 [Module 5 Lesson 2>>](./Module_5_2.md)
