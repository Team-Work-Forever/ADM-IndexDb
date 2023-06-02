Import-Module SqlServer

$variableName = "SQL_SERVER_INSTANCE_SCRIPT"
$Instance = [Environment]::GetEnvironmentVariable($variableName, "User")

Write-Output $Instance

$Directory = $args[0]

function FindSqlScripts {
    param (
        [string]$DirectoryPath
    )

    $sqlScriptFiles = Get-ChildItem -Path $DirectoryPath -Filter "*.sql" -Exclude "*test.sql" -File -Recurse
    $matchingScripts = @()

    foreach ($file in $sqlScriptFiles) {
        $matchingScripts += $file.FullName
    }

    return $matchingScripts
}

# Usage example
$directoryPath = $Directory
$matchingScripts = FindSqlScripts -DirectoryPath $directoryPath

if ($matchingScripts.Count -eq 0) {
    Write-Output "No scripts found that run SQL Server files."
}
else {
    Write-Output "Scripts found:"
    foreach ($script in $matchingScripts) {
        Invoke-Sqlcmd -InputFile $script -ServerInstance $Instance -Database "db_index" -Encrypt Optional -Username "sa" -Password "123456" | Out-Null
        Write-Output $script
    }
}
