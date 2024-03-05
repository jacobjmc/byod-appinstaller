Start-BitsTransfer "https://go.microsoft.com/fwlink/?linkid=2196106&clcid=0xc09&culture=en-au&country=au" -destination "$env:TEMP\MSTeams-x64.msix"
Get-BitsTransfer
Add-AppxPackage -Path "$env:TEMP\MSTeams-x64.msix"


try {
    $TeamsInstalled = Get-AppxPackage -Name "MSTeams"
}
catch { 
    $TeamsInstalled = $false
}

if ($TeamsInstalled) { $True | Out-String }