@echo off

Rem ��ਯ� ��⠭���� ����� �ணࠬ� ��������� Softium

rem Windows XP �� �����ন������!!!
ver | find "5.1."

If %errorlevel%==0  (
	Echo Windows XP unsupported!!!
	Exit /b 1
 ) 

rem ****************************************************************************************
rem �஢��塞 ����稥 � ���짮��⥫� �����᪨� �ࠢ...
rem ****************************************************************************************

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

rem ****************************************************************************************
rem ����뢠�� ��६����.
rem ****************************************************************************************

rem ����� �㤠 �㤥� ᪠稢��� ����ਡ�⨢�
set MyFolder=%SystemDrive%\Distr

rem ������� URL ��� ᪠稢���� ����ਡ�⨢�� �ணࠬ�

set URLWget="https://eternallybored.org/misc/wget/1.20.3/32/wget.exe"
set URLWget-x64="https://eternallybored.org/misc/wget/1.20.3/64/wget.exe"

set URLlnk="http://repo.mihanik.net/softium/lnk_create.js"

set URL7Zip="https://www.7-zip.org/a/7z1900.msi"
set URL7Zip-x64="https://www.7-zip.org/a/7z1900-x64.msi"

set URLAdobeAIR="http://repo.mihanik.net/softium/AdobeAIRInstaller.exe"

set URLScratch="http://repo.mihanik.net/softium/Scratch-461.exe"

set URLScratchDesktop="http://repo.mihanik.net/softium/ScratchDesktopSetup3.15.0.exe"

set URLGIMP="http://repo.mihanik.net/softium/gimp-2.10.20-setup-1.exe"

set URLGoogleChrome="https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B5E813859-E748-6A1E-715A-14E59A2D35C5%7D%26lang%3Den%26browser%3D3%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dtrue%26ap%3Dstable-arch_x86-statsdef_0%26brand%3DGCEA/dl/chrome/install/googlechromestandaloneenterprise.msi"
set URLGoogleChrome-x64="https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B5E813859-E748-6A1E-715A-14E59A2D35C5%7D%26lang%3Den%26browser%3D3%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dtrue%26ap%3Dx64-stable-statsdef_0%26brand%3DGCEA/dl/chrome/install/googlechromestandaloneenterprise64.msi"

set URLBABYTYPE2000="http://repo.mihanik.net/softium/BABYTYPE2000.zip"

set URLsnap="http://repo.mihanik.net/softium/Snap-6.1.4.zip"

set URLNotepad="https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v7.9/npp.7.9.Installer.exe"
set URLNotepad-x64="https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v7.9/npp.7.9.Installer.x64.exe"

set URLconstruct="http://repo.mihanik.net/softium/construct2-r279-setup.exe"

set URLPlayer="http://repo.mihanik.net/softium/SWF.max-2.2.exe"

set URLAnimate="http://repo.mihanik.net/softium/animate.swf"
set URLAnimateIco="http://repo.mihanik.net/softium/animate.ico"

set URLxnafx="https://download.microsoft.com/download/5/3/A/53A804C8-EC78-43CD-A0F0-2FB4D45603D3/xnafx40_redist.msi"
set URLKodu="https://download.microsoft.com/download/2/6/0/2605ED8C-5143-4AB1-ACDD-075AEE33D1FE/KoduSetup.msi"

set URLPython3="https://www.python.org/ftp/python/3.9.0/python-3.9.0.exe"

rem ****************************************************************************************
rem ����ࠨ���� ����� ����� ���짮��⥫�� �� ��������
rem ****************************************************************************************

rem ��⨢��㥬 ���஥����� �����������
net user ����������� "AdminPass" /active:yes

rem �������� ���짮��⥫� Softium � ��஫�� 321
net user Softium 321 /add

rem ****************************************************************************************
rem ����ந� ������� ����室��� ��ࠬ���� 
rem ****************************************************************************************

rem �⪫�稬 ��⮬���᪮� ���������� ��⥬�
net stop wuauserv
sc config wuauserv start= disabled

rem ����稬 �� �६� ࠡ��� �ਯ� ०�� ���ய�⠭�� "��᮪�� �ந�����⥫쭮���"
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

rem ������� �� �⪫���� ��ᯫ�� �� ��⠭�� �� ��
powercfg /CHANGE -monitor-timeout-dc 0

rem ������� �� �⪫���� ��� �� ��⠭�� �� ��
powercfg /CHANGE -disk-timeout-dc 0

rem ������� �� �室��� � ०�� �������� �� ��⠭�� �� ��
powercfg /CHANGE -standby-timeout-dc 0

rem ������� �� �室��� � ०�� ᭠ �� ��⠭�� �� ��
powercfg /CHANGE -hibernate-timeout-dc 0

rem �⪫�砥� ��騩 ०��
powercfg -hibernate off
reg ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power /v HiberFileSizePercent /t REG_DWORD /d 0 /f
reg ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power /v HibernateEnabled /t REG_DWORD /d 0 /f

rem ��������㥬 �� ��直� ��砩 ���������� �몫�祭�� � �������
SCHTASKS /Create /RU "NT AUTHORITY\SYSTEM" /SC DAILY /TN "Microsoft\Office\Office Shutdown" /TR  "\"C:\Windows\System32\shutdown.exe\" /s /f /t 00"  /ST 00:00 /RL HIGHEST

rem ����砥� ADMIN ���
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v LocalAccountTokenFilterPolicy /t reg_sz /d 1 /f

rem ����稬 ����⥢�� �࠭
netsh advfirewall set allprofiles state on

rem ����訬 �⢥��� �� ping 
netsh firewall set icmpsetting 8

rem ****************************************************************************************
rem ��稭��� ��⠭�������� �� �ணࠬ�� �� ��।�
rem ****************************************************************************************

rem ���室�� �� ��⥬�� ���
%SystemDrive%

rem ������ ����� ��� �࠭���� ����ਡ�⨢�� � ���室�� � ���
mkdir "%MyFolder%"
cd "%MyFolder%"

ECHO Install curl...
ECHO .
mkdir  "%ProgramFiles%\curl\"

rem ������塞 �⨫��� certutil.exe � �᪫�祭�� �࠭����� Windows
	netsh advfirewall firewall del rule name="Certutil"
	netsh firewall add allowedprogram "C:\Windows\System32\certutil.exe" Certutil
	netsh advfirewall firewall add rule name="Certutil" dir=in action=allow program="C:\Windows\System32\certutil.exe"

If exist "%SystemDrive%\Program Files (x86)" (
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win64/libcurl-x64.dll" "%ProgramFiles%\curl\libcurl-x64.dll"
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win64/curl.exe" "%ProgramFiles%\curl\curl.exe"
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win64/curl-ca-bundle.crt" "%ProgramFiles%\curl\curl-ca-bundle.crt"
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win64/libcurl-x64.def" "%ProgramFiles%\curl\libcurl-x64.def"

 ) else (
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win32/libcurl.dll" "%ProgramFiles%\curl\libcurl.dll"
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win32/curl.exe" "%ProgramFiles%\curl\curl.exe"
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win32/curl-ca-bundle.crt" "%ProgramFiles%\curl\curl-ca-bundle.crt"
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win32/libcurl.def" "%ProgramFiles%\curl\libcurl.def"
)

rem ��⠭���� ᪠砭�� ���䨪�� ��� ��� ���짮��⥫��
rem certutil -f -addstore "My" "%ProgramFiles%\curl\curl-ca-bundle.crt"

rem ������� ���� � curl � path
	setx PATH "%ProgramFiles%\curl\;%Path%"
	PATH=%ProgramFiles%\curl\;%Path%

rem ������塞 �⨫��� curl.exe � �᪫�祭�� �࠭����� Windows
	netsh advfirewall firewall del rule name="curl"
	netsh firewall add allowedprogram "%ProgramFiles%\curl\curl.exe" curl
	netsh advfirewall firewall add rule name="curl" dir=in action=allow program="%ProgramFiles%\curl\curl.exe"

ECHO .
ECHO Install wget...
ECHO .
mkdir  "%ProgramFiles%\wget\"
	If exist "%SystemDrive%\Program Files (x86)" (
		curl.exe -k -o "%ProgramFiles%\wget\wget.exe" %URLWget-x64%
	) else (
		curl.exe -k -o "%ProgramFiles%\wget\wget.exe" %URLWget%
	)

rem ������� ���� � wget � path
	setx PATH "%ProgramFiles%\wget\;%Path%"
	PATH=%ProgramFiles%\wget\;%Path%

rem ������塞 �⨫��� wget.exe � �᪫�祭�� �࠭����� Windows
	netsh advfirewall firewall del rule name="wget"
	netsh firewall add allowedprogram "%ProgramFiles%\wget\wget.exe" wget
	netsh advfirewall firewall add rule name="wget" dir=in action=allow program="%ProgramFiles%\wget\wget.exe"

rem ���稢��� �ਯ� ᮧ����� ��몮�
	wget.exe --no-check-certificate -O "%MyFolder%\lnk_create.js" %URLlnk%

ECHO .
ECHO Install 7-Zip...
ECHO .
 If exist "%SystemDrive%\Program Files (x86)" (
		wget.exe --no-check-certificate -O "%MyFolder%\7z-x64.msi" %URL7Zip-x64%
		start /wait 7z-x64.msi /passive /norestart
	) else (
		wget.exe --no-check-certificate -O "%MyFolder%\7z.msi" %URL7Zip%
		start /wait 7z.msi /passive /norestart
	)

ECHO .
ECHO Install AdobeAIR...
ECHO .
	wget.exe --no-check-certificate -O "%MyFolder%\AdobeAIRInstaller.exe" %URLAdobeAIR%
	start /wait AdobeAIRInstaller.exe -silent
 
ECHO .
ECHO Install Scratch Offline...
ECHO .
	wget.exe --no-check-certificate -O "%MyFolder%\Scratch-461.exe" %URLScratch%
	start /wait Scratch-461.exe -silent
 
	If exist "%SystemDrive%\Program Files (x86)" (
		cscript /nologo /e:jscript "%MyFolder%\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles(x86)%\Scratch 2\Scratch 2.exe" "%USERPROFILE%" "Scratch 2" "%ProgramFiles(x86)%\Scratch 2\Scratch 2.exe" "�䫠��-।���� Scratch 2.0"
	 ) else (
		cscript /nologo /e:jscript "%MyFolder%\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\Scratch 2\Scratch 2.exe" "%USERPROFILE%" "Scratch 2" "%ProgramFiles%\Scratch 2\Scratch 2.exe" "�䫠��-।���� Scratch 2.0"
	)

ECHO .
ECHO Install Scratch Desktop...
ECHO .
	wget.exe --no-check-certificate -O "%MyFolder%\ScratchDesktopSetup3.15.0.exe" %URLScratchDesktop%
	start /wait ScratchDesktopSetup3.15.0.exe /S /allusers

ECHO .
ECHO Install GIMP...
ECHO .
	wget.exe --no-check-certificate -O "%MyFolder%\gimp-2.10.20-setup-1.exe" %URLGIMP%
	start /wait gimp-2.10.20-setup-1.exe /SILENT

rem ��������  ��뫪� �� GIMP
	cscript /nologo /e:jscript "%MyFolder%\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\GIMP 2\bin\gimp-2.10.exe" "%USERPROFILE%" "GIMP" "%ProgramFiles%\GIMP 2\bin\gimp-2.10.exe" "����᪨� ।���� GIMP"

ECHO .
ECHO Install Google Chrome...
ECHO .
	If exist "%SystemDrive%\Program Files (x86)" (
		wget.exe --no-check-certificate -O "%MyFolder%\googlechromestandaloneenterprise64.msi" %URLGoogleChrome-x64%
		Start /wait googlechromestandaloneenterprise64.msi /passive /norestart
	 ) else (
		wget.exe --no-check-certificate -O "%MyFolder%\googlechromestandaloneenterprise.msi" %URLGoogleChrome%
 		Start /wait googlechromestandaloneenterprise.msi /passive /norestart
 	)

rem ��������  ��뫪� �� Chrome
	REM cscript /nologo /e:jscript "%MyFolder%\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\Google\Chrome\Application\chrome.exe" "%ProgramFiles%\Google\Chrome\Application" "Chrome" "%ProgramFiles%\Google\Chrome\Application\chrome.exe" "����� � ���୥�"

ECHO .
ECHO Install BABYTYPE2000...
ECHO .
	wget.exe --no-check-certificate -O "%MyFolder%\BABYTYPE2000.zip" %URLBABYTYPE2000%
	"%ProgramFiles%\7-Zip\7z.exe" x -y  %MyFolder%\BABYTYPE2000.zip -oc:

Rem ��������  ��뫪� �� BABYTYPE
	cscript /nologo /e:jscript "%MyFolder%\lnk_create.js" "AllUsersDesktop"  "" "C:\BABYTYPE2000\BABYTYPE.EXE" "C:\BABYTYPE2000" "BabyType" "%SystemRoot%\System32\SHELL32.dll,41" "�७���� ���� BabyType"

ECHO .
ECHO Install Snap...
ECHO .
	wget.exe --no-check-certificate -O "%MyFolder%\snap.zip" %URLsnap%
	mkdir "%ProgramFiles%\SNAP"
	"%ProgramFiles%\7-Zip\7z.exe" x -y  %MyFolder%\snap.zip -o"%ProgramFiles%\SNAP"

Rem ��������  ��뫪� �� Snap
	cscript /nologo /e:jscript "%MyFolder%\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\SNAP\Snap-6.1.4\index.html" "%ProgramFiles%\SNAP\Snap-6.1.4" "Snap!" "%ProgramFiles%\SNAP\Snap-6.1.4\src\favicon.ico" "SNAP! ��䫠�� �����"

ECHO .
ECHO Install Notepad++...
ECHO .
	If exist "%SystemDrive%\Program Files (x86)" (
		wget.exe --no-check-certificate -O "%MyFolder%\npp-x64.exe" %URLNotepad-x64%
		Start /wait npp-x64.exe /S
	 ) else (
		wget.exe --no-check-certificate -O "%MyFolder%\npp.exe" %URLNotepad%
 		Start /wait npp.exe /S
 	)

Rem ��������  ��뫪� �� Notepad
	cscript /nologo /e:jscript "%MyFolder%\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\Notepad++\notepad++.exe" "%ProgramFiles%\Notepad++" "Notepad++" "%ProgramFiles%\Notepad++\notepad++.exe" "����⮢� ।���� Notepad++"

ECHO .
ECHO Install Construct...
ECHO .
	wget.exe --no-check-certificate -O "%MyFolder%\construct2-r279-setup.exe" %URLconstruct%
	start /wait construct2-r279-setup.exe /verysilent

rem ��������  ��뫪� �� construct2
	cscript /nologo /e:jscript "%MyFolder%\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\Construct 2\Construct2.exe" "%ProgramFiles%\Construct 2" "Construct2" "%ProgramFiles%\Construct 2\Construct2.exe" "The HTML5 game and app creator by Scirra."

ECHO .
ECHO Install SWF_Player...
ECHO .
	wget.exe --no-check-certificate -O "%MyFolder%\SWF.exe" %URLPlayer%
	start /wait "%MyFolder%\SWF.exe"

rem ���樨�㥬 䠩�� � �ந��뢠⥫��
	REM assoc .swf=application.x-shockwave-flash
	REM If exist "%SystemDrive%\Program Files (x86)" (
		REM ftype application.x-shockwave-flash="%ProgramFiles(x86)%\SWF.max\SWF.max.exe"  "%1"
		REM setx PATH "%ProgramFiles(x86)%\SWF.max\;%Path%"
		REM PATH="%ProgramFiles(x86)%\SWF.max\;%Path%"
	 REM ) else (
		REM ftype application.x-shockwave-flash="%ProgramFiles%\SWF.max\SWF.max.exe"  "%1"
		REM setx PATH "%ProgramFiles%\SWF.max\;%Path%"
		REM PATH="%ProgramFiles%\SWF.max\;%Path%"
 	REM )

ECHO .
ECHO Install Animate...
ECHO .
	mkdir "%ProgramFiles%\Animate"
	wget.exe --no-check-certificate -O "%ProgramFiles%\Animate\animate.swf" %URLAnimate%
	wget.exe --no-check-certificate -O "%ProgramFiles%\Animate\animate.ico" %URLAnimateIco%
	
Rem ��������  ��뫪� �� Animate
	cscript /nologo /e:jscript "%MyFolder%\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\Animate\animate.swf" "%USERPROFILE%" "Animate" "%ProgramFiles%\Animate\animate.ico" "Animate (��� ��砫쭮�� �஢��)."

ECHO .
ECHO Install Kodu...
ECHO .
	wget.exe --no-check-certificate -O "%MyFolder%\xnafx40_redist.msi" %URLxnafx%
	Start /wait xnafx40_redist.msi /passive /norestart
	wget.exe --no-check-certificate -O "%MyFolder%\KoduSetup.msi" %URLKodu%
	Start /wait KoduSetup.msi /passive /norestart

ECHO .
ECHO Install Python 3...
ECHO .
	wget.exe --no-check-certificate -O "%MyFolder%\PythonSetup.exe" %URLPython3%
	Start /wait PythonSetup.exe /quiet InstallAllUsers=1 PrependPath=1 DefaultAllUsersTargetDir="C:\Python3" AssociateFiles=1 Shortcuts=1
	
	PATH=C:\Python3\;C:\Python3\Scripts;%Path%
	python.exe -m pip install --upgrade pip
	pip install pywin32
	pip install pygame
	pip install WMI
	
rem �������� �������騥 ��모

Rem ��������  ��뫪� �� �������
	cscript /nologo /e:jscript "%MyFolder%\lnk_create.js" "AllUsersDesktop"  "" "%windir%\system32\notepad.exe" "%HOMEDRIVE%%HOMEPATH%" "�������" "%windir%\system32\notepad.exe" "����⮢� ।���� �������"

rem ����稬 ०�� ���ய�⠭�� "�������� �ࣨ�"
	powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a

REM ����稬 ���⭨�� Windows
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableBehaviorMonitoring /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableOnAccessProtection /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableScanOnRealtimeEnable /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableIOAVProtection /t REG_DWORD /d 0 /f


rem ����稬 ��⮬���᪮� ���������� ��⥬�
sc config wuauserv start= delayed-auto

rem �⪫�砥� ��⮬���᪮� ����������
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f


:CONTINUE
	ECHO .
	ECHO ���!
	ECHO .
	
:END

shutdown -r -f -t 00

EXIT /B
