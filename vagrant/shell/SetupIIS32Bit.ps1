# import needed PS module
Import-Module WebAdministration

# set app pool to 32 bit mode
Set-ItemProperty 'IIS:/AppPools/DefaultAppPool' -Name enable32BitAppOnWin64 -Value true