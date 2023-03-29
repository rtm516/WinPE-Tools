
$drives = @{}

foreach ($drive in Get-Volume) {
	if ($drive.DriveLetter -eq "") { continue }

	$drives.Add("&" + $drive.DriveLetter + ": $($drive.Size)", $drive.DriveLetter)
}

$options = ($drives.Keys + @("&Back"))
$drive = Show-Menu -Title "Copy event logs to USB" -Message "Please select a disk to copy event logs to" -Options $options

if ($options[$drive] -eq "&Back") {
	return
}

$drive = $drives[$drive]

Write-Output "Copying logs to ${drive}:\Logs\..."

# Copy the event logs to the USB drive
Copy-Item -Path "$env:OSDRIVE\Windows\System32\winevt\Logs" -Destination "${drive}:\Logs" -Recurse -Force