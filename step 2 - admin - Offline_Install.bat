@echo off

REM Скрипт установки пакета программ на компьютеры Softium

REM ****************************************************************************************
REM Проверяем наличие у пользователя админских прав...
REM ****************************************************************************************

SET HasAdminRights=0
FOR /F %%i IN ('WHOAMI /PRIV /NH') DO (
	IF "%%i"=="SeTakeOwnershipPrivilege" SET HasAdminRights=1
)

IF NOT %HasAdminRights%==1 (
	ECHO .
	ECHO You need administrator rights to run!!!
	ECHO .
	GOTO END
)

REM ****************************************************************************************
REM Описываем переменные.
REM ****************************************************************************************

REM Глобальная переменная. Используется во всей сессии CMD
set ScriptPath=%~dp0

REM set PathToWallpaper="%ScriptPath%Distr\noarch\Wallpaper.jpg"

REM set PathToSoftium="%ScriptPath%Distr\noarch\softiumscan.exe"

REM set PathToRegTaskbar="%ScriptPath%Distr\noarch\PinnedTaskbar.reg"
REM set PathToTaskbarFolder="%ScriptPath%Distr\noarch\QuickLaunch.zip"

REM PathToUserTaskBar, вероятно, не используется...
set PathToUserTaskBar="%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"

REM set PathToComputerLNK="%ScriptPath%Distr\noarch\computer.lnk"
REM set PathToChromeDefault="%ScriptPath%Distr\noarch\Chrome.reg"

REM Не используется
REM set PathToRestrictRunReg="%ScriptPath%Distr\noarch\RestrictRun.reg"
REM set PathToRestrictRunPs1="%ScriptPath%Distr\noarch\RestrictRun.ps1"

REM set PathToGroupPolicy="%ScriptPath%Distr\noarch\GroupPolicy.zip"

REM set PathToDelWindowsApps="%ScriptPath%Distr\noarch\DelWindowsApps.ps1"

rem set PathToWget="%ScriptPath%Distr\x32\wget.exe"
rem set PathToWget-x64="%ScriptPath%Distr\x64\wget.exe"

REM set PathTolnk="%SystemDrive%\ProgramData\Softium\lnk_create.js"

REM set PathTo7Zip="%ScriptPath%Distr\x32\7z2301.msi"
REM set PathTo7Zip-x64="%ScriptPath%Distr\x64\7z2301-x64.msi"

REM set PathToAdobeAIR="%ScriptPath%Distr\noarch\AdobeAIR.exe"

REM set PathToScratch="%ScriptPath%Distr\noarch\Scratch-461.exe"

REM set PathToScratchDesktop="%ScriptPath%Distr\noarch\Scratch 3.29.1 Setup.exe"

REM set PathToGIMP="%ScriptPath%Distr\noarch\gimp-2.10.34-setup-2.exe"

REM set PathToGoogleChrome="%ScriptPath%Distr\x32\ChromeStandaloneSetup.exe"
REM set PathToGoogleChrome-x64="%ScriptPath%Distr\x64\ChromeStandaloneSetup64.exe"

REM set PathToBABYTYPE2000="%ScriptPath%Distr\noarch\BABYTYPE2000.zip"

REM set PathTosnap="%ScriptPath%Distr\noarch\Snap-9.0.5.zip"

REM set PathToNotepad="%ScriptPath%Distr\x32\npp.8.5.7.Installer.exe"
REM set PathToNotepad-x64="%ScriptPath%Distr\x64\npp.8.5.7.Installer.x64.exe"

REM set PathToconstruct="%ScriptPath%Distr\noarch\construct2-r280-setup.exe"

REM set PathToPlayer="%ScriptPath%Distr\noarch\SWF.max-2.3.exe"
REM set PathToFlashOCX="%ScriptPath%Distr\noarch\Flash.ocx"

REM set PathToAnimate="%ScriptPath%Distr\noarch\animate.swf"
REM set PathToAnimateIco="%ScriptPath%Distr\noarch\animate.ico"

REM set PathToxnafx="%ScriptPath%Distr\noarch\xnafx40_redist.msi"
REM set PathToKodu="%ScriptPath%Distr\noarch\KoduSetup_1.6.18.0.msi"

REM set PathToPython3="%ScriptPath%Distr\noarch\python-3.11.5.exe"

set PathToOOSU10="%ScriptPath%Distr\noarch\OOSU10.exe"
set PathToOOSU10-CFG="%ScriptPath%Distr\noarch\ooshutup10.cfg"

REM set PathToSetuserFTA="%ScriptPath%Distr\noarch\SetUserFTA\*"

REM ****************************************************************************************
REM Удалим всё с общего рабочего стола
REM ****************************************************************************************

del "%SystemDrive%\Users\Public\Desktop\*" /q /s /f
forfiles /P "%SystemDrive%\Users\Public\Desktop" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

REM ****************************************************************************************
REM Скопируем файлы на настраиваемый компьютер
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\CopyFilesToPC.bat"

REM ****************************************************************************************
REM Установим программу Softium для обучающегося
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallSoftiumscan.bat"

REM ****************************************************************************************
REM Настраиваем учётные записи пользователей на компьютере
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\UserAccounts.bat"

REM ****************************************************************************************
REM Отключим автоматическое обновление системы
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\DisableWindowsUpdates.bat"

REM ****************************************************************************************
REM Отключим службу поиска Windows
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\DisableWindowsSearch.bat"

REM ****************************************************************************************
REM Включим на время работы скрипта режим электропитания "Высокая производительность"
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\HighPerformanceOn.bat"

REM ****************************************************************************************
REM Настроим дополнительные параметры электропитания
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\PowerSupplyParameters.bat"

REM ****************************************************************************************
REM Запланируем на всякий случай ежедневное выключение в 21:00
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\ScheduleShutdown.bat"

REM ****************************************************************************************
REM Включим административные папки
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\EnableAdministrativeFolders.bat"

REM ****************************************************************************************
REM Настроим межсетевой экран
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\FirewallSettings.bat"

REM ****************************************************************************************
REM Начинаем устанавливать все программы по очереди
REM ****************************************************************************************

REM Переходим на системный диск
%SystemDrive%

REM Начинаем ставить утилиты и программы

REM ****************************************************************************************
REM Устанавливаем SetuserFTA
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallSetuserFTA.bat"

REM ****************************************************************************************
REM Устанавливаем wget
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallWGET.bat"

REM ****************************************************************************************
REM Устанавливаем программу-архиватор 7zip
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\Install7Zip.bat"

REM ****************************************************************************************
REM Устанавливаем AdobeAIR + Scratch 2
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallScratch.bat"

REM ****************************************************************************************
REM Устанавливаем Scratch 3
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallScratch3.bat"

REM ****************************************************************************************
REM Устанавливаем GIMP
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallGIMP.bat"

REM ****************************************************************************************
REM Устанавливаем Google Chrome
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallGoogleChrome.bat"

REM ****************************************************************************************
REM Устанавливаем BABYTYPE2000
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallBABYTYPE2000.bat"

REM ****************************************************************************************
REM Устанавливаем Snap
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallSnap.bat"

REM ****************************************************************************************
REM Устанавливаем Notepad++
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallNotepad++.bat"

REM ****************************************************************************************
REM Устанавливаем Construct
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallConstruct.bat"

REM ****************************************************************************************
REM Устанавливаем SWF_Player + Animate
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallAnimate.bat"

REM ****************************************************************************************
REM Устанавливаем Kodu
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallKodu.bat"

REM ****************************************************************************************
REM Устанавливаем Python 3
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallPython3.bat"

REM ****************************************************************************************
REM Отбражаем Мой компьютер
REM ****************************************************************************************
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f

REM ****************************************************************************************
REM Создадим недостающие ярлыки
REM ****************************************************************************************

REM + Блокнот
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "%windir%\system32\notepad.exe" "%HOMEDRIVE%%HOMEPATH%" "Блокнот" "%windir%\system32\notepad.exe" "Текстовый редактор Блокнот"

REM + Скрипт выключения
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "%SystemDrive%\ProgramData\Softium\shutdown.bat" "%HOMEDRIVE%%HOMEPATH%" "Выключить" "%SystemRoot%\System32\SHELL32.dll,27" "Выключение компьютера"

REM ****************************************************************************************
REM Настройки для Microsoft Edge
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\DeleteMicrosoftEdge.bat"

REM ****************************************************************************************
REM Удалим One Drive
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\DeleteOneDrive.bat"

Rem Удалим лишние программы

start "Title" /wait powershell -command "Set-ExecutionPolicy Bypass -Force"

start "Title" /wait powershell -File  "%SystemDrive%\ProgramData\Softium\DelWindowsApps.ps1"

REM Отключаем режим планшета
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v SignInMode /t REG_DWORD /d 2 /f

REM Установим собственную тему оформления

CALL "%ScriptPath%Scripts\SetSoftiumTheme.bat"

REM Включим защитника Windows

start "Title" /wait powershell -command "Set-MpPreference -DisableRealtimeMonitoring $false"

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableBehaviorMonitoring /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableOnAccessProtection /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableScanOnRealtimeEnable /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableIOAVProtection /t REG_DWORD /d 0 /f

REM включим режим электропитания "Экономия энергии"
	powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a

REM Отключим некоторые функции Windows
REM start "Title" /wait %PathToOOSU10% %PathToOOSU10-CFG% /quiet /nosrp

REM Установим имя компьютера
set /p MyHostname="Укажите имя компьютера: "
wmic computersystem where name="%computername%" call rename name="%MyHostname%"

Rem Установим параметры групповой политики

"%ProgramFiles%\7-Zip\7z.exe" x -y  "%SystemDrive%\ProgramData\Softium\GroupPolicy.zip" -o"%windir%\System32"

:CONTINUE
	ECHO .
	ECHO Всё!
	ECHO .
	ECHO Перезагрузка через 10 секунд...
:END

timeout 10 /nobreak

shutdown -r -f -t 00

EXIT /B
