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
REM Скопируем файлы на настраиваемый компьютер
REM ****************************************************************************************

	set PathToWallpaper="%ScriptPath%Distr\noarch\Wallpaper.jpg"
	set PathToRegTaskbar="%ScriptPath%Distr\noarch\PinnedTaskbar.reg"
	set PathToTaskbarFolder="%ScriptPath%Distr\noarch\QuickLaunch.zip"
	set PathToGroupPolicy="%ScriptPath%Distr\noarch\GroupPolicy.zip"
	set PathToDelWindowsApps="%ScriptPath%Distr\noarch\DelWindowsApps.ps1"
	set PathToComputerLNK="%ScriptPath%Distr\noarch\computer.lnk"
	set PathToChromeDefault="%ScriptPath%Distr\noarch\Chrome.reg"
	set PathToTheme="%ScriptPath%Distr\noarch\Softium.theme"

REM создаём скрытую папку для хранения важных файлов
	mkdir "%SystemDrive%\ProgramData\Softium"

	copy /y %PathToWallpaper% "%SystemDrive%\ProgramData\Softium\Wallpaper.jpg"
	copy /y %PathToRegTaskbar% "%SystemDrive%\ProgramData\Softium\PinnedTaskbar.reg"
	copy /y %PathToTaskbarFolder% "%SystemDrive%\ProgramData\Softium\QuickLaunch.zip"
	copy /y %PathToGroupPolicy% "%SystemDrive%\ProgramData\Softium\GroupPolicy.zip"
	copy /y %PathToDelWindowsApps% "%SystemDrive%\ProgramData\Softium\DelWindowsApps.ps1"
	
	copy /y %PathToComputerLNK% "%SystemDrive%\ProgramData\Softium\computer.lnk"
	copy /y %PathToChromeDefault% "%SystemDrive%\ProgramData\Softium\Chrome.reg"
	
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
	copy /y "%ScriptPath%step-3-user-CleanUp.bat" "%SystemDrive%\ProgramData\Softium\step-3-user-CleanUp.bat"
	copy /y "%ScriptPath%step-3-user-CleanUp.bat" "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\StartUp\CleanUp.bat"

:ENDSUB

timeout 3 /nobreak

EXIT /B
