Function EnsureInPath {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true,Position=0)]
        [string]$PathToMatch = '',
        [Parameter(Mandatory=$false,Position=1)]
        [switch]$SystemPath = $true
    )
    
    # ensure valid parameter
    if (-not [System.String]::IsNullOrWhitespace($PathToMatch)) {

        # Get path info from PathToMatch parameter
        $pathInfo = Get-Item -Path $PathToMatch | Select-Object -First 1
        $literalPath = $pathInfo.FullName
        $lowerLiteralPath = $literalPath.ToLower()
        Write-Host "literalPath: $literalPath"
        Write-Host "lowerLiteralPath: $lowerLiteralPath"

        # scope path level
        $pathLevel = [System.EnvironmentVariableTarget]::Machine
        if ( -not $SystemPath ) {
            $pathLevel = [System.EnvironmentVariableTarget]::User
        }

        # Get path environmental variable
        $actualPath = [Environment]::GetEnvironmentVariable('Path', $pathLevel)
        $lowerActualPath = $actualPath.ToLower()
        Write-Host "actualPath: $actualPath"
        Write-Host "lowerActualPath: $lowerActualPath"

        # check path
        if (-not ($lowerActualPath -contains $lowerLiteralPath)) {
            Write-Host "PATH environment variable does not have `'$literalPath`' in it. Adding..."

            # format new path for addition to enviroment variable
            $statementTerminator = ';'
            $hasStatementTerminator = ($actualPath -ne $null) -and ($actualPath.EndsWith($statementTerminator))
            if ((-not $hasStatementTerminator) -and ($actualPath -ne $null)) {
              $literalPath = $statementTerminator + $literalPath
            }

            # update path enviroment variable
            [Environment]::SetEnvironmentVariable('Path', $actualPath + $literalPath, $pathLevel)
        }
    }
}