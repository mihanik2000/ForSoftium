@echo off
REM ****************************************
REM
REM Автор скрипта Михаил Медведев aka mihanik
REM
REM https://mihanik.net
REM
REM        Требуется наличие прав администратора: ДА
REM Антивирусная программа должна быть отключена: желательно, но не обязательно
REM                                    Замечания: НЕТ
REM
REM Описание
REM
REM ****************************************

REM **************************************************
REM Проверяем наличие у пользователя админских прав.
REM Если таковых прав нет, завершаем работу скрипта...
REM **************************************************

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

if NOT defined ScriptPath (
	ECHO .
	ECHO Не определена переменная ScriptPath
	ECHO .
	GOTO ENDSUB
)

REM ****************************************************************************************
REM Устанавливаем программу-архиватор 7zip
REM ****************************************************************************************

set PathTo7Zip="%ScriptPath%Distr\x32\7z2407.msi"
set PathTo7Zip-x64="%ScriptPath%Distr\x64\7z2407-x64.msi"

ECHO .
ECHO Install 7-Zip...
ECHO .
 If exist "%SystemDrive%\Program Files (x86)" (
		start "Title" /wait %PathTo7Zip-x64% /passive /norestart
	) else (
		start "Title" /wait %PathTo7Zip% /passive /norestart
	)

:ENDSUB

timeout 3 /nobreak

EXIT /B
