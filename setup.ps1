function FindRunScripts {
    param (
        $SearchRunScripts
    )

    $scriptFiles = Get-ChildItem -Path $SearchRunScripts -Filter "*run.ps1" -File -Recurse -Exclude "tests" | Sort-Object Name

    foreach ($file in $scriptFiles) {
        Invoke-Expression -Command (".\searchSql.ps1 ola " + $file.Directory)
    }

    
}

$variableName = "SQL_SERVER_INSTANCE_SCRIPT"

if (![Environment]::GetEnvironmentVariable($variableName, "User")) {
    $variableValue = Read-Host "Enter SQL Server Instance"
    [Environment]::SetEnvironmentVariable($variableName, $variableValue, "User")
    
    FindRunScripts .

}
else {
    FindRunScripts .
}
