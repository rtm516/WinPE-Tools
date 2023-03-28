
$hives = @(
	"S&oftware",
	"S&ystem",
	"S&AM",
	"S&ecurity"
)

$options = ($hives + @("&Back"))
$hive = Show-Menu -Title "Registry" -Message "Please select a registry hive to open" -Options $options

if ($options[$hive] -eq "&Back") {
	return
}

# Load the hive
$hive = ($options[$hive] -replace "&").ToUpper()
$hivePath = "HKLM\Offline$hive"
reg load "$hivePath" "$env:SYSTEMDRIVE\Windows\System32\config\$hive"

# Set the last open location
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit" /v "Lastkey" /t REG_SZ /d "$hivePath" /f

# Start the registry editor
Start-Process -FilePath regedit.exe -Wait

# Load the hive when the editor is closed
reg unload "$hivePath"
