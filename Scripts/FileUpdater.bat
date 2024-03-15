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
REM Процедура обновляет используемые в работе на ПК файлы.
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

REM Задаём URL файлов

	set PathToWallpaper="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/Wallpaper.jpg"
	set PathToRegTaskbar="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/PinnedTaskbar.reg"
	set PathToTaskbarFolder="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/QuickLaunch.zip"
	set PathToGroupPolicy="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/GroupPolicy.7z"
	set PathToDelWindowsApps="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/DelWindowsApps.ps1"
	set PathToComputerLNK="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/computer.lnk"
	set PathToChromeDefault="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/Chrome.reg"
	set PathToTheme="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/Softium.theme"
	set PathToCleanUp="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/user-CleanUp.bat"
	
	set PathToLnkCreate="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/lnk_create.js"
	
	set PathToFileDelete="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/file_delete.js"
	
	set PathToPowerOff="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/shutdown.bat"

REM создаём скрытую папку для хранения важных файлов
	mkdir "%SystemDrive%\ProgramData\Softium"

	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\Wallpaper.jpg" %PathToWallpaper%
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\PinnedTaskbar.reg" %PathToRegTaskbar%
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\QuickLaunch.zip" %PathToTaskbarFolder%
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\GroupPolicy.7z" %PathToGroupPolicy%
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\DelWindowsApps.ps1" %PathToDelWindowsApps% 
	
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\computer.lnk" %PathToComputerLNK%
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\Chrome.reg" %PathToChromeDefault%
	
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\Softium.theme" %PathToTheme%
	
REM Служебные JAVA-Скрипты
REM Скрипт создания ссылки на файл
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\lnk_create.js" %PathToLnkCreate%

REM Скрипт удаления файла
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\file_delete.js" %PathToFileDelete%

REM Дополнительные скрипты
REM Скрипт выключения ПК
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\shutdown.bat" %PathToPowerOff%

REM Скрипт очистки папок пользователей. Производит действия только для пользователя с именем Softium !!!
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\user-CleanUp.bat" %PathToCleanUp%
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\StartUp\CleanUp.bat" %PathToCleanUp%
	
Rem Установим параметры групповой политики
	"%ProgramFiles%\7-Zip\7z.exe" x -y  "%SystemDrive%\ProgramData\Softium\GroupPolicy.7z" -o"%windir%\System32"
	gpupdate /force

:ENDSUB

timeout 3 /nobreak

EXIT /B
