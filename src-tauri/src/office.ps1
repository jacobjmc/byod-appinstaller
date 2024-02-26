try {
    $OfficeInstalled = Test-Path "HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration"
} catch {
    $OfficeInstalled = $false
}

if (-Not ($OfficeInstalled)) {
    Start-BitsTransfer "https://byod.mwsc.vic.edu.au/applications/22/download" -Destination "$env:USERPROFILE\Downloads\OfficeSetup.exe"
Get-BitsTransfer
Start-Process -FilePath "$env:USERPROFILE\Downloads\OfficeSetup.exe" -Wait
} 
