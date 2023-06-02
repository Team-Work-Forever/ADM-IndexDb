Import-Module SqlServer

Invoke-Sqlcmd -InputFile .\db_drop.sql -ServerInstance "XA-22\TP_ADM" -Database "db_index" -Encrypt Optional -Username "sa" -Password "123456" -ErrorAction 'SilentlyContinue' 
Invoke-Sqlcmd -InputFile .\db_drop.sql -ServerInstance "XA-22\TP_ADM" -Database "db_index" -Encrypt Optional -Username "sa" -Password "123456" -ErrorAction 'SilentlyContinue'
Invoke-Sqlcmd -InputFile .\db_drop.sql -ServerInstance "XA-22\TP_ADM" -Database "db_index" -Encrypt Optional -Username "sa" -Password "123456" -ErrorAction 'SilentlyContinue'

Write-Output "DB Clean"