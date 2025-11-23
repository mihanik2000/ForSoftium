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
:: Устанавливаем ActivePresenter
:: ****************************************************************************************

set PathToActivePresenter="%ScriptPath%Distr\noarch\ActivePresenter_v9.1.4_setup.exe"

echo.
echo Устанавливаем ActivePresenter...
echo.

start "ActivePresenter" /wait %PathToActivePresenter% /VERYSILENT /NORESTART

:ENDSUB

timeout 3 /nobreak

EXIT /B
