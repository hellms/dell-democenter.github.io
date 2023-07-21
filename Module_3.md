# MODULE 3 - PROTECT VMWARE VIRTUAL MACHINES - MODULE OVERVIEW

## LESSON 1 - DISCOVER VIRTUAL MACHINES

In this lesson we simulate adding of a vCenter in Powershell.  
As a vCenter i already preconfigured in the Environemnt, we can only look at the existing and change some settings

```Powershell
Get-PPDMinventory_sources -Type VCENTER -filter 'address eq "vcsa-7.demo.local"'
```

You should see the vCenter configuration now:

![Alt text](image-6.png)
