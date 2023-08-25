# MODULE 4 - PROTECT SQL DATABASES

## LESSON 1 - DISCOVER SQL DATABASES

Review the Agent Regitration Status.

```Powershell
Get-PPDMagent_registration_status
```

The Command will output all Agents Registrations

![Alt text](./images/image-45.png)

Agents cann be approved via the *Set-PPDMWhitelist* Function, eiter from ID or from Pipeline

```Powershell
Get-PPDMWhitelist | Set-PPDMWhitelist -state APPROVED
```

![Alt text](./images/image-46.png)

Lets start a discover for host *sql-02.demo.local*

```Powershell
Get-PPDMhosts -filter 'name eq"sql-02.demo.local"' | Start-PPDMdiscoveries -level HOSTFULL -start hosts
```

![Alt text](./images/image-47.png)

```Powershell
Get-PPDMactivities -taskid <Use TaskID from you discover to check the activity>
```

![Alt text](./images/image-48.png)

Now lets have a look at the Discovered Databases

```Powershell
Get-PPDMassets -type MICROSOFT_SQL_DATABASE -filter 'details.database.clusterName eq "sql-02.demo.local"' | ft
```

![Alt text](./images/image-49.png)

[TLDR](./scripts/Module_4_1.ps1)

[<<Module 3 Lesson 5](./Module_3_5.md) This Concludes Module 4 Lesson 1 [Module 4 Lesson 2>>](./Module_4_2.md)