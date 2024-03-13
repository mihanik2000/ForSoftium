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

REM ������쭠� ��६�����. �ᯮ������ �� �ᥩ ��ᨨ CMD
set ScriptPath=%~dp0

REM PathToUserTaskBar, ����⭮, �� �ᯮ������...
set PathToUserTaskBar="%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"

set PathToOOSU10="%ScriptPath%Distr\noarch\OOSU10.exe"
set PathToOOSU10-CFG="%ScriptPath%Distr\noarch\ooshutup10.cfg"

REM ���⠢�塞 �᭮���� ���� �ணࠬ��

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
REM ������ ��� � ��饣� ࠡ�祣� �⮫�
REM ****************************************************************************************

if %BClerAllUsersDesktop%==1 (
	del "%SystemDrive%\Users\Public\Desktop\*" /q /s /f
	forfiles /P "%SystemDrive%\Users\Public\Desktop" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"
	)

REM ****************************************************************************************
REM ������㥬 䠩�� �� ����ࠨ����� ��������
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\CopyFilesToPC.bat"

REM ****************************************************************************************
REM ��⠭���� �ணࠬ�� Softium ��� �����饣���
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallSoftiumscan.bat"

REM ****************************************************************************************
REM ����ࠨ���� ����� ����� ���짮��⥫�� �� ��������
REM ****************************************************************************************

if %BUserAccounts%==1 (
	CALL "%ScriptPath%Scripts\UserAccounts.bat"
	)

REM ****************************************************************************************
REM �⪫�稬 ��⮬���᪮� ���������� ��⥬�
REM ****************************************************************************************

if %BDisWinUpdates%==1 (
	CALL "%ScriptPath%Scripts\DisableWindowsUpdates.bat"
	)

REM ****************************************************************************************
REM �⪫�稬 �㦡� ���᪠ Windows
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\DisableWindowsSearch.bat"

REM ****************************************************************************************
REM ����稬 �� �६� ࠡ��� �ਯ� ०�� ���ய�⠭�� "��᮪�� �ந�����⥫쭮���"
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\HighPerformanceOn.bat"

REM ****************************************************************************************
REM ����ந� �������⥫�� ��ࠬ���� ���ய�⠭��
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\PowerSupplyParameters.bat"

REM ****************************************************************************************
REM ��������㥬 �� ��直� ��砩 ���������� �몫�祭�� � 21:00
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\ScheduleShutdown.bat"

REM ****************************************************************************************
REM ����稬 ���������⨢�� �����
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\EnableAdministrativeFolders.bat"

REM ****************************************************************************************
REM ����ந� ����⥢�� �࠭
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\FirewallSettings.bat"

REM ****************************************************************************************
REM ��稭��� ��⠭�������� �� �ணࠬ�� �� ��।�
REM ****************************************************************************************

REM ���室�� �� ��⥬�� ���
%SystemDrive%

REM ��稭��� �⠢��� �⨫��� � �ணࠬ��

REM ****************************************************************************************
REM ��⠭�������� SetuserFTA
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallSetuserFTA.bat"

REM ****************************************************************************************
REM ��⠭�������� wget
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallWGET.bat"

REM ****************************************************************************************
REM ��⠭�������� �ணࠬ��-��娢��� 7zip � ���樨�㥬 �� � ��娢�묨 䠩����
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\Install7Zip.bat"
CALL "%ScriptPath%Scripts\7Zip-associate.bat"

REM ****************************************************************************************
REM ��⠭�������� AdobeAIR + Scratch 2
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallScratch.bat"

REM ****************************************************************************************
REM ��⠭�������� Scratch 3
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallScratch3.bat"

REM ****************************************************************************************
REM ��⠭�������� GIMP
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallGIMP.bat"

REM ****************************************************************************************
REM ��⠭�������� Google Chrome
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallGoogleChrome.bat"

REM ****************************************************************************************
REM ��⠭�������� BABYTYPE2000
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallBABYTYPE2000.bat"

REM ****************************************************************************************
REM ��⠭�������� Snap
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallSnap.bat"

REM ****************************************************************************************
REM ��⠭�������� Notepad++
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallNotepad++.bat"

REM ****************************************************************************************
REM ��⠭�������� Construct
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallConstruct.bat"

REM ****************************************************************************************
REM ��⠭�������� SWF_Player + Animate
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallAnimate.bat"

REM ****************************************************************************************
REM ��⠭�������� Kodu
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallKodu.bat"

REM ****************************************************************************************
REM ��⠭�������� Python 3
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\InstallPython3.bat"

REM ****************************************************************************************
REM ��ࠦ��� ��� ��������
REM ****************************************************************************************
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f

REM ****************************************************************************************
REM �������� �������騥 ��모
REM ****************************************************************************************

REM + �������
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "%windir%\system32\notepad.exe" "%HOMEDRIVE%%HOMEPATH%" "�������" "%windir%\system32\notepad.exe" "����⮢� ।���� �������"

REM + ��ਯ� �몫�祭��
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "%SystemDrive%\ProgramData\Softium\shutdown.bat" "%HOMEDRIVE%%HOMEPATH%" "�몫����" "%SystemRoot%\System32\SHELL32.dll,27" "�몫�祭�� ��������"

REM ****************************************************************************************
REM ����ன�� ��� Microsoft Edge
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\DeleteMicrosoftEdge.bat"

REM ****************************************************************************************
REM ������ One Drive
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\DeleteOneDrive.bat"

Rem ������ ��譨� �ணࠬ�� Windows
if %BDelWinApps%==1 (
	start "Title" /wait powershell -command "Set-ExecutionPolicy Bypass -Force"
	start "Title" /wait powershell -File  "%SystemDrive%\ProgramData\Softium\DelWindowsApps.ps1"
	)

REM �⪫�砥� ०�� ������
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v SignInMode /t REG_DWORD /d 2 /f

REM ��⠭���� ᮡ�⢥���� ⥬� ��ଫ����

CALL "%ScriptPath%Scripts\SetSoftiumTheme.bat"

REM ����稬 ���⭨�� Windows

powershell -command "Set-MpPreference -DisableArchiveScanning $false"
powershell -command "Set-MpPreference -DisableAutoExclusions $false"
powershell -command "Set-MpPreference -DisableBehaviorMonitoring $false"
powershell -command "Set-MpPreference -DisableBlockAtFirstSeen $false"
powershell -command "Set-MpPreference -DisableIOAVProtection $false"
powershell -command "Set-MpPreference -DisablePrivacyMode $false"
powershell -command "Set-MpPreference -DisableRealtimeMonitoring $false"
powershell -command "Set-MpPreference -DisableScanningNetworkFiles $false"
powershell -command "Set-MpPreference -DisableScriptScanning $false"

REM ����稬 ०�� ���ய�⠭�� "�������� �ࣨ�"
	powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a

REM �⪫�稬 ������� �㭪樨 Windows
REM start "Title" /wait %PathToOOSU10% %PathToOOSU10-CFG% /quiet /nosrp

REM ��⠭���� ��� ��������
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
