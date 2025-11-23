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
:: Установим программу Softium для обучающегося
:: ****************************************************************************************

:: Определяем место расположения программы softiumscan

set PathToSoftium="%ScriptPath%Distr\noarch\softiumscan.exe"

:: создаём папку в корне системного диска для хранения рабочих файлов

mkdir "%SystemDrive%\Softium" >nul 2>&1

:: Программа Softium для обучающегося

copy /y %PathToSoftium% "%SystemDrive%\Softium\softiumscan.exe" >nul 2>&1

:: Добавляем программу softiumscan в исключения брандмауера Windows

netsh advfirewall firewall del rule name="softiumscan" >nul 2>&1
netsh advfirewall firewall add rule name="softiumscan" dir=in action=allow program="%SystemDrive%\Softium\softiumscan.exe" >nul 2>&1

:: Создаём ссылку на Softium на общем рабочем столе

cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "C:\Softium\softiumscan.exe" "C:\Softium\" "Софтиум" "C:\Softium\softiumscan.exe" "Софтиум" >nul 2>&1

:ENDSUB

timeout 3 /nobreak

EXIT /B
