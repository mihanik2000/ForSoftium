Rem �⪫�砥� �뢮� ᠬ�� ������ �� �࠭
@echo off 

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
net user �����1 /add 

rem ****************************************************************************************
rem ����ந� ������� ��ࠬ���� ����室��� ��� 㤠�񭭮�� ���������஢����.
rem ****************************************************************************************

rem ����稬 ०�� ���ய�⠭�� "�������� �ࣨ�"
powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a

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

REM ���室�� � ����� � ����ਡ�⨢���

D:

cd D:\data\Softium\

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

rem ****************************************************************************************
rem ��⠭�������� �ணࠬ��
rem ****************************************************************************************

rem ���室�� � ����� � �ਯ⮬
D:
cd D:\data\Softium\

ECHO ��⠭�������� ������ ����㭨��樨
ECHO ...
start /wait D:\data\Softium\em_dv6eDwnk_installer.msi /qn

ECHO ��⠭�������� ��娢���
ECHO ...
start /wait D:\data\Softium\7z1806.msi /qn

ECHO ��⠭�������� Notepad++ 
ECHO ...
start /wait D:\data\Softium\npp.7.6.3.Installer.exe /S

ECHO ��⠭�������� AdobeAIRInstaller 
ECHO ...
start /wait D:\data\Softium\AdobeAIRInstaller.exe -silent

ECHO ��⠭�������� Scratch 
ECHO ...
start /wait D:\data\Softium\Scratch-460.exe -silent

ECHO ��⠭�������� GIMP 
ECHO ...
start /wait D:\data\Softium\gimp-2.10.8-setup-2.exe /SILENT

ECHO ��⠭�������� Chrome 
ECHO ...
start /wait D:\data\Softium\ChromeSetup.exe /silent /install

ECHO ��⠭�������� BabyType 
ECHO ...
set PATH=%PATH%;C:\Program Files\7-Zip
cd c:\
7z x D:\data\Softium\BabyType.rar *
ren C:\BabyType BabyType2000
cd D:\data\Softium\

ECHO ��⠭�������� SNAP 
ECHO ...
md "C:\Program Files\SNAP"
cd "C:\Program Files\SNAP"
7z x D:\data\Softium\snap.zip *
cd D:\data\Softium\

ECHO ��⠭�������� SWF Player
ECHO ...
start /wait D:\data\Softium\SWFPlayer_2.2.exe /S

ECHO ��⠭�������� construct2
ECHO ...
start /wait D:\data\Softium\construct2-r255-setup.exe /verysilent

ECHO ��⠭�������� Animate
ECHO ...
md "C:\Program Files\Animate"
copy /Y D:\data\Softium\animate.* "C:\Program Files\Animate\"

ECHO ��⠭�������� Softium
ECHO ...
md "C:\Program Files\Softium"
copy /Y D:\data\Softium\Softium.exe "C:\Program Files\Softium\"

:CONTINUE
	ECHO .
	ECHO ���!
	ECHO .
	
:END

PAUSE

EXIT /B
