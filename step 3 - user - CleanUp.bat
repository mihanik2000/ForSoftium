@echo off

Rem ��ਯ� ����ன�� �।� ���짮��⥫�

Rem ****************************************************************************************
Rem ����뢠�� ��६����.
Rem ****************************************************************************************

set PathToUserTaskBar="%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"

Rem ������� Chrome ��㧥஬ ��-㬮�砭��.
regedit.exe /s "C:\ProgramData\Softium\Chrome.reg"

Rem ����稬 ०�� ���ய�⠭�� "�������� �ࣨ�"
powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a

Rem �⪫�砥� ०�� ������
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v SignInMode /t REG_DWORD /d 2 /f

Rem ��⠭�������� ���� ࠡ�祣� �⮫�
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "C:\ProgramData\Softium\Wallpaper.jpg" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\BackUpWallpaper" /v Wallpaper /t REG_SZ /d "C:\ProgramData\Softium\Wallpaper.jpg" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\Wallpaper" /v Wallpaper /t REG_SZ /d "C:\ProgramData\Softium\Wallpaper.jpg" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\Wallpaper" /v WallpaperSource /t REG_SZ /d "C:\ProgramData\Softium\Wallpaper.jpg" /f

Rem ����ந� ������ �����
del "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*" /q /s
cscript /nologo /e:jscript "C:\ProgramData\Softium\lnk_create.js" ""  %PathToUserTaskBar% "%ProgramFiles%\Google\Chrome\Application\chrome.exe" "%ProgramFiles%\Google\Chrome\Application" "Google Chrome" "%ProgramFiles%\Google\Chrome\Application\chrome.exe" "����� � ���୥�"
cscript /nologo /e:jscript "C:\ProgramData\Softium\lnk_create.js" ""  %PathToUserTaskBar% "%ProgramFiles%\Scratch Desktop\Scratch Desktop.exe" "%ProgramFiles%\Scratch Desktop" "Scratch Desktop" "%ProgramFiles%\Scratch Desktop\Scratch Desktop.exe" "Scratch Desktop"
If exist "%SystemDrive%\Program Files (x86)" (
	cscript /nologo /e:jscript "C:\ProgramData\Softium\lnk_create.js" "" %PathToUserTaskBar% "%ProgramFiles(x86)%\Scratch 2\Scratch 2.exe" "%USERPROFILE%" "Scratch 2" "%ProgramFiles(x86)%\Scratch 2\Scratch 2.exe" "�䫠��-।���� Scratch 2.0"
 ) else (
	cscript /nologo /e:jscript "C:\ProgramData\Softium\lnk_create.js" ""  %PathToUserTaskBar% "%ProgramFiles%\Scratch 2\Scratch 2.exe" "%USERPROFILE%" "Scratch 2" "%ProgramFiles%\Scratch 2\Scratch 2.exe" "�䫠��-।���� Scratch 2.0"
)
copy /y "C:\ProgramData\Softium\computer.lnk" "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\computer.lnk"
regedit.exe /s "C:\ProgramData\Softium\PinnedTaskbar.reg"

Rem ��ࠦ��� ��� ��������
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f

Rem �ਬ���� ����ன��
REM TASKKILL /F /IM explorer.exe

REM ping -n 5 127.0.0.1 >> nul

REM start explorer.exe

Rem ����⨬ �����
del "%USERPROFILE%\3D Objects\*" /q /s
del "%USERPROFILE%\Contacts\*" /q /s
del "%USERPROFILE%\Desktop\*" /q /s
del "%USERPROFILE%\Documents\*" /q /s
del "%USERPROFILE%\Downloads\*" /q /s
del "%USERPROFILE%\Favorites\*" /q /s
del "%USERPROFILE%\Links\*" /q /s
del "%USERPROFILE%\Music\*" /q /s
del "%USERPROFILE%\OneDrive\*" /q /s
del "%USERPROFILE%\Pictures\*" /q /s
del "%USERPROFILE%\Saved Games\*" /q /s
del "%USERPROFILE%\Searches\*" /q /s
del "%USERPROFILE%\Videos\*" /q /s

:CONTINUE
	ECHO .
	ECHO ���!
	ECHO .
:END

EXIT /B
