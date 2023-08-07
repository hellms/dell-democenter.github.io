# MODULE 7 - PROTECT MICROSOFT EXCHANGE WORKLOADS

## LESSON 1- REVIEW AND DISCOVER EXCHANGE DATABASES

Review the Exchange Infrastructure Sourec(es)

```Powershell
$ExchangeHost=Get-PPDMhosts -type APP_HOST -filter 'details.appHost.subTypes eq "MICROSOFT_EXCHANGE_DATABASE_SYSTEM" and name -eq "exchange.demo.local"'
```

## Next, we do a Host Full Discovery

![Alt text](image-10.png)

## Monitor the Job with:


![Alt text](image-11.png)