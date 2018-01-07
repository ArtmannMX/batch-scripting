@echo off
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" /v Administrador /t REG_DWORD /d 1
net user Administrador /active:yes
