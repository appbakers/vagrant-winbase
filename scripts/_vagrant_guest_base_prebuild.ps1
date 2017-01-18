###==> run with Administrator rights

###==> disable UAC
reg add HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /d 0 /t REG_DWORD /f /reg:64

###==> set First Network NIC as Private Connection(When first booted, usually the connection type was Public.)
###==> to negate security rule (Usually, Private Connection is trusted, Public Connection is not trusted)
Get-NetConnectionProfile | findstr InterfaceIndex | Select-Object -first 1 | %{$_.Split(":") } | Select-Object -first 2 | Select-Object -last 1  -outvariable netidx Set-NetConnectionProfile -InterfaceIndex $netidx -NetworkCategory Private

###==> open 5985 port for WinRM service
netsh advfirewall firewall set rule group="remote administration" new enable=yes
netsh advfirewall firewall add rule name="Open Port 5985" dir=in action=allow protocol=TCP localport=5985

winrm quickconfig -q
winrm quickconfig -transport:http
winrm set winrm/config '@{MaxTimeoutms="7200000"}'
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="0"}'
winrm set winrm/config/winrs '@{MaxProcessesPerShell="0"}'
winrm set winrm/config/winrs '@{MaxShellsPerUser="0"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/client/auth '@{Basic="true"}'

net stop winrm
sc.exe config winrm start= auto
net start winrm

