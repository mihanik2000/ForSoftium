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

REM PathToUserTaskBar, вероятно, не используется...
set PathToUserTaskBar="%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"

set PathToOOSU10="%ScriptPath%Distr\noarch\OOSU10.exe"
set PathToOOSU10-CFG="%ScriptPath%Distr\noarch\ooshutup10.cfg"

REM Составляем основное меню программы

set BUserAccounts=1
set BDisWinUpdates=1
set BDelWinApps=1
set BGroupPolicy=1
set BClerAllUsersDesktop=1
set BClearSoftiumProfile=1

mode 128,32
cls

:StartMenu

echo Выберите параметры настройки рабочего места.
echo .

if %BUserAccounts%==1 (
		echo 1 - Настроить аккаунты пользователей - Да
	) else (
		echo 1 - Настроить аккаунты пользователей - Нет
	)

if %BDisWinUpdates%==1 (
		echo 2 - Отключить обновление Windows - Да
	) else (
		echo 2 - Отключить обновление Windows - Нет
	)

if %BDelWinApps%==1 (
		echo 3 - Удалить "лишние" программы Windows - Да
	) else (
		echo 3 - Удалить "лишние" программы Windows - Нет
	)

if %BGroupPolicy%==1 (
		echo 4 - Ограничить запуск программ - Да
	) else (
		echo 4 - Ограничить запуск программ - Нет
	)

if %BClerAllUsersDesktop%==1 (
		echo 5 - Очистить общий рабочий стол - Да
	) else (
		echo 5 - Очистить общий рабочий стол - Нет
	)

if %BClearSoftiumProfile%==1 (
		echo 6 - Установить скрипт очистки профиля ребёнка - Да
	) else (
		echo 6 - Установить скрипт очистки профиля ребёнка - Нет
	)

echo 7 - Выполнить скрипт с указанными ограничениями

echo 8 - Выполнить скрипт со значениями по-умолчанию

echo 9 - Прервать работу скрипта

CHOICE /C:123456789 /N /T 30 /D 6

cls

if %errorlevel%==1 (if %BUserAccounts%==1  (set BUserAccounts=0) else (set BUserAccounts=1))

if %errorlevel%==2 (if %BDisWinUpdates%==1  (set BDisWinUpdates=0) else (set BDisWinUpdates=1))

if %errorlevel%==3 (if %BDelWinApps%==1  (set BDelWinApps=0) else (set BDelWinApps=1))

if %errorlevel%==4 (if %BGroupPolicy%==1  (set BGroupPolicy=0) else (set BGroupPolicy=1))

if %errorlevel%==5 (if %BClerAllUsersDesktop%==1  (set BClerAllUsersDesktop=0) else (set BClerAllUsersDesktop=1))

if %errorlevel%==6 (if %BClearSoftiumProfile%==1  (set BClearSoftiumProfile=0) else (set BClearSoftiumProfile=1))

if %errorlevel%==7 (goto MyStart)

if %errorlevel%==8 (goto SetDefVal)

if %errorlevel%==9 (EXIT /B)

GOTO StartMenu

:SetDefVal

set BUserAccounts=1
set BDisWinUpdates=1
set BDelWinApps=1
set BGroupPolicy=1
set BClerAllUsersDesktop=1
set BClearSoftiumProfile=1

:MyStart

REM ****************************************************************************************
REM Удалим всё с общего рабочего стола
REM ****************************************************************************************

if %BClerAllUsersDesktop%==1 (
	del "%SystemDrive%\Users\Public\Desktop\*" /q /s /f
	forfiles /P "%SystemDrive%\Users\Public\Desktop" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"
	)

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

if %BUserAccounts%==1 (
	CALL "%ScriptPath%Scripts\UserAccounts.bat"
	)

REM ****************************************************************************************
REM Отключим автоматическое обновление системы
REM ****************************************************************************************

if %BDisWinUpdates%==1 (
	CALL "%ScriptPath%Scripts\DisableWindowsUpdates.bat"
	)

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
REM Устанавливаем программу-архиватор 7zip и ассоциируем её с архивными файлами
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\Install7Zip.bat"
CALL "%ScriptPath%Scripts\7Zip-associate.bat"

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

Rem Удалим лишние программы Windows
if %BDelWinApps%==1 (
	start "Title" /wait powershell -command "Set-ExecutionPolicy Bypass -Force"
	start "Title" /wait powershell -File  "%SystemDrive%\ProgramData\Softium\DelWindowsApps.ps1"
	)

REM Отключаем режим планшета
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v SignInMode /t REG_DWORD /d 2 /f

REM Установим собственную тему оформления

CALL "%ScriptPath%Scripts\SetSoftiumTheme.bat"

REM Включим защитника Windows

powershell -command "Set-MpPreference -DisableArchiveScanning $false"
powershell -command "Set-MpPreference -DisableAutoExclusions $false"
powershell -command "Set-MpPreference -DisableBehaviorMonitoring $false"
powershell -command "Set-MpPreference -DisableBlockAtFirstSeen $false"
powershell -command "Set-MpPreference -DisableIOAVProtection $false"
powershell -command "Set-MpPreference -DisablePrivacyMode $false"
powershell -command "Set-MpPreference -DisableRealtimeMonitoring $false"
powershell -command "Set-MpPreference -DisableScanningNetworkFiles $false"
powershell -command "Set-MpPreference -DisableScriptScanning $false"

REM включим режим электропитания "Экономия энергии"
	powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a

REM Отключим некоторые функции Windows
REM start "Title" /wait %PathToOOSU10% %PathToOOSU10-CFG% /quiet /nosrp

REM Установим имя компьютера
set /p MyHostname="Укажите имя компьютера: "
wmic computersystem where name="%computername%" call rename name="%MyHostname%"

Rem Установим параметры групповой политики
if %BGroupPolicy%==1 (
	"%ProgramFiles%\7-Zip\7z.exe" x -y  "%SystemDrive%\ProgramData\Softium\GroupPolicy.7z" -o"%windir%\System32"
	)

ECHO .
ECHO Всё!
ECHO .
ECHO Перезагрузка через 10 секунд...
	
:END

timeout 10 /nobreak

shutdown -r -f -t 00

EXIT /B
