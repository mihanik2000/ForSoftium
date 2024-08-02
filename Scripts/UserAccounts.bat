@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM        Require administrator rights: YES
REM Antivirus software must be disabled: Not necessary
REM                        Dependencies: No
REM
REM Описание
REM
REM ****************************************

rem Проверяем наличие у пользователя админских прав...
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

Rem Срок действия пароля Администратора не ограничен
wmic UserAccount where Name="Администратор" set PasswordExpires=False

REM Создадим пользователя Softium с паролем 321
if %BClearSoftiumProfile%==1 (
	Rem Назначим пользователю Sofium стартовый скрипт
	net user Softium "321" /add /expires:never /passwordchg:no /scriptpath:CleanUp.bat
	) else (
	Rem Не назначаем пользователю Sofium стартовый скрипт
	net user Softium "321" /add /expires:never /passwordchg:no
	)

Rem Срок действия пароля пользователя Softium не ограничен
wmic UserAccount where Name="Softium" set PasswordExpires=False

Rem Пользователю Softium запрещаем менять пароль
Rem wmic UserAccount where Name="Softium" set PasswordChangeable=False




:ENDSUB

timeout 3 /nobreak

EXIT /B
