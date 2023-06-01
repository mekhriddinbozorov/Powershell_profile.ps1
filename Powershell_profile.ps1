
function prompt {
    $p = Split-Path -Leaf -Path (Get-Location)
    Write-Host " $p" -ForegroundColor DarkBlue -NoNewline

    $branchName = $(git rev-parse --abbrev-ref HEAD 2>$null)
    if ($branchName) {
        Write-Host " (" -ForegroundColor DarkBlue -NoNewline

        Write-Host "$branchName" -ForegroundColor DarkGreen -NoNewline

        $untracked = $(git diff --stat | Measure-Object | Select-Object -ExpandProperty Count 2>$null)
        if($untracked){
            Write-Host " $($untracked-1)" -ForegroundColor DarkGray -NoNewline
        }

        $staged = $(git diff --stat --cached | Measure-Object | Select-Object -ExpandProperty Count 2>$null)
        if($staged){
            Write-Host " $($staged-1)" -ForegroundColor Yellow -NoNewline
        }

        Write-Host ")" -ForegroundColor DarkBlue -NoNewline
    }
    return " "
}
clear
