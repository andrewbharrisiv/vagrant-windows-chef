$ChefTempFolder = "$env:SystemDrive\tmp\vagrant-chef-resources"

if (-not (Test-Path $ChefTempFolder)) {
    Write-Host "Creating folder `'$ChefTempFolder`'"
    New-Item -Path "$ChefTempFolder" -ItemType Directory | Out-Null
}

# Copy-Item 'c:\vagrant\vagrant\chef\Cheffile' "$ChefTempFolder"

Push-Location "$ChefTempFolder"

# Install librarian chef
if (Get-Command librarian-chef -ErrorAction SilentlyContinue) {
    Write-Host 'Running librarian-chef update'
    & librarian-chef update
} else {
    Write-Host "Installing librarian chef"
    & gem install librarian-chef --no-ri --no-rdoc

    Write-Host "Running librarian-chef install"
    & librarian-chef install --clean
}

Pop-Location
