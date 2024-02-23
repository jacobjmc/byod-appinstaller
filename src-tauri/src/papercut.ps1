# Check if the printer is installed
try {
    $PapercutInstalled = Get-Printer | Where-Object { $_.Name -eq "Toshiba_FollowMe [Follow Me Queue (Login to any photocopier to release your print job)](Mobility)" }
} catch {
    $PapercutInstalled = $false
}

if !($PapercutInstalled) {
    Start-BitsTransfer "https://papercut.com/products/ng/mobility-print/download/client/windows" -Destination "$env:USERPROFILE\Downloads\papercut_installer.exe"
    Get-BitsTransfer
    
    Start-Process -FilePath "$env:USERPROFILE\Downloads\papercut_installer.exe" -Wait
} 
