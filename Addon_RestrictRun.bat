@echo off

Rem Скрипт установки пакета программ компьютеры Softium

Rem Windows XP не поддерживается!!!
ver | find "5.1."

If %errorlevel%==0  (
	Echo Windows XP unsupported!!!
	timeout 10 /nobreak
	Exit /b 1
 ) 

Rem ****************************************************************************************
Rem Проверяем наличие у пользователя админских прав...
Rem ****************************************************************************************

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

Rem Запретим пользователю Softium запускать лишние программы

net localgroup Администраторы Softium /add

Powershell.exe -executionpolicy Bypass -File C:\ProgramData\Softium\RestrictRun.ps1

net localgroup Администраторы Softium /del

Rem Отключим некоторые функции Windows
REM start "Title" /wait start "OOSU10" /wait %PathToOOSU10% %PathToOOSU10-CFG% /quiet /nosrp

:END

timeout 10 /nobreak

EXIT /B
