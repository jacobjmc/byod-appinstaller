
if !($TeamsInstalled) {
    Start-BitsTransfer "https://go.microsoft.com/fwlink/?linkid=2196106&clcid=0xc09&culture=en-au&country=au" -destination "$env:USERPROFILE\Downloads\MSTeams-x64.msix"
Get-BitsTransfer
Add-AppxPackage -Path "$env:USERPROFILE\Downloads\MSTeams-x64.msix"
} 

