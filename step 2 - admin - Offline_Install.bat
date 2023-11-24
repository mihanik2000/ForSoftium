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

set ScriptPath=%~dp0

set PathToWallpaper="%ScriptPath%Distr\noarch\Wallpaper.jpg"

set PathToSoftium="%ScriptPath%Distr\noarch\softiumscan.exe"

set PathToRegTaskbar="%ScriptPath%Distr\noarch\PinnedTaskbar.reg"
set PathToTaskbarFolder="%ScriptPath%Distr\noarch\QuickLaunch.zip"

set PathToUserTaskBar="%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"
set PathToComputerLNK="%ScriptPath%Distr\noarch\computer.lnk"
set PathToChromeDefault="%ScriptPath%Distr\noarch\Chrome.reg"

set PathToRestrictRunReg="%ScriptPath%Distr\noarch\RestrictRun.reg"
set PathToRestrictRunPs1="%ScriptPath%Distr\noarch\RestrictRun.ps1"

set PathToGroupPolicy="%ScriptPath%Distr\noarch\GroupPolicy.zip"

set PathToDelWindowsApps="%ScriptPath%Distr\noarch\DelWindowsApps.ps1"

set PathToWget="%ScriptPath%Distr\x32\wget.exe"
set PathToWget-x64="%ScriptPath%Distr\x64\wget.exe"

set PathTolnk="%ScriptPath%Distr\noarch\lnk_create.js"

set PathTo7Zip="%ScriptPath%Distr\x32\7z2301.msi"
set PathTo7Zip-x64="%ScriptPath%Distr\x64\7z2301-x64.msi"

set PathToAdobeAIR="%ScriptPath%Distr\noarch\AdobeAIR.exe"

set PathToScratch="%ScriptPath%Distr\noarch\Scratch-461.exe"

set PathToScratchDesktop="%ScriptPath%Distr\noarch\Scratch 3.29.1 Setup.exe"

set PathToGIMP="%ScriptPath%Distr\noarch\gimp-2.10.34-setup-2.exe"

set PathToGoogleChrome="%ScriptPath%Distr\x32\ChromeStandaloneSetup.exe"
set PathToGoogleChrome-x64="%ScriptPath%Distr\x64\ChromeStandaloneSetup64.exe"

set PathToBABYTYPE2000="%ScriptPath%Distr\noarch\BABYTYPE2000.zip"

set PathTosnap="%ScriptPath%Distr\noarch\Snap-9.0.5.zip"

set PathToNotepad="%ScriptPath%Distr\x32\npp.8.5.7.Installer.exe"
set PathToNotepad-x64="%ScriptPath%Distr\x64\npp.8.5.7.Installer.x64.exe"

set PathToconstruct="%ScriptPath%Distr\noarch\construct2-r280-setup.exe"

set PathToPlayer="%ScriptPath%Distr\noarch\SWF.max-2.3.exe"
set PathToFlashOCX="%ScriptPath%Distr\noarch\Flash.ocx"

set PathToAnimate="%ScriptPath%Distr\noarch\animate.swf"
set PathToAnimateIco="%ScriptPath%Distr\noarch\animate.ico"

set PathToxnafx="%ScriptPath%Distr\noarch\xnafx40_redist.msi"
set PathToKodu="%ScriptPath%Distr\noarch\KoduSetup_1.6.18.0.msi"

set PathToPython3="%ScriptPath%Distr\noarch\python-3.11.5.exe"

set PathToOOSU10="%ScriptPath%Distr\noarch\OOSU10.exe"
set PathToOOSU10-CFG="%ScriptPath%Distr\noarch\ooshutup10.cfg"

set PathToSetuserFTA="%ScriptPath%Distr\noarch\SetUserFTA\*"

REM Скопируем файлы на настраиваемый компьютер

REM создаём скрытую папку для хранения важных файлов
	mkdir "C:\ProgramData\Softium"

	copy /y %PathToWallpaper% "C:\ProgramData\Softium\Wallpaper.jpg"
	copy /y %PathToRegTaskbar% "C:\ProgramData\Softium\PinnedTaskbar.reg"
	copy /y %PathToTaskbarFolder% "C:\ProgramData\Softium\QuickLaunch.zip"
	copy /y %PathToGroupPolicy% "C:\ProgramData\Softium\GroupPolicy.zip"
	copy /y %PathToDelWindowsApps% "C:\ProgramData\Softium\DelWindowsApps.ps1"
	
	copy /y %PathToComputerLNK% "C:\ProgramData\Softium\computer.lnk"
	copy /y %PathToChromeDefault% "C:\ProgramData\Softium\Chrome.reg"
	copy /y "%ScriptPath%Distr\noarch\lnk_create.js" "C:\ProgramData\Softium\lnk_create.js"
	copy /y "%ScriptPath%Distr\noarch\file_delete.js" "C:\ProgramData\Softium\file_delete.js"
	copy /y "%ScriptPath%step 3 - user - CleanUp.bat" "C:\ProgramData\Softium\step 3 - user - CleanUp.bat"

REM Ограничение запуска программ. В разработке. Пока не используется.
	copy /y %PathToRestrictRunReg%="C:\ProgramData\Softium\RestrictRun.reg"
	copy /y %PathToRestrictRunPs1%="C:\ProgramData\Softium\RestrictRun.ps1"
	
REM создаём папку в корне диска для хранения рабочих файлов
	mkdir "C:\Softium"

REM Программа Softium для обучающегося
	copy /y %PathToSoftium% "C:\Softium\softiumscan.exe"

REM Добавляем программу softiumscan в исключения брандмауера Windows
	netsh advfirewall firewall del rule name="softiumscan"
	netsh firewall add allowedprogram "C:\Softium\softiumscan.exe" softiumscan
	netsh advfirewall firewall add rule name="softiumscan" dir=in action=allow program="C:\Softium\softiumscan.exe"

REM Скрипт очистки папок пользователей. Производит действия только для пользователя с именем Softium !!!
	copy /y "%ScriptPath%step 3 - user - CleanUp.bat" "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\StartUp\CleanUp.bat"

REM ****************************************************************************************
REM Настраиваем учётные записи пользователей на компьютере
REM ****************************************************************************************

REM активируем встроенного Администратора
net user Администратор "AdminPass" /active:yes /expires:never

REM Создадим пользователя Softium с паролем 321
net user Softium "321" /add /expires:never

REM ****************************************************************************************
REM Настроим некоторые необходимые параметры 
REM ****************************************************************************************

REM Отключим автоматическое обновление системы

net stop wuauserv
sc config wuauserv start= disabled

reg ADD HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate /v DoNotConnectToWindowsUpdateInternetLocations /t REG_DWORD /d 1 /f
reg ADD HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate /v DisableWindowsUpdateAccess /t REG_DWORD /d 1 /f
reg ADD HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate /v WUServer /t REG_SZ /d " " /f
reg ADD HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate /v WUStatusServer /t REG_SZ /d " " /f
reg ADD HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate /v UpdateServiceUrlAlternate /t REG_SZ /d " " /f
reg ADD HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate\AU /v UseWUServer /t REG_DWORD /d 1 /f

reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f

REM Отключим службу поиска Windows
net stop WSearch
sc config WSearch start= disabled

REM Включим на время работы скрипта режим электропитания "Высокая производительность"
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

REM Никогда не отключать дисплей при питании от сети
powercfg /CHANGE -monitor-timeout-dc 0

REM Никогда не отключать диск при питании от сети
powercfg /CHANGE -disk-timeout-dc 0

REM Никогда не уходить в режим ожидания при питании от сети
powercfg /CHANGE -standby-timeout-dc 0

REM Никогда не уходить в режим сна при питании от сети
powercfg /CHANGE -hibernate-timeout-dc 0

REM отключаем спящий режим
powercfg -hibernate off
reg ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power /v HiberFileSizePercent /t REG_DWORD /d 0 /f
reg ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power /v HibernateEnabled /t REG_DWORD /d 0 /f

REM Запланируем на всякий случай ежедневное выключение в полночь
SCHTASKS /Create /RU "NT AUTHORITY\SYSTEM" /SC DAILY /TN "Microsoft\Office\Office Shutdown" /TR  "\"C:\Windows\System32\shutdown.exe\" /s /f /t 00"  /ST 00:00 /RL HIGHEST

REM Включаем ADMIN шару
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v LocalAccountTokenFilterPolicy /t reg_sz /d 1 /f

REM Включим межсетевой экран
netsh advfirewall set allprofiles state on

REM Разрешим отвечать на ping 
netsh firewall set icmpsetting 8

REM ****************************************************************************************
REM Начинаем устанавливать все программы по очереди
REM ****************************************************************************************

REM Переходим на системный диск
%SystemDrive%

REM Начинаем ставить утилиты и программы

REM SetuserFTA - Программа для управления защищёнными настройками Windows 10.
REM Сайт разработчика: http://kolbi.cz/blog/2017/10/25/setuserfta-userchoice-hash-defeated-set-file-type-associations-per-user/
REM По русски: https://ru.desktopsupportpanel.com/izmenit-prilozheniya-po-umolchaniyu-brauzer-ili-sopostavleni

ECHO Install SetuserFTA...
ECHO .
mkdir  "%ProgramFiles%\SetuserFTA\"

copy /y %PathToSetuserFTA% "%ProgramFiles%\SetuserFTA\"

REM Wget - не обязательный компонет. Можно не ставить. Но может пригодиться!!!
ECHO .
ECHO Install wget...
ECHO .
mkdir  "%ProgramFiles%\wget\"
	If exist "%SystemDrive%\Program Files (x86)" (
		copy /y %PathToWget-x64% "%ProgramFiles%\wget\wget.exe"
	) else (
		copy /y %PathToWget% "%ProgramFiles%\wget\wget.exe"
	)

REM Добавим путь к wget в path
	setx PATH "%ProgramFiles%\wget\;%Path%"
	PATH=%ProgramFiles%\wget\;%Path%

REM Добавляем утилиту wget.exe в исключения брандмауера Windows
	netsh advfirewall firewall del rule name="wget"
	netsh firewall add allowedprogram "%ProgramFiles%\wget\wget.exe" wget
	netsh advfirewall firewall add rule name="wget" dir=in action=allow program="%ProgramFiles%\wget\wget.exe"

REM Устанавливаем программу-архиватор 7zip
ECHO .
ECHO Install 7-Zip...
ECHO .
 If exist "%SystemDrive%\Program Files (x86)" (
		start "Title" /wait %PathTo7Zip-x64% /passive /norestart
	) else (
		start "Title" /wait %PathTo7Zip% /passive /norestart
	)

REM Устанавливаем программу AdobeAIR
ECHO .
ECHO Install AdobeAIR...
ECHO .
	start "Title" /wait %PathToAdobeAIR% -silent

REM Устанавливаем программу Scratch 2
ECHO .
ECHO Install Scratch Offline...
ECHO .
	start "Title" /wait %PathToScratch% -silent
 
	If exist "%SystemDrive%\Program Files (x86)" (
		cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles(x86)%\Scratch 2\Scratch 2.exe" "%USERPROFILE%" "Scratch 2" "%ProgramFiles(x86)%\Scratch 2\Scratch 2.exe" "Офлайн-редактор Scratch 2.0"
	 ) else (
		cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\Scratch 2\Scratch 2.exe" "%USERPROFILE%" "Scratch 2" "%ProgramFiles%\Scratch 2\Scratch 2.exe" "Офлайн-редактор Scratch 2.0"
	)

REM Устанавливаем программу Scratch 3
ECHO .
ECHO Install Scratch Desktop...
ECHO .
	start "Title" /wait %PathToScratchDesktop% /S /allusers

REM Устанавливаем программу GIMP
ECHO .
ECHO Install GIMP...
ECHO .
	start "Install GIMP..." /wait %PathToGIMP% /SILENT /NORESTART /ALLUSERS

REM Создадим  ссылку на GIMP
	cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\GIMP 2\bin\gimp-2.10.exe" "%USERPROFILE%" "GIMP" "%ProgramFiles%\GIMP 2\bin\gimp-2.10.exe" "Графический редактор GIMP"

REM Устанавливаем программу Google Chrome
ECHO .
ECHO Install Google Chrome...
ECHO .
	If exist "%SystemDrive%\Program Files (x86)" (
		start "Install Google Chrome..." /wait %PathToGoogleChrome-x64% /silent /install
	 ) else (
 		start "Install Google Chrome..." /wait %PathToGoogleChrome% /silent /install
 	)
	
REM Сделаем Chrome браузером по-умолчанию.
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  http ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  https ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  .htm ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  .html ChromeHTML

REM Устанавливаем программу BABYTYPE2000
ECHO .
ECHO Install BABYTYPE2000...
ECHO .
	"%ProgramFiles%\7-Zip\7z.exe" x -y  %PathToBABYTYPE2000% -oc:

REM Создадим  ссылку на BABYTYPE
	cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\lnk_create.js" "AllUsersDesktop"  "" "C:\BABYTYPE2000\BABYTYPE.EXE" "C:\BABYTYPE2000" "BabyType" "%SystemRoot%\System32\SHELL32.dll,41" "Тренажер печати BabyType"

REM Устанавливаем программу Snap
ECHO .
ECHO Install Snap...
ECHO .
	mkdir "%ProgramFiles%\SNAP"
	"%ProgramFiles%\7-Zip\7z.exe" x -y  %PathTosnap% -o"%ProgramFiles%\SNAP"

REM Создадим  ссылку на Snap
	cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\SNAP\Snap-9.0.5\index.html" "%ProgramFiles%\SNAP\Snap-9.0.5" "Snap!" "%ProgramFiles%\SNAP\Snap-9.0.5\src\favicon.ico" "SNAP! Оффлайн версия"

REM Устанавливаем программу Notepad++
ECHO .
ECHO Install Notepad++...
ECHO .
	If exist "%SystemDrive%\Program Files (x86)" (
		start "Title" /wait %PathToNotepad-x64% /S
	 ) else (
 		start "Title" /wait %PathToNotepad% /S
 	)

REM Создадим  ссылку на Notepad
	cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\Notepad++\notepad++.exe" "%ProgramFiles%\Notepad++" "Notepad++" "%ProgramFiles%\Notepad++\notepad++.exe" "Текстовый редактор Notepad++"

REM Устанавливаем программу Construct
ECHO .
ECHO Install Construct...
ECHO .
	start "Title" /wait %PathToconstruct% /verysilent

REM Создадим  ссылку на construct2
	cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\Construct 2\Construct2.exe" "%ProgramFiles%\Construct 2" "Construct2" "%ProgramFiles%\Construct 2\Construct2.exe" "The HTML5 game and app creator by Scirra."

REM Устанавливаем программу SWF_Player
ECHO .
ECHO Install SWF_Player...
ECHO ВАЖНО!!!
ECHO Программу нужно устанавливать в ручном режиме.
ECHO Нет возможности установить программу автоматически.
ECHO .
	start "Title" /wait %PathToPlayer% /silent
	If exist "%SystemDrive%\Program Files (x86)" (
			copy /y %PathToFlashOCX% "C:\Program Files (x86)\SWF.max\Media\Binary\Flash.ocx"
	 ) else (
			copy /y %PathToFlashOCX% "C:\Program Files\SWF.max\Media\Binary\Flash.ocx"
	)

REM Удалим с рабочего стола ярлык SWF.max Flash Player
	cscript /nologo /e:jscript "C:\ProgramData\Softium\file_delete.js" "Desktop" "\SWF.max Flash Player.lnk"

REM Устанавливаем программу Animate (Создай мульт)
ECHO .
ECHO Install Animate...
ECHO .
	mkdir "%ProgramFiles%\Animate"
	copy /y %PathToAnimate% "%ProgramFiles%\Animate\animate.swf"
	copy /y %PathToAnimateIco% "%ProgramFiles%\Animate\animate.ico"
	
REM Создадим  ссылку на Animate
	cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\Animate\animate.swf" "%USERPROFILE%" "Сделай мульт" "%ProgramFiles%\Animate\animate.ico" "Animate (для начального уровня)."

REM Устанавливаем программу Kodu с необходимыми зависимостями
ECHO .
ECHO Install Kodu...
ECHO .
	start "Title" /wait %PathToxnafx% /passive /norestart
	start "Title" /wait %PathToKodu% /passive /norestart

REM Удалим лишнюю ссылку Kodu
	cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\file_delete.js" "AllUsersDesktop" "\Configure Kodu Game Lab.lnk"

REM Устанавливаем программу Python 3
ECHO .
ECHO Install Python 3...
ECHO .
	start "Title" /wait %PathToPython3% /quiet InstallAllUsers=1 PrependPath=1 DefaultAllUsersTargetDir="C:\Python3" AssociateFiles=1 Shortcuts=1
	
	PATH=C:\Python3\;C:\Python3\Scripts;%Path%
	python.exe -m pip install --upgrade pip
	pip install pywin32
	pip install pygame
	pip install WMI

REM Создадим ссылку на IDLE
	cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\lnk_create.js" "AllUsersDesktop"  ""  "C:\Python3\Lib\idlelib\idle.pyw" "C:\Python3" "Python IDLE" "C:\Python3\pythonw.exe" "Python IDLE"

REM Создадим недостающие ярлыки
REM + Softium
	cscript /nologo /e:jscript "C:\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "C:\Softium\softiumscan.exe" "C:\Softium\" "Софтиум" "C:\Softium\softiumscan.exe" "Софтиум"

REM + Блокнот
	cscript /nologo /e:jscript "C:\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "%windir%\system32\notepad.exe" "%HOMEDRIVE%%HOMEPATH%" "Блокнот" "%windir%\system32\notepad.exe" "Текстовый редактор Блокнот"

REM Отбражаем Мой компьютер
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f

REM Удалим лишние ярлыки
REM - Microsoft Edge
	cscript /nologo /e:jscript "C:\ProgramData\Softium\file_delete.js" "Desktop" "\Microsoft Edge.lnk"
	cscript /nologo /e:jscript "C:\ProgramData\Softium\file_delete.js" "AllUsersDesktop" "\Microsoft Edge.lnk"

REM Запретим в дальнейшем создавать ярлык для Microsoft Edge на рабочем столе
	reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer /v "DisableEdgeDesktopShortcutCreation" /t REG_DWORD /d "1" /f
	
REM Отключаем режим планшета
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v SignInMode /t REG_DWORD /d 2 /f

REM Устанавливаем обои рабочего стола
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "C:\ProgramData\Softium\Wallpaper.jpg" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\BackUpWallpaper" /v Wallpaper /t REG_SZ /d "C:\ProgramData\Softium\Wallpaper.jpg" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\Wallpaper" /v Wallpaper /t REG_SZ /d "C:\ProgramData\Softium\Wallpaper.jpg" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\Wallpaper" /v WallpaperSource /t REG_SZ /d "C:\ProgramData\Softium\Wallpaper.jpg" /f

REM ****************************************************************************************
REM Удаляем Edge Chromium
REM ****************************************************************************************

 If exist "%programfiles(x86)%" (
		cd "C:\Program Files (x86)\Microsoft\Edge\Application"
	) else (
		cd "C:\Program Files\Microsoft\Edge\Application"
	)

dir /b | findstr [0-9] > ver.txt
SET /p myvar= < ver.txt
cd %myvar%\Installer
setup.exe -uninstall -system-level -verbose-logging -force-uninstall

ECHO Ждём пока закончится удаление Edge Chromium 10 секунд...
timeout 10 /nobreak

REM ****************************************************************************************
REM Запрещаем обновляться до Edge Chromium
REM ****************************************************************************************
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v DoNotUpdateToEdgeWithChromium /t REG_DWORD /d 1 /f

REM Удалим One Drive
taskkill /f /im OneDrive.exe
	If exist "%SystemDrive%\Program Files (x86)" (
		start "Title" /wait %SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
	 ) else (
 		start "Title" /wait %SystemRoot%\System32\OneDriveSetup.exe /uninstall
 	)

Rem Удалим лишние программы

start "Title" /wait powershell -command "Set-ExecutionPolicy Bypass -Force"

start "Title" /wait powershell -File  "C:\ProgramData\Softium\DelWindowsApps.ps1"

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

"%ProgramFiles%\7-Zip\7z.exe" x -y  %PathToGroupPolicy% -o"%windir%\System32"

:CONTINUE
	ECHO .
	ECHO Всё!
	ECHO .
	ECHO Перезагрузка через 10 секунд...
:END

timeout 10 /nobreak

shutdown -r -f -t 00

EXIT /B
