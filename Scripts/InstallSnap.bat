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
:: Устанавливаем Snap
:: ****************************************************************************************

set PathTosnap="%ScriptPath%Distr\noarch\Snap-9.0.5.zip"

echo.
echo Install Snap...
echo.

mkdir "%ProgramFiles%\SNAP" >nul 2>&1

"%ProgramFiles%\7-Zip\7z.exe" x -y  %PathTosnap% -o"%ProgramFiles%\SNAP" >nul 2>&1

:: Создадим  ссылку на Snap

cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\SNAP\Snap-9.0.5\index.html" "C:\Users\Softium\Documents" "Snap!" "%ProgramFiles%\SNAP\Snap-9.0.5\src\favicon.ico" "SNAP! Оффлайн версия"  >nul 2>&1

:ENDSUB

timeout 3 /nobreak

EXIT /B
