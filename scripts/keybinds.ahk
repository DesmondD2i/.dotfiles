; Launch or focus Chrome with Alt+C
!b:: {
    app := "C:\Program Files\Google\Chrome\Application\chrome.exe"
    Run app
}

; Launch VS Code with Alt+V
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
    Return
}
