@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM        Require administrator rights: YES
REM Antivirus software must be disabled: Not necessary
REM                        Dependencies: No
REM
REM ���ᠭ��
REM
REM ****************************************

rem �஢��塞 ����稥 � ���짮��⥫� �����᪨� �ࠢ...
SET HasAdminRights=0

FOR /F %%i IN ('WHOAMI /PRIV /NH') DO (
	IF "%%i"=="SeTakeOwnershipPrivilege" SET HasAdminRights=1
)

IF NOT %HasAdminRights%==1 (
	ECHO .
	ECHO ��� �㦭� �ࠢ� ����������� ��� ����᪠ �⮣� �ਯ�!
	ECHO .
	GOTO ENDSUB
)

if NOT defined ScriptPath (
	ECHO .
	ECHO �� ��।����� ��६����� ScriptPath
	ECHO .
	GOTO ENDSUB
)

REM ****************************************************************************************
REM ����ன�� ��� Microsoft Edge
REM ****************************************************************************************

REM ������ ��譨� ��모

REM - Microsoft Edge
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\file_delete.js" "Desktop" "\Microsoft Edge.lnk"
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\file_delete.js" "AllUsersDesktop" "\Microsoft Edge.lnk"

REM ����⨬ � ���쭥�襬 ᮧ������ ��� ��� Microsoft Edge �� ࠡ�祬 �⮫�
	reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer /v "DisableEdgeDesktopShortcutCreation" /t REG_DWORD /d "1" /f

REM ����塞 Edge Chromium
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

REM ����頥� ����������� �� Edge Chromium
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v DoNotUpdateToEdgeWithChromium /t REG_DWORD /d 1 /f

:ENDSUB

timeout 3 /nobreak

EXIT /B
