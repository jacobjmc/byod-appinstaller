Start-BitsTransfer "https://papercut.com/products/ng/mobility-print/download/client/windows" -Destination "$env:USERPROFILE\Downloads\papercut_installer.exe"
Get-BitsTransfer

Start-Process "$env:USERPROFILE\Downloads\papercut_installer.exe" -erroraction silentlycontinue