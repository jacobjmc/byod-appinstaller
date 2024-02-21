$ChromeInstalled = Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe'
$TeamsInstalled = Get-AppxPackage -Name "MSTeams"
$OfficeInstalled = Test-Path "HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration"


$applications = New-Object PSObject -Property @{
    
    chrome = @{ name = "Chrome"; installed = $false }
    teams = @{ name = "Teams"; installed = $false }
    office = @{ name = "Office"; installed = $false }

}

if ($ChromeInstalled) {
    $applications.chrome.installed = $true
} else { "Chrome not installed" | Out-String }

if ($TeamsInstalled) {
    $applications.teams.installed = $true
} else { "Teams not installed" | Out-String }

if ($OfficeInstalled) {
    $applications.office.installed = $true
} else { "Office not installed" | Out-String }

$applications | ConvertTo-Json

