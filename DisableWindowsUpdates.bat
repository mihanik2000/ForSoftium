@echo off

REM Скрипт установки пакета программ на компьютеры Softium

REM ****************************************************************************************
REM Проверяем наличие у пользователя админских прав...
REM ****************************************************************************************

SET HasAdminRights=0
FOR /F %%i IN ('WHOAMI /PRIV /NH') DO (
	IF "%%i"=="SeTakeOwnershipPrivilege" SET HasAdminRights=1
)

IF NOT %HasAdminRights%==1 (
	ECHO .
	ECHO You need administrator rights to run!!!
	ECHO .
	GOTO END
)

REM Отключим автоматическое обновление системы

reg ADD HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate /v DoNotConnectToWindowsUpdateInternetLocations /t REG_DWORD /d 1 /f
reg ADD HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate /v DisableWindowsUpdateAccess /t REG_DWORD /d 1 /f
reg ADD HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate /v WUServer /t REG_SZ /d " " /f
reg ADD HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate /v WUStatusServer /t REG_SZ /d " " /f
reg ADD HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate /v UpdateServiceUrlAlternate /t REG_SZ /d " " /f
reg ADD HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate\AU /v UseWUServer /t REG_DWORD /d 1 /f

net stop wuauserv
sc config wuauserv start= disabled

END:

timeout 10
