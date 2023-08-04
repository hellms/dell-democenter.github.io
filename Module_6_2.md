# MODULE 6 - PROTECT KUBERNETES WORKLOAD

## LESSON 2 -RESTORE PERSISTENT VOLUME CLAIMS PROTECTED TO ALTERNATE NAMESPACE AND VALIDATE

We still have the Asset from prevous Session. If not, do

```Powershell
$Asset=Get-PPDMassets -type KUBERNETES -filter 'name eq "demo-ns"'
```

now we create our Restore Job

> namespace: test-namespace
> restore-type: to_alternate

```Powershell
Restore-PPDMK8Scopies -CopyObject $Conpy -targetInventorySourceId $StorageSystem.id -TO_ALTERNATE -namespace test-namespace
```
