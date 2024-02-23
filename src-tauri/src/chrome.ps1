try {
    $ChromeInstalled = Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe'
} catch {
    $ChromeInstalled = $false
}

if (!$ChromeInstalled) {
    Start-BitsTransfer "https://dl.google.com/dl/chrome/install/googlechromestandaloneenterprise64.msi" -destination "$env:USERPROFILE\Downloads\googlechromestandaloneenterprise64.msi"
 Get-BitsTransfer

 Start-Process msiexec.exe -ArgumentList "/I $env:USERPROFILE\Downloads\googlechromestandaloneenterprise64.msi /quiet" -Verb RunAs -Wait
}
