@echo off

REM Скрипт установки пакета программ компьютеры Softium

REM Windows XP не поддерживается!!!
ver | find "5.1."

If %errorlevel%==0  (
	Echo Windows XP unsupported!!!
	timeout 10 /nobreak
	Exit /b 1
 ) 

REM ****************************************************************************************
REM Проверяем наличие у пользователя админских прав.
REM Если таковых прав нет, завершаем работу скрипта.
REM Если таковых прав нет, завершаем работу скрипта...
REM ****************************************************************************************

SET HasAdminRights=0
FOR /F %%i IN ('WHOAMI /PRIV /NH') DO (
	IF "%%i"=="SeTakeOwnershipPrivilege" SET HasAdminRights=1
)

IF NOT %HasAdminRights%==1 (
	ECHO .
	ECHO Для запуска этого скрипта вам нужно обладать правами "Администратоа"
	ECHO .
	GOTO END
)

REM Запретим пользователю Softium запускать лишние программы

net localgroup Администраторы Softium /add

Powershell.exe -executionpolicy Bypass -File C:\ProgramData\Softium\RestrictRun.ps1

net localgroup Администраторы Softium /del

:END

timeout 10 /nobreak

EXIT /B
