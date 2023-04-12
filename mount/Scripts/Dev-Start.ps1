# This script should be run to setup the development environment for the project.
# Please run Download-PSModules.ps1 before running this script.

$winpePSModules = Resolve-Path "$pwd\..\Program Files\WindowsPowerShell\Modules\"

$env:PSModulePath = $env:PSModulePath + ";" + $winpePSModules

. "./Menu.ps1"