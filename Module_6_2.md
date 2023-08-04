# MODULE 6 - PROTECT KUBERNETES WORKLOAD

## LESSON 2 -RESTORE PERSISTENT VOLUME CLAIMS PROTECTED TO ALTERNATE NAMESPACE AND VALIDATE

We still have the Asset from prevous Session. If not, do

```Powershell
$Asset=Get-PPDMassets -type KUBERNETES -filter 'name eq "demo-ns"'
```

now we create our Restore Job

> namespace: test-namespace
> restore-type: to_alternate

we read the latest copy using:

```Powershell
$copyObject=$Asset | Get-PPDMlatest_copies
```

An we need the Inventory Source ID of the Kubernetes Cluster we restore to:

```Powershell
$K8S_Inventory=Get-PPDMinventory_sources -Type KUBERNETES -filter 'name eq "Cluster-01"'
```

```Powershell
Restore-PPDMK8Scopies -CopyObject $copyObject -targetInventorySourceId $K8S_Inventory.ID -TO_ALTERNATE -namespace test-namespace
```
