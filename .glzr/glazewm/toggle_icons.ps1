# toggle_desktop_icons_ui.ps1
param(
  [int]$ShortDelayMs = 120,
  [int]$MediumDelayMs = 220
)

$ws = New-Object -ComObject WScript.Shell
function SendKeys($s) { $ws.SendKeys($s) }

Add-Type @"
using System;
using System.Runtime.InteropServices;
public static class K {
    [DllImport("user32.dll")] public static extern void keybd_event(byte bVk, byte bScan, uint dwFlags, UIntPtr dwExtraInfo);
    public const uint KEYEVENTF_KEYUP = 0x0002;
    public const byte VK_LWIN = 0x5B;
}
"@

function PressWinPlus([string]$key) {
    [K]::keybd_event([K]::VK_LWIN, 0, 0, [UIntPtr]::Zero)
    Start-Sleep -Milliseconds 60
    SendKeys($key)
    Start-Sleep -Milliseconds 60
    [K]::keybd_event([K]::VK_LWIN, 0, [K]::KEYEVENTF_KEYUP, [UIntPtr]::Zero)
}

# Show desktop
PressWinPlus("d")
Start-Sleep -Milliseconds $ShortDelayMs

# Open desktop context menu
SendKeys("+{F10}")
Start-Sleep -Milliseconds $ShortDelayMs

# Open View (English: 'v') then toggle Show desktop icons (English: 's')
SendKeys("v")
Start-Sleep -Milliseconds $ShortDelayMs
SendKeys("s")
Start-Sleep -Milliseconds $MediumDelayMs

# Restore previous windows
PressWinPlus("d")
