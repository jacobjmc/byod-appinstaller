# Start-BitsTransfer "https://aka.ms/getwinget" -Destination "$env:TEMP\wingetInstaller.msixbundle"
# Get-BitsTransfer
# Add-AppxPackage -Path "$env:TEMP\wingetInstaller.msixbundle"

# Start-Process winget.exe -ArgumentList "install --id=Microsoft.Office -e -h --accept-source-agreements --accept-package-agreements" -WindowStyle Hidden
# Start-Sleep -Seconds 3
# Get-Process * | Set-WindowState -State Minimize -ErrorAction SilentlyContinue

Start-BitsTransfer "https://byod.mwsc.vic.edu.au/applications/22/download" -Destination "$env:TEMP\OfficeSetup.exe"
Get-BitsTransfer
Start-Process -FilePath "$env:TEMP\OfficeSetup.exe"

try {
    $OfficeInstalled = Test-Path "HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration"
}
catch {
    $OfficeInstalled = $false
}

if ($OfficeInstalled) { $True | Out-String }


