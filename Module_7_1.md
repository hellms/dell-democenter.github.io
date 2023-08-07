# MODULE 7 - PROTECT MICROSOFT EXCHANGE WORKLOADS

## LESSON 1- REVIEW AND DISCOVER EXCHANGE DATABASES

Review the Exchange Infrastructure Sourec(es) and Assets

## Get the Exchange Host

```Powershell
$ExchangeHost=Get-PPDMhosts -type APP_HOST -filter 'details.appHost.subTypes eq "MICROSOFT_EXCHANGE_DATABASE_SYSTEM" and name -eq "exchange.demo.local"'
```

## Next, we do a Host Full Discovery


```Powershell
$ExchangeHost | Start-PPDMdiscoveries -level HOSTFULL -start hosts
```

![Alt text](image-10.png)

## Monitor the Job with:

```Powershell
Get-PPDMactivities -PredefinedFilter SYSTEM_JOBS -filter 'name lk "%exchange%"#' -pageSize 1
```

![Alt text](image-11.png)

## List the Exchange Assets for *exchange.demo.local*


```Powershell
Get-PPDMassets -type MICROSOFT_EXCHANGE_DATABASE  -filter 'details.database.clusterName eq "exchange.demo.local"' | ft
```
