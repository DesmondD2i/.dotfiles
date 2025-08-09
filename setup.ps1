# Check/install Chocolatey
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

# Install packages
choco install -y glazewm zebar lively oh-my-posh nerd-fonts-fira-code

# Setup dotfiles repo (clone or update)
$dotfilesRepo = "https://github.com/DesmondD2i/.dotfiles"
$dotfilesPath = "$HOME\.dotfiles"
if (-not (Test-Path $dotfilesPath)) {
    git clone $dotfilesRepo $dotfilesPath
} else {
    Set-Location $dotfilesPath
    git pull
}

$dotfilesPath = "$HOME\.dotfiles"
$userHome = "$HOME"
$profileDestination = "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
$fontsSource = Join-Path $dotfilesPath "fonts\0xproto"

# Clone or update repo
if (-not (Test-Path $dotfilesPath)) {
    Write-Output "Cloning dotfiles repo..."
    git clone $dotfilesRepo $dotfilesPath
} else {
    Write-Output "Updating dotfiles repo..."
    Set-Location $dotfilesPath
    git pull
}

# Copy .dotfiles content to user home (merge, overwrite)
Write-Output "Copying .dotfiles content to user folder..."
Copy-Item -Path (Join-Path $dotfilesPath ".dotfiles\*") -Destination $userHome -Recurse -Force

# Copy .glzr folder to user home (create if missing)
$glzrSrc = Join-Path $dotfilesPath ".glzr"
$glzrDest = Join-Path $userHome ".glzr"
if (-not (Test-Path $glzrDest)) { New-Item -ItemType Directory -Path $glzrDest | Out-Null }
Write-Output "Copying .glzr content to user folder..."
Copy-Item -Path (Join-Path $glzrSrc "*") -Destination $glzrDest -Recurse -Force

# Copy PowerShell profile from repo to proper location
$profileSrc = Join-Path $dotfilesPath "Microsoft.PowerShell_profile.ps1"
if (-not (Test-Path (Split-Path $profileDestination))) {
    New-Item -ItemType Directory -Path (Split-Path $profileDestination) | Out-Null
}
Write-Output "Copying PowerShell profile..."
Copy-Item -Path $profileSrc -Destination $profileDestination -Force

# Install fonts from fonts/0xproto folder
if (Test-Path $fontsSource) {
    Write-Output "Installing fonts from $fontsSource..."
    $fonts = Get-ChildItem -Path $fontsSource -Include *.ttf,*.otf -Recurse
    foreach ($font in $fonts) {
        Write-Output "Installing font $($font.Name)..."
        $fontDestination = "$env:SystemRoot\Fonts\$($font.Name)"
        Copy-Item -Path $font.FullName -Destination $fontDestination -Force
        $shellApp = New-Object -ComObject Shell.Application
        $folder = $shellApp.Namespace(0x14)  # Fonts folder
        $folder.CopyHere($font.FullName)
    }
} else {
    Write-Output "Fonts folder not found: $fontsSource"
}

Write-Output "Bootstrap complete. Restart your terminal."
