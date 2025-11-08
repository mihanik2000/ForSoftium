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

:: ****************************************************************************************
:: Настраиваем учётные записи пользователей на компьютере
:: ****************************************************************************************

:: Отключение блокировки учетной записи
net accounts /lockoutthreshold:0 >nul 2>&1

:: активируем встроенного Администратора
net user Администратор "AdminPass" /active:yes /expires:never

:: Срок действия пароля Администратора не ограничен
wmic UserAccount where Name="Администратор" set PasswordExpires=False

:: Создадим пользователя Softium с паролем 321
if %BClearSoftiumProfile%==1 (
	:: Назначим пользователю Sofium стартовый скрипт
	:: https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc771865(v=ws.11)
	:: /scriptpath:<Path>
	:: Sets a path for the user's logon script. <Path> cannot be an absolute path. <Path> is relative to %systemroot%\System32\Repl\Import\Scripts.
	
	net user Softium "321" /add /expires:never /passwordchg:no /scriptpath:CleanUp.bat

	:: Т.к. профиль пользователя ещё не создан, то первый запуск скрипта приведёт
	:: к зависанию Windows во время создания профиля пользователя.
	:: Чтобы этого не произошло нужно при первом входе в профиль скрипт не отрабатывал до конца.
	
	:: создаём папку для хранения файлов
	mkdir "%SystemDrive%\ProgramData\Softium"
	
	:: В этой папке создаём файл-признак для того, чтобы стартап-скрипт мог понять, что он запускается первый раз.
	echo yes > "%SystemDrive%\ProgramData\Softium\FirstRun.txt"
	
	::  Отключаем у файла наследование прав NTFS с удалением списка доступа
	:: Это чтобы скрипт запущенный от имени пользователя Softium смог удалить файл
	
	ICACLS "%SystemDrive%\ProgramData\Softium\FirstRun.txt" /inheritance:r
	
	:: Группам <Все>, <Система>, <Администраторы> даём полный доступ к файлу

	ICACLS "%SystemDrive%\ProgramData\Softium\FirstRun.txt" /grant Все:F
	ICACLS "%SystemDrive%\ProgramData\Softium\FirstRun.txt" /grant Система:F
	ICACLS "%SystemDrive%\ProgramData\Softium\FirstRun.txt" /grant Администраторы:F
	
	) else (
	
	:: Не назначаем пользователю Sofium стартовый скрипт
	net user Softium "321" /add /expires:never /passwordchg:no
	
	)

:: Срок действия пароля пользователя Softium не ограничен
	wmic UserAccount where Name="Softium" set PasswordExpires=False

:ENDSUB

timeout 3 /nobreak

EXIT /B
