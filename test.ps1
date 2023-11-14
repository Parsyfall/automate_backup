$time = Get-Date -UFormat %R -Minute 0 -Hour 0
$action = New-ScheduledTaskAction -Execute python3 -Argument "C:\Users\Dumitru\Git\traineeland\assignment_2\script.py"
$trigger = New-ScheduledTaskTrigger -Weekly -At $time
Write-Output $trigger

# Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Backup Script" -Description "Periodicaly back up files"
