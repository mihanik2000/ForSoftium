@echo off

Rem ��ਯ� ��⠭���� ����� �ணࠬ� �� ��������� Softium

Rem ****************************************************************************************
Rem �஢��塞 ����稥 � ���짮��⥫� �����᪨� �ࠢ...
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
Rem ����뢠�� ��६����.
Rem ****************************************************************************************

Rem ������쭠� ��६�����. �ᯮ������ �� �ᥩ ��ᨨ CMD
set ScriptPath=%~dp0

Rem PathToUserTaskBar, ����⭮, �� �ᯮ������...
set PathToUserTaskBar="%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"

set PathToOOSU10="%ScriptPath%Distr\noarch\OOSU10.exe"
set PathToOOSU10-CFG="%ScriptPath%Distr\noarch\ooshutup10.cfg"

Rem ���⠢�塞 �᭮���� ���� �ணࠬ��

set BUserAccounts=1
set BDisWinUpdates=1
set BDelWinApps=1
set BGroupPolicy=1
set BClerAllUsersDesktop=1
set BClearSoftiumProfile=1

mode 128,32
cls

:StartMenu

echo �롥�� ��ࠬ���� ����ன�� ࠡ�祣� ����.
echo .

if %BUserAccounts%==1 (
		echo 1 - ����ந�� ������� ���짮��⥫�� - ��
	) else (
		echo 1 - ����ந�� ������� ���짮��⥫�� - ���
	)

if %BDisWinUpdates%==1 (
		echo 2 - �⪫���� ���������� Windows - ��
	) else (
		echo 2 - �⪫���� ���������� Windows - ���
	)

if %BDelWinApps%==1 (
		echo 3 - ������� "��譨�" �ணࠬ�� Windows - ��
	) else (
		echo 3 - ������� "��譨�" �ணࠬ�� Windows - ���
	)

if %BGroupPolicy%==1 (
		echo 4 - ��࠭���� ����� �ணࠬ� - ��
	) else (
		echo 4 - ��࠭���� ����� �ணࠬ� - ���
	)

if %BClerAllUsersDesktop%==1 (
		echo 5 - ������ ��騩 ࠡ�稩 �⮫ - ��
	) else (
		echo 5 - ������ ��騩 ࠡ�稩 �⮫ - ���
	)

if %BClearSoftiumProfile%==1 (
		echo 6 - ��⠭����� �ਯ� ���⪨ ��䨫� ॡ񭪠 - ��
	) else (
		echo 6 - ��⠭����� �ਯ� ���⪨ ��䨫� ॡ񭪠 - ���
	)

echo 7 - �믮����� �ਯ� � 㪠����묨 ��࠭�祭�ﬨ

echo 8 - �믮����� �ਯ� � ���祭�ﬨ ��-㬮�砭��

echo 9 - ��ࢠ�� ࠡ��� �ਯ�

CHOICE /C:123456789 /N /T 30 /D 6

cls

Rem ����ன�� ������ ����ᥩ ���짮��⥫�� �� ��������
if %errorlevel%==1 (if %BUserAccounts%==1  (set BUserAccounts=0) else (set BUserAccounts=1))

Rem �⪫�祭�� ��⮬���᪮�� ���������� ��⥬�
if %errorlevel%==2 (if %BDisWinUpdates%==1  (set BDisWinUpdates=0) else (set BDisWinUpdates=1))

Rem �������� "��譨�" �ணࠬ� Windows
if %errorlevel%==3 (if %BDelWinApps%==1  (set BDelWinApps=0) else (set BDelWinApps=1))

Rem ����ன�� ��㯯���� ����⨪� �� ��
if %errorlevel%==4 (if %BGroupPolicy%==1  (set BGroupPolicy=0) else (set BGroupPolicy=1))

Rem �������� 䠩��� � ��饣� ࠡ�祣� �⮫�
if %errorlevel%==5 (if %BClerAllUsersDesktop%==1  (set BClerAllUsersDesktop=0) else (set BClerAllUsersDesktop=1))

Rem ��⠭���� �ਯ� ���⪨ ��䨫� ���짮��⥫�
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
Rem ������ ��� � ��饣� ࠡ�祣� �⮫�
Rem ****************************************************************************************

if %BClerAllUsersDesktop%==1 (
	del "%SystemDrive%\Users\Public\Desktop\*" /q /s /f
	forfiles /P "%SystemDrive%\Users\Public\Desktop" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"
	)

Rem ****************************************************************************************
Rem ������㥬 䠩�� �� ����ࠨ����� ��������
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\CopyFilesToPC.bat"

Rem ****************************************************************************************
Rem ��⠭���� �ணࠬ�� Softium ��� �����饣���
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallSoftiumscan.bat"

Rem ****************************************************************************************
Rem ����ࠨ���� ����� ����� ���짮��⥫�� �� ��������
Rem ****************************************************************************************

if %BUserAccounts%==1 (
	CALL "%ScriptPath%Scripts\UserAccounts.bat"
	)

Rem ****************************************************************************************
Rem �⪫�稬 ��⮬���᪮� ���������� ��⥬�
Rem ****************************************************************************************

if %BDisWinUpdates%==1 (
	CALL "%ScriptPath%Scripts\DisableWindowsUpdates.bat"
	)

Rem ****************************************************************************************
Rem �⪫�稬 �㦡� ���᪠ Windows
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\DisableWindowsSearch.bat"

Rem ****************************************************************************************
Rem ����稬 �� �६� ࠡ��� �ਯ� ०�� ���ய�⠭�� "��᮪�� �ந�����⥫쭮���"
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\HighPerformanceOn.bat"

Rem ****************************************************************************************
Rem ����ந� �������⥫�� ��ࠬ���� ���ய�⠭��
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\PowerSupplyParameters.bat"

Rem ****************************************************************************************
Rem ��������㥬 �� ��直� ��砩 ���������� �몫�祭�� � 21:00
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\ScheduleShutdown.bat"

Rem ****************************************************************************************
Rem ����稬 ���������⨢�� �����
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\EnableAdministrativeFolders.bat"

Rem ****************************************************************************************
Rem ����ந� ����⥢�� �࠭
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\FirewallSettings.bat"

Rem ****************************************************************************************
Rem ��稭��� ��⠭�������� �� �ணࠬ�� �� ��।�
Rem ****************************************************************************************

Rem ���室�� �� ��⥬�� ���
%SystemDrive%

Rem ��稭��� �⠢��� �⨫��� � �ணࠬ��

Rem ****************************************************************************************
Rem ��⠭�������� SetuserFTA
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallSetuserFTA.bat"

Rem ****************************************************************************************
Rem ��⠭�������� BGInfo
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallBGInfo.bat"

Rem ****************************************************************************************
Rem ��⠭�������� wget
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallWGET.bat"

Rem ****************************************************************************************
Rem ��⠭�������� �ணࠬ��-��娢��� 7zip � ���樨�㥬 �� � ��娢�묨 䠩����
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\Install7Zip.bat"
CALL "%ScriptPath%Scripts\7Zip-associate.bat"

Rem ****************************************************************************************
Rem ��⠭�������� AdobeAIR + Scratch 2
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallScratch.bat"

Rem ****************************************************************************************
Rem ��⠭�������� Scratch 3
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallScratch3.bat"

Rem ****************************************************************************************
Rem ��⠭�������� GIMP
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallGIMP.bat"

Rem ****************************************************************************************
Rem ��⠭�������� Google Chrome
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallGoogleChrome.bat"

Rem ****************************************************************************************
Rem ��⠭�������� BABYTYPE2000
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallBABYTYPE2000.bat"

Rem ****************************************************************************************
Rem ��⠭�������� Snap
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallSnap.bat"

Rem ****************************************************************************************
Rem ��⠭�������� Notepad++
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallNotepad++.bat"

Rem ****************************************************************************************
Rem ��⠭�������� Construct
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallConstruct.bat"

Rem ****************************************************************************************
Rem ��⠭�������� SWF_Player + Animate
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallAnimate.bat"

Rem ****************************************************************************************
Rem ��⠭�������� Kodu
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallKodu.bat"

Rem ****************************************************************************************
Rem ��⠭�������� Python 3
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallPython3.bat"

Rem ****************************************************************************************
Rem ��ࠦ��� ��� ��������
Rem ****************************************************************************************
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f

Rem ****************************************************************************************
Rem �������� �������騥 ��모
Rem ****************************************************************************************

Rem + �������
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "%windir%\system32\notepad.exe" "%HOMEDRIVE%%HOMEPATH%" "�������" "%windir%\system32\notepad.exe" "����⮢� ।���� �������"

Rem + ��ਯ� �몫�祭��
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "%SystemDrive%\ProgramData\Softium\shutdown.bat" "%HOMEDRIVE%%HOMEPATH%" "�몫����" "%SystemRoot%\System32\SHELL32.dll,27" "�몫�祭�� ��������"

Rem ****************************************************************************************
Rem ����ன�� ��� Microsoft Edge
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\DeleteMicrosoftEdge.bat"

Rem ****************************************************************************************
Rem ������ One Drive
Rem ****************************************************************************************

CALL "%ScriptPath%Scripts\DeleteOneDrive.bat"

Rem ������ ��譨� �ணࠬ�� Windows
if %BDelWinApps%==1 (
	start "Title" /wait powershell -command "Set-ExecutionPolicy Bypass -Force"
	start "Title" /wait powershell -File  "%SystemDrive%\ProgramData\Softium\DelWindowsApps.ps1"
	)

Rem �⪫�砥� ०�� ������
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v SignInMode /t REG_DWORD /d 2 /f

Rem ��⠭���� ᮡ�⢥���� ⥬� ��ଫ����
	CALL "%ScriptPath%Scripts\SetLockScreen.bat"
	CALL "%ScriptPath%Scripts\SetSoftiumTheme.bat"

Rem ����稬 ���⭨�� Windows

powershell -command "Set-MpPreference -DisableArchiveScanning $false"
powershell -command "Set-MpPreference -DisableAutoExclusions $false"
powershell -command "Set-MpPreference -DisableBehaviorMonitoring $false"
powershell -command "Set-MpPreference -DisableBlockAtFirstSeen $false"
powershell -command "Set-MpPreference -DisableIOAVProtection $false"
powershell -command "Set-MpPreference -DisablePrivacyMode $false"
powershell -command "Set-MpPreference -DisableRealtimeMonitoring $false"
powershell -command "Set-MpPreference -DisableScanningNetworkFiles $false"
powershell -command "Set-MpPreference -DisableScriptScanning $false"

Rem ����稬 ०�� ���ய�⠭�� "�������� �ࣨ�"
	powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a

Rem �⪫�稬 ������� �㭪樨 Windows
Rem start "Title" /wait %PathToOOSU10% %PathToOOSU10-CFG% /quiet /nosrp

Rem ��⠭���� ��� ��������
set /p MyHostname="������ ��� ��������: "
wmic computersystem where name="%computername%" call rename name="%MyHostname%"

Rem ��⠭���� ��ࠬ���� ��㯯���� ����⨪�
if %BGroupPolicy%==1 (
	"%ProgramFiles%\7-Zip\7z.exe" x -y  "%SystemDrive%\ProgramData\Softium\GroupPolicy.7z" -o"%windir%\System32"
	)

ECHO .
ECHO ���!
ECHO .
ECHO ��१���㧪� �१ 10 ᥪ㭤...
	
:END

timeout 10 /nobreak

shutdown -r -f -t 00

EXIT /B
