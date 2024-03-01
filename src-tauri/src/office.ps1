Start-BitsTransfer "https://byod.mwsc.vic.edu.au/applications/22/download" -Destination "$env:TEMP\OfficeSetup.exe"
Get-BitsTransfer
Start-Process -FilePath "$env:TEMP\OfficeSetup.exe"

