@echo off

Rem Скрипт установки пакета программ на компьютеры Softium

Rem ****************************************************************************************
Rem Проверяем наличие у пользователя админских прав...
Rem ****************************************************************************************

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

Rem ****************************************************************************************
Rem Описываем переменные.
Rem ****************************************************************************************

Rem Глобальная переменная. Используется во всей сессии CMD
set ScriptPath=%~dp0

Rem PathToUserTaskBar, вероятно, не используется...
set PathToUserTaskBar="%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"

set PathToOOSU10="%ScriptPath%Distr\noarch\OOSU10.exe"
set PathToOOSU10-CFG="%ScriptPath%Distr\noarch\ooshutup10.cfg"

Rem Составляем основное меню программы

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

Rem Настройка учётных записей пользователей на компьютере
if %errorlevel%==1 (if %BUserAccounts%==1  (set BUserAccounts=0) else (set BUserAccounts=1))

Rem Отключение автоматического обновление системы
if %errorlevel%==2 (if %BDisWinUpdates%==1  (set BDisWinUpdates=0) else (set BDisWinUpdates=1))

Rem Удаление "лишних" программ Windows
if %errorlevel%==3 (if %BDelWinApps%==1  (set BDelWinApps=0) else (set BDelWinApps=1))

Rem Настройка групповой политики на ПК
if %errorlevel%==4 (if %BGroupPolicy%==1  (set BGroupPolicy=0) else (set BGroupPolicy=1))

Rem Удаление файлов с общего рабочего стола
if %errorlevel%==5 (if %BClerAllUsersDesktop%==1  (set BClerAllUsersDesktop=0) else (set BClerAllUsersDesktop=1))

Rem установка скрипта очистки профиля пользователя
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

Rem ****************************************************************************************
Rem Удалим всё с общего рабочего стола
Rem ****************************************************************************************

if %BClerAllUsersDesktop%==1 (
	del "%SystemDrive%\Users\Public\Desktop\*" /q /s /f
	forfiles /P "%SystemDrive%\Users\Public\Desktop" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"
	)

Rem ****************************************************************************************
Rem Скопируем файлы на настраиваемый компьютер
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\CopyFilesToPC.bat"

Rem ****************************************************************************************
Rem Установим программу Softium для обучающегося
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallSoftiumscan.bat"

Rem ****************************************************************************************
Rem Настраиваем учётные записи пользователей на компьютере
Rem ****************************************************************************************

if %BUserAccounts%==1 (
	CALL "%ScriptPath%Scripts\UserAccounts.bat"
	)

Rem ****************************************************************************************
Rem Отключим автоматическое обновление системы
Rem ****************************************************************************************

if %BDisWinUpdates%==1 (
	CALL "%ScriptPath%Scripts\DisableWindowsUpdates.bat"
	)

Rem ****************************************************************************************
Rem Отключим службу поиска Windows
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\DisableWindowsSearch.bat"

Rem ****************************************************************************************
Rem Включим на время работы скрипта режим электропитания "Высокая производительность"
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\HighPerformanceOn.bat"

Rem ****************************************************************************************
Rem Настроим дополнительные параметры электропитания
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\PowerSupplyParameters.bat"

Rem ****************************************************************************************
Rem Запланируем на всякий случай ежедневное выключение в 21:00
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\ScheduleShutdown.bat"

Rem ****************************************************************************************
Rem Включим административные папки
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\EnableAdministrativeFolders.bat"

Rem ****************************************************************************************
Rem Настроим межсетевой экран
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\FirewallSettings.bat"

Rem ****************************************************************************************
Rem Начинаем устанавливать все программы по очереди
Rem ****************************************************************************************

Rem Переходим на системный диск
%SystemDrive%

Rem Начинаем ставить утилиты и программы

Rem ****************************************************************************************
Rem Устанавливаем SetuserFTA
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallSetuserFTA.bat"

Rem ****************************************************************************************
Rem Устанавливаем BGInfo
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallBGInfo.bat"

Rem ****************************************************************************************
Rem Устанавливаем wget
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallWGET.bat"

Rem ****************************************************************************************
Rem Устанавливаем программу-архиватор 7zip и ассоциируем её с архивными файлами
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\Install7Zip.bat"
CALL "%ScriptPath%Scripts\7Zip-associate.bat"

Rem ****************************************************************************************
Rem Устанавливаем AdobeAIR + Scratch 2
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallScratch.bat"

Rem ****************************************************************************************
Rem Устанавливаем Scratch 3
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallScratch3.bat"

Rem ****************************************************************************************
Rem Устанавливаем GIMP
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallGIMP.bat"

Rem ****************************************************************************************
Rem Устанавливаем Google Chrome
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallGoogleChrome.bat"

Rem ****************************************************************************************
Rem Устанавливаем BABYTYPE2000
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallBABYTYPE2000.bat"

Rem ****************************************************************************************
Rem Устанавливаем Snap
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallSnap.bat"

Rem ****************************************************************************************
Rem Устанавливаем Notepad++
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallNotepad++.bat"

Rem ****************************************************************************************
Rem Устанавливаем Construct
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallConstruct.bat"

Rem ****************************************************************************************
Rem Устанавливаем SWF_Player + Animate
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallAnimate.bat"

Rem ****************************************************************************************
Rem Устанавливаем Kodu
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallKodu.bat"

Rem ****************************************************************************************
Rem Устанавливаем Python 3
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallPython3.bat"

Rem ****************************************************************************************
Rem Отбражаем Мой компьютер
Rem ****************************************************************************************
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f

Rem ****************************************************************************************
Rem Создадим недостающие ярлыки
Rem ****************************************************************************************

Rem + Блокнот
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "%windir%\system32\notepad.exe" "%HOMEDRIVE%%HOMEPATH%" "Блокнот" "%windir%\system32\notepad.exe" "Текстовый редактор Блокнот"

Rem + Скрипт выключения
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "%SystemDrive%\ProgramData\Softium\shutdown.bat" "%HOMEDRIVE%%HOMEPATH%" "Выключить" "%SystemRoot%\System32\SHELL32.dll,27" "Выключение компьютера"

Rem ****************************************************************************************
Rem Настройки для Microsoft Edge
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\DeleteMicrosoftEdge.bat"

Rem ****************************************************************************************
Rem Удалим One Drive
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\DeleteOneDrive.bat"

Rem Удалим лишние программы Windows
if %BDelWinApps%==1 (
	start "Title" /wait powershell -command "Set-ExecutionPolicy Bypass -Force"
	start "Title" /wait powershell -File  "%SystemDrive%\ProgramData\Softium\DelWindowsApps.ps1"
	)

Rem Отключаем режим планшета
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v SignInMode /t REG_DWORD /d 2 /f

Rem Установим собственную тему оформления
	CALL "%ScriptPath%Scripts\SetLockScreen.bat"
	CALL "%ScriptPath%Scripts\SetSoftiumTheme.bat"

Rem Включим защитника Windows

powershell -command "Set-MpPreference -DisableArchiveScanning $false"
powershell -command "Set-MpPreference -DisableAutoExclusions $false"
powershell -command "Set-MpPreference -DisableBehaviorMonitoring $false"
powershell -command "Set-MpPreference -DisableBlockAtFirstSeen $false"
powershell -command "Set-MpPreference -DisableIOAVProtection $false"
powershell -command "Set-MpPreference -DisablePrivacyMode $false"
powershell -command "Set-MpPreference -DisableRealtimeMonitoring $false"
powershell -command "Set-MpPreference -DisableScanningNetworkFiles $false"
powershell -command "Set-MpPreference -DisableScriptScanning $false"

Rem включим режим электропитания "Экономия энергии"
	powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a

Rem Отключим некоторые функции Windows
Rem start "Title" /wait %PathToOOSU10% %PathToOOSU10-CFG% /quiet /nosrp

Rem Установим имя компьютера
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
