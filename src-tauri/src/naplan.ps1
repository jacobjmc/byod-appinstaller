Start-BitsTransfer "https://pages.assessform.edu.au/uploads/files/Release/NAP%20Locked%20down%20browser%20-%20Release%20-%205.6.15.msi"  -destination "$env:TEMP\naplan_installer.msi"
Get-BitsTransfer
Start-Process msiexec "/I $env:TEMP\naplan_installer.msi /passive" -Verb RunAs -Wait

    

