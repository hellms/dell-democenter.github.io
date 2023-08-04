# MODULE 6 - PROTECT KUBERNETES WORKLOAD

## LESSON 2 - RESTORE PERSISTENT VOLUME CLAIMS PROTECTED TO ALTERNATE NAMESPACE AND VALIDATE

Now we create our Restore Job
> asset: demo-ns
> restore namespace: test-namespace
> restore-type: to_alternate
> Target Cluster Cluster-01

## Read the Asset:

We still have the Asset from prevous Session. If not, do

```Powershell
$Asset=Get-PPDMassets -type KUBERNETES -filter 'name eq "demo-ns"'
```

## Get Latest Copy

we read the latest copy using:

```Powershell
$copyObject=$Asset | Get-PPDMlatest_copies
```

## Get Inventory Source for Restore Target

An we need the Inventory Source ID of the Kubernetes Cluster we restore to:

```Powershell
$K8S_Inventory=Get-PPDMinventory_sources -Type KUBERNETES -filter 'name eq "Cluster-01"'
```

```Powershell
Restore-PPDMK8Scopies -CopyObject $copyObject -targetInventorySourceId $K8S_Inventory.ID -TO_ALTERNATE -namespace test-namespace
```

![Alt text](image-8.png)

Monitor the Activity

```Powershell
Get-PPDMactivities -filter 'category eq "RESTORE"' -pageSize 2
```

![Alt text](image-9.png)


[<<Module 6 Lesson 1](./Module_6_1.md) This Concludes Module 6 Lesson 2 [Module 6 Lesson 1>>](./Module_6_1.md)