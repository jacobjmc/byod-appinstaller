Start-BitsTransfer "https://pages.assessform.edu.au/uploads/files/Release/NAP%20Locked%20down%20browser%20-%20Release%20-%205.8.19.msi"  -destination "$env:TEMP\naplan_installer.msi"
Get-BitsTransfer
Start-Process msiexec "/I $env:TEMP\naplan_installer.msi /passive" -Verb RunAs -Wait

# Define the product code of the application you want to check
$NaplanProductCode = "{74C4ACE7-0DEC-44FB-B366-C4573FB80D52}"

# Define the registry path for 32-bit and 64-bit systems
$registryPath = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"

try {
    # Check if the product code exists in the registry
    $NaplanInstalled = Get-ItemProperty -Path $registryPath | Where-Object { $_.PSChildName -eq $NaplanProductCode }
}
catch {
    $NaplanInstalled = $false
}

if ($NaplanInstalled) { $True | Out-String }
    

