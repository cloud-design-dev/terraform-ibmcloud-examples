#ps1_sysnative
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;
Invoke-WebRequest -Uri https://raw.githubusercontent.com/IBM-Bluemix/developer-tools-installer/master/windows-installer/idt-win-installer.ps1 -OutFile idt-win-installer.ps1 -UseBasicParsing;

Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux;
Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile Ubuntu.appx -UseBasicParsing;
Rename-Item .\Ubuntu.appx .\Ubuntu.zip;
Expand-Archive .\Ubuntu.zip .\Ubuntu;
