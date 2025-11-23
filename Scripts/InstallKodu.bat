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
:: Устанавливаем Kodu
:: ****************************************************************************************

set PathToxnafx="%ScriptPath%Distr\noarch\xnafx40_redist.msi"
set PathToKodu="%ScriptPath%Distr\noarch\KoduSetup_1.6.18.0.msi"

echo.
echo Install Kodu...
echo.
	start "Title" /wait %PathToxnafx% /passive /norestart
	start "Title" /wait %PathToKodu% /passive /norestart

:: Удалим лишнюю ссылку Kodu

cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\file_delete.js" "AllUsersDesktop" "\Configure Kodu Game Lab.lnk" >nul 2>&1

:ENDSUB

timeout 3 /nobreak

EXIT /B
