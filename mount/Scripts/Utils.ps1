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
