@echo off

Rem Скрипт установки пакета программ компьютеры Softium

Rem Windows XP не поддерживается!!!
ver | find "5.1."

If %errorlevel%==0  (
	Echo Windows XP unsupported!!!
	Exit /b 1
 ) 

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

set ScriptPath=%~dp0

set PathToWallpaper="%ScriptPath%Distr\noarch\Wallpaper.jpg"
set PathToSoftium="%ScriptPath%Distr\noarch\softiumscan.exe"
set PathToRegTaskbar="%ScriptPath%Distr\noarch\PinnedTaskbar.reg"
set PathToUserTaskBar="%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"
set PathToComputerLNK="%ScriptPath%Distr\noarch\computer.lnk"
set PathToChromeDefault="%ScriptPath%Distr\noarch\Chrome.reg"

set PathToWget="%ScriptPath%Distr\x32\wget.exe"
set PathToWget-x64="%ScriptPath%Distr\x64\wget.exe"

set PathTolnk="%ScriptPath%Distr\noarch\lnk_create.js"

set PathTo7Zip="%ScriptPath%Distr\x32\7z1900.msi"
set PathTo7Zip-x64="%ScriptPath%Distr\x64\7z1900-x64.msi"

set PathToAdobeAIR="%ScriptPath%Distr\noarch\AdobeAIR.exe"

set PathToScratch="%ScriptPath%Distr\noarch\Scratch-461.exe"

set PathToScratchDesktop="%ScriptPath%Distr\noarch\ScratchDesktopSetup3.15.0.exe"

set PathToGIMP="%ScriptPath%Distr\noarch\gimp-2.10.20-setup-1.exe"

set PathToGoogleChrome="%ScriptPath%Distr\x32\googlechromestandaloneenterprise.msi"
set PathToGoogleChrome-x64="%ScriptPath%Distr\x64\googlechromestandaloneenterprise64.msi"

set PathToBABYTYPE2000="%ScriptPath%Distr\noarch\BABYTYPE2000.zip"

set PathTosnap="%ScriptPath%Distr\noarch\Snap-6.1.4.zip"

set PathToNotepad="%ScriptPath%Distr\x32\npp.7.9.Installer.exe"
set PathToNotepad-x64="%ScriptPath%Distr\x64\npp.7.9.Installer.x64.exe"

set PathToconstruct="%ScriptPath%Distr\noarch\construct2-r279-setup.exe"

set PathToPlayer="%ScriptPath%Distr\noarch\SWF.max-2.3.exe"
set PathToFlashOCX="%ScriptPath%Distr\noarch\Flash.ocx"

set PathToAnimate="%ScriptPath%Distr\noarch\animate.swf"
set PathToAnimateIco="%ScriptPath%Distr\noarch\animate.ico"

set PathToxnafx="%ScriptPath%Distr\noarch\xnafx40_redist.msi"
set PathToKodu="%ScriptPath%Distr\noarch\KoduSetup.msi"

set PathToPython3="%ScriptPath%Distr\noarch\python-3.8.6.exe"

set PathToSetuserFTA="%ScriptPath%Distr\noarch\SetUserFTA\*"

Rem ****************************************************************************************
Rem Настраиваем учётные записи пользователей на компьютере
Rem ****************************************************************************************

Rem активируем встроенного Администратора
net user Администратор "AdminPass" /active:yes /expires:never

Rem Создадим пользователя Softium с паролем 321
net user Softium "321" /add /expires:never

Rem ****************************************************************************************
Rem Настроим некоторые необходимые параметры 
Rem ****************************************************************************************

Rem Отключим автоматическое обновление системы
net stop wuauserv
sc config wuauserv start= disabled

Rem Отключим службу поиска Windows
net stop WSearch
sc config WSearch start= disabled

Rem Включим на время работы скрипта режим электропитания "Высокая производительность"
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

Rem Никогда не отключать дисплей при питании от сети
powercfg /CHANGE -monitor-timeout-dc 0

Rem Никогда не отключать диск при питании от сети
powercfg /CHANGE -disk-timeout-dc 0

Rem Никогда не уходить в режим ожидания при питании от сети
powercfg /CHANGE -standby-timeout-dc 0

Rem Никогда не уходить в режим сна при питании от сети
powercfg /CHANGE -hibernate-timeout-dc 0

Rem отключаем спящий режим
powercfg -hibernate off
reg ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power /v HiberFileSizePercent /t REG_DWORD /d 0 /f
reg ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power /v HibernateEnabled /t REG_DWORD /d 0 /f

Rem Запланируем на всякий случай ежедневное выключение в полночь
SCHTASKS /Create /RU "NT AUTHORITY\SYSTEM" /SC DAILY /TN "Microsoft\Office\Office Shutdown" /TR  "\"C:\Windows\System32\shutdown.exe\" /s /f /t 00"  /ST 00:00 /RL HIGHEST

Rem Включаем ADMIN шару
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v LocalAccountTokenFilterPolicy /t reg_sz /d 1 /f

Rem Включим межсетевой экран
netsh advfirewall set allprofiles state on

Rem Разрешим отвечать на ping 
netsh firewall set icmpsetting 8

Rem ****************************************************************************************
Rem Начинаем устанавливать все программы по очереди
Rem ****************************************************************************************

Rem Переходим на системный диск
%SystemDrive%

Rem Начинаем ставить утилиты и программы

Rem SetuserFTA - Программа для управления защищёнными настройками Windows 10.
Rem Сайт разработчика: http://kolbi.cz/blog/2017/10/25/setuserfta-userchoice-hash-defeated-set-file-type-associations-per-user/
Rem По русски: https://ru.desktopsupportpanel.com/izmenit-prilozheniya-po-umolchaniyu-brauzer-ili-sopostavleni

ECHO Install SetuserFTA...
ECHO .
mkdir  "%ProgramFiles%\SetuserFTA\"

copy /y %PathToSetuserFTA% "%ProgramFiles%\SetuserFTA\"

Rem Wget - не обязательный компонет. Можно не ставить. Но может пригодиться!!!
ECHO .
ECHO Install wget...
ECHO .
mkdir  "%ProgramFiles%\wget\"
	If exist "%SystemDrive%\Program Files (x86)" (
		copy /y %PathToWget-x64% "%ProgramFiles%\wget\wget.exe"
	) else (
		copy /y %PathToWget% "%ProgramFiles%\wget\wget.exe"
	)

Rem Добавим путь к wget в path
	setx PATH "%ProgramFiles%\wget\;%Path%"
	PATH=%ProgramFiles%\wget\;%Path%

Rem Добавляем утилиту wget.exe в исключения брандмауера Windows
	netsh advfirewall firewall del rule name="wget"
	netsh firewall add allowedprogram "%ProgramFiles%\wget\wget.exe" wget
	netsh advfirewall firewall add rule name="wget" dir=in action=allow program="%ProgramFiles%\wget\wget.exe"

ECHO .
ECHO Install 7-Zip...
ECHO .
 If exist "%SystemDrive%\Program Files (x86)" (
		start "Title" /wait %PathTo7Zip-x64% /passive /norestart
	) else (
		start "Title" /wait %PathTo7Zip% /passive /norestart
	)

ECHO .
ECHO Install AdobeAIR...
ECHO .
	start "Title" /wait %PathToAdobeAIR% -silent
 
ECHO .
ECHO Install Scratch Offline...
ECHO .
	start "Title" /wait %PathToScratch% -silent
 
	If exist "%SystemDrive%\Program Files (x86)" (
		cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles(x86)%\Scratch 2\Scratch 2.exe" "%USERPROFILE%" "Scratch 2" "%ProgramFiles(x86)%\Scratch 2\Scratch 2.exe" "Офлайн-редактор Scratch 2.0"
	 ) else (
		cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\Scratch 2\Scratch 2.exe" "%USERPROFILE%" "Scratch 2" "%ProgramFiles%\Scratch 2\Scratch 2.exe" "Офлайн-редактор Scratch 2.0"
	)

ECHO .
ECHO Install Scratch Desktop...
ECHO .
	start "Title" /wait %PathToScratchDesktop% /S /allusers

ECHO .
ECHO Install GIMP...
ECHO .
	start "Title" /wait %PathToGIMP% /SILENT /NORESTART /ALLUSERS

Rem Создадим  ссылку на GIMP
	cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\GIMP 2\bin\gimp-2.10.exe" "%USERPROFILE%" "GIMP" "%ProgramFiles%\GIMP 2\bin\gimp-2.10.exe" "Графический редактор GIMP"

ECHO .
ECHO Install Google Chrome...
ECHO .
	If exist "%SystemDrive%\Program Files (x86)" (
		start "Title" /wait %PathToGoogleChrome-x64% /passive /norestart
	 ) else (
 		start "Title" /wait %PathToGoogleChrome% /passive /norestart
 	)
	
Rem Сделаем Chrome браузером по-умолчанию.
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  http ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  https ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  .htm ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  .html ChromeHTML

ECHO .
ECHO Install BABYTYPE2000...
ECHO .
	"%ProgramFiles%\7-Zip\7z.exe" x -y  %PathToBABYTYPE2000% -oc:

Rem Создадим  ссылку на BABYTYPE
	cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\lnk_create.js" "AllUsersDesktop"  "" "C:\BABYTYPE2000\BABYTYPE.EXE" "C:\BABYTYPE2000" "BabyType" "%SystemRoot%\System32\SHELL32.dll,41" "Тренажер печати BabyType"

ECHO .
ECHO Install Snap...
ECHO .
	mkdir "%ProgramFiles%\SNAP"
	"%ProgramFiles%\7-Zip\7z.exe" x -y  %PathTosnap% -o"%ProgramFiles%\SNAP"

Rem Создадим  ссылку на Snap
	cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\SNAP\Snap-6.1.4\index.html" "%ProgramFiles%\SNAP\Snap-6.1.4" "Snap!" "%ProgramFiles%\SNAP\Snap-6.1.4\src\favicon.ico" "SNAP! Оффлайн версия"

ECHO .
ECHO Install Notepad++...
ECHO .
	If exist "%SystemDrive%\Program Files (x86)" (
		start "Title" /wait %PathToNotepad-x64% /S
	 ) else (
 		start "Title" /wait %PathToNotepad% /S
 	)

Rem Создадим  ссылку на Notepad
	cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\Notepad++\notepad++.exe" "%ProgramFiles%\Notepad++" "Notepad++" "%ProgramFiles%\Notepad++\notepad++.exe" "Текстовый редактор Notepad++"

ECHO .
ECHO Install Construct...
ECHO .
	start "Title" /wait %PathToconstruct% /verysilent

Rem Создадим  ссылку на construct2
	cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\Construct 2\Construct2.exe" "%ProgramFiles%\Construct 2" "Construct2" "%ProgramFiles%\Construct 2\Construct2.exe" "The HTML5 game and app creator by Scirra."

ECHO .
ECHO Install SWF_Player...
ECHO .
	start "Title" /wait %PathToPlayer% /silent
	If exist "%SystemDrive%\Program Files (x86)" (
			copy /y %PathToFlashOCX% "C:\Program Files (x86)\SWF.max\Media\Binary\Flash.ocx"
	 ) else (
			copy /y %PathToFlashOCX% "C:\Program Files\SWF.max\Media\Binary\Flash.ocx"
	)

ECHO .
ECHO Install Animate...
ECHO .
	mkdir "%ProgramFiles%\Animate"
	copy /y %PathToAnimate% "%ProgramFiles%\Animate\animate.swf"
	copy /y %PathToAnimateIco% "%ProgramFiles%\Animate\animate.ico"
	
Rem Создадим  ссылку на Animate
	cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\Animate\animate.swf" "%USERPROFILE%" "Сделай мульт" "%ProgramFiles%\Animate\animate.ico" "Animate (для начального уровня)."

ECHO .
ECHO Install Kodu...
ECHO .
	start "Title" /wait %PathToxnafx% /passive /norestart
	start "Title" /wait %PathToKodu% /passive /norestart

Rem Удалим лишнюю ссылку Kodu
	cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\file_delete.js" "AllUsersDesktop" "\Configure Kodu Game Lab.lnk"

ECHO .
ECHO Install Python 3...
ECHO .
	start "Title" /wait %PathToPython3% /quiet InstallAllUsers=1 PrependPath=1 DefaultAllUsersTargetDir="C:\Python3" AssociateFiles=1 Shortcuts=1
	
	PATH=C:\Python3\;C:\Python3\Scripts;%Path%
	python.exe -m pip install --upgrade pip
	pip install pywin32
	pip install pygame
	pip install WMI

Rem Создадим ссылку на IDLE
	cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\lnk_create.js" "AllUsersDesktop"  ""  "C:\Python3\Lib\idlelib\idle.pyw" "C:\Python3" "Python IDLE" "C:\Python3\pythonw.exe" "Python IDLE"

Rem Скопируем дополнительные файлы
	mkdir "C:\ProgramData\Softium"
	mkdir "C:\Softium"
	copy /y %PathToWallpaper% "C:\ProgramData\Softium\Wallpaper.jpg"
	copy /y %PathToSoftium% "C:\Softium\softiumscan.exe"
	copy /y %PathToRegTaskbar% "C:\ProgramData\Softium\PinnedTaskbar.reg"
	copy /y %PathToComputerLNK% "C:\ProgramData\Softium\computer.lnk"
	copy /y %PathToChromeDefault% "C:\ProgramData\Softium\Chrome.reg"
	copy /y "%ScriptPath%Distr\noarch\lnk_create.js" "C:\ProgramData\Softium\lnk_create.js"
	copy /y "%ScriptPath%Distr\noarch\file_delete.js" "C:\ProgramData\Softium\file_delete.js"
	copy /y "%ScriptPath%step 3 - user - CleanUp.bat" "C:\ProgramData\Softium\step 3 - user - CleanUp.bat"
	copy /y "%ScriptPath%step 3 - user - CleanUp.bat" "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\StartUp\step 3 - user - CleanUp.bat"

Rem Создадим недостающие ярлыки
Rem + Softium
	cscript /nologo /e:jscript "C:\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "C:\Softium\softiumscan.exe" "C:\Softium\" "Софтиум" "C:\Softium\softiumscan.exe" "Софтиум"

Rem + Блокнот
	cscript /nologo /e:jscript "C:\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "%windir%\system32\notepad.exe" "%HOMEDRIVE%%HOMEPATH%" "Блокнот" "%windir%\system32\notepad.exe" "Текстовый редактор Блокнот"

Rem Отбражаем Мой компьютер
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f

Rem Удалим лишние ярлыки
Rem - Microsoft Edge
	cscript /nologo /e:jscript "C:\ProgramData\Softium\file_delete.js" "Desktop" "\Microsoft Edge.lnk"
	
Rem Запретим в дальнейшем создавать ярлык для Microsoft Edge на рабочем столе
	reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer /v "DisableEdgeDesktopShortcutCreation" /t REG_DWORD /d "1" /f
	
Rem - SWF.max Flash Player
	cscript /nologo /e:jscript "C:\ProgramData\Softium\file_delete.js" "Desktop" "\SWF.max Flash Player.lnk"

Rem Отключаем режим планшета
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v SignInMode /t REG_DWORD /d 2 /f

Rem Устанавливаем обои рабочего стола
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "C:\ProgramData\Softium\Wallpaper.jpg" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\BackUpWallpaper" /v Wallpaper /t REG_SZ /d "C:\ProgramData\Softium\Wallpaper.jpg" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\Wallpaper" /v Wallpaper /t REG_SZ /d "C:\ProgramData\Softium\Wallpaper.jpg" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\Wallpaper" /v WallpaperSource /t REG_SZ /d "C:\ProgramData\Softium\Wallpaper.jpg" /f

Rem Настроим панель задач
del "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*" /q /s
cscript /nologo /e:jscript "C:\ProgramData\Softium\lnk_create.js" ""  %PathToUserTaskBar% "%ProgramFiles%\Google\Chrome\Application\chrome.exe" "%ProgramFiles%\Google\Chrome\Application" "Google Chrome" "%ProgramFiles%\Google\Chrome\Application\chrome.exe" "Доступ в Интернет"
cscript /nologo /e:jscript "C:\ProgramData\Softium\lnk_create.js" ""  %PathToUserTaskBar% "%ProgramFiles%\Scratch Desktop\Scratch Desktop.exe" "%ProgramFiles%\Scratch Desktop" "Scratch Desktop" "%ProgramFiles%\Scratch Desktop\Scratch Desktop.exe" "Scratch Desktop"
If exist "%SystemDrive%\Program Files (x86)" (
	cscript /nologo /e:jscript "C:\ProgramData\Softium\lnk_create.js" "" %PathToUserTaskBar% "%ProgramFiles(x86)%\Scratch 2\Scratch 2.exe" "%USERPROFILE%" "Scratch 2" "%ProgramFiles(x86)%\Scratch 2\Scratch 2.exe" "Офлайн-редактор Scratch 2.0"
 ) else (
	cscript /nologo /e:jscript "C:\ProgramData\Softium\lnk_create.js" ""  %PathToUserTaskBar% "%ProgramFiles%\Scratch 2\Scratch 2.exe" "%USERPROFILE%" "Scratch 2" "%ProgramFiles%\Scratch 2\Scratch 2.exe" "Офлайн-редактор Scratch 2.0"
)
copy /y "C:\ProgramData\Softium\computer.lnk" "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\computer.lnk"
regedit.exe /s "C:\ProgramData\Softium\PinnedTaskbar.reg"

Rem Применим настройки
TASKKILL /F /IM explorer.exe
start explorer.exe

rem ****************************************************************************************
rem Удаляем Edge Chromium
rem ****************************************************************************************

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

rem ****************************************************************************************
rem Запрещаем обновляться до Edge Chromium
rem ****************************************************************************************
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v DoNotUpdateToEdgeWithChromium /t REG_DWORD /d 1 /f

Rem Удалим One Drive
taskkill /f /im OneDrive.exe
	If exist "%SystemDrive%\Program Files (x86)" (
		start "Title" /wait %SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
	 ) else (
 		start "Title" /wait %SystemRoot%\System32\OneDriveSetup.exe /uninstall
 	)

Rem Включим защитника Windows
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableBehaviorMonitoring /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableOnAccessProtection /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableScanOnRealtimeEnable /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableIOAVProtection /t REG_DWORD /d 0 /f

powershell -command "Set-MpPreference -DisableRealtimeMonitoring $false"

rem Отключим автоматическое обновление системы
sc config wuauserv start= disabled

Rem Отключаем автоматическое обновление
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f

Rem включим режим электропитания "Экономия энергии"
	powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a

Rem Установим имя компьютера
set /p MyHostname="Укажите имя компьютера: "
wmic computersystem where name="%computername%" call rename name="%MyHostname%"

:CONTINUE
	ECHO .
	ECHO Всё!
	ECHO .
	ECHO Перезагрузка через 10 секунд...
:END

timeout 10 /nobreak

shutdown -r -f -t 00

EXIT /B
