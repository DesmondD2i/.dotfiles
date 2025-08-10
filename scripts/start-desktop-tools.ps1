# start-desktop-tools.ps1

function Wait-ForProcess {
    param (
        [string]$ProcessName
    )
    while (-not (Get-Process -Name $ProcessName -ErrorAction SilentlyContinue)) {
        Start-Sleep -Seconds 1
    }
}

# Wait for Explorer and DWM
Write-Host "Waiting for Explorer..."
Wait-ForProcess "explorer"

Write-Host "Waiting for DWM..."
Wait-ForProcess "dwm"

Start-Sleep -Seconds 3  # stability buffer

# Start GlazeWM if not running
if (-not (Get-Process -Name "glazewm" -ErrorAction SilentlyContinue)) {
    Start-Process "C:\Program Files\glzr.io\GlazeWM\cli\glazewm.exe"
    Start-Sleep -Seconds 10
}

# Start Lively via shell protocol to avoid version path issues
if (-not (Get-Process -Name "Lively.UI.WinUI" -ErrorAction SilentlyContinue)) {
    Start-Process "shell:AppsFolder\12030rocksdanister.LivelyWallpaper_97hta09mmv6hy!App"
    Start-Sleep -Seconds 10
}

# Start AutoHotkey script if not running
if (-not (Get-Process -Name "AutoHotkey" -ErrorAction SilentlyContinue)) {
    Start-Process "C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe" -ArgumentList '"C:\Users\D2i - Desmond\.dotfiles\scripts\keybinds.ahk"'
}
