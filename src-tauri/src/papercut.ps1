Start-BitsTransfer "https://papercut.com/products/ng/mobility-print/download/client/windows" -Destination "$env:TEMP\papercut_installer.exe"
Get-BitsTransfer
Start-Process -FilePath "$env:TEMP\papercut_installer.exe" -Wait

