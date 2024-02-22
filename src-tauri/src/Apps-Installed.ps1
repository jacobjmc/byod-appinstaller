$ChromeInstalled = Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe'
$TeamsInstalled = Get-AppxPackage -Name "MSTeams"
$OfficeInstalled = Test-Path "HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration"
$NaplanProductCode = "{8A4846B5-DF7E-442F-992E-60FE5228D31A}"
try {
    $NaplanInstalled = Get-WmiObject -Class Win32_Product | Where-Object {$_.IdentifyingNumber -eq $NaplanProductCode}
} catch {
    $NaplanInstalled = $false
}


$applications = New-Object PSObject -Property @{
    
   chrome = @{ name = "Chrome"; installed = $false; image = "https://byod.mwsc.vic.edu.au/storage/applications/imgs/Chrome.png" }
   teams = @{ name = "Teams"; installed = $false; image = "https://byod.mwsc.vic.edu.au/storage/applications/imgs/newteams.png" }
    office = @{ name = "Office"; installed = $false; image = "https://byod.mwsc.vic.edu.au/storage/applications/imgs/Office.png" }
    naplan = @{ name = "Naplan"; installed = $false; image = "https://byod.mwsc.vic.edu.au/storage/applications/imgs/NAPLAN_lg.png" }
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

if ($NaplanInstalled) {
    $applications.naplan.installed = $true
}

$applications | ConvertTo-Json

