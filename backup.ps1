# Define source paths
$dotfilesSrc = "C:\Users\D2i - Desmond\.dotfiles\*"
$glzrSrc = "C:\Users\D2i - Desmond\.glzr\*"
$profileSrc = $PROFILE

# Define repo backup path
$repoPath = "C:\Users\D2i - Desmond\OneDrive - Data2improve\Desktop\scripts\.dotfiles"

# Copy .dotfiles folder content
Write-Output "Copying .dotfiles..."
Copy-Item -Path $dotfilesSrc -Destination $repoPath -Recurse -Force

# Copy .glzr folder content
Write-Output "Copying .glzr..."
Copy-Item -Path $glzrSrc -Destination (Join-Path $repoPath ".glzr") -Recurse -Force

# Copy PowerShell profile
Write-Output "Copying PowerShell profile..."
Copy-Item -Path $profileSrc -Destination (Join-Path $repoPath "Microsoft.PowerShell_profile.ps1") -Force

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
