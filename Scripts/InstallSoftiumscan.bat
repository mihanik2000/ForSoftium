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
	netsh advfirewall firewall add rule name="softiumscan" dir=in action=allow program="%SystemDrive%\Softium\softiumscan.exe"

REM Создаём ссылку на Softium на общем рабочем столе
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "C:\Softium\softiumscan.exe" "C:\Softium\" "Софтиум" "C:\Softium\softiumscan.exe" "Софтиум"

:ENDSUB

timeout 3 /nobreak

EXIT /B
