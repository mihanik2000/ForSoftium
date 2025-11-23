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
	echo.
	echo Вам нужны права администратора для запуска этого скрипта!
	echo.
	GOTO ENDSUB
)

if NOT defined ScriptPath (
	echo.
	echo Не определена переменная ScriptPath
	echo.
	GOTO ENDSUB
)

:: ****************************************************************************************
:: Устанавливаем Google Chrome
:: ****************************************************************************************

set PathToGoogleChrome-x64="%ScriptPath%Distr\x64\GoogleChromeStandaloneEnterprise64.msi"
Set PathToChromeForcelist="%ScriptPath%Distr\noarch\ChromeForcelist.reg"
Set PathToInitialPreferences="%ScriptPath%Distr\noarch\initial_preferences"

echo.
echo Устанавливаем Google Chrome...
echo.

start "Install Google Chrome..." /wait %PathToGoogleChrome-x64% /passive /norestart


if %BChromePolicy%==1 (
	echo.
	echo Настраиваем политики Google Chrome...
	echo.

	reg import %PathToChromeForcelist% >nul 2>&1

	mkdir "%ProgramFiles%\Google\Chrome\Application\"  >nul 2>&1

	copy /y %PathToInitialPreferences% "%ProgramFiles%\Google\Chrome\Application\initial_preferences" >nul 2>&1
)

:: Дополнительно создаём ассоциацию для PDF

reg add "HKCU\Software\Classes\.pdf" /ve /t REG_SZ /d "ChromeHTML" /f  >nul 2>&1
	
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
