try {
    $ChromeInstalled = Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe'
} catch {
    $ChromeInstalled = $false
}

try {
    $TeamsInstalled = Get-AppxPackage -Name "MSTeams"
} catch { 
    $TeamsInstalled = $false
}

 try {
    $OfficeInstalled = Test-Path "HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration"
} catch {
    $OfficeInstalled = $false
}

# Define the product code of the application you want to check
$NaplanProductCode = "{8A4846B5-DF7E-442F-992E-60FE5228D31A}"

# Define the registry path for 32-bit and 64-bit systems
$registryPath = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"

try {
    # Check if the product code exists in the registry
    $NaplanInstalled = Get-ItemProperty -Path $registryPath | Where-Object { $_.PSChildName -eq $NaplanProductCode }
} catch {
    $NaplanInstalled = $false
}

# Check if the printer is installed
try {
    $PapercutInstalled = Get-Printer | Where-Object { $_.Name -eq "Toshiba_FollowMe [Follow Me Queue (Login to any photocopier to release your print job)](Mobility)" }
} catch {
    $PapercutInstalled = $false
}


$applications = New-Object PSObject -Property @{
    
   chrome = @{ name = "Chrome"; installed = $false; image = "https://byod.mwsc.vic.edu.au/storage/applications/imgs/Chrome.png" }
   teams = @{ name = "Teams"; installed = $false; image = "https://byod.mwsc.vic.edu.au/storage/applications/imgs/newteams.png" }
    office = @{ name = "Office"; installed = $false; image = "https://byod.mwsc.vic.edu.au/storage/applications/imgs/Office.png" }
    papercut = @{ name = "Papercut"; installed = $false; image = "https://byod.mwsc.vic.edu.au/storage/applications/imgs/Papercut.png" }
    naplan = @{ name = "Naplan"; installed = $false; image = "https://byod.mwsc.vic.edu.au/storage/applications/imgs/NAPLAN_lg.png" }
}

if ($ChromeInstalled) {
    $applications.chrome.installed = $true
}

if ($TeamsInstalled) {
    $applications.teams.installed = $true
} 

if ($OfficeInstalled) {
    $applications.office.installed = $true
} 

if ($PapercutInstalled) {
    $applications.papercut.installed = $true
} 

if ($NaplanInstalled) {
    $applications.naplan.installed = $true
}

$applications | ConvertTo-Json

