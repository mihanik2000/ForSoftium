@echo off

REM ��ਯ� ��⠭���� ����� �ணࠬ� �� ��������� Softium

REM ****************************************************************************************
REM �஢��塞 ����稥 � ���짮��⥫� �����᪨� �ࠢ...
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
REM ����뢠�� ��६����.
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

REM ������㥬 䠩�� �� ����ࠨ����� ��������

REM ᮧ��� ������ ����� ��� �࠭���� ������ 䠩���
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

REM ��࠭�祭�� ����᪠ �ணࠬ�. � ࠧࠡ�⪥. ���� �� �ᯮ������.
	copy /y %PathToRestrictRunReg%="C:\ProgramData\Softium\RestrictRun.reg"
	copy /y %PathToRestrictRunPs1%="C:\ProgramData\Softium\RestrictRun.ps1"
	
REM ᮧ��� ����� � ��୥ ��᪠ ��� �࠭���� ࠡ��� 䠩���
	mkdir "C:\Softium"

REM �ணࠬ�� Softium ��� �����饣���
	copy /y %PathToSoftium% "C:\Softium\softiumscan.exe"

REM ������塞 �ணࠬ�� softiumscan � �᪫�祭�� �࠭����� Windows
	netsh advfirewall firewall del rule name="softiumscan"
	netsh firewall add allowedprogram "C:\Softium\softiumscan.exe" softiumscan
	netsh advfirewall firewall add rule name="softiumscan" dir=in action=allow program="C:\Softium\softiumscan.exe"

REM ��ਯ� ���⪨ ����� ���짮��⥫��. �ந������ ����⢨� ⮫쪮 ��� ���짮��⥫� � ������ Softium !!!
	copy /y "%ScriptPath%step 3 - user - CleanUp.bat" "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\StartUp\CleanUp.bat"

REM ****************************************************************************************
REM ����ࠨ���� ����� ����� ���짮��⥫�� �� ��������
REM ****************************************************************************************

REM ��⨢��㥬 ���஥����� �����������
net user ����������� "AdminPass" /active:yes /expires:never

REM �������� ���짮��⥫� Softium � ��஫�� 321
net user Softium "321" /add /expires:never

REM ****************************************************************************************
REM ����ந� ������� ����室��� ��ࠬ���� 
REM ****************************************************************************************

REM �⪫�稬 ��⮬���᪮� ���������� ��⥬�

net stop wuauserv
sc config wuauserv start= disabled

reg ADD HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate /v DoNotConnectToWindowsUpdateInternetLocations /t REG_DWORD /d 1 /f
reg ADD HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate /v DisableWindowsUpdateAccess /t REG_DWORD /d 1 /f
reg ADD HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate /v WUServer /t REG_SZ /d " " /f
reg ADD HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate /v WUStatusServer /t REG_SZ /d " " /f
reg ADD HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate /v UpdateServiceUrlAlternate /t REG_SZ /d " " /f
reg ADD HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate\AU /v UseWUServer /t REG_DWORD /d 1 /f

reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f

REM �⪫�稬 �㦡� ���᪠ Windows
net stop WSearch
sc config WSearch start= disabled

REM ����稬 �� �६� ࠡ��� �ਯ� ०�� ���ய�⠭�� "��᮪�� �ந�����⥫쭮���"
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

REM ������� �� �⪫���� ��ᯫ�� �� ��⠭�� �� ��
powercfg /CHANGE -monitor-timeout-dc 0

REM ������� �� �⪫���� ��� �� ��⠭�� �� ��
powercfg /CHANGE -disk-timeout-dc 0

REM ������� �� �室��� � ०�� �������� �� ��⠭�� �� ��
powercfg /CHANGE -standby-timeout-dc 0

REM ������� �� �室��� � ०�� ᭠ �� ��⠭�� �� ��
powercfg /CHANGE -hibernate-timeout-dc 0

REM �⪫�砥� ��騩 ०��
powercfg -hibernate off
reg ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power /v HiberFileSizePercent /t REG_DWORD /d 0 /f
reg ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power /v HibernateEnabled /t REG_DWORD /d 0 /f

REM ��������㥬 �� ��直� ��砩 ���������� �몫�祭�� � �������
SCHTASKS /Create /RU "NT AUTHORITY\SYSTEM" /SC DAILY /TN "Microsoft\Office\Office Shutdown" /TR  "\"C:\Windows\System32\shutdown.exe\" /s /f /t 00"  /ST 00:00 /RL HIGHEST

REM ����砥� ADMIN ���
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v LocalAccountTokenFilterPolicy /t reg_sz /d 1 /f

REM ����稬 ����⥢�� �࠭
netsh advfirewall set allprofiles state on

REM ����訬 �⢥��� �� ping 
netsh firewall set icmpsetting 8

REM ****************************************************************************************
REM ��稭��� ��⠭�������� �� �ணࠬ�� �� ��।�
REM ****************************************************************************************

REM ���室�� �� ��⥬�� ���
%SystemDrive%

REM ��稭��� �⠢��� �⨫��� � �ணࠬ��

REM SetuserFTA - �ணࠬ�� ��� �ࠢ����� �����묨 ����ன���� Windows 10.
REM ���� ࠧࠡ��稪�: http://kolbi.cz/blog/2017/10/25/setuserfta-userchoice-hash-defeated-set-file-type-associations-per-user/
REM �� ���᪨: https://ru.desktopsupportpanel.com/izmenit-prilozheniya-po-umolchaniyu-brauzer-ili-sopostavleni

ECHO Install SetuserFTA...
ECHO .
mkdir  "%ProgramFiles%\SetuserFTA\"

copy /y %PathToSetuserFTA% "%ProgramFiles%\SetuserFTA\"

REM Wget - �� ��易⥫�� ��������. ����� �� �⠢���. �� ����� �ਣ�������!!!
ECHO .
ECHO Install wget...
ECHO .
mkdir  "%ProgramFiles%\wget\"
	If exist "%SystemDrive%\Program Files (x86)" (
		copy /y %PathToWget-x64% "%ProgramFiles%\wget\wget.exe"
	) else (
		copy /y %PathToWget% "%ProgramFiles%\wget\wget.exe"
	)

REM ������� ���� � wget � path
	setx PATH "%ProgramFiles%\wget\;%Path%"
	PATH=%ProgramFiles%\wget\;%Path%

REM ������塞 �⨫��� wget.exe � �᪫�祭�� �࠭����� Windows
	netsh advfirewall firewall del rule name="wget"
	netsh firewall add allowedprogram "%ProgramFiles%\wget\wget.exe" wget
	netsh advfirewall firewall add rule name="wget" dir=in action=allow program="%ProgramFiles%\wget\wget.exe"

REM ��⠭�������� �ணࠬ��-��娢��� 7zip
ECHO .
ECHO Install 7-Zip...
ECHO .
 If exist "%SystemDrive%\Program Files (x86)" (
		start "Title" /wait %PathTo7Zip-x64% /passive /norestart
	) else (
		start "Title" /wait %PathTo7Zip% /passive /norestart
	)

REM ��⠭�������� �ணࠬ�� AdobeAIR
ECHO .
ECHO Install AdobeAIR...
ECHO .
	start "Title" /wait %PathToAdobeAIR% -silent

REM ��⠭�������� �ணࠬ�� Scratch 2
ECHO .
ECHO Install Scratch Offline...
ECHO .
	start "Title" /wait %PathToScratch% -silent
 
	If exist "%SystemDrive%\Program Files (x86)" (
		cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles(x86)%\Scratch 2\Scratch 2.exe" "%USERPROFILE%" "Scratch 2" "%ProgramFiles(x86)%\Scratch 2\Scratch 2.exe" "�䫠��-।���� Scratch 2.0"
	 ) else (
		cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\Scratch 2\Scratch 2.exe" "%USERPROFILE%" "Scratch 2" "%ProgramFiles%\Scratch 2\Scratch 2.exe" "�䫠��-।���� Scratch 2.0"
	)

REM ��⠭�������� �ணࠬ�� Scratch 3
ECHO .
ECHO Install Scratch Desktop...
ECHO .
	start "Title" /wait %PathToScratchDesktop% /S /allusers

REM ��⠭�������� �ணࠬ�� GIMP
ECHO .
ECHO Install GIMP...
ECHO .
	start "Install GIMP..." /wait %PathToGIMP% /SILENT /NORESTART /ALLUSERS

REM ��������  ��뫪� �� GIMP
	cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\GIMP 2\bin\gimp-2.10.exe" "%USERPROFILE%" "GIMP" "%ProgramFiles%\GIMP 2\bin\gimp-2.10.exe" "����᪨� ।���� GIMP"

REM ��⠭�������� �ணࠬ�� Google Chrome
ECHO .
ECHO Install Google Chrome...
ECHO .
	If exist "%SystemDrive%\Program Files (x86)" (
		start "Install Google Chrome..." /wait %PathToGoogleChrome-x64% /silent /install
	 ) else (
 		start "Install Google Chrome..." /wait %PathToGoogleChrome% /silent /install
 	)
	
REM ������� Chrome ��㧥஬ ��-㬮�砭��.
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  http ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  https ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  .htm ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  .html ChromeHTML

REM ��⠭�������� �ணࠬ�� BABYTYPE2000
ECHO .
ECHO Install BABYTYPE2000...
ECHO .
	"%ProgramFiles%\7-Zip\7z.exe" x -y  %PathToBABYTYPE2000% -oc:

REM ��������  ��뫪� �� BABYTYPE
	cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\lnk_create.js" "AllUsersDesktop"  "" "C:\BABYTYPE2000\BABYTYPE.EXE" "C:\BABYTYPE2000" "BabyType" "%SystemRoot%\System32\SHELL32.dll,41" "�७���� ���� BabyType"

REM ��⠭�������� �ணࠬ�� Snap
ECHO .
ECHO Install Snap...
ECHO .
	mkdir "%ProgramFiles%\SNAP"
	"%ProgramFiles%\7-Zip\7z.exe" x -y  %PathTosnap% -o"%ProgramFiles%\SNAP"

REM ��������  ��뫪� �� Snap
	cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\SNAP\Snap-9.0.5\index.html" "%ProgramFiles%\SNAP\Snap-9.0.5" "Snap!" "%ProgramFiles%\SNAP\Snap-9.0.5\src\favicon.ico" "SNAP! ��䫠�� �����"

REM ��⠭�������� �ணࠬ�� Notepad++
ECHO .
ECHO Install Notepad++...
ECHO .
	If exist "%SystemDrive%\Program Files (x86)" (
		start "Title" /wait %PathToNotepad-x64% /S
	 ) else (
 		start "Title" /wait %PathToNotepad% /S
 	)

REM ��������  ��뫪� �� Notepad
	cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\Notepad++\notepad++.exe" "%ProgramFiles%\Notepad++" "Notepad++" "%ProgramFiles%\Notepad++\notepad++.exe" "����⮢� ।���� Notepad++"

REM ��⠭�������� �ணࠬ�� Construct
ECHO .
ECHO Install Construct...
ECHO .
	start "Title" /wait %PathToconstruct% /verysilent

REM ��������  ��뫪� �� construct2
	cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\Construct 2\Construct2.exe" "%ProgramFiles%\Construct 2" "Construct2" "%ProgramFiles%\Construct 2\Construct2.exe" "The HTML5 game and app creator by Scirra."

REM ��⠭�������� �ணࠬ�� SWF_Player
ECHO .
ECHO Install SWF_Player...
ECHO �����!!!
ECHO �ணࠬ�� �㦭� ��⠭�������� � ��筮� ०���.
ECHO ��� ���������� ��⠭����� �ணࠬ�� ��⮬���᪨.
ECHO .
	start "Title" /wait %PathToPlayer% /silent
	If exist "%SystemDrive%\Program Files (x86)" (
			copy /y %PathToFlashOCX% "C:\Program Files (x86)\SWF.max\Media\Binary\Flash.ocx"
	 ) else (
			copy /y %PathToFlashOCX% "C:\Program Files\SWF.max\Media\Binary\Flash.ocx"
	)

REM ������ � ࠡ�祣� �⮫� ��� SWF.max Flash Player
	cscript /nologo /e:jscript "C:\ProgramData\Softium\file_delete.js" "Desktop" "\SWF.max Flash Player.lnk"

REM ��⠭�������� �ணࠬ�� Animate (������ ����)
ECHO .
ECHO Install Animate...
ECHO .
	mkdir "%ProgramFiles%\Animate"
	copy /y %PathToAnimate% "%ProgramFiles%\Animate\animate.swf"
	copy /y %PathToAnimateIco% "%ProgramFiles%\Animate\animate.ico"
	
REM ��������  ��뫪� �� Animate
	cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\Animate\animate.swf" "%USERPROFILE%" "������ ����" "%ProgramFiles%\Animate\animate.ico" "Animate (��� ��砫쭮�� �஢��)."

REM ��⠭�������� �ணࠬ�� Kodu � ����室��묨 ����ᨬ���ﬨ
ECHO .
ECHO Install Kodu...
ECHO .
	start "Title" /wait %PathToxnafx% /passive /norestart
	start "Title" /wait %PathToKodu% /passive /norestart

REM ������ ����� ��뫪� Kodu
	cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\file_delete.js" "AllUsersDesktop" "\Configure Kodu Game Lab.lnk"

REM ��⠭�������� �ணࠬ�� Python 3
ECHO .
ECHO Install Python 3...
ECHO .
	start "Title" /wait %PathToPython3% /quiet InstallAllUsers=1 PrependPath=1 DefaultAllUsersTargetDir="C:\Python3" AssociateFiles=1 Shortcuts=1
	
	PATH=C:\Python3\;C:\Python3\Scripts;%Path%
	python.exe -m pip install --upgrade pip
	pip install pywin32
	pip install pygame
	pip install WMI

REM �������� ��뫪� �� IDLE
	cscript /nologo /e:jscript "%ScriptPath%Distr\noarch\lnk_create.js" "AllUsersDesktop"  ""  "C:\Python3\Lib\idlelib\idle.pyw" "C:\Python3" "Python IDLE" "C:\Python3\pythonw.exe" "Python IDLE"

REM �������� �������騥 ��모
REM + Softium
	cscript /nologo /e:jscript "C:\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "C:\Softium\softiumscan.exe" "C:\Softium\" "�����" "C:\Softium\softiumscan.exe" "�����"

REM + �������
	cscript /nologo /e:jscript "C:\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "%windir%\system32\notepad.exe" "%HOMEDRIVE%%HOMEPATH%" "�������" "%windir%\system32\notepad.exe" "����⮢� ।���� �������"

REM ��ࠦ��� ��� ��������
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f

REM ������ ��譨� ��모
REM - Microsoft Edge
	cscript /nologo /e:jscript "C:\ProgramData\Softium\file_delete.js" "Desktop" "\Microsoft Edge.lnk"
	cscript /nologo /e:jscript "C:\ProgramData\Softium\file_delete.js" "AllUsersDesktop" "\Microsoft Edge.lnk"

REM ����⨬ � ���쭥�襬 ᮧ������ ��� ��� Microsoft Edge �� ࠡ�祬 �⮫�
	reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer /v "DisableEdgeDesktopShortcutCreation" /t REG_DWORD /d "1" /f
	
REM �⪫�砥� ०�� ������
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v SignInMode /t REG_DWORD /d 2 /f

REM ��⠭�������� ���� ࠡ�祣� �⮫�
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "C:\ProgramData\Softium\Wallpaper.jpg" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\BackUpWallpaper" /v Wallpaper /t REG_SZ /d "C:\ProgramData\Softium\Wallpaper.jpg" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\Wallpaper" /v Wallpaper /t REG_SZ /d "C:\ProgramData\Softium\Wallpaper.jpg" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\Wallpaper" /v WallpaperSource /t REG_SZ /d "C:\ProgramData\Softium\Wallpaper.jpg" /f

REM ****************************************************************************************
REM ����塞 Edge Chromium
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

ECHO ��� ���� ��������� 㤠����� Edge Chromium 10 ᥪ㭤...
timeout 10 /nobreak

REM ****************************************************************************************
REM ����頥� ����������� �� Edge Chromium
REM ****************************************************************************************
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v DoNotUpdateToEdgeWithChromium /t REG_DWORD /d 1 /f

REM ������ One Drive
taskkill /f /im OneDrive.exe
	If exist "%SystemDrive%\Program Files (x86)" (
		start "Title" /wait %SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
	 ) else (
 		start "Title" /wait %SystemRoot%\System32\OneDriveSetup.exe /uninstall
 	)

Rem ������ ��譨� �ணࠬ��

start "Title" /wait powershell -command "Set-ExecutionPolicy Bypass -Force"

start "Title" /wait powershell -File  "C:\ProgramData\Softium\DelWindowsApps.ps1"

REM ����稬 ���⭨�� Windows

start "Title" /wait powershell -command "Set-MpPreference -DisableRealtimeMonitoring $false"

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableBehaviorMonitoring /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableOnAccessProtection /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableScanOnRealtimeEnable /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableIOAVProtection /t REG_DWORD /d 0 /f

REM ����稬 ०�� ���ய�⠭�� "�������� �ࣨ�"
	powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a

REM �⪫�稬 ������� �㭪樨 Windows
REM start "Title" /wait %PathToOOSU10% %PathToOOSU10-CFG% /quiet /nosrp

REM ��⠭���� ��� ��������
set /p MyHostname="������ ��� ��������: "
wmic computersystem where name="%computername%" call rename name="%MyHostname%"

Rem ��⠭���� ��ࠬ���� ��㯯���� ����⨪�

"%ProgramFiles%\7-Zip\7z.exe" x -y  %PathToGroupPolicy% -o"%windir%\System32"

:CONTINUE
	ECHO .
	ECHO ���!
	ECHO .
	ECHO ��१���㧪� �१ 10 ᥪ㭤...
:END

timeout 10 /nobreak

shutdown -r -f -t 00

EXIT /B
