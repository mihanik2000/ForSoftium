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
:: Устанавливаем wget
:: ****************************************************************************************

set PathToWget="%ScriptPath%Distr\x32\wget.exe"
set PathToWget-x64="%ScriptPath%Distr\x64\wget.exe"

ECHO.
ECHO Install wget...
ECHO.
mkdir  "%ProgramFiles%\wget\"
	If exist "%SystemDrive%\Program Files (x86)" (
		copy /y %PathToWget-x64% "%ProgramFiles%\wget\wget.exe"
	) else (
		copy /y %PathToWget% "%ProgramFiles%\wget\wget.exe"
	)

:: Добавим путь к wget в path
	setx PATH "%ProgramFiles%\wget\;%Path%"
	PATH=%ProgramFiles%\wget\;%Path%

:: Добавляем утилиту wget.exe в исключения брандмауера Windows
	netsh advfirewall firewall del rule name="wget"
	netsh advfirewall firewall add rule name="wget" dir=in action=allow program="%ProgramFiles%\wget\wget.exe"

:ENDSUB

timeout 3 /nobreak

EXIT /B
