$menuItems = New-SLMenuItemList
$menuItems.Add((New-SLMenuItem -Comment -Name 'Please select a disk to copy event logs to'))

# Add the sub-menu items based on the folders in the current directory
ForEach ($drive in Get-Volume) {
	if ($null -eq $drive.DriveLetter) { continue }

	$name = "$($drive.DriveLetter): $(Format-FileSize $drive.Size)"
	$id = $menuItems.Count # We dont need to add 1 here because we are adding a comment
	$menuItems.Add((New-SLMenuItem -Key $id -Name "$name" -Data {
		Param ($drive)
		Write-Output "Copying logs to ${drive}:\Logs\..."

		# Copy the event logs to the USB drive
		Copy-Item -Path "$($env:OSDRIVE):\Windows\System32\winevt\Logs" -Destination "${drive}:\Logs" -Recurse -Force
	} -Arguments $drive))
}

# Add the separator, shell and exit menu item
$menuItems.Add((New-SLMenuItem -Separator))
$menuItems.Add((New-SLMenuItemQuit -Name 'Back'))

# Show the menu
Show-SLMenuExecute -MenuItems $menuItems -Title 'Copy event logs to USB' -Clear
