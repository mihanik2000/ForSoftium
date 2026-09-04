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
:: Описание: отключаем запланированные задачи
::		
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

IF /I NOT "%HasAdminRights%"=="1" (
	echo.
	echo Вам нужны права администратора для запуска этого скрипта!
	echo.
	GOTO ENDSUB
)

SCHTASKS /Change /TN "Microsoft\Office\Update File Updater" /Disable /F
SCHTASKS /Change /TN "Microsoft\Office\Restore Adblock Plus Settings" /Disable /F
SCHTASKS /Change /TN "Microsoft\Office\File Updater" /Disable /F

:ENDSUB

timeout 3 /nobreak

EXIT /B
