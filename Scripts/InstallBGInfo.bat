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
:: Устанавливаем BGInfo
:: ****************************************************************************************

set PathToBGInfo="%ScriptPath%Distr\noarch\BGInfo\*"

:: BGInfo - Программа для выведения на рабочий стол технической информации о ПК
:: Сайт разработчика: https://learn.microsoft.com/en-us/sysinternals/downloads/bginfo

echo Install BGInfo...
echo.

mkdir  "%ProgramFiles%\BGInfo\" >nul 2>&1

copy /y %PathToBGInfo% "%ProgramFiles%\BGInfo\" >nul 2>&1

:ENDSUB

timeout 3 /nobreak

EXIT /B
