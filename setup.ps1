function FindRunScripts {
    param (
        $SearchRunScripts
    )

    $scriptFiles = Get-ChildItem -Path $SearchRunScripts -Filter "*run.ps1" -File -Recurse -Exclude "tests" | Sort-Object Name

    foreach ($file in $scriptFiles) {
        Invoke-Expression -Command (".\searchSql.ps1 ola " + $file.Directory)
    }

    Write-Output "DB CREATED"
    
}

FindRunScripts .

