Set-Location -Path (Split-Path $MyInvocation.MyCommand.Path)
Import-Module -Name .\Utils.ps1 -Force

Function Main-Menu {
	$folders = Get-Childitem -Directory | ForEach-Object { "&" + $_.Name }
	$options = ($folders + @("&Shell", "&Exit"))

	$option = Show-Menu -Title "WinPE Tools menu" -Message "Please select a category/tool!" -Options $options
	$option = $options[$option] -replace "&"

	switch ($option) {
		"Shell" {
			Write-Output ""
			powershell
		}
		"Exit" {
			exit
		}
		default {
			Sub-Menu $option
		}
	}
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
	
	$a = @{

	}

	$i = 0
	$scripts = @{}
	foreach ($script in (Get-Childitem -Path $folder)) {
		$i++
		$scripts.Add("&$i. " + $script.Name -replace ".ps1", $script.Name)
	}

	$options = ($scripts.Keys + @("&Back"))

	$option = Show-Menu -Title ($folder + " menu") -Message "Please select a tool!" -Options $options

	switch ($options[$option] -replace "&") {
		"Back" {
			return
		}
		default {
			$script = "$folder\$($scripts.Values[$option])"
			. $script
		}
	}
}

while ($true) {
	Main-Menu
}
