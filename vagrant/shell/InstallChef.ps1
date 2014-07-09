# Import function for PATH
. $env:SystemDrive\vagrant\vagrant\shell\EnsureInPath.ps1

# Determine if chef-solo installed
if (Get-Command chef-solo -ErrorAction SilentlyContinue)
{
  $ChefVersion = & chef-solo '--version'
  Write-Host "Chef $ChefVersion is installed. This process does not ensure the exact version or at least version specified, but only that Chef is installed. Exiting..."
  Exit 0
}

Write-Host 'Chef is not installed, continuing...'
 
& chocolatey install 'chef-client'

# ensuring chef bin and chef embedded bin in Machine PATH
EnsureInPath "$env:SystemDrive\opscode\bin"
EnsureInPath "$env:SystemDrive\opscode\embedded\bin"