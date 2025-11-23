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
:: Устанавливаем SetuserFTA
:: ****************************************************************************************

set PathToSetuserFTA="%ScriptPath%Distr\noarch\SetUserFTA\*"

:: SetuserFTA - Программа для управления защищёнными настройками Windows 10.
:: Сайт разработчика: http://kolbi.cz/blog/2017/10/25/setuserfta-userchoice-hash-defeated-set-file-type-associations-per-user/
:: По русски: https://ru.desktopsupportpanel.com/izmenit-prilozheniya-po-umolchaniyu-brauzer-ili-sopostavleni

echo.
echo Устанавливаем SetuserFTA...
echo.

mkdir  "%ProgramFiles%\SetuserFTA\" >nul 2>&1

copy /y %PathToSetuserFTA% "%ProgramFiles%\SetuserFTA\" >nul 2>&1

:: подробности тут: https://kolbi.cz/blog/2024/04/03/userchoice-protection-driver-ucpd-sys/

net stop UCPD >nul 2>&1
sc.exe delete UCPD >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UCPD" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\AppxDeploymentClient\UCPD velocity" /Disable >nul 2>&1

:ENDSUB

timeout 3 /nobreak

EXIT /B
