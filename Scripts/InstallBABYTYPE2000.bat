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
:: Устанавливаем BABYTYPE2000
:: ****************************************************************************************

set PathToBABYTYPE2000="%ScriptPath%Distr\noarch\BABYTYPE2000.zip"

ECHO.
ECHO Install BABYTYPE2000...
ECHO.
	"%ProgramFiles%\7-Zip\7z.exe" x -y  %PathToBABYTYPE2000% -oc:

:: Создадим  ссылку на BABYTYPE
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "C:\BABYTYPE2000\BABYTYPE.EXE" "C:\BABYTYPE2000" "BabyType" "%SystemRoot%\System32\SHELL32.dll,41" "Тренажер печати BabyType"

:ENDSUB

timeout 3 /nobreak

EXIT /B
