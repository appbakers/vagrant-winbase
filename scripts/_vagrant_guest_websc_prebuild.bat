###==> powershell with Admin right

###==> installing choco
@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

###==> installing GoogleChrome firefox jdk7
start cmd.exe /c choco install -y GoogleChrome & start cmd.exe /c choco install -y firefox & start cmd.exe /c choco install -y jdk7
