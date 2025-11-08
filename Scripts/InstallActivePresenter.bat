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
:: Устанавливаем ActivePresenter
:: ****************************************************************************************

set PathToconstruct="%ScriptPath%Distr\noarch\ActivePresenter_v9.1.4_setup.exe"

ECHO.
ECHO Install ActivePresenter...
ECHO.
	start "ActivePresenter" /wait %PathToconstruct% /VERYSILENT /NORESTART

:: Создадим  ссылку на ActivePresenter
::	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\ATOMI\ActivePresenter\ActivePresenter.exe" "%ProgramFiles%\ATOMI\ActivePresenter" "ActivePresenter" "%ProgramFiles%\ATOMI\ActivePresenter\ActivePresenter.exe" "ActivePresenter"

:ENDSUB

timeout 3 /nobreak

EXIT /B
