@echo off
:: ****************************************
::
:: Автор скрипта Михаил Медведев aka mihanik
::
:: https://mihanik.net
::
::        Требуется наличие прав администратора: ДА
:: Антивирусная программа должна быть отключена: желательно, но не обязательно
::                                    Замечания: НЕТ
::
:: Описание
::
:: ****************************************

:: **************************************************
:: Проверяем наличие у пользователя админских прав.
:: Если таковых прав нет, завершаем работу скрипта...
:: **************************************************

SET HasAdminRights=0

FOR /F %%i IN ('WHOAMI /PRIV /NH') DO (
	IF "%%i"=="SeTakeOwnershipPrivilege" SET HasAdminRights=1
)

IF NOT %HasAdminRights%==1 (
	ECHO.
	ECHO Вам нужны права администратора для запуска этого скрипта!
	ECHO.
	GOTO ENDSUB
)

if NOT defined ScriptPath (
	ECHO.
	ECHO Не определена переменная ScriptPath
	ECHO.
	GOTO ENDSUB
)

:: ****************************************************************************************
:: Устанавливаем Google Chrome
:: ****************************************************************************************

set PathToGoogleChrome="%ScriptPath%Distr\x32\GoogleChromeStandaloneEnterprise.msi"
set PathToGoogleChrome-x64="%ScriptPath%Distr\x64\GoogleChromeStandaloneEnterprise64.msi"
Set PathToChromeForcelist="%ScriptPath%Distr\noarch\ChromeForcelist.reg"

reg import %PathToChromeForcelist%

ECHO.
ECHO Install Google Chrome...
ECHO.
	If exist "%SystemDrive%\Program Files (x86)" (
		start "Install Google Chrome..." /wait %PathToGoogleChrome-x64% /passive /norestart
	 ) else (
 		start "Install Google Chrome..." /wait %PathToGoogleChrome% /passive /norestart
 	)

:: Дополнительно создаём ассоциацию для PDF
reg add "HKCU\Software\Classes\.pdf" /ve /t REG_SZ /d "ChromeHTML" /f
	
:: Сделаем Chrome браузером по-умолчанию.
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  http ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  https ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  .htm ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  .html ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  .pdf ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  .website ChromeHTML

:ENDSUB

timeout 3 /nobreak

EXIT /B
