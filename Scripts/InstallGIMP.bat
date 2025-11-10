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
:: Устанавливаем GIMP
:: ****************************************************************************************

set PathToGIMP="%ScriptPath%Distr\noarch\gimp-2.10.38-setup.exe"

ECHO.
ECHO Install GIMP...
ECHO.
	start "Install GIMP..." /wait %PathToGIMP% /SILENT /NORESTART /ALLUSERS

:: Удалим созданную автоматически ссылку и создадим  правильную ссылку на GIMP
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\file_delete.js" "AllUsersDesktop" "\GIMP 2.10.38.lnk"
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\lnk_create.js"  "AllUsersDesktop"  "" "%ProgramFiles%\GIMP 2\bin\gimp-2.10.exe" "C:\Users\Softium\Documents" "GIMP" "%ProgramFiles%\GIMP 2\bin\gimp-2.10.exe" "Графический редактор GIMP"

:ENDSUB

timeout 3 /nobreak

EXIT /B
