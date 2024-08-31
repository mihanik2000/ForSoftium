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

if NOT defined ScriptPath (
	ECHO .
	ECHO Не определена переменная ScriptPath
	ECHO .
	GOTO ENDSUB
)

REM ****************************************************************************************
REM Устанавливаем Google Chrome
REM ****************************************************************************************

set PathToGoogleChrome="%ScriptPath%Distr\x32\GoogleChromeStandaloneEnterprise.msi"
set PathToGoogleChrome-x64="%ScriptPath%Distr\x64\GoogleChromeStandaloneEnterprise64.msi"
Set PathToChromeForcelist="%ScriptPath%Distr\noarch\ChromeForcelist.reg"

reg import %PathToChromeForcelist%

ECHO .
ECHO Install Google Chrome...
ECHO .
	If exist "%SystemDrive%\Program Files (x86)" (
		start "Install Google Chrome..." /wait %PathToGoogleChrome-x64% /passive /norestart
	 ) else (
 		start "Install Google Chrome..." /wait %PathToGoogleChrome% /passive /norestart
 	)
	
REM Сделаем Chrome браузером по-умолчанию.
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  http ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  https ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  .htm ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  .html ChromeHTML

:ENDSUB

timeout 3 /nobreak

EXIT /B
