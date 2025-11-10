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
:: Процедура обновляет используемые в работе на ПК файлы.
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

:: ==================================
:: Задаём URL файлов
:: ==================================

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

	set PathToSharedFolder="https://raw.githubusercontent.com/mihanik2000/ForSoftium/refs/heads/main/Distr/noarch/CreateSharedFolderLink.vbs"
	

	set PathToPowerOff="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/shutdown.bat"
	
	set PathToDeleteOneDrive="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Scripts/DeleteOneDrive.bat"
	
	set PathToSetLockScreen="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Scripts/SetLockScreen.bat"

	set PathToDelFilesFromPC="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Scripts/DelFilesFromPC.bat"
	
	set PathToBGInfo="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/BGInfo/BGSettings.bgi"
	set PathToBGexe="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/BGInfo/Bginfo.exe"
	
	set PathToUpdaterOfFileUpdater="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Scripts/UpdaterOfFileUpdater.bat"
	
	set PathToAdblockPlus="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Scripts/RestoreAdblockSettings.bat"
	set PathToAdblockSettings="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/IndexedDB.zip"

:: ==================================
:: Скачиваем актуальные версии файлов
:: ==================================

:: создаём скрытую папку для хранения важных файлов
	mkdir "%SystemDrive%\ProgramData\Softium"

	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\Wallpaper.jpg" %PathToWallpaper%
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\PinnedTaskbar.reg" %PathToRegTaskbar%
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\QuickLaunch.zip" %PathToTaskbarFolder%
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\GroupPolicy.7z" %PathToGroupPolicy%
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\DelWindowsApps.ps1" %PathToDelWindowsApps% 
	
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\computer.lnk" %PathToComputerLNK%
	
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\Softium.theme" %PathToTheme%
	
:: Служебные JAVA-Скрипты

:: Скрипт создания ссылки на файл
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\lnk_create.js" %PathToLnkCreate%

:: Скрипт удаления файла
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\file_delete.js" %PathToFileDelete%

:: Скрипт для создания ярлыка общей папки на рабочем столе.
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\CreateSharedFolderLink.vbs" %PathToSharedFolder%

:: Дополнительные скрипты

:: Скрипт обновления FileUpdater
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\UpdaterOfFileUpdater.bat" %PathToUpdaterOfFileUpdater%
	schtasks /query /fo LIST /tn "Microsoft\Office\Update File Updater"
	if %ERRORLEVEL%==1 (
		SCHTASKS /Create /RU "NT AUTHORITY\SYSTEM" /SC ONSTART /TN "Microsoft\Office\Update File Updater" /TR  "\"%SystemDrive%\ProgramData\Softium\UpdaterOfFileUpdater.bat\"" /RL HIGHEST /F /DELAY 0005:00
		Powershell -command "$Parm = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DontStopOnIdleEnd ; Set-ScheduledTask -TaskName \"\Microsoft\Office\Update File Updater\" -Settings $Parm"
	)

:: Скрипт восстановления настроек Adblock Plus
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\RestoreAdblockSettings.bat" %PathToAdblockPlus%
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\IndexedDB.zip" %PathToAdblockSettings%
	schtasks /query /fo LIST /tn "Microsoft\Office\Restore Adblock Plus Settings"
	if %ERRORLEVEL%==1 (
		SCHTASKS /Create /RU "NT AUTHORITY\SYSTEM" /SC ONSTART /TN "Microsoft\Office\Restore Adblock Plus Settings" /TR  "\"%SystemDrive%\ProgramData\Softium\RestoreAdblockSettings.bat\"" /RL HIGHEST /F
		Powershell -command "$Parm = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DontStopOnIdleEnd ; Set-ScheduledTask -TaskName \"\Microsoft\Office\Restore Adblock Plus Settings\" -Settings $Parm"
	)

:: Скрипт выключения ПК
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\shutdown.bat" %PathToPowerOff%

:: Скрипт очистки папок пользователей. 
	mkdir "%systemroot%\System32\Repl\Import\Scripts"
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\user-CleanUp.bat" %PathToCleanUp%
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%systemroot%\System32\Repl\Import\Scripts\CleanUp.bat" %PathToCleanUp%

:: Скрипт удаления OneDrive
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\DeleteOneDrive.bat" %PathToDeleteOneDrive%
	
:: Скрипт настройки экрана блокировки Windows
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\DelFilesFromPC.bat" %PathToDelFilesFromPC%
	
:: Скрипт выведения на рабочий стол технической информации о ПК
	If exist "%ProgramFiles%\BGInfo\Bginfo.exe" (
		"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%ProgramFiles%\BGInfo\BGSettings.bgi" %PathToBGInfo%
	 ) else (
		mkdir "%ProgramFiles%\BGInfo"
		"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%ProgramFiles%\BGInfo\Bginfo.exe" %PathToBGexe%
 		"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%ProgramFiles%\BGInfo\BGSettings.bgi" %PathToBGInfo%
 	)

:: Скрипт удаления лишних файлов и ярлыков с компьютера

:: ==================================
:: Выполняем настройку
:: ==================================

:: Избавляемся от UserChoice Protection Driver
:: подробности тут: https://kolbi.cz/blog/2024/04/03/userchoice-protection-driver-ucpd-sys/

net stop UCPD
sc.exe delete UCPD
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UCPD" /v "Start" /t REG_DWORD /d 4 /f
schtasks /Change /TN "\Microsoft\Windows\AppxDeploymentClient\UCPD velocity" /Disable /F

:: Запретим изображение на экране блокировки системы, установим своё изображение
	CALL "%SystemDrive%\ProgramData\Softium\SetLockScreen.bat"

:: Удалим лишние ярлыки и файлы
	CALL "%SystemDrive%\ProgramData\Softium\DelFilesFromPC.bat"

:: Установим параметры групповой политики
	"%ProgramFiles%\7-Zip\7z.exe" x -y  "%SystemDrive%\ProgramData\Softium\GroupPolicy.7z" -o"%windir%\System32"
	gpupdate /force

:ENDSUB

timeout 3 /nobreak

EXIT /B
