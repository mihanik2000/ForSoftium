@echo off
REM ****************************************
REM
REM Автор скрипта Михаил Медведев aka mihanik
REM
REM https://mihanik.net
REM
REM        Требуется наличие прав администратора: ДА
REM Антивирусная программа должна быть отключена: желательно, но не обязательно
REM                                    Замечания: НЕТ
REM
REM Описание
REM
REM ****************************************

REM **************************************************
REM Проверяем наличие у пользователя админских прав.
REM Если таковых прав нет, завершаем работу скрипта...
REM **************************************************

SET HasAdminRights=0

FOR /F %%i IN ('WHOAMI /PRIV /NH') DO (
	IF "%%i"=="SeTakeOwnershipPrivilege" SET HasAdminRights=1
)

IF NOT %HasAdminRights%==1 (
	ECHO .
	ECHO Вам нужны права администратора для запуска этого скрипта!
	ECHO .
	GOTO ENDSUB
)

REM ****************************************************************************************
REM Настраиваем учётные записи пользователей на компьютере
REM ****************************************************************************************

REM активируем встроенного Администратора
net user Администратор "AdminPass" /active:yes /expires:never

REM Срок действия пароля Администратора не ограничен
wmic UserAccount where Name="Администратор" set PasswordExpires=False

REM Создадим пользователя Softium с паролем 321
if %BClearSoftiumProfile%==1 (
	REM Назначим пользователю Sofium стартовый скрипт
	REM https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc771865(v=ws.11)
	REM /scriptpath:<Path>
	REM Sets a path for the user's logon script. <Path> cannot be an absolute path. <Path> is relative to %systemroot%\System32\Repl\Import\Scripts.
	
	net user Softium "321" /add /expires:never /passwordchg:no /scriptpath:CleanUp.bat
	
	REM Т.к. профиль пользователя ещё не создан, то первый запуск скрипта приведёт
	REM к зависанию Windows во время создания профиля пользователя.
	REM Чтобы этого не произошло нужно при первом входе в профиль скрипт не отрабатывал до конца.
	
	REM создаём папку для хранения файлов
	mkdir "%SystemDrive%\ProgramData\Softium"
	
	REM В этой папке создаём файл-признак для того, чтобы стартап-скрипт мог понять, что он запускается первый раз.
	echo yes > "%SystemDrive%\ProgramData\Softium\FirstRun.txt"
	
	REM  Отключаем у файла наследование прав NTFS с удалением списка доступа
	REM Это чтобы скрипт запущенный от имени пользователя Softium смог удалить файл
	
	ICACLS "%SystemDrive%\ProgramData\Softium\FirstRun.txt" /inheritance:r
	
	REM Группам <Все>, <Система>, <Администраторы> даём полный доступ к паке

	ICACLS "%SystemDrive%\ProgramData\Softium\FirstRun.txt" /grant Все:F
	ICACLS "%SystemDrive%\ProgramData\Softium\FirstRun.txt" /grant Система:F
	ICACLS "%SystemDrive%\ProgramData\Softium\FirstRun.txt" /grant Администраторы:F
	
	) else (
	
	REM Не назначаем пользователю Sofium стартовый скрипт
	net user Softium "321" /add /expires:never /passwordchg:no
	
	)

REM Срок действия пароля пользователя Softium не ограничен
wmic UserAccount where Name="Softium" set PasswordExpires=False

:ENDSUB

timeout 3 /nobreak

EXIT /B
