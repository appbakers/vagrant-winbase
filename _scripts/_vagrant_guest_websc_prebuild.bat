###==> powershell with Admin right

@call _vagrant_guest_inst_choco.bat

@call _vagrant_guest_inst_vbox_guest_additions.ps1

###==> installing GoogleChrome firefox jdk7 ie11
start cmd.exe /c choco install -y GoogleChrome & start cmd.exe /c choco install -y firefox & start cmd.exe /c choco install -y jdk7 & start cmd.exe /c choco install -y ie11

