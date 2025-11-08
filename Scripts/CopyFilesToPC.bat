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
:: Скопируем файлы на настраиваемый компьютер
:: ****************************************************************************************

	set PathToWallpaper="%ScriptPath%Distr\noarch\Wallpaper.jpg"
	set PathToRegTaskbar="%ScriptPath%Distr\noarch\PinnedTaskbar.reg"
	set PathToTaskbarFolder="%ScriptPath%Distr\noarch\QuickLaunch.zip"
	set PathToGroupPolicy="%ScriptPath%Distr\noarch\GroupPolicy.7z"
	set PathToDelWindowsApps="%ScriptPath%Distr\noarch\DelWindowsApps.ps1"
	set PathToTheme="%ScriptPath%Distr\noarch\Softium.theme"
	set PathToFileUpdater="%ScriptPath%Scripts\FileUpdater.bat"
	set PathToFileUpdaterInstaller="%ScriptPath%Scripts\ScheduleFileUpdate.bat"
	set PathToUpdaterOfFileUpdater="%ScriptPath%Scripts\UpdaterOfFileUpdater.bat"
	set PathToDeleteOneDrive="%ScriptPath%Scripts\DeleteOneDrive.bat"
	set PathToSetLockScreen="%ScriptPath%Scripts\SetLockScreen.bat"
	
	set PathToAdblockPlus="%ScriptPath%Scripts\RestoreAdblockSettings.bat"
	set PathToAdblockSettings="%ScriptPath%Distr\noarch\IndexedDB.zip"
	

:: создаём скрытую папку для хранения важных файлов
	mkdir "%SystemDrive%\ProgramData\Softium"

:: Начинаем копировать файлы
	copy /y %PathToWallpaper% "%SystemDrive%\ProgramData\Softium\Wallpaper.jpg"
	copy /y %PathToRegTaskbar% "%SystemDrive%\ProgramData\Softium\PinnedTaskbar.reg"
	copy /y %PathToTaskbarFolder% "%SystemDrive%\ProgramData\Softium\QuickLaunch.zip"
	copy /y %PathToGroupPolicy% "%SystemDrive%\ProgramData\Softium\GroupPolicy.7z"
	copy /y %PathToDelWindowsApps% "%SystemDrive%\ProgramData\Softium\DelWindowsApps.ps1"
	
	copy /y %PathToTheme% "%SystemDrive%\ProgramData\Softium\Softium.theme"
	
:: Служебные JAVA-Скрипты

:: Скрипт создания ссылки на файл
	copy /y "%ScriptPath%Distr\noarch\lnk_create.js" "%SystemDrive%\ProgramData\Softium\lnk_create.js"

:: Скрипт удаления файла
	copy /y "%ScriptPath%Distr\noarch\file_delete.js" "%SystemDrive%\ProgramData\Softium\file_delete.js"

:: Дополнительные скрипты

:: Скрипт выключения ПК
	copy /y "%ScriptPath%Distr\noarch\shutdown.bat"  "%SystemDrive%\ProgramData\Softium\shutdown.bat"

:: Скрипт очистки папок пользователей. Производит действия только для пользователя с именем Softium !!!
	copy /y "%ScriptPath%user-CleanUp.bat" "%SystemDrive%\ProgramData\Softium\user-CleanUp.bat"

:: Копируем скрипт очистки профиля в папку startup-скриптов
	mkdir "%systemroot%\System32\Repl\Import\Scripts"
	copy /y "%ScriptPath%user-CleanUp.bat" "%systemroot%\System32\Repl\Import\Scripts\CleanUp.bat"
	
:: Скрипты обновления служебных файлов
	copy /y "%PathToFileUpdater%"  "%SystemDrive%\ProgramData\Softium\FileUpdater.bat"
	copy /y "%PathToFileUpdaterInstaller%"  "%SystemDrive%\ProgramData\Softium\ScheduleFileUpdate.bat"
	copy /y "%PathToUpdaterOfFileUpdater%"  "%SystemDrive%\ProgramData\Softium\UpdaterOfFileUpdater.bat"
	
:: Скрипт восстановления настроек Adblock Plus у пользователя Softium
	copy /y "%PathToAdblockPlus%"  "%SystemDrive%\ProgramData\Softium\RestoreAdblockSettings.bat"
	copy /y "%PathToAdblockSettings%"  "%SystemDrive%\ProgramData\Softium\IndexedDB.zip"

:: Скрипт удаления OneDrive
	copy /y "%PathToDeleteOneDrive%"  "%SystemDrive%\ProgramData\Softium\DeleteOneDrive.bat"
	
:: Скрипт настройки экрана блокировки Windows
	copy /y "%PathToSetLockScreen%"  "%SystemDrive%\ProgramData\Softium\SetLockScreen.bat"

:ENDSUB

timeout 3 /nobreak

EXIT /B
