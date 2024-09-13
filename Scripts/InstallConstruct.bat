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
REM Устанавливаем Construct
REM ****************************************************************************************

set PathToconstruct="%ScriptPath%Distr\noarch\construct2-r280-setup.exe"

ECHO .
ECHO Install Construct...
ECHO .
	start "Construct" /wait %PathToconstruct% /verysilent

REM Создадим  ссылку на construct2
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\Construct 2\Construct2.exe" "%ProgramFiles%\Construct 2" "Construct2" "%ProgramFiles%\Construct 2\Construct2.exe" "The HTML5 game and app creator by Scirra."

:ENDSUB

timeout 3 /nobreak

EXIT /B
