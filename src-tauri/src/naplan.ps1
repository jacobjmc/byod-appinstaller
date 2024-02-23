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

<# DOWNLOAD AND INSTALL NAPLAN #>
if !($NaplanInstalled) {
    Start-BitsTransfer "https://pages.assessform.edu.au/uploads/files/Release/NAP%20Locked%20down%20browser%20-%20Release%20-%205.6.15.msi"  -destination "$env:USERPROFILE\Downloads\naplan_installer.msi"
    Get-BitsTransfer



Set-Location $env:USERPROFILE\Downloads

Start-Process msiexec.exe -ArgumentList "/I $env:USERPROFILE\Downloads\naplan_installer.msi /quiet" -Verb RunAs -Wait
}
    

