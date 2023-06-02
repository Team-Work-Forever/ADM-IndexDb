Import-Module SqlServer

$variableName = "SQL_SERVER_INSTANCE_SCRIPT"
$Instance = [Environment]::GetEnvironmentVariable($variableName, "User")

function restore {

    Invoke-Sqlcmd -InputFile .\db_drop.sql -ServerInstance $Instance -Database "db_index" -Encrypt Optional -Username "sa" -Password "123456" -ErrorAction 'SilentlyContinue' 
    Invoke-Sqlcmd -InputFile .\db_drop.sql -ServerInstance $Instance -Database "db_index" -Encrypt Optional -Username "sa" -Password "123456" -ErrorAction 'SilentlyContinue'
    Invoke-Sqlcmd -InputFile .\db_drop.sql -ServerInstance $Instance -Database "db_index" -Encrypt Optional -Username "sa" -Password "123456" -ErrorAction 'SilentlyContinue'
    
    Write-Output "DB Clean"
    
}

if (![Environment]::GetEnvironmentVariable($variableName, "User")) {
    $variableValue = Read-Host "Write your SQL Server Instance"

    [Environment]::SetEnvironmentVariable($variableName, $variableValue, "User")

    restore 
}
else {
    restore
}
