@echo off
REM ****************************************
REM
REM Автор скрипта Михаил Медведев aka mihanik
REM
REM https://mihanik.net
REM
REM        Требуется наличие прав администратора: ДА
REM Антивирусная программа должна быть отключена: желательно, но не обязательно
REM                                    Замечания: НЕТ
REM
REM Описание
REM
REM ****************************************

REM **************************************************
REM Проверяем наличие у пользователя админских прав.
REM Если таковых прав нет, завершаем работу скрипта...
REM **************************************************

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
REM Устанавливаем Notepad++
REM ****************************************************************************************

set PathToNotepad="%ScriptPath%Distr\x32\npp.8.6.9.Installer.exe"
set PathToNotepad-x64="%ScriptPath%Distr\x64\npp.8.6.9.Installer.x64.exe"

ECHO .
ECHO Install Notepad++...
ECHO .
	If exist "%SystemDrive%\Program Files (x86)" (
		start "Title" /wait %PathToNotepad-x64% /S
	 ) else (
 		start "Title" /wait %PathToNotepad% /S
 	)

REM Создадим  ссылку на Notepad
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\Notepad++\notepad++.exe" "%ProgramFiles%\Notepad++" "Notepad++" "%ProgramFiles%\Notepad++\notepad++.exe" "Текстовый редактор Notepad++"

:ENDSUB

timeout 3 /nobreak

EXIT /B
