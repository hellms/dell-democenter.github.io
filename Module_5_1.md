# MODULE 5 - PROTECT & RESTORE ORACLE DATABASE FROM POWERSHELL

## LESSON 1 - PROTECT ORACLE DATABASES

In this Lesson we Create a Protectin Policy for Oracle Centralized Protection
We alo need to create the following Credentials:

>Credential Name: oracle
>User Name: oracle
>Password: Password123!
Thie time we will pass a credentials string to Powershell

```Powershell
$username="oracle"
$credentialname="oracle"
$password="Password123!"
$Securestring=ConvertTo-SecureString -AsPlainText -String $Password -Force
$Credentials = New-Object System.Management.Automation.PSCredential($username, $Securestring)
$Credentials=New-PPDMcredentials -type OS -name $credentialname -authmethod BASIC 
```

[<<Module 4 Lesson 1](./Module_4_1.md) This Concludes Module 4 Lesson 2 [Module 5 Lesson 1>>](./Module_5_1.md)