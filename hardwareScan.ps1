$basepath = 'C:\Users\a435000\Documents\'
$workstationsFile = "{0}workstations.txt" -f $basepath
$date = (Get-Date -format yyyyMMddHHmmss)
$cNmae=$env:computername
$uName = $env:USERNAME

$logFile = "{0}HardwareScan_{1}_{2}_{3}.csv" -f $basepath,$cNmae,$uName,$date

$computers = (Get-Content $workstationsFile)
cls
foreach($computer in $computers)
{
    if (Test-Connection -count 1 -computer $computer -quiet){
        Write-Host "Updating system" $computer "....." -ForegroundColor Green 
        Get-WmiObject -ComputerName $computer -Class Win32_PnPEntity | select SystemName, Manufacturer, Name, Caption, Description, Service, Status | Export-Csv $logFile -Delimiter ";" -NoTypeInformation -Append 
    } else{
	    Write-Host "System Offline " $computer "....." -ForegroundColor Red
    }
}
