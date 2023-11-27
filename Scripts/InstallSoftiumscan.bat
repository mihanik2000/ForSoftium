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

if NOT defined ScriptPath (
	ECHO .
	ECHO Не определена переменная ScriptPath
	ECHO .
	GOTO ENDSUB
)

REM ****************************************************************************************
REM Установим программу Softium для обучающегося
REM ****************************************************************************************

REM создаём папку в корне системного диска для хранения рабочих файлов
	mkdir "%SystemDrive%\Softium"

set PathToSoftium="%ScriptPath%Distr\noarch\softiumscan.exe"

REM Программа Softium для обучающегося
	copy /y %PathToSoftium% "%SystemDrive%\Softium\softiumscan.exe"

REM Добавляем программу softiumscan в исключения брандмауера Windows
	netsh advfirewall firewall del rule name="softiumscan"
	netsh firewall add allowedprogram "%SystemDrive%\Softium\softiumscan.exe" softiumscan
	netsh advfirewall firewall add rule name="softiumscan" dir=in action=allow program="%SystemDrive%\Softium\softiumscan.exe"

REM + Softium
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "C:\Softium\softiumscan.exe" "C:\Softium\" "Софтиум" "C:\Softium\softiumscan.exe" "Софтиум"

:ENDSUB

timeout 3 /nobreak

EXIT /B
