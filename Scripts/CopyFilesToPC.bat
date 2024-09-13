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
REM Скопируем файлы на настраиваемый компьютер
REM ****************************************************************************************

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
	

REM создаём скрытую папку для хранения важных файлов
	mkdir "%SystemDrive%\ProgramData\Softium"

REM Начинаем копировать файлы
	copy /y %PathToWallpaper% "%SystemDrive%\ProgramData\Softium\Wallpaper.jpg"
	copy /y %PathToRegTaskbar% "%SystemDrive%\ProgramData\Softium\PinnedTaskbar.reg"
	copy /y %PathToTaskbarFolder% "%SystemDrive%\ProgramData\Softium\QuickLaunch.zip"
	copy /y %PathToGroupPolicy% "%SystemDrive%\ProgramData\Softium\GroupPolicy.7z"
	copy /y %PathToDelWindowsApps% "%SystemDrive%\ProgramData\Softium\DelWindowsApps.ps1"
	
	copy /y %PathToTheme% "%SystemDrive%\ProgramData\Softium\Softium.theme"
	
REM Служебные JAVA-Скрипты

REM Скрипт создания ссылки на файл
	copy /y "%ScriptPath%Distr\noarch\lnk_create.js" "%SystemDrive%\ProgramData\Softium\lnk_create.js"

REM Скрипт удаления файла
	copy /y "%ScriptPath%Distr\noarch\file_delete.js" "%SystemDrive%\ProgramData\Softium\file_delete.js"

REM Дополнительные скрипты

REM Скрипт выключения ПК
	copy /y "%ScriptPath%Distr\noarch\shutdown.bat"  "%SystemDrive%\ProgramData\Softium\shutdown.bat"

REM Скрипт очистки папок пользователей. Производит действия только для пользователя с именем Softium !!!
	copy /y "%ScriptPath%user-CleanUp.bat" "%SystemDrive%\ProgramData\Softium\user-CleanUp.bat"

REM Копируем скрипт очистки профиля в папку startup-скриптов
	mkdir "%systemroot%\System32\Repl\Import\Scripts"
	copy /y "%ScriptPath%user-CleanUp.bat" "%systemroot%\System32\Repl\Import\Scripts\CleanUp.bat"
	
REM Скрипты обновления служебных файлов
	copy /y "%PathToFileUpdater%"  "%SystemDrive%\ProgramData\Softium\FileUpdater.bat"
	copy /y "%PathToFileUpdaterInstaller%"  "%SystemDrive%\ProgramData\Softium\ScheduleFileUpdate.bat"
	copy /y "%PathToUpdaterOfFileUpdater%"  "%SystemDrive%\ProgramData\Softium\UpdaterOfFileUpdater.bat"
	
REM Скрипт восстановления настроек Adblock Plus у пользователя Softium
	copy /y "%PathToAdblockPlus%"  "%SystemDrive%\ProgramData\Softium\RestoreAdblockSettings.bat"
	copy /y "%PathToAdblockSettings%"  "%SystemDrive%\ProgramData\Softium\IndexedDB.zip"

REM Скрипт удаления OneDrive
	copy /y "%PathToDeleteOneDrive%"  "%SystemDrive%\ProgramData\Softium\DeleteOneDrive.bat"
	
REM Скрипт настройки экрана блокировки Windows
	copy /y "%PathToSetLockScreen%"  "%SystemDrive%\ProgramData\Softium\SetLockScreen.bat"

:ENDSUB

timeout 3 /nobreak

EXIT /B
