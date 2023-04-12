# Download PSModules from PowerShell Gallery and save them to $modulesPath

$modulesPath = "$pwd\mount\Program Files\WindowsPowerShell\Modules\"
New-Item -Path $modulesPath -ItemType Directory -Force | Out-Null

ForEach ($packageId in Get-Content '.\modules.list') {
    # Remove any version numbers
	$packageInfo = $packageId -Split '/'
    $packageName = $packageInfo[0]
	$packageVersion = if ($packageInfo.count -gt 1) { $packageInfo[1] } else { "latest" }
	$downloadPath = $modulesPath + $packageName + "\"

	Write-Output "Downloading $packageName ($packageVersion) to $downloadPath"

    # Create a temp file
    $tmpFile = New-TemporaryFile | Rename-Item -NewName { $_ -replace 'tmp$', 'zip' } -PassThru
    
    # Download and extract the package
    Invoke-WebRequest -OutFile $tmpFile -Uri "https://www.powershellgallery.com/api/v2/package/$packageId"
    $tmpFile | Expand-Archive -Force -DestinationPath $downloadPath

    # Remove the temp file
    $tmpFile | Remove-Item
}