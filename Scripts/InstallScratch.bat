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
:: Устанавливаем AdobeAIR + Scratch 2
:: ****************************************************************************************

set PathToAdobeAIR="%ScriptPath%Distr\noarch\AdobeAIR.exe"

set PathToScratch="%ScriptPath%Distr\noarch\Scratch-461.exe"

echo.
echo Устанавливаем AdobeAIR...
echo.
	start "Title" /wait %PathToAdobeAIR% -silent

echo.
echo Install Scratch Offline...
echo.

start "Title" /wait %PathToScratch% -silent
 
cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles(x86)%\Scratch 2\Scratch 2.exe" "C:\Users\Softium\Documents" "Scratch 2" "%ProgramFiles(x86)%\Scratch 2\Scratch 2.exe" "Офлайн-редактор Scratch 2.0"  >nul 2>&1

:ENDSUB

timeout 3 /nobreak

EXIT /B
