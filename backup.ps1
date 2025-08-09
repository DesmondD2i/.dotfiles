# Define source paths
$dotfilesSrc = "C:\Users\D2i - Desmond\.dotfiles\*"
$glzrSrc = "C:\Users\D2i - Desmond\.glzr\*"
$profileSrc = "C:\Users\D2i - Desmond\OneDrive - Data2improve\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"


# Define repo backup path
$repoPath = "C:\Users\D2i - Desmond\OneDrive - Data2improve\Desktop\scripts\.dotfiles"

# Copy .dotfiles folder content
Write-Output "Copying .dotfiles..."
Copy-Item -Path $dotfilesSrc -Destination $repoPath -Recurse -Force

# Copy .glzr folder content
Write-Output "Copying .glzr..."
$glzrDest = Join-Path $repoPath ".glzr"
if (-Not (Test-Path $glzrDest)) {
    New-Item -ItemType Directory -Path $glzrDest | Out-Null
}
Copy-Item -Path $glzrSrc -Destination $glzrDest -Recurse -Force

# Copy PowerShell profile
Write-Output "Copying PowerShell profile..."
if (Test-Path $profileSrc) {
    Copy-Item -Path $profileSrc -Destination (Join-Path $repoPath "Microsoft.PowerShell_profile.ps1") -Force
} else {
    Write-Output "Profile file not found at $profileSrc — skipping copy."
}

# Change directory to repo
Set-Location $repoPath

# Git add, commit, push 
Write-Output "Adding changes to git..."
git add .

Write-Output "Committing changes..."
git commit -m "Backup: updated dotfiles, glzr config, and PowerShell profile"

Write-Output "Pushing to remote..."
git push

Write-Output "Backup complete."
