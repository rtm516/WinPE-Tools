
function Mount-Hive {
	param(
		[Parameter(Mandatory=$true)]
		[string]$hive
	)

	# Load the hive
	$hive = $hive.ToUpper()
	$hivePath = "HKLM\Offline$hive"
	reg load "$hivePath" "$env:OSDRIVE\Windows\System32\config\$hive"

	# Set the last open location
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit" /v "Lastkey" /t REG_SZ /d "$hivePath" /f

	# Start the registry editor
	Start-Process -FilePath regedit.exe -Wait

	# Load the hive when the editor is closed
	reg unload "$hivePath"
}

$menuItems = @(
	New-SLMenuItem -Comment -Name 'Please select a registry hive to open'
	New-SLMenuItem -Key '1' -Name 'Software' -Data { Mount-Hive 'Software' }
	New-SLMenuItem -Key '2' -Name 'System' -Data { Mount-Hive 'System' }
	New-SLMenuItem -Key '3' -Name 'SAM' -Data { Mount-Hive 'SAM' }
	New-SLMenuItem -Key '4' -Name 'Security' -Data { Mount-Hive 'Security' }
	New-SLMenuItem -Separator
	New-SLMenuItemQuit -Name 'Back'
)
Show-SLMenuExecute -MenuItems $menuItems -Title 'Registry Editor' -Clear
