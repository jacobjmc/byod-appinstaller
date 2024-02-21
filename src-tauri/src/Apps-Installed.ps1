$Chrome = Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe'
$Teams = Get-AppxPackage -Name "MSTeams"

if ($ChromeInstalled -eq $false) {
    "Chrome not installed" | Out-String 
} else { "Chrome installed" | Out-String }

if (!$Teams) {
    "Teams not installed" | Out-String
} else { "Teams Installed" | Out-String }

