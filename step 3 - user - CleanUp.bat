rem exit /b

Rem ����ࠥ��� ����᪠�� �ਫ������ � �ਢ�����ﬨ த�⥫�᪮�� ����� ��� ����� UAC, �.�. �� ����� ����᪠�饣� ���짮��⥫�
set __COMPAT_LAYER=RUNASINVOKER

@echo off

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

Rem ��⠭�������� ���� ࠡ�祣� �⮫�
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "C:\ProgramData\Softium\Wallpaper.jpg" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\BackUpWallpaper" /v Wallpaper /t REG_SZ /d "C:\ProgramData\Softium\Wallpaper.jpg" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\Wallpaper" /v Wallpaper /t REG_SZ /d "C:\ProgramData\Softium\Wallpaper.jpg" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\Wallpaper" /v WallpaperSource /t REG_SZ /d "C:\ProgramData\Softium\Wallpaper.jpg" /f

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

Rem �ਬ���� ����ன��
REM TASKKILL /F /IM explorer.exe

REM ping -n 5 127.0.0.1 >> nul

REM start explorer.exe

Rem ����⨬ �����
rem del "%USERPROFILE%\3D Objects\*" /q /s /f

del "%USERPROFILE%\Contacts\*" /q /s /f
forfiles /P "%USERPROFILE%\Contacts" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

del "%USERPROFILE%\Desktop\*" /q /s /f
forfiles /P "%USERPROFILE%\Desktop" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

rem del "%USERPROFILE%\Documents\*" /q /s /f
del "%USERPROFILE%\Downloads\*" /q /s /f
forfiles /P "%USERPROFILE%\Downloads" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

del "%USERPROFILE%\Favorites\*" /q /s /f
forfiles /P "%USERPROFILE%\Favorites" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

del "%USERPROFILE%\Links\*" /q /s /f
forfiles /P "%USERPROFILE%\Links" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

del "%USERPROFILE%\Music\*" /q /s /f
forfiles /P "%USERPROFILE%\Music" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

del "%USERPROFILE%\OneDrive\*" /q /s /f
forfiles /P "%USERPROFILE%\OneDrive" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

del "%USERPROFILE%\Pictures\*" /q /s /f
forfiles /P "%USERPROFILE%\Pictures" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

del "%USERPROFILE%\Saved Games\*" /q /s /f
forfiles /P "%USERPROFILE%\Saved Games" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

del "%USERPROFILE%\Searches\*" /q /s /f
forfiles /P "%USERPROFILE%\Searches" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

del "%USERPROFILE%\Videos\*" /q /s /f
forfiles /P "%USERPROFILE%\Videos" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

del "%USERPROFILE%\AppData\Local\Temp\*" /q /s /f
forfiles /P "%USERPROFILE%\AppData\Local\Temp" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

del "%USERPROFILE%\AppData\LocalLow\Temp\*" /q /s /f
forfiles /P "%USERPROFILE%\Desktop\AppData\LocalLow\Temp" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

:CONTINUE
	ECHO .
	ECHO ���!
	ECHO .
:END

EXIT /B
