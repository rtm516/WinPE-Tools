$utilman = "$($env:OSDRIVE):\Windows\System32\utilman.exe"
$utilmanOrig = "$($env:OSDRIVE):\Windows\System32\utilman-orig.exe"
$cmd = "$($env:OSDRIVE):\Windows\System32\cmd.exe"

# Check if -orig file exists
$enabled = Test-Path $utilmanOrig

# Show current state
Write-Output "System command prompt is currently $(If ($enabled) { 'enabled' } else { 'disabled' })"

# Ask user if they wish to toggle the state
$toggle = (Read-Host -Prompt "Do you wish to toggle the state? (y/n)") -eq "y"

# Toggle the state
if ($toggle) {
	$enabled = !$enabled

	if ($enabled) {
		# Rename utilman.exe to utilman-orig.exe
		Move-Item -Path $utilman -Destination $utilmanOrig -Force
		# Copy cmd.exe to utilman.exe
		Copy-Item -Path $cmd -Destination $utilman -Force
	} else {
		# Rename utilman-orig.exe to utilman.exe
		Move-Item -Path $utilmanOrig -Destination $utilman -Force
	}
}