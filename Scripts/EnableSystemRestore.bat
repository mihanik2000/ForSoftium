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
::		Скрипт включения восстановления Windows для системного диска.
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

echo Включаем возможность использования точек восстановления системы...

IF NOT %HasAdminRights%==1 (
	echo.
	echo Вам нужны права администратора для запуска этого скрипта!
	echo.
	GOTO ENDSUB
)

:: включаем службу теневого копирования

echo.
echo Включаем службу теневого копирования...
echo.

sc config vss start= demand >nul 2>&1

timeout 3 /nobreak

:: включаем восстановление на системном диске

echo.
echo Включаем восстановление для системного диска...
echo.

wmic /namespace:\\root\default Path SystemRestore Call enable "%systemdrive%" >nul 2>&1

timeout 3 /nobreak

:: отдаём под восстановление системы 15% дискового пространства

echo.
echo Разрешаем использовать восстановление системы 15% дискового пространства...
echo.

vssadmin resize shadowstorage /for=%systemdrive% /on=%systemdrive% /maxsize=15%% >nul 2>&1

echo.
echo Снимаем ограничение на создание точек восстановления не чаще, чем 1 раз в 24 часа.
echo.

reg ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v SystemRestorePointCreationFrequency /t REG_DWORD /d 0 /f >nul 2>&1


:ENDSUB

timeout 3 /nobreak

EXIT /B
