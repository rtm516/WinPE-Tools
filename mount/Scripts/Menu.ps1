# Change the working directory to the script directory
Set-Location -Path (Split-Path $MyInvocation.MyCommand.Path)

# Load the SLMenu module
Import-Module -Name SLMenu -Force

# Load the Utils script
Import-Module -Name .\Utils.ps1 -Force

Function Main-Menu {
	$menuItems = New-SLMenuItemList

	# Add the sub-menu items based on the folders in the current directory
	ForEach ($folder in Get-Childitem -Directory) {
		$name = $folder.Name
		$id = $menuItems.Count + 1
		$menuItems.Add((New-SLMenuItem -Key $id -Name "$name" -Data {
			Param ($name)
			Sub-Menu $name
		} -Arguments $name))
	}

	# Add the separator, shell and exit menu item
	$menuItems.Add((New-SLMenuItem -Separator))
	$menuItems.Add((New-SLMenuItem -Key 's' -Name 'Shell' -Data {
		Write-Output ""
		powershell
	}))
	$menuItems.Add((New-SLMenuItem -Key 'q' -Name 'Shutdown' -Data { exit }))

	# Show the menu
	Show-SLMenuExecute -MenuItems $menuItems -Title 'WinPE Tools' -Clear -LoopAfterChoice
}

Function Sub-Menu {
	Param (
		[Parameter(Mandatory=$true)]
		[string]$folder
	)

	# Check if the folder exists
	if (!(Test-Path -Path "$folder")) {
		Write-Error "Folder $folder does not exist!"
		return
	}


	$menuItems = New-SLMenuItemList

	# Add the sub-menu items based on the folders in the current directory
	ForEach ($script in (Get-Childitem -Path $folder)) {
		$filename = $script.Name
		$name = $filename -replace ".ps1"
		$id = $menuItems.Count + 1
		$menuItems.Add((New-SLMenuItem -Key $id -Name "$name" -Data {
			Param ($folder, $filename)
			$scriptFile = "$folder\$filename"
			. $scriptFile
		} -Arguments $folder, $filename))
	}

	# Add the separator and back menu item
	$menuItems.Add((New-SLMenuItem -Separator))
	$menuItems.Add((New-SLMenuItemQuit -Name 'Back'))

	# Show the menu
	Show-SLMenuExecute -MenuItems $menuItems -Title "$folder menu" -Clear -LoopAfterChoice
}

Main-Menu