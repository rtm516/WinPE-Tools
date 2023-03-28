function Test-Menu () {
	$title = "Backup"
	$message = "Please select resources for backup!"
	$option1 = New-Object System.Management.Automation.Host.ChoiceDescription "Personal &amp;Account", "Account"
	$option2 = New-Object System.Management.Automation.Host.ChoiceDescription "Personal &amp;Folder", "Folder"
	$option3 = New-Object System.Management.Automation.Host.ChoiceDescription "Personal &amp;Database", "Database"
	$option4 = New-Object System.Management.Automation.Host.ChoiceDescription "&amp;Public Folder", "Public"
	$options = [System.Management.Automation.Host.ChoiceDescription[]]($option1, $option2, $option3, $option4)
	$backup=$host.ui.PromptForChoice($title, $message, $options, [int[]](1))
}

Function Show-Menu {
	Param (
		[Parameter(Mandatory=$true)]
		[string]$title,
		[Parameter(Mandatory=$true)]
		[string]$message,
		[Parameter(Mandatory=$true)]
		[string[]]$options,
		[Parameter(Mandatory=$false)]
		[int]$default = -1
	)
	
	$choices = [System.Management.Automation.Host.ChoiceDescription[]]@()

	foreach ($option in $options) {
		$choices += (New-Object System.Management.Automation.Host.ChoiceDescription $option)
	}

	return $host.ui.PromptForChoice($title, $message, $choices, $default)
}
