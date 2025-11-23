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
:: Описание:
::		Скрипт создания точки восстановления Windows
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

:: Создаём точку восстановления Windows

:: Для EventType (первый параметр):

    :: 100 = BEGIN_SYSTEM_CHANGE (начало изменений)
    :: 101 = END_SYSTEM_CHANGE (окончание изменений)
    :: 102 = BEGIN_NESTED_SYSTEM_CHANGE (начало вложенных изменений)
    :: 103 = END_NESTED_SYSTEM_CHANGE (окончание вложенных изменений)

:: Для RestorePointType (второй параметр):

    :: 0 = APPLICATION_INSTALL (установка приложения) - устаревшее
    :: 12 = APPLICATION_INSTALL (установка приложения)
    :: 13 = APPLICATION_UNINSTALL (удаление приложения)
    :: 7 = DEVICE_DRIVER_INSTALL (установка драйвера)
    :: 10 = MODIFY_SETTINGS (изменение настроек)

echo.
echo Создаём точку восстановления Windows...
echo.

wmic /namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Restore point %date% %time:~0,8% by MihaNik", 100, 7 >nul 2>&1

:ENDSUB

timeout 3 /nobreak

EXIT /B
