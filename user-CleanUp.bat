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

Rem Устанавливаем ассоциации файлов

"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .swf "C:\Program Files (x86)\SWF.max\SWF.max.exe"

"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .3g2  AppX6eg8h5sxqq90pv53845wmnbewywdqq5h
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .3gp  AppX6eg8h5sxqq90pv53845wmnbewywdqq5h
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .3gp2  AppX6eg8h5sxqq90pv53845wmnbewywdqq5h
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .3gpp  AppX6eg8h5sxqq90pv53845wmnbewywdqq5h
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .3mf  AppXvhc4p7vz4b485xfp46hhk3fq3grkdgjg
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .aac  AppXqj98qxeaynz6dv4459ayz6bnqxbyaqcs
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .ac3  AppXqj98qxeaynz6dv4459ayz6bnqxbyaqcs
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .adt  AppXqj98qxeaynz6dv4459ayz6bnqxbyaqcs
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .adts  AppXqj98qxeaynz6dv4459ayz6bnqxbyaqcs
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .amr  AppXqj98qxeaynz6dv4459ayz6bnqxbyaqcs
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .arw  AppX43hnxtbyyps62jhe9sqpdzxn1790zetc
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .avi  AppX6eg8h5sxqq90pv53845wmnbewywdqq5h
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .bmp  AppX43hnxtbyyps62jhe9sqpdzxn1790zetc
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .cr2  AppX43hnxtbyyps62jhe9sqpdzxn1790zetc
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .crw  AppX43hnxtbyyps62jhe9sqpdzxn1790zetc
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .dib  AppX43hnxtbyyps62jhe9sqpdzxn1790zetc
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .ec3  AppXqj98qxeaynz6dv4459ayz6bnqxbyaqcs
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .epub  AppXvepbp3z66accmsd0x877zbbxjctkpr6t
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .erf  AppX43hnxtbyyps62jhe9sqpdzxn1790zetc
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .fbx  AppXmgw6pxxs62rbgfp9petmdyb4fx7rnd4k
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .flac  AppXqj98qxeaynz6dv4459ayz6bnqxbyaqcs
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .gif  AppX43hnxtbyyps62jhe9sqpdzxn1790zetc
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .glb  AppXmgw6pxxs62rbgfp9petmdyb4fx7rnd4k
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .gltf  AppXmgw6pxxs62rbgfp9petmdyb4fx7rnd4k
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .htm  ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .html  ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .inf  inffile
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .ini  inifile
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .jfif  AppX43hnxtbyyps62jhe9sqpdzxn1790zetc
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .jpe  AppX43hnxtbyyps62jhe9sqpdzxn1790zetc
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .jpeg  AppX43hnxtbyyps62jhe9sqpdzxn1790zetc
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .jpg  AppX43hnxtbyyps62jhe9sqpdzxn1790zetc
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .jxr  AppX43hnxtbyyps62jhe9sqpdzxn1790zetc
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .kdc  AppX43hnxtbyyps62jhe9sqpdzxn1790zetc
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .log  txtfile
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .m2t  AppX6eg8h5sxqq90pv53845wmnbewywdqq5h
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .m2ts  AppX6eg8h5sxqq90pv53845wmnbewywdqq5h
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .m3u  AppXqj98qxeaynz6dv4459ayz6bnqxbyaqcs
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .m4a  AppXqj98qxeaynz6dv4459ayz6bnqxbyaqcs
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .m4r  AppXqj98qxeaynz6dv4459ayz6bnqxbyaqcs
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .m4v  AppX6eg8h5sxqq90pv53845wmnbewywdqq5h
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .mka  AppXqj98qxeaynz6dv4459ayz6bnqxbyaqcs
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .mkv  AppX6eg8h5sxqq90pv53845wmnbewywdqq5h
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .mod  AppX6eg8h5sxqq90pv53845wmnbewywdqq5h
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .mov  AppX6eg8h5sxqq90pv53845wmnbewywdqq5h
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .MP2  WMP11.AssocFile.MP3
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .mp3  AppXqj98qxeaynz6dv4459ayz6bnqxbyaqcs
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .mp4  AppX6eg8h5sxqq90pv53845wmnbewywdqq5h
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .mp4v  AppX6eg8h5sxqq90pv53845wmnbewywdqq5h
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .mpa  AppXqj98qxeaynz6dv4459ayz6bnqxbyaqcs
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .MPE  AppX6eg8h5sxqq90pv53845wmnbewywdqq5h
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .mpeg  AppX6eg8h5sxqq90pv53845wmnbewywdqq5h
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .mpg  AppX6eg8h5sxqq90pv53845wmnbewywdqq5h
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .mpv2  AppX6eg8h5sxqq90pv53845wmnbewywdqq5h
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .mrw  AppX43hnxtbyyps62jhe9sqpdzxn1790zetc
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .mts  AppX6eg8h5sxqq90pv53845wmnbewywdqq5h
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .nef  AppX43hnxtbyyps62jhe9sqpdzxn1790zetc
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .nrw  AppX43hnxtbyyps62jhe9sqpdzxn1790zetc
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .obj  AppXmgw6pxxs62rbgfp9petmdyb4fx7rnd4k
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .oga  AppXqj98qxeaynz6dv4459ayz6bnqxbyaqcs
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .ogg  AppXqj98qxeaynz6dv4459ayz6bnqxbyaqcs
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .ogm  AppX6eg8h5sxqq90pv53845wmnbewywdqq5h
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .ogv  AppX6eg8h5sxqq90pv53845wmnbewywdqq5h
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .ogx  AppX6eg8h5sxqq90pv53845wmnbewywdqq5h
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .opus  AppXqj98qxeaynz6dv4459ayz6bnqxbyaqcs
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .orf  AppX43hnxtbyyps62jhe9sqpdzxn1790zetc
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .oxps  Windows.XPSReachViewer
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .pdf  AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .pef  AppX43hnxtbyyps62jhe9sqpdzxn1790zetc
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .ply  AppXmgw6pxxs62rbgfp9petmdyb4fx7rnd4k
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .png  AppX43hnxtbyyps62jhe9sqpdzxn1790zetc
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .ps1  Microsoft.PowerShellScript.1
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .psd1  Microsoft.PowerShellData.1
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .psm1  Microsoft.PowerShellModule.1
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .raf  AppX43hnxtbyyps62jhe9sqpdzxn1790zetc
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .raw  AppX43hnxtbyyps62jhe9sqpdzxn1790zetc
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .rw2  AppX43hnxtbyyps62jhe9sqpdzxn1790zetc
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .rwl  AppX43hnxtbyyps62jhe9sqpdzxn1790zetc
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .scp  txtfile
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .sr2  AppX43hnxtbyyps62jhe9sqpdzxn1790zetc
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .srw  AppX43hnxtbyyps62jhe9sqpdzxn1790zetc
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .stl  AppXvhc4p7vz4b485xfp46hhk3fq3grkdgjg
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .svg  AppXde74bfzw9j31bzhcvsrxsyjnhhbq66cs
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .tif  PhotoViewer.FileAssoc.Tiff
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .tiff  PhotoViewer.FileAssoc.Tiff
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .tod  AppX6eg8h5sxqq90pv53845wmnbewywdqq5h
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .TS  AppX6eg8h5sxqq90pv53845wmnbewywdqq5h
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .TTS  AppX6eg8h5sxqq90pv53845wmnbewywdqq5h
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .txt  txtfile
REM "%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .url  ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .wav  AppXqj98qxeaynz6dv4459ayz6bnqxbyaqcs
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .wdp  AppX43hnxtbyyps62jhe9sqpdzxn1790zetc
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .webm  AppX6eg8h5sxqq90pv53845wmnbewywdqq5h
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .website  ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .wm  AppX6eg8h5sxqq90pv53845wmnbewywdqq5h
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .wma  AppXqj98qxeaynz6dv4459ayz6bnqxbyaqcs
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .wmv  AppX6eg8h5sxqq90pv53845wmnbewywdqq5h
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .WPL  AppXqj98qxeaynz6dv4459ayz6bnqxbyaqcs
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .wsb  Windows.Sandbox
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .wtx  txtfile
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .xps  Windows.XPSReachViewer
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .xvid  AppX6eg8h5sxqq90pv53845wmnbewywdqq5h
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" .zpl  AppXqj98qxeaynz6dv4459ayz6bnqxbyaqcs
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" bingmaps  AppXp9gkwccvk6fa6yyfq3tmsk8ws2nprk1p
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" http  ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" https  ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" mailto  AppXydk58wgm44se4b399557yyyj1w7mbmvd
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" microsoft-edge  AppX7rm9drdg8sk7vqndwj3sdjw11x96jc0y
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" microsoft-edge-holographic  AppX3xxs313wwkfjhythsb8q46xdsq8d2cvv
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" ms-xbl-3d8b930f  AppXdn5b0j699ka5fqvrr3pgjad0evqarm6d
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" mswindowsmusic  AppXtggqqtcfspt6ks3fjzyfppwc05yxwtwy
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" mswindowsvideo  AppX6w6n4f8xch1s3vzwf3af6bfe88qhxbza
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe" read  AppXe862j7twqs4aww05211jaakwxyfjx4da

Rem включим режим электропитания "Экономия энергии"
powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a

Rem Отключаем режим планшета
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v SignInMode /t REG_DWORD /d 2 /f

Rem Настроим панель задач
del "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*" /q /s /f

"%ProgramFiles%\7-Zip\7z.exe" x -y  "C:\ProgramData\Softium\QuickLaunch.zip" -o"%APPDATA%\Microsoft\Internet Explorer"

regedit.exe /s "C:\ProgramData\Softium\PinnedTaskbar.reg"

Rem Отбражаем Мой компьютер
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f

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

REM Возвращаем правильное название "Мой компьютер"
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /ve /d "Мой компьютер" /t REG_SZ /f > nul 2> nul
 
REM Возвращаем правильное название "Корзина"
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}" /ve /d "Корзина" /t REG_SZ /f > nul 2> nul
 
REM Перезапуск explorer.exe
taskkill /f /im explorer.exe > nul
start explorer.exe

REM Удалим программы Яндекса

wmic product where name="Голосовой помощник Алиса" call uninstall /nointeractive

FORFILES /P "%LOCALAPPDATA%\Yandex\YandexBrowser\Application" /S /M setup.exe /C "cmd /c \"@path\" --uninstall --force-uninstall"

FORFILES /P "%LOCALAPPDATA%\Yandex\YaPin" /S /M Yandex.exe /C "cmd /c \"@path\" --uninstall --force-uninstall"

REM Удалим OneDrive

CALL "%SystemDrive%\ProgramData\Softium\DeleteOneDrive.bat"

REM Выводим на рабочий стол техническую информацию о ПК
reg add HKEY_CURRENT_USER\Software\Sysinternals\BGInfo /v EulaAccepted /t REG_DWORD /d 1 /f
"%ProgramFiles%\BGInfo\Bginfo.exe" "%ProgramFiles%\BGInfo\BGSettings.bgi" /silent /TIMER:00 /nolicprompt

:CONTINUE
	ECHO .
	ECHO Всё!
	ECHO .
:END



EXIT /B
