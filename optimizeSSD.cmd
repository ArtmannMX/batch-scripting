@echo off
color 0c
::mode con: cols=160 lines=78
goto :inicio
::
:: Optimizacion de disco de estado solido
:: Contiene las siguientes configuraciones:
:: Habilitacion de AHCI
:: Habilitacion de comando TRIM
:: Deshabilitacion de Superfetch y prefetch
:: hibernacion del equipo
::
::
:: INICIO
:inicio
cls
echo --------------------------------------------------------------------
echo  Script de Optimizacion de discos de estado solido (ssd) en windows
echo                   PCS Tecno Servicio El refugio Cd. Fdz.
echo --------------------------------------------------------------------
echo.
echo.
echo Selecciona una de las siguientes opciones:
echo.
echo 1 - Habilitacion de AHCI
echo 2 - Habilitacion de TRIM
echo 3 - Deshabilitacion de prefetch y superfetch
echo 4 - Deshabilitacion de hibernacion del equipo
echo 5 - Evitar apagar el disco  por inactividad
ECHO 6 - Deshabilitar cache de escritura en SSD
echo 0 - Salir
echo.
set/p opcion= opcion =
if %opcion% == 1 goto :1
if %opcion% == 2 goto :2
if %opcion% == 3 goto :3
if %opcion% == 4 goto :4
if %opcion% == 5 goto :5
if %opcion% == 6 goto :6
if %opcion% == 0 goto :EOF
::
::
:: PROCESO 1
:1
cls
echo --------------------
echo Habilitacion de AHCI
echo --------------------
echo.
echo los valores de registro deben de ser igual a cero (0):
echo.
REG QUERY HKLM\SYSTEM\CurrentControlSet\Services\iaStorV /v Start
set /p r1= cambiar? [s]i [n]o =
if %r1% == s (
	REG ADD HKLM\SYSTEM\CurrentControlSet\Services\iaStorV /v Start /d 0
	)
cls
echo --------------------
echo Habilitacion de AHCI
echo --------------------
echo.
echo los valores de registro deben de ser igual a cero (0):
echo.
REG QUERY HKLM\SYSTEM\CurrentControlSet\Services\iaStorV\StartOverride /v 0
set /p r2= cambiar? [s]i [n]o =
if %r2% == s (
	REG ADD HKLM\SYSTEM\CurrentControlSet\Services\iaStorV\StartOverride /v 0 /d 0
	)
cls
echo --------------------
echo Habilitacion de AHCI
echo --------------------
echo.
echo los valores de registro deben de ser igual a cero (0):
echo.
REG QUERY HKLM\SYSTEM\CurrentControlSet\Services\iaStorAV /v Start
set /p r3= cambiar? [s]i [n]o =
if %r3% == s (
	REG ADD HKLM\SYSTEM\CurrentControlSet\Services\iaStorAV /v Start /d 0
	)
cls
echo --------------------
echo Habilitacion de AHCI
echo --------------------
echo.
echo los valores de registro deben de ser igual a cero (0):
echo.
REG QUERY HKLM\SYSTEM\CurrentControlSet\Services\iaStorAV\StartOverride /v 0
set /p r4= cambiar? [s]i [n]o =
if %r4% == s (
	REG ADD HKLM\SYSTEM\CurrentControlSet\Services\iaStorAV\StartOverride /v 0 /d 0
	)
cls
echo --------------------
echo Habilitacion de AHCI
echo --------------------
echo.
echo los valores de registro deben de ser igual a cero (0):
echo.
REG QUERY HKLM\SYSTEM\CurrentControlSet\Services\storahci /v Start
set /p r5= cambiar? [s]i [n]o =
if %r5% == s (
	REG ADD HKLM\SYSTEM\CurrentControlSet\Services\storahci /v Start /d 0
	)
cls
echo --------------------
echo Habilitacion de AHCI
echo --------------------
echo.
echo los valores de registro deben de ser igual a cero (0):
echo.
REG QUERY HKLM\SYSTEM\CurrentControlSet\Services\storahci\StartOverride /v 0
set /p r6= cambiar? [s]i [n]o =
if %r6% == s (
	REG ADD HKLM\SYSTEM\CurrentControlSet\Services\storahci\StartOverride /v 0 /d 0
	)
cls
echo --------------------
echo Habilitacion de AHCI
echo --------------------
echo.
echo los valores de registro deben de ser igual a cero (0):
echo.
echo Oprime cualquier tecla para regresar al menu principal...
pause>nul
goto :inicio
::
::
:: PROCESO 2
:2
cls
echo --------------------
echo Habilitacion de TRIM
echo --------------------
echo.
echo El valor debe ser igual a cero (0)
fsutil behavior query DisableDeleteNotify
set /p r7= cambiar [s]i [n]o = 
if %r7% == s (
cls
fsutil behavior set DisableDeleteNotify 0
echo Se ha cambiado el valor a cero, presiona cualquier tecla para continuar
pause
goto :inicio
) else goto :inicio
::
::
:: PROCESO 3
:3
cls
echo ----------------------------------------
echo Deshabilitacion de Superfetch y prefetch
echo ----------------------------------------
echo.
echo los valores de registro deben ser igual a cero (0)
echo.
REG QUERY "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher
set /p r8= cambiar [s]i [n]o =
if %r8% == s (
	REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /d 0
	)
cls
echo ----------------------------------------
echo Deshabilitacion de Superfetch y prefetch
echo ----------------------------------------
echo.
echo Se mostrará el estatus del servicio superfetch
echo.
sc query SysMain
echo.
echo Quieres deshabilitar superfetch?
set/p r9=[s]í [n]o =   
if %r9% == s (
	sc stop SysMain
	sc config SysMain start=disabled
	) else goto :inicio
pause
cls
echo ----------------------------------------
echo Deshabilitacion de Superfetch y prefetch
echo ----------------------------------------
echo.
echo Se mostrará el estatus del servicio superfetch
echo.
sc query SysMain
echo.
pause
goto :inicio
::
::
:: PROCESO 4
:4
cls
echo -----------------------------------------
echo Deshabilitacion de hibernacion del equipo
echo -----------------------------------------
echo.
set /p r10= para deshabilitar la hibernacion del equipo presiona [s]i de lo contrario presiona [no] =
if %r10% == s (
	powercfg -h off
echo se ha deshabilitado la hibernacion, presiona cualquier tecla para regresar al inicio
pause>nul
	) else goto :inicio
goto :inicio
::
::
:: PROCESO 5
:5
cls
echo -----------------------------------------
echo   Evitar apagar el Disco en inactividad
echo -----------------------------------------
echo.
echo Para cambiar esta configuracion abre la ventana de configuracion de energia y da clic en:
echo CAMBIAR LA CONFIGURACION DEL PLAN - CAMBIAR LA CONFIGURACION AVANZADA DE ENERGIA 
echo y en la opcion apagar el disco duro tras
echo se pone el contador en 0
echo Quieres abrir la venta de configuracion de energia para aplicar esta configuracion?
set/p r11= [s]i [n]o ? =    
if %r11% == s (
	powercfg.cpl
	) else goto :inicio
goto :inicio
::
::
:: PROCESO 6
:6
cls
echo -------------------------------------------
echo  Deshabilitar cache de escritura en el SSD
echo -------------------------------------------
echo.
echo Para desahabilitar esta opcion necesitas dar clic derecho en la unidad de estado solido
echo dar clic en PROPIEDADES - HARDWARE - PROPIEDADES - CAMBIAR CONFIGURACION - DIRECTIVAS - ACEPTAR - ACEPTAR
echo abrir el explorador de archivos?
set/p r12= [s]i [n]o ?  =    
if %r12% == s (
	start explorer.exe
	pause
	) else goto :inicio
goto :inicio 
::
::
:: PROCESO 7
:7
cls
echo -------------------------------------------
echo  Deshabilitar paginacion (Memoria Virtual)
echo -------------------------------------------
echo.
:EOF