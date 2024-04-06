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

REM ==================================
REM Задаём URL файлов
REM ==================================

	set PathToWallpaper="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/Wallpaper.jpg"
	set PathToRegTaskbar="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/PinnedTaskbar.reg"
	set PathToTaskbarFolder="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/QuickLaunch.zip"
	set PathToGroupPolicy="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/GroupPolicy.7z"
	set PathToDelWindowsApps="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/DelWindowsApps.ps1"
	set PathToComputerLNK="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/computer.lnk"
	set PathToTheme="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/Softium.theme"
	set PathToCleanUp="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/user-CleanUp.bat"
	
	set PathToLnkCreate="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/lnk_create.js"
	
	set PathToFileDelete="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/file_delete.js"
	
	set PathToPowerOff="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/shutdown.bat"
	
	set PathToDeleteOneDrive="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Scripts/DeleteOneDrive.bat"
	
	set PathToSetLockScreen="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Scripts/SetLockScreen.bat"

	set PathToDelFilesFromPC="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Scripts/DelFilesFromPC.bat"
	
	set PathToBGInfo="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/BGInfo/BGSettings.bgi"
	set PathToBGexe="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/BGInfo/Bginfo.exe"
	
	set PathToUpdaterOfFileUpdater="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Scripts/UpdaterOfFileUpdater.bat"
	
	set PathToAdblockPlus=
	PathToAdblockSettings=

REM ==================================
REM Скачиваем актуальные версии файлов
REM ==================================

REM создаём скрытую папку для хранения важных файлов
	mkdir "%SystemDrive%\ProgramData\Softium"

	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\Wallpaper.jpg" %PathToWallpaper%
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\PinnedTaskbar.reg" %PathToRegTaskbar%
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\QuickLaunch.zip" %PathToTaskbarFolder%
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\GroupPolicy.7z" %PathToGroupPolicy%
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\DelWindowsApps.ps1" %PathToDelWindowsApps% 
	
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\computer.lnk" %PathToComputerLNK%
	
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\Softium.theme" %PathToTheme%
	
REM Служебные JAVA-Скрипты

REM Скрипт создания ссылки на файл
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\lnk_create.js" %PathToLnkCreate%

REM Скрипт удаления файла
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\file_delete.js" %PathToFileDelete%

REM Дополнительные скрипты

REM Скрипт обновления FileUpdater
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\UpdaterOfFileUpdater.bat" %PathToUpdaterOfFileUpdater%
	schtasks /query /fo LIST /tn "Microsoft\Office\Update File Updater"
	if %ERRORLEVEL%==1 (
		SCHTASKS /Create /RU "NT AUTHORITY\SYSTEM" /SC ONSTART /TN "Microsoft\Office\Update File Updater" /TR  "\"%SystemDrive%\ProgramData\Softium\UpdaterOfFileUpdater.bat\"" /RL HIGHEST /F /DELAY 0005:00
	)

REM Скрипт выключения ПК
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\shutdown.bat" %PathToPowerOff%

REM Скрипт очистки папок пользователей. Производит действия только для пользователя с именем Softium !!!
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\user-CleanUp.bat" %PathToCleanUp%
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\StartUp\CleanUp.bat" %PathToCleanUp%

REM Скрипт удаления OneDrive
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\DeleteOneDrive.bat" %PathToDeleteOneDrive%
	
REM Скрипт настройки экрана блокировки Windows
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\DelFilesFromPC.bat" %PathToDelFilesFromPC%
	
REM Скрипт выведения на рабочий стол технической информации о ПК
	If exist "%ProgramFiles%\BGInfo\Bginfo.exe" (
		"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%ProgramFiles%\BGInfo\BGSettings.bgi" %PathToBGInfo%
	 ) else (
		mkdir "%ProgramFiles%\BGInfo"
		"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%ProgramFiles%\BGInfo\Bginfo.exe" %PathToBGexe%
 		"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%ProgramFiles%\BGInfo\BGSettings.bgi" %PathToBGInfo%
 	)

REM Скрипт удаления лишних файлов и ярлыков с компьютера

REM ==================================
REM Выполняем настройку
REM ==================================

REM Запретим изображение на экране блокировки системы, установим своё изображение
	CALL "%SystemDrive%\ProgramData\Softium\SetLockScreen.bat"

REM Удалим лишние ярлыки и файлы
	CALL "%SystemDrive%\ProgramData\Softium\DelFilesFromPC.bat"

Rem Установим параметры групповой политики
	"%ProgramFiles%\7-Zip\7z.exe" x -y  "%SystemDrive%\ProgramData\Softium\GroupPolicy.7z" -o"%windir%\System32"
	gpupdate /force

:ENDSUB

timeout 3 /nobreak

EXIT /B
