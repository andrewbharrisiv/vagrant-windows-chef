# Import function for PATH
. $env:SystemDrive\vagrant\vagrant\shell\EnsureInPath.ps1

# determine if ruby installed
if (Get-Command ruby -ErrorAction SilentlyContinue)
{
  $RubyVersion = & ruby '--version'
  Write-Host "Ruby $RubyVersion is installed. This process does not ensure the exact version or at least version specified, but only that ruby is installed. Exiting..."
  Exit 0
}

Write-Host 'Ruby is not installed, continuing...'
 
& chocolatey install 'ruby1.9'

# ensuring ruby in Machine PATH
EnsureInPath "$env:SystemDrive/ruby*/bin"