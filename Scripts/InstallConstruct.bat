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
:: Устанавливаем Construct
:: ****************************************************************************************

set PathToconstruct="%ScriptPath%Distr\noarch\construct2-r280-setup.exe"

echo.
echo Install Construct...
echo.

start "Construct" /wait %PathToconstruct% /verysilent

:: Создадим  ссылку на construct2

cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\Construct 2\Construct2.exe" "C:\Users\Softium\Documents" "Construct2" "%ProgramFiles%\Construct 2\Construct2.exe" "The HTML5 game and app creator by Scirra."

:ENDSUB

timeout 3 /nobreak

EXIT /B
