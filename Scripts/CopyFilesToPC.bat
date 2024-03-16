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
REM ������㥬 䠩�� �� ����ࠨ����� ��������
REM ****************************************************************************************

	set PathToWallpaper="%ScriptPath%Distr\noarch\Wallpaper.jpg"
	set PathToRegTaskbar="%ScriptPath%Distr\noarch\PinnedTaskbar.reg"
	set PathToTaskbarFolder="%ScriptPath%Distr\noarch\QuickLaunch.zip"
	set PathToGroupPolicy="%ScriptPath%Distr\noarch\GroupPolicy.7z"
	set PathToDelWindowsApps="%ScriptPath%Distr\noarch\DelWindowsApps.ps1"
	set PathToTheme="%ScriptPath%Distr\noarch\Softium.theme"
	set PathToFileUpdater="%ScriptPath%Scripts\FileUpdater.bat"
	set PathToFileUpdaterInstaller="%ScriptPath%Scripts\ScheduleFileUpdate.bat"
	set PathToDeleteOneDrive="%ScriptPath%Scripts\DeleteOneDrive.bat"
	set PathToSetLockScreen="%ScriptPath%Scripts\SetLockScreen.bat"
	

REM ᮧ��� ������ ����� ��� �࠭���� ������ 䠩���
	mkdir "%SystemDrive%\ProgramData\Softium"

	copy /y %PathToWallpaper% "%SystemDrive%\ProgramData\Softium\Wallpaper.jpg"
	copy /y %PathToRegTaskbar% "%SystemDrive%\ProgramData\Softium\PinnedTaskbar.reg"
	copy /y %PathToTaskbarFolder% "%SystemDrive%\ProgramData\Softium\QuickLaunch.zip"
	copy /y %PathToGroupPolicy% "%SystemDrive%\ProgramData\Softium\GroupPolicy.7z"
	copy /y %PathToDelWindowsApps% "%SystemDrive%\ProgramData\Softium\DelWindowsApps.ps1"
	
	copy /y %PathToTheme% "%SystemDrive%\ProgramData\Softium\Softium.theme"
	
REM ��㦥��� JAVA-��ਯ��

REM ��ਯ� ᮧ����� ��뫪� �� 䠩�
	copy /y "%ScriptPath%Distr\noarch\lnk_create.js" "%SystemDrive%\ProgramData\Softium\lnk_create.js"

REM ��ਯ� 㤠����� 䠩��
	copy /y "%ScriptPath%Distr\noarch\file_delete.js" "%SystemDrive%\ProgramData\Softium\file_delete.js"

REM �������⥫�� �ਯ��

REM ��ਯ� �몫�祭�� ��
	copy /y "%ScriptPath%Distr\noarch\shutdown.bat"  "%SystemDrive%\ProgramData\Softium\shutdown.bat"

REM ��ਯ� ���⪨ ����� ���짮��⥫��. �ந������ ����⢨� ⮫쪮 ��� ���짮��⥫� � ������ Softium !!!
	copy /y "%ScriptPath%user-CleanUp.bat" "%SystemDrive%\ProgramData\Softium\user-CleanUp.bat"

if %BClearSoftiumProfile%==1 (
	copy /y "%ScriptPath%user-CleanUp.bat" "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\StartUp\CleanUp.bat"
	)
	
REM ��ਯ� ���������� �㦥���� 䠩���
	copy /y "%PathToFileUpdater%"  "%SystemDrive%\ProgramData\Softium\FileUpdater.bat"
	copy /y "%PathToFileUpdaterInstaller%"  "%SystemDrive%\ProgramData\Softium\ScheduleFileUpdate.bat"

REM ��ਯ� 㤠����� OneDrive
	copy /y "%PathToDeleteOneDrive%"  "%SystemDrive%\ProgramData\Softium\DeleteOneDrive.bat"
	
REM ��ਯ� ����ன�� �࠭� �����஢�� Windows
	copy /y "%PathToSetLockScreen%"  "%SystemDrive%\ProgramData\Softium\SetLockScreen.bat"

:ENDSUB

timeout 3 /nobreak

EXIT /B
