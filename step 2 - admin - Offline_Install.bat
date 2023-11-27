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

REM set PathToWallpaper="%ScriptPath%Distr\noarch\Wallpaper.jpg"

REM set PathToSoftium="%ScriptPath%Distr\noarch\softiumscan.exe"

REM set PathToRegTaskbar="%ScriptPath%Distr\noarch\PinnedTaskbar.reg"
REM set PathToTaskbarFolder="%ScriptPath%Distr\noarch\QuickLaunch.zip"

REM PathToUserTaskBar, ����⭮, �� �ᯮ������...
set PathToUserTaskBar="%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"

REM set PathToComputerLNK="%ScriptPath%Distr\noarch\computer.lnk"
REM set PathToChromeDefault="%ScriptPath%Distr\noarch\Chrome.reg"

REM �� �ᯮ������
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
REM ������ ��� � ��饣� ࠡ�祣� �⮫�
REM ****************************************************************************************

del "%SystemDrive%\Users\Public\Desktop\*" /q /s /f
forfiles /P "%SystemDrive%\Users\Public\Desktop" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

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

CALL "%ScriptPath%Scripts\UserAccounts.bat"

REM ****************************************************************************************
REM �⪫�稬 ��⮬���᪮� ���������� ��⥬�
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\DisableWindowsUpdates.bat"

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
REM ��⠭�������� �ணࠬ��-��娢��� 7zip
REM ****************************************************************************************

CALL "%ScriptPath%Scripts\Install7Zip.bat"

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

Rem ������ ��譨� �ணࠬ��

start "Title" /wait powershell -command "Set-ExecutionPolicy Bypass -Force"

start "Title" /wait powershell -File  "%SystemDrive%\ProgramData\Softium\DelWindowsApps.ps1"

REM �⪫�砥� ०�� ������
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v SignInMode /t REG_DWORD /d 2 /f

REM ��⠭���� ᮡ�⢥���� ⥬� ��ଫ����

CALL "%ScriptPath%Scripts\SetSoftiumTheme.bat"

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

"%ProgramFiles%\7-Zip\7z.exe" x -y  "%SystemDrive%\ProgramData\Softium\GroupPolicy.zip" -o"%windir%\System32"

:CONTINUE
	ECHO .
	ECHO ���!
	ECHO .
	ECHO ��१���㧪� �१ 10 ᥪ㭤...
:END

timeout 10 /nobreak

shutdown -r -f -t 00

EXIT /B
