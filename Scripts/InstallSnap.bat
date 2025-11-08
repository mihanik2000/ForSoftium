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
:: Устанавливаем Snap
:: ****************************************************************************************

set PathTosnap="%ScriptPath%Distr\noarch\Snap-9.0.5.zip"

ECHO.
ECHO Install Snap...
ECHO.
	mkdir "%ProgramFiles%\SNAP"
	"%ProgramFiles%\7-Zip\7z.exe" x -y  %PathTosnap% -o"%ProgramFiles%\SNAP"

:: Создадим  ссылку на Snap
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\SNAP\Snap-9.0.5\index.html" "%ProgramFiles%\SNAP\Snap-9.0.5" "Snap!" "%ProgramFiles%\SNAP\Snap-9.0.5\src\favicon.ico" "SNAP! Оффлайн версия"

:ENDSUB

timeout 3 /nobreak

EXIT /B
