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
:: Устанавливаем wget
:: ****************************************************************************************

set PathToWget-x64="%ScriptPath%Distr\x64\wget.exe"

echo.
echo Устанавливаем wget...
echo.

mkdir  "%ProgramFiles%\wget\" >nul 2>&1

copy /y %PathToWget-x64% "%ProgramFiles%\wget\wget.exe" >nul 2>&1

:: Добавим путь к wget в path

setx PATH "%ProgramFiles%\wget\;%Path%" >nul 2>&1
PATH=%ProgramFiles%\wget\;%Path% >nul 2>&1

:: Добавляем утилиту wget.exe в исключения брандмауера Windows

netsh advfirewall firewall del rule name="wget" >nul 2>&1
netsh advfirewall firewall add rule name="wget" dir=in action=allow program="%ProgramFiles%\wget\wget.exe" >nul 2>&1

:ENDSUB

timeout 3 /nobreak

EXIT /B
