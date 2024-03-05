Start-BitsTransfer "https://dl.google.com/dl/chrome/install/googlechromestandaloneenterprise64.msi" -destination "$env:TEMP\googlechromestandaloneenterprise64.msi"
Get-BitsTransfer
Start-Process msiexec.exe -ArgumentList "/I $env:TEMP\googlechromestandaloneenterprise64.msi /passive" -Verb RunAs -Wait

try {
    $ChromeInstalled = Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe'
}
catch {
    $ChromeInstalled = $false
}

if ($ChromeInstalled) { $True | Out-String }