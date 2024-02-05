# MODULE 5 - PROTECT & RESTORE ORACLE DATABASE FROM POWERSHELL
# Scripted Version
## LESSON 2 - VIEW ORACLE COPIES
$Asset=Get-PPDMassets -type ORACLE_DATABASE -filter 'name eq "orcl"' 6>$null 
$Asset | Get-PPDMassetcopies | ft | Out-String
$Asset | Get-PPDMlatest_copies| Out-String
