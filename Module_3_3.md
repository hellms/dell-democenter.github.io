
$Policy=Get-PPDMprotection_policies -filter 'name eq "Linux VM"'

$Policy.stages[0].target.dataTargetId

