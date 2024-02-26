Start-BitsTransfer "https://pages.assessform.edu.au/uploads/files/Release/NAP%20Locked%20down%20browser%20-%20Release%20-%205.6.15.msi"  -destination "$env:USERPROFILE\Downloads\naplan_installer.msi"
Get-BitsTransfer
Set-Location $env:USERPROFILE\Downloads
Start-Process msiexec.exe -ArgumentList "/I $env:USERPROFILE\Downloads\naplan_installer.msi /quiet" -Verb RunAs -Wait

    

