@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM        Require administrator rights: YES
REM Antivirus software must be disabled: Not necessary
REM                        Dependencies: No
REM
REM Описание
REM
REM ****************************************

rem Проверяем наличие у пользователя админских прав...
SET HasAdminRights=0

FOR /F %%i IN ('WHOAMI /PRIV /NH') DO (
	IF "%%i"=="SeTakeOwnershipPrivilege" SET HasAdminRights=1
)

IF NOT %HasAdminRights%==1 (
	ECHO .
	ECHO Вам нужны права администратора для запуска этого скрипта!
	ECHO .
	GOTO ENDSUB
)
REM Запретим изображение на экране блокировки системы

	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v DisableLogonBackgroundImage /t REG_DWORD /d 1 /f

REM ****************************************************************************************
REM Описание процедуры
REM ****************************************************************************************

:ENDSUB

timeout 3 /nobreak

EXIT /B
