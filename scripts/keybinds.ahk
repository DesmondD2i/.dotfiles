; Launch or focus Chrome with Alt+B
!b:: {
    app := "C:\Program Files\Google\Chrome\Application\chrome.exe"
    Run app
}

; Launch VS Code with Alt+C
!c:: {
    app := "C:\Users\D2i - Desmond\AppData\Local\Programs\Microsoft VS Code\Code.exe"
    if WinExist("ahk_exe Code.exe") {
        WinActivate
    } else {
        Run app
    }
}

; Alt+G → Open ChatGPT in Chrome
!g:: {
    chrome := "C:\Program Files\Google\Chrome\Application\chrome.exe"
    url := "https://chatgpt.com"
    Run format('"{}" --app="{}"', chrome, url)
}

#Enter::
{
    DesktopPath := A_Desktop
    Run('wt.exe -p "PowerShell" -d "' DesktopPath '"')
    return
}

^!k:: {
    appUrl := "https://keepersecurity.eu/vault/"
    chromePath := "C:\Program Files\Google\Chrome\Application\chrome.exe"
    fuzzyTitle := "vault - desmond"

    if WinExist("ahk_exe chrome.exe ahk_class Chrome_WidgetWin_1") {
        title := WinGetTitle("A")
        if InStr(title, fuzzyTitle) {
            WinActivate()
            return
        }
    }

    Run(Format('"{1}" --app="{2}"', chromePath, appUrl))
}

; Ctrl + Alt + T
^!t:: {
    ; Path to your GUI launcher
    exe := "C:\projects\time-tracker\.venv\Scripts\pythonw.exe"
    script := "C:\projects\time-tracker\app\time_logger.py"

    ; Match the window by title — adjust if your GUI title is different
    winTitle := "Time Tracker"

    if WinExist(winTitle) {
        WinActivate
    } else {
        Run exe . " " . script
    }
}
