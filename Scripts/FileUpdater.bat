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
REM ��楤�� �������� �ᯮ��㥬� � ࠡ�� �� �� 䠩��.
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

REM ����� URL 䠩���

	set PathToWallpaper="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/Wallpaper.jpg"
	set PathToRegTaskbar="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/PinnedTaskbar.reg"
	set PathToTaskbarFolder="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/QuickLaunch.zip"
	set PathToGroupPolicy="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/GroupPolicy.7z"
	set PathToDelWindowsApps="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/DelWindowsApps.ps1"
	set PathToComputerLNK="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/computer.lnk"
	set PathToChromeDefault="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/Chrome.reg"
	set PathToTheme="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/Softium.theme"
	set PathToCleanUp="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/user-CleanUp.bat"
	
	set PathToLnkCreate="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/lnk_create.js"
	
	set PathToFileDelete="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/file_delete.js"
	
	set PathToPowerOff="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/shutdown.bat"

REM ᮧ��� ������ ����� ��� �࠭���� ������ 䠩���
	mkdir "%SystemDrive%\ProgramData\Softium"

	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\Wallpaper.jpg" %PathToWallpaper%
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\PinnedTaskbar.reg" %PathToRegTaskbar%
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\QuickLaunch.zip" %PathToTaskbarFolder%
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\GroupPolicy.7z" %PathToGroupPolicy%
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\DelWindowsApps.ps1" %PathToDelWindowsApps% 
	
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\computer.lnk" %PathToComputerLNK%
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\Chrome.reg" %PathToChromeDefault%
	
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\Softium.theme" %PathToTheme%
	
REM ��㦥��� JAVA-��ਯ��
REM ��ਯ� ᮧ����� ��뫪� �� 䠩�
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\lnk_create.js" %PathToLnkCreate%

REM ��ਯ� 㤠����� 䠩��
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\file_delete.js" %PathToFileDelete%

REM �������⥫�� �ਯ��
REM ��ਯ� �몫�祭�� ��
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\shutdown.bat" %PathToPowerOff%

REM ��ਯ� ���⪨ ����� ���짮��⥫��. �ந������ ����⢨� ⮫쪮 ��� ���짮��⥫� � ������ Softium !!!
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\user-CleanUp.bat" %PathToCleanUp%
	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\StartUp\CleanUp.bat" %PathToCleanUp%
	
Rem ��⠭���� ��ࠬ���� ��㯯���� ����⨪�
	"%ProgramFiles%\7-Zip\7z.exe" x -y  "%SystemDrive%\ProgramData\Softium\GroupPolicy.7z" -o"%windir%\System32"
	gpupdate /force

:ENDSUB

timeout 3 /nobreak

EXIT /B
