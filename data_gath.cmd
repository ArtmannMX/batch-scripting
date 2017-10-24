@echo off
:: 
:: 
:: 
:: 
::
::
title PC Soluciones - Servicio Tecnico
color 0a
set/p letter=Letra=
if exist %letter%:\REPORTES\db (goto continuar) else (goto cdb)
::
::
:cdb
echo.
echo ---------------------
echo creando base de datos 
echo --------------------- 
echo.
md %letter%:\REPORTES\db
attrib +H %letter%:\REPORTES\db
echo creado!
::
::
:continuar
echo.
echo.
echo --------------
echo base de datos:
echo --------------
echo.
dir %letter%:\REPORTES\db
pause
set/p user=Nombre de Usuario=
if exist %letter%:\REPORTES\db\%user%.txt (goto continuar2) else (echo %user% > %letter%:\REPORTES\db\%user%.txt)
:continuar2
set userd=%COMPUTERNAME%_%USERNAME%
::
::
::Crea el folder reportes si no existe
if exist %letter%:\REPORTES\ (
	echo.
	echo.
	echo ----------------------------------------------
	echo ya existe el folder REPORTES, proseguiremos...
	echo ----------------------------------------------
	) else (md %letter%\REPORTES\ & echo listo!)
::
::
:: Crea el folder de usuario si no existe
if exist %letter%:\REPORTES\%user%\ (
	echo.
	echo.
	echo --------------------------------------------
	echo ya existe el folder %user%, proseguiremos...
	echo --------------------------------------------
	) else (md %letter%:\REPORTES\%user% & echo %user% > %letter%:\REPORTES\db\%user%.txt)
::
::
:: BASE DE DATOS

::
::
:: Crea el folder de equipo si no existe
if exist %letter%:\REPORTES\%user%\%userd%\ (
	echo.
	echo. 
	echo ---------------------------------------------
	echo ya existe el folder %userd%, proseguiremos...
	echo ---------------------------------------------
	) else (md %letter%:\REPORTES\%user%\%userd%\ & echo listo!)
::
::
:: Crea carpeta sysinfo si no existe
if exist %letter%:\REPORTES\%user%\%userd%\SYSINFO\ (
	echo.
	echo. 
	echo ---------------------------------------------
	echo ya existe el folder SYSINFO, proseguiremos...
	echo ---------------------------------------------
	) else (md %letter%:\REPORTES\%user%\%userd%\SYSINFO\ & echo Listo!)
::
::
:: Crea carpeta de netinfo si no existe
if exist %letter%:\REPORTES\%user%\%userd%\NETINFO\ (
	echo.
	echo. 
	echo ---------------------------------------------
	echo ya existe el folder NETINFO, proseguiremos...
	echo ---------------------------------------------
	) else (md %letter%:\REPORTES\%user%\%userd%\NETINFO\ & echo listo!)
::
::
:: Crea carpeta de wifidata si no existe
if exist %letter%:\REPORTES\%user%\%userd%\NETINFO\WiFiData\ (
	echo.
	echo.
	echo ----------------------------------------------
	echo Ya existe el folder WiFiData, proseguiremos...
	echo ----------------------------------------------
	echo.
	) else (md %letter%:\REPORTES\%user%\%userd%\NETINFO\WiFiData\ & echo listo!) 
::
::
:: Crea carpeta de export si no existe
if exist %letter%:\REPORTES\%user%\%userd%\NETINFO\WiFiData\export\ (
	echo.
	echo.
	echo --------------------------------------------
	echo Ya existe el folder export, proseguiremos...
	echo --------------------------------------------
	echo.
	) else (md %letter%:\REPORTES\%user%\%userd%\NETINFO\WiFiData\export\ & echo listo!) 
::
::
:: IPCONFIG
ipconfig > %letter%:\REPORTES\%user%\%userd%\NETINFO\ipconfig.txt
:: Configuracion del archivo del perfil de red
set wififile=%letter%:\REPORTES\%user%\%userd%\NETINFO\WiFiData\WFCon_%date:~-4,4%%date:~-7,2%%date:~-10,2%_%time:~0,2%%time:~3,2%%time:~6,2%.txt
echo.
echo.
echo -------------------------------------
echo Copiando información de netsh wlan...
echo espere un momento...
echo -------------------------------------
::
::
:: Todo este bloque se escribirá en el archivo
	echo. > %wififile%
	echo --------------------------------------------- >> %wififile%
	echo Información de conexiónes de red inalámbricas >> %wififile%
	echo de la computadora %COMPUTERNAME% y el usuario >> %wififile%
	echo               %USERNAME% >> %wififile%
	echo Ruta de usuario: %USERPROFILE% >> %wififile%
	echo --------------------------------------------- >> %wififile%
	echo. >> %wififile%
	echo. >> %wififile%
	netsh wlan show profiles >> %wififile%
	echo. >> %wififile%
	netsh wlan show interfaces >> %wififile%
	echo. >> %wififile%
	netsh wlan show drivers >> %wififile%
	echo. >> %wififile%
	netsh wlan show wirelesscapabilities >> %wififile%
	echo. >> %wififile%
:: fin del bloque
::
::
:: Aqui exportamos todos los perfiles de conexion inalámbricas 
:: existentes.
netsh wlan export profile key=clear folder="%letter%:\REPORTES\%user%\%userd%\NETINFO\WiFiData\export"
::
::
:: Fin del script
::
::
echo.
echo.
echo ----------------------------------
echo Decodificando el DMI del equipo...
echo ----------------------------------
%letter%:\Programas\SOPORTE_TECNICO\dmidecode.exe > %letter%:\REPORTES\%user%\%userd%\SYSINFO\dmidecode.txt
systeminfo > %letter%:\REPORTES\%user%\%userd%\SYSINFO\sysinfo.txt
cls
echo. 
echo.
echo ------
echo Listo!
echo ------
echo.
echo.
pause
