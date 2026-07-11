:: Скрипт настройки среды пользователя

@echo off

powershell -window Hidden -command ""

:: Постараемся запускать приложения с привилегиями родительского процесса без запроса UAC,
:: т.е. от имени запускающего пользователя
set __COMPAT_LAYER=RUNASINVOKER

:: Если скрипт запускается первый раз, то завершаем работу скрипта
	If exist "%SystemDrive%\ProgramData\Softium\FirstRun.txt" (
		echo Первый запуск. Выходим из скрипта.
		del "%SystemDrive%\ProgramData\Softium\FirstRun.txt" /q /f
		powershell -command "$wshell = New-Object -ComObject WScript.Shell; $wshell.Popup(\"Это первый вход пользователя Softium в систему`nПрофиль пользователя создан.`nТребуется повторный вход.\", 0, 'Скрипт настройки профиля', 64)"
		logoff
	 )

:: ****************************************************************************************
:: Описываем переменные.
:: ****************************************************************************************

:: Запускаем AutoHotkey для того, чтобы закрывать окна, которые будет показывать SetUserFTA

start "AutoHotkey" "C:\Program Files\AutoHotkey\v2\AutoHotkey.exe" C:\ProgramData\Softium\KillSetUserFTA.ahk

:: Дадим немного времени, чтобы AutoHotkey успел запуститься

ping 127.0.0.1  > nul 2> nul

:: Сделаем Yandex Browser браузером по-умолчанию.

"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .crx YandexCRX
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .css YandexCSS
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .fb2 YandexFB2
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .htm YandexHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .html YandexHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .infected YandexINFE
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .js YandexJS
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .mhtml YandexHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .shtml YandexHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .svg YandexSVG
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .webp YandexWEBP
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .website YandexHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .xht YandexHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .xhtml YandexHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .xml YandexXML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .yprotect YandexYPROTECT
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" http YandexHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" https YandexHTML

:: Дополнительно создаём ассоциацию для PDF

"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .pdf YandexPDF

:: Вернём ассоциацию SWF-файлов

"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .swf SWF.max.swf

:: включим режим электропитания "Экономия энергии"
powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a

:: Отключаем режим планшета
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v SignInMode /t REG_DWORD /d 2 /f

:: Настроим панель задач
del "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*" /q /s /f

"%ProgramFiles%\7-Zip\7z.exe" x -y  "C:\ProgramData\Softium\QuickLaunch.zip" -o"%APPDATA%\Microsoft\Internet Explorer"

regedit.exe /s "C:\ProgramData\Softium\PinnedTaskbar.reg"

:: Отбражаем Мой компьютер
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f

:: Почистим папки

:: Контакты
del "%USERPROFILE%\Contacts\*" /q /s /f
forfiles /P "%USERPROFILE%\Contacts" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

:: Рабочий стол
del "%USERPROFILE%\Desktop\*" /q /s /f
forfiles /P "%USERPROFILE%\Desktop" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

:: Загрузки
del "%USERPROFILE%\Downloads\*" /q /s /f
forfiles /P "%USERPROFILE%\Downloads" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

:: Избранное
del "%USERPROFILE%\Favorites\*" /q /s /f
forfiles /P "%USERPROFILE%\Favorites" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

:: Ссылки
del "%USERPROFILE%\Links\*" /q /s /f
forfiles /P "%USERPROFILE%\Links" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

:: Музыка
del "%USERPROFILE%\Music\*" /q /s /f
forfiles /P "%USERPROFILE%\Music" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

:: Изображения
del "%USERPROFILE%\Pictures\*" /q /s /f
forfiles /P "%USERPROFILE%\Pictures" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

:: Сохранения игр
del "%USERPROFILE%\Saved Games\*" /q /s /f
forfiles /P "%USERPROFILE%\Saved Games" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

:: Поиски
del "%USERPROFILE%\Searches\*" /q /s /f
forfiles /P "%USERPROFILE%\Searches" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

:: Видео
del "%USERPROFILE%\Videos\*" /q /s /f
forfiles /P "%USERPROFILE%\Videos" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

:: Временные файлы
del "%USERPROFILE%\AppData\Local\Temp\*" /q /s /f
forfiles /P "%USERPROFILE%\AppData\Local\Temp" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

:: ****************************************************************************************
:: Установим тему Softium
:: ****************************************************************************************

:: применяем тему
::[*] rundll32 не умеет в определение текущей папки, поэтому если надо - придется подсунуть ему %cd%
::[*] пути с кавычками не работают

rundll32 themecpl.dll,OpenThemeAction %SystemDrive%\ProgramData\Softium\Softium.theme
 
:: прибиваем настройки
:killsettings_loop
tasklist | find /i "SystemSettings.exe" > nul 2> nul
if not %ERRORLEVEL%==0 goto killsettings_loop
taskkill /f /im SystemSettings.exe > nul

:: Возвращаем правильное название "Мой компьютер"
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /ve /d "Мой компьютер" /t REG_SZ /f > nul 2> nul
 
:: Возвращаем правильное название "Корзина"
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}" /ve /d "Корзина" /t REG_SZ /f > nul 2> nul
 
:: Перезапуск explorer.exe
taskkill /f /im explorer.exe > nul
start explorer.exe

:: Создадим на рабочем столе ярлык для общей папки (SharedFolder)

cscript /nologo "%SystemDrive%\ProgramData\Softium\CreateSharedFolderLink.vbs"

:: Удалим программы Яндекса

:: wmic product where name="Голосовой помощник Алиса" call uninstall /nointeractive

:: FORFILES /P "%LOCALAPPDATA%\Yandex\YandexBrowser\Application" /S /M setup.exe /C "cmd /c \"@path\" --uninstall --force-uninstall"

:: FORFILES /P "%LOCALAPPDATA%\Yandex\YaPin" /S /M Yandex.exe /C "cmd /c \"@path\" --uninstall --force-uninstall"

:: Удалим OneDrive

CALL "%SystemDrive%\ProgramData\Softium\DeleteOneDrive.bat"
forfiles /P "%USERPROFILE%\OneDrive" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"
forfiles /P "%USERPROFILE%\AppData\Local\Microsoft\OneDrive" /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

:: Выводим на рабочий стол техническую информацию о ПК

reg add HKEY_CURRENT_USER\Software\Sysinternals\BGInfo /v EulaAccepted /t REG_DWORD /d 1 /f

"%ProgramFiles%\BGInfo\Bginfo.exe" "%ProgramFiles%\BGInfo\BGSettings.bgi" /silent /TIMER:00 /nolicprompt

powershell -command "$wshell = New-Object -ComObject WScript.Shell; $wshell.Popup(\"Настройка профиля завершена.`nМожно работать!\", 0, 'Скрипт настройки профиля', 64)"

:CONTINUE
	ECHO .
	ECHO Всё!
	ECHO .
:END

EXIT /B
