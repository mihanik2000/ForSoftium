@echo off

powershell -window minimized -command ""

Rem ����ࠥ��� ����᪠�� �ਫ������ � �ਢ�����ﬨ த�⥫�᪮�� ����� ��� ����� UAC, �.�. �� ����� ����᪠�饣� ���짮��⥫�
set __COMPAT_LAYER=RUNASINVOKER

REM �믮��塞 �ਯ� ⮫쪮 ��� ���짮��⥫� Softium!!!

whoami | find "softium"

If %errorlevel%==1  (
	Echo ��� �⮣� ���짮��⥫� ����� �ਯ� �� �㦥�!
	timeout 5 /nobreak
	Exit /b 1
 )

Rem ��ਯ� ����ன�� �।� ���짮��⥫�

Rem ****************************************************************************************
Rem ����뢠�� ��६����.
Rem ****************************************************************************************

set PathToUserTaskBar="%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"

Rem ������� Chrome ��㧥஬ ��-㬮�砭��.
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  http ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  https ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  .htm ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  .html ChromeHTML

"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" swf "C:\Program Files (x86)\SWF.max\SWF.max.exe"

Rem ����稬 ०�� ���ய�⠭�� "�������� �ࣨ�"
powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a

Rem ������ ��譨� ��모
Rem - Microsoft Edge
	cscript /nologo /e:jscript "C:\ProgramData\Softium\file_delete.js" "Desktop" "\Microsoft Edge.lnk"

Rem �⪫�砥� ०�� ������
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v SignInMode /t REG_DWORD /d 2 /f

Rem ����ந� ������ �����
del "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*" /q /s /f

"%ProgramFiles%\7-Zip\7z.exe" x -y  "C:\ProgramData\Softium\QuickLaunch.zip" -o"%APPDATA%\Microsoft\Internet Explorer"

regedit.exe /s "C:\ProgramData\Softium\PinnedTaskbar.reg"

Rem ��ࠦ��� ��� ��������
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f

REM ������ �ணࠬ�� ������

wmic product where name="����ᮢ�� ����魨� ����" call uninstall /nointeractive

FORFILES /P "%LOCALAPPDATA%\Yandex\YandexBrowser\Application" /S /M setup.exe /C "cmd /c \"@path\" --uninstall --force-uninstall"

FORFILES /P "%LOCALAPPDATA%\Yandex\YaPin" /S /M Yandex.exe /C "cmd /c \"@path\" --uninstall --force-uninstall"

Rem ����⨬ �����

rem ���⠪��
del "%USERPROFILE%\Contacts\*" /q /s /f
forfiles /P "%USERPROFILE%\Contacts" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

rem ����稩 �⮫
del "%USERPROFILE%\Desktop\*" /q /s /f
forfiles /P "%USERPROFILE%\Desktop" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

rem ����㧪�
del "%USERPROFILE%\Downloads\*" /q /s /f
forfiles /P "%USERPROFILE%\Downloads" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

rem ���࠭���
del "%USERPROFILE%\Favorites\*" /q /s /f
forfiles /P "%USERPROFILE%\Favorites" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

rem ��뫪�
del "%USERPROFILE%\Links\*" /q /s /f
forfiles /P "%USERPROFILE%\Links" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

rem ��몠
del "%USERPROFILE%\Music\*" /q /s /f
forfiles /P "%USERPROFILE%\Music" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

rem OneDrive
del "%USERPROFILE%\OneDrive\*" /q /s /f
forfiles /P "%USERPROFILE%\OneDrive" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

del "%USERPROFILE%\AppData\Local\Microsoft\OneDrive\*" /q /s /f
forfiles /P "%USERPROFILE%\AppData\Local\Microsoft\OneDrive" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

rem ����ࠦ����
del "%USERPROFILE%\Pictures\*" /q /s /f
forfiles /P "%USERPROFILE%\Pictures" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

rem ���࠭���� ���
del "%USERPROFILE%\Saved Games\*" /q /s /f
forfiles /P "%USERPROFILE%\Saved Games" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

rem ���᪨
del "%USERPROFILE%\Searches\*" /q /s /f
forfiles /P "%USERPROFILE%\Searches" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

rem �����
del "%USERPROFILE%\Videos\*" /q /s /f
forfiles /P "%USERPROFILE%\Videos" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

rem �६���� 䠩��
del "%USERPROFILE%\AppData\Local\Temp\*" /q /s /f
forfiles /P "%USERPROFILE%\AppData\Local\Temp" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

REM ****************************************************************************************
REM ��⠭���� ⥬� Softium
REM ****************************************************************************************

REM �ਬ��塞 ⥬�
REM[*] rundll32 �� 㬥�� � ��।������ ⥪�饩 �����, ���⮬� �᫨ ���� - �ਤ���� �������� ��� %cd%
REM[*] ��� � ����窠�� �� ࠡ����
rundll32 themecpl.dll,OpenThemeAction %SystemDrive%\ProgramData\Softium\Softium.theme
 
REM �ਡ����� ����ன��
:killsettings_loop
tasklist | find /i "SystemSettings.exe" > nul 2> nul
if not %ERRORLEVEL%==0 goto killsettings_loop
taskkill /f /im SystemSettings.exe > nul

:CONTINUE
	ECHO .
	ECHO ���!
	ECHO .
:END

EXIT /B
