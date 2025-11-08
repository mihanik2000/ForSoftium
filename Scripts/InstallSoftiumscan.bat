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
:: Установим программу Softium для обучающегося
:: ****************************************************************************************

:: Определяем место расположения программы softiumscan
	set PathToSoftium="%ScriptPath%Distr\noarch\softiumscan.exe"

:: создаём папку в корне системного диска для хранения рабочих файлов
	mkdir "%SystemDrive%\Softium"

:: Программа Softium для обучающегося
	copy /y %PathToSoftium% "%SystemDrive%\Softium\softiumscan.exe"

:: Добавляем программу softiumscan в исключения брандмауера Windows
	netsh advfirewall firewall del rule name="softiumscan"
	netsh advfirewall firewall add rule name="softiumscan" dir=in action=allow program="%SystemDrive%\Softium\softiumscan.exe"

:: Создаём ссылку на Softium на общем рабочем столе
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "C:\Softium\softiumscan.exe" "C:\Softium\" "Софтиум" "C:\Softium\softiumscan.exe" "Софтиум"

:ENDSUB

timeout 3 /nobreak

EXIT /B
