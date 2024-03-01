Start-BitsTransfer "https://dl.google.com/dl/chrome/install/googlechromestandaloneenterprise64.msi" -destination "$env:TEMP\googlechromestandaloneenterprise64.msi"
Get-BitsTransfer
Start-Process msiexec.exe -ArgumentList "/I $env:TEMP\googlechromestandaloneenterprise64.msi /passive" -Verb RunAs -Wait
