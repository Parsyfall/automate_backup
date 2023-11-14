param (
    # Path to script
    [Parameter(Mandatory)]
    [string] $path,
    
    # Daily
    [Parameter()]
    [switch] $daily,
    
    # Minutes
    [Parameter()]
    [int] $m = 0,
    
    # Hour
    [Parameter()]
    [int] $h = 0,

    # At which day interval to run, default 1 (every day)
    [Parameter()]
    [int] $dayInterval = 1,

    # Weelky
    [Parameter()]
    [switch] $weekly,
    
    # In which days to run, by default on Mondays
    [Parameter()]
    [string[]] $daysOfWeek = @("Monday"),

    # At which week interval to run, default 1 (each week)
    [Parameter()]
    [int] $weekInterval = 1
)

if ($weekly -and $daily) {
    Write-Error "-weekly and -daily arguments are incompatible, use only one of them"
    exit -1
}

$time = Get-Date -UFormat %R -Minute $m -Hour $h    # Display time in 24h format
$daysOfWeek = $daysOfWeek -split ','    # Split string to array

if ($daily) {
    $trigger = New-ScheduledTaskTrigger -Daily -DaysInterval $dayInterval -At $time
}
elseif ($weekly) {
    $trigger = New-ScheduledTaskTrigger -Weekly -WeeksInterval $weekInterval -DaysOfWeek $daysOfWeek -At $time
}

$action = New-ScheduledTaskAction -Execute python3 -Argument $path

Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Backup Script" -Description "Periodicaly back up files"