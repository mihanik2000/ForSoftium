@Rem �⪫�砥� �뢮� ᠬ�� ������ �� �࠭
@echo off 

REM ���室�� � ����� � �ਯ⮬

set MyPath=%~dp0
set MyPath=%MyPath:~0,2%

%MyPath%
cd %~dp0

rem ****************************************************************************************
rem �஢��塞 ����稥 � ���짮��⥫� �����᪨� �ࠢ...
rem ****************************************************************************************

SET HasAdminRights=0
FOR /F %%i IN ('WHOAMI /PRIV /NH') DO (
	IF "%%i"=="SeTakeOwnershipPrivilege" SET HasAdminRights=1
)

IF NOT %HasAdminRights%==1 (
	ECHO .
	ECHO ��� �ਯ� ����室��� ����᪠�� �� ����� �����������.
	ECHO .
	GOTO END
)

rem ****************************************************************************************
rem ����ࠨ���� ����� ����� ���짮��⥫�� �� ��������
rem ****************************************************************************************

rem ��⨢��㥬 ���஥����� ������
net user ����������� MyPa$$w0rd /active:yes

rem ������� ���짮��⥫� admin ��஫� Pa$$w0rd
net user admin Pa$$w0rd

rem �������� ���짮��⥫� ����� ��� ��஫�
net user ����� /add 

rem ****************************************************************************************
rem ����ந� ������� ��ࠬ���� ����室��� ��� 㤠�񭭮�� ���������஢����.
rem ****************************************************************************************

rem ����稬 ०�� ���ய�⠭�� "��᮪�� �ந�����⥫쭮���"
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

rem �⪫�砥� ��騩 ०��
powercfg -hibernate off
reg ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power /v HiberFileSizePercent /t REG_DWORD /d 0 /f
reg ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power /v HibernateEnabled /t REG_DWORD /d 0 /f

rem ��������㥬 ���������� �몫�祭�� � �������
SCHTASKS /Create /RU "NT AUTHORITY\SYSTEM" /SC DAILY /TN "Microsoft\Office\Office Shutdown" /TR  "\"C:\Windows\System32\shutdown.exe\" /s /f /t 00"  /ST 00:00 /RL HIGHEST

rem �⪫�稬 ��⮬���᪮� ���������� ��⥬�
net stop wuauserv
sc config wuauserv start= disabled

rem ����稬 ����⥢�� �࠭
netsh advfirewall set allprofiles state on

rem ����訬 �⢥��� �� ping 
netsh firewall set icmpsetting 8

rem ****************************************************************************************
rem ����ࠨ���� �।� ���짮��⥫�
rem ****************************************************************************************

ECHO ��⠭�������� ���� ࠡ�祣� �⮫�
ECHO ...

copy /Y "D:\data\Softium\���⠢�� ��� ࠡ�祣� �⮫�_full.jpg" C:\ProgramData\

reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "C:\ProgramData\���⠢�� ��� ࠡ�祣� �⮫�_full.jpg" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\BackUpWallpaper" /v Wallpaper /t REG_SZ /d "C:\ProgramData\���⠢�� ��� ࠡ�祣� �⮫�_full.jpg" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\Wallpaper" /v Wallpaper /t REG_SZ /d "C:\ProgramData\���⠢�� ��� ࠡ�祣� �⮫�_full.jpg" /f

rem ��ࠦ��� ��� ��������
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f

ECHO �⪫�砥� ०�� ������
ECHO ...
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v SignInMode /t REG_DWORD /d 2 /f


%SystemRoot%\System32\RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters

echo reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "C:\ProgramData\���⠢�� ��� ࠡ�祣� �⮫�_full.jpg" /f  > "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\wallpaper.bat"
echo reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\BackUpWallpaper" /v Wallpaper /t REG_SZ /d "C:\ProgramData\���⠢�� ��� ࠡ�祣� �⮫�_full.jpg" /f >> "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\wallpaper.bat"
echo reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\Wallpaper" /v Wallpaper /t REG_SZ /d "C:\ProgramData\���⠢�� ��� ࠡ�祣� �⮫�_full.jpg" /f >> "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\wallpaper.bat"

echo %SystemRoot%\System32\RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
echo reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f >> "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\wallpaper.bat"
echo reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v SignInMode /t REG_DWORD /d 2 /f >> "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\wallpaper.bat"
echo reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f >> "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\wallpaper.bat"

echo EXIT /B >> "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\wallpaper.bat"


rem ����稬 ०�� ���ய�⠭�� "�������� �ࣨ�"
powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a

:CONTINUE
	ECHO .
	ECHO ���!
	ECHO .
	
:END

PAUSE

EXIT /B
