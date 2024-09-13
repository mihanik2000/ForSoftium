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
REM Устанавливаем BGInfo
REM ****************************************************************************************

set PathToBGInfo="%ScriptPath%Distr\noarch\BGInfo\*"

REM BGInfo - Программа для выведения на рабочий стол технической информации о ПК
REM Сайт разработчика: https://learn.microsoft.com/en-us/sysinternals/downloads/bginfo

ECHO Install BGInfo...
ECHO .
mkdir  "%ProgramFiles%\BGInfo\"

copy /y %PathToBGInfo% "%ProgramFiles%\BGInfo\"

:ENDSUB

timeout 3 /nobreak

EXIT /B
