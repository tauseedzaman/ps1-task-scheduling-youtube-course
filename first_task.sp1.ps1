$ServiceName="WebClient"

$TaskName="OurSecondTask"

$user = "$(hostname)\$env:USERNAME"

$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-Command start-service $ServiceName"

$tasktrigger= New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(1)

$principle= New-ScheduledTaskPrincipal -UserId $user -RunLevel Highest

$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries

$task = New-ScheduledTask -Action $action -Trigger $tasktrigger -Principal $principle -Settings $settings

Register-ScheduledTask -TaskName  $TaskName -InputObject $task -Force

write-host "$TaskName is registered"