@echo off

:: comando para liberar espacio en la carpeta de componentes WinSxS
:: C:\Windows\WinSxS

Dism.exe /Online /Cleanup-Image /StartComponentCleanup