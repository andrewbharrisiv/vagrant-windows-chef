# Import function for PATH
. $env:SystemDrive\vagrant\vagrant\shell\EnsureInPath.ps1

# determine if chocolatey installed
if (Get-Command chocolatey -ErrorAction SilentlyContinue) {    
  Write-Host "Chocolatey is installed. This process does not ensure the exact version or at least version specified, but only that ruby is installed. Exiting..."
  Exit 0
}

$ChocoInstallPath = "$env:SystemDrive\Chocolatey\bin"

# Put chocolatey on the MACHINE path, vagrant does not have access to user environment variables
EnsureInPath $ChocoInstallPath

# Install chocolatey
iex ((new-object net.webclient).DownloadString('http://chocolatey.org/install.ps1'))
