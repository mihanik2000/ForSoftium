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
:: Устанавливаем Notepad++
:: ****************************************************************************************

set PathToNotepad-x64="%ScriptPath%Distr\x64\npp.8.6.9.Installer.x64.exe"

echo.
echo Устанавливаем Notepad++...
echo.

start "Title" /wait %PathToNotepad-x64% /S

:: Создадим  ссылку на Notepad

cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\Notepad++\notepad++.exe" "C:\Users\Softium\Documents" "Notepad++" "%ProgramFiles%\Notepad++\notepad++.exe" "Текстовый редактор Notepad++"  >nul 2>&1

:ENDSUB

timeout 3 /nobreak

EXIT /B
