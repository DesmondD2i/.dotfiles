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
    Run("powershell.exe -NoExit -Command Set-Location -Path '" DesktopPath "'")
    Return
}

#g::
{
    A_Clipboard := ""            ; clear clipboard
    Send("^c")                   ; copy selection
    if !ClipWait(1) {
        MsgBox("No text selected or clipboard didn't update.")
        return
    }

    search := UriEncode(A_Clipboard)
    Run("https://www.google.com/search?q=" . search)
}
return

UriEncode(str) {
    static enc := Map(
        "`%", "%25"
      , " ", "+"
      , "!", "%21"
      , "#", "%23"
      , "$", "%24"
      , "&", "%26"
      , "'", "%27"
      , "(", "%28"
      , ")", "%29"
      , "*", "%2A"
      , "+", "%2B"
      , ",", "%2C"
      , "/", "%2F"
      , ":", "%3A"
      , ";", "%3B"
      , "=", "%3D"
      , "?", "%3F"
      , "@", "%40"
      , "[", "%5B"
      , "]", "%5D"
    )

    out := ""
    for c in StrSplit(str) {
        out .= RegExMatch(c, "^[A-Za-z0-9]$") ? c
              : enc.Has(c) ? enc[c]
              : Format("%%{:02X}", Ord(c))
    }
    return out
}