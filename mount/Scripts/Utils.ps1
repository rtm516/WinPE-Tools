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

	ForEach ($option in $options) {
		$choices += (New-Object System.Management.Automation.Host.ChoiceDescription $option)
	}

	return $host.ui.PromptForChoice($title, $message, $choices, $default)
}

Function Format-FileSize() {
    Param ([int64]$size)
    If     ($size -gt 1TB) {[string]::Format("{0:0.00} TB", $size / 1TB)}
    ElseIf ($size -gt 1GB) {[string]::Format("{0:0.00} GB", $size / 1GB)}
    ElseIf ($size -gt 1MB) {[string]::Format("{0:0.00} MB", $size / 1MB)}
    ElseIf ($size -gt 1KB) {[string]::Format("{0:0.00} kB", $size / 1KB)}
    ElseIf ($size -gt 0)   {[string]::Format("{0:0.00} B", $size)}
    Else                   {""}
}
