
<# DOWNLOAD AND INSTALL APPS
Start-BitsTransfer "https://go.microsoft.com/fwlink/?linkid=2196106&clcid=0xc09&culture=en-au&country=au", "https://dl.google.com/dl/chrome/install/googlechromestandaloneenterprise64.msi", "https://pages.assessform.edu.au/uploads/files/Release/NAP%20Locked%20down%20browser%20-%20Release%20-%205.6.15.msi"  -destination "$env:USERPROFILE\Downloads\MSTeams-x64.msix", "$env:USERPROFILE\Downloads\googlechromestandaloneenterprise64.msi", "$env:USERPROFILE\Downloads\naplan_installer.msi"
Get-BitsTransfer

winget settings --enable InstallerHashOverride

start-process winget.exe -NoNewWindow -ArgumentList "install --id Microsoft.Office -h --accept-package-agreements --accept-source-agreements"


Add-AppxPackage -Path "$env:USERPROFILE\Downloads\MSTeams-x64.msix"

Set-Location $env:USERPROFILE\Downloads

Start-Process msiexec.exe -Wait -ArgumentList '/I googlechromestandaloneenterprise64.msi /quiet'

Start-Process msiexec.exe -Wait -ArgumentList '/I naplan_installer.msi /quiet'
Get-BitsTransfer

Invoke-WebRequest -Uri "https://papercut.com/products/ng/mobility-print/download/client/windows" -Outfile "$env:USERPROFILE\Downloads\papercut_installer.exe"

write-host $PSScriptRoot

Start-Process "$env:USERPROFILE\Downloads\papercut_installer.exe" -erroraction silentlycontinue #>
