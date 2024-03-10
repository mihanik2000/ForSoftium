@echo off

powershell -window minimized -command ""

Rem Постараемся запускать приложения с привилегиями родительского процесса без запроса UAC, т.е. от имени запускающего пользователя
set __COMPAT_LAYER=RUNASINVOKER

REM Выполняем скрипт только для пользователя Softium!!!

whoami | find "softium"

If %errorlevel%==1  (
	Echo Для этого пользователя запуск скрипта не нужен!
	timeout 5 /nobreak
	Exit /b 1
 )

Rem Скрипт настройки среды пользователя

Rem ****************************************************************************************
Rem Описываем переменные.
Rem ****************************************************************************************

set PathToUserTaskBar="%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"

Rem Сделаем Chrome браузером по-умолчанию.
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  http ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  https ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  .htm ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  .html ChromeHTML

"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" swf "C:\Program Files (x86)\SWF.max\SWF.max.exe"

Rem включим режим электропитания "Экономия энергии"
powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a

Rem Удалим лишние ярлыки
Rem - Microsoft Edge
	cscript /nologo /e:jscript "C:\ProgramData\Softium\file_delete.js" "Desktop" "\Microsoft Edge.lnk"

Rem Отключаем режим планшета
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v SignInMode /t REG_DWORD /d 2 /f

Rem Настроим панель задач
del "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*" /q /s /f

"%ProgramFiles%\7-Zip\7z.exe" x -y  "C:\ProgramData\Softium\QuickLaunch.zip" -o"%APPDATA%\Microsoft\Internet Explorer"

regedit.exe /s "C:\ProgramData\Softium\PinnedTaskbar.reg"

Rem Отбражаем Мой компьютер
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f

REM Удалим программы Яндекса

wmic product where name="Голосовой помощник Алиса" call uninstall /nointeractive

FORFILES /P "%LOCALAPPDATA%\Yandex\YandexBrowser\Application" /S /M setup.exe /C "cmd /c \"@path\" --uninstall --force-uninstall"

FORFILES /P "%LOCALAPPDATA%\Yandex\YaPin" /S /M Yandex.exe /C "cmd /c \"@path\" --uninstall --force-uninstall"

Rem Почистим папки

rem Контакты
del "%USERPROFILE%\Contacts\*" /q /s /f
forfiles /P "%USERPROFILE%\Contacts" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

rem Рабочий стол
del "%USERPROFILE%\Desktop\*" /q /s /f
forfiles /P "%USERPROFILE%\Desktop" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

rem Загрузки
del "%USERPROFILE%\Downloads\*" /q /s /f
forfiles /P "%USERPROFILE%\Downloads" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

rem Избранное
del "%USERPROFILE%\Favorites\*" /q /s /f
forfiles /P "%USERPROFILE%\Favorites" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

rem Ссылки
del "%USERPROFILE%\Links\*" /q /s /f
forfiles /P "%USERPROFILE%\Links" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

rem Музыка
del "%USERPROFILE%\Music\*" /q /s /f
forfiles /P "%USERPROFILE%\Music" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

rem OneDrive
del "%USERPROFILE%\OneDrive\*" /q /s /f
forfiles /P "%USERPROFILE%\OneDrive" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

del "%USERPROFILE%\AppData\Local\Microsoft\OneDrive\*" /q /s /f
forfiles /P "%USERPROFILE%\AppData\Local\Microsoft\OneDrive" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

rem Изображения
del "%USERPROFILE%\Pictures\*" /q /s /f
forfiles /P "%USERPROFILE%\Pictures" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

rem Сохранения игр
del "%USERPROFILE%\Saved Games\*" /q /s /f
forfiles /P "%USERPROFILE%\Saved Games" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

rem Поиски
del "%USERPROFILE%\Searches\*" /q /s /f
forfiles /P "%USERPROFILE%\Searches" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

rem Видео
del "%USERPROFILE%\Videos\*" /q /s /f
forfiles /P "%USERPROFILE%\Videos" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

rem Временные файлы
del "%USERPROFILE%\AppData\Local\Temp\*" /q /s /f
forfiles /P "%USERPROFILE%\AppData\Local\Temp" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

REM ****************************************************************************************
REM Установим тему Softium
REM ****************************************************************************************

REM применяем тему
REM[*] rundll32 не умеет в определение текущей папки, поэтому если надо - придется подсунуть ему %cd%
REM[*] пути с кавычками не работают
rundll32 themecpl.dll,OpenThemeAction %SystemDrive%\ProgramData\Softium\Softium.theme
 
REM прибиваем настройки
:killsettings_loop
tasklist | find /i "SystemSettings.exe" > nul 2> nul
if not %ERRORLEVEL%==0 goto killsettings_loop
taskkill /f /im SystemSettings.exe > nul

:CONTINUE
	ECHO .
	ECHO Всё!
	ECHO .
:END

EXIT /B
