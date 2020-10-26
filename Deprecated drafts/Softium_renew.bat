@Rem Отключаем вывод самих команд на экран
	@echo off 

rem ****************************************************************************************
rem Проверяем наличие у пользователя админских прав...
rem ****************************************************************************************

	SET HasAdminRights=0
	FOR /F %%i IN ('WHOAMI /PRIV /NH') DO (
		IF "%%i"=="SeTakeOwnershipPrivilege" SET HasAdminRights=1
	)

	IF NOT %HasAdminRights%==1 (
		ECHO .
		ECHO Этот скрипт необходимо запускать от имени администратора.
		ECHO .
		GOTO END
	)

rem ****************************************************************************************
rem включим режим электропитания "Высокая производительность"
rem ****************************************************************************************
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

rem ****************************************************************************************
REM Переходим в папку со скриптом
rem ****************************************************************************************
	set MyPath=%~dp0
	set MyPath=%MyPath:~0,2%
	%MyPath%
	cd %~dp0

rem ****************************************************************************************
rem Настраиваем учётные записи пользователей на компьютере
rem ****************************************************************************************

rem активируем встроенного Админа
net user Администратор MyPa$$w0rd /active:yes

rem Зададим пользователю admin пароль Pa$$w0rd
net user admin Pa$$w0rd

rem ****************************************************************************************
rem Настроим некоторые параметры необходимые для удалённого администрирования.
rem ****************************************************************************************

rem отключаем спящий режим
powercfg -hibernate off
reg ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power /v HiberFileSizePercent /t REG_DWORD /d 0 /f
reg ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power /v HibernateEnabled /t REG_DWORD /d 0 /f

rem Запланируем ежедневное выключение в полночь
SCHTASKS /Create /RU "NT AUTHORITY\SYSTEM" /SC DAILY /TN "Microsoft\Office\Office Shutdown" /TR  "\"C:\Windows\System32\shutdown.exe\" /s /f /t 00"  /ST 00:00 /RL HIGHEST

rem Отключим автоматическое обновление системы
net stop wuauserv
sc config wuauserv start= disabled

rem Включим межсетевой экран
netsh advfirewall set allprofiles state on

rem Разрешим отвечать на ping 
netsh firewall set icmpsetting 8

rem ****************************************************************************************
rem Настраиваем среду пользователя
rem ****************************************************************************************

ECHO Устанавливаем обои рабочего стола
ECHO ...

reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "C:\ProgramData\Заставка для рабочего стола_full.jpg" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\BackUpWallpaper" /v Wallpaper /t REG_SZ /d "C:\ProgramData\Заставка для рабочего стола_full.jpg" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\Wallpaper" /v Wallpaper /t REG_SZ /d "C:\ProgramData\Заставка для рабочего стола_full.jpg" /f

ECHO Отбражаем Мой компьютер
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f

ECHO  Отключаем режим планшета
ECHO ...
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v SignInMode /t REG_DWORD /d 2 /f

%SystemRoot%\System32\RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters ,1 ,True

REM Формируем файл, который подготовит среду пользователя
(
	rem Устанавливаем обои рабочего стола
	echo reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "C:\ProgramData\Заставка для рабочего стола_full.jpg" /f
	echo reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\BackUpWallpaper" /v Wallpaper /t REG_SZ /d "C:\ProgramData\Заставка для рабочего стола_full.jpg" /f
	echo reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\Wallpaper" /v Wallpaper /t REG_SZ /d "C:\ProgramData\Заставка для рабочего стола_full.jpg" /f

	rem  Отключаем режим планшета
	echo reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f
	echo reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v SignInMode /t REG_DWORD /d 2 /f

	rem Отбражаем Мой компьютере
	echo reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f

	rem Применяем параметры пользователя
	echo %%SystemRoot%%\System32\RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
	
	rem сделаем ссылки в панели быстрого запуска
	cd "%%userprofile%%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch"
	del /F /Q *
	call %%windir%%\temp\myquiklnk.bat
	echo EXIT /B 
	
) > "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\wallpaper.bat"

(
echo @set @x=0 /*
echo @rem
echo @rem ****************************************************************************************************************************
echo @rem Скрипт для создания ярлыков к программам и файлам на компьютере
echo @rem ****************************************************************************************************************************
echo @rem
echo @rem ЗАМЕТКИ НА ПОЛЯХ :-^)
echo @rem Адрес панели быстрого запуска пользователя
echo @rem %%userprofile%%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch
echo @rem
echo @rem ****************************************************************************************************************************
echo @rem Описание параметров скрипта
echo @rem "Папка, где создаём ярлык" "хвост к папке" "Путь к программе" "Путь к рабочей папке" "Имя ярлыка" "путь к файлу с иконкой" 
echo @rem ****************************************************************************************************************************
echo @rem
echo @cscript /nologo /e:jscript "%%~f0" "AllUsersDesktop" "" "C:\Windows\System32\notepad.exe" 				"C:\WINDOWS\system32" 			"Блокнот" 		"C:\Windows\System32\notepad.exe"
echo @cscript /nologo /e:jscript "%%~f0" "AllUsersDesktop" "" "C:\Program Files\GIMP 2\bin\gimp-2.10.exe" 	"C:\Program Files\GIMP 2\bin" 	"GIMP" 			"C:\Program Files\GIMP 2\bin\gimp-2.10.exe"
echo @cscript /nologo /e:jscript "%%~f0" "AllUsersDesktop" "" "C:\Program Files\Scratch 2\Scratch 2.exe" 		"C:\Program Files\Scratch 2" 	"Scratch" 		"C:\Program Files\Scratch 2\Scratch 2.exe"
echo @cscript /nologo /e:jscript "%%~f0" "AllUsersDesktop" "" "C:\BabyType2000\BABYTYPE.EXE" 					"C:\BabyType2000" 				"BabyType" 		"%%SystemRoot%%\System32\SHELL32.dll,41"
echo @cscript /nologo /e:jscript "%%~f0" "AllUsersDesktop" "" "C:\Program Files\SNAP\index.html" 				"C:\Program Files\SNAP" 		"SNAP!" 		"C:\Program Files\SNAP\favicon.ico"
echo @cscript /nologo /e:jscript "%%~f0" "AllUsersDesktop" "" "C:\Program Files\Notepad++\notepad++.exe" 		"C:\Program Files\Notepad++" 	"notepad++" 	"C:\Program Files\Notepad++\notepad++.exe"
echo @cscript /nologo /e:jscript "%%~f0" "AllUsersDesktop" "" "C:\Program Files\Construct 2\Construct2.exe" 	"C:\Program Files\Construct 2" 	"Construct 2" 	"C:\Program Files\Construct 2\Construct2.exe"
echo @cscript /nologo /e:jscript "%%~f0" "AllUsersDesktop" "" "C:\Program Files\Animate\animate.swf" 			"C:\Program Files\Animate" 		"Создай Мульт" 	"C:\Program Files\Animate\animate.ico"
echo @cscript /nologo /e:jscript "%%~f0" "AllUsersDesktop" "" "C:\Program Files\Softium\Softium.exe" 			"C:\Program Files\Softium" 		"Софтиум" 		"C:\Program Files\Softium\Softium.exe"
echo 
echo @exit /b */
echo 
echo sh=WScript.CreateObject^("WScript.Shell"^)
echo MyFolderPart=sh.SpecialFolders^(WScript.Arguments^(0^)^)
echo MyFolderPart=MyFolderPart+WScript.Arguments^(1^)
echo lk=sh.CreateShortcut^(MyFolderPart+"\\"+WScript.Arguments^(4^)+".lnk"^)
echo lk.TargetPath = WScript.Arguments^(2^)
echo lk.WorkingDirectory = WScript.Arguments^(3^)
echo lk.WindowStyle = 1
echo lk.Hotkey = ""
echo lk.IconLocation = WScript.Arguments^(5^)
echo lk.Description = ""
echo lk.Arguments = ""
echo lk.Save^(^)
echo ) > %windir%\temp\mylnk.bat


(
echo @set @x=0 /*
echo @rem
echo @rem ****************************************************************************************************************************
echo @rem Скрипт для создания ярлыков к программам и файлам на компьютере
echo @rem ****************************************************************************************************************************
echo @rem
echo @rem ЗАМЕТКИ НА ПОЛЯХ :-^)
echo @rem Адрес панели быстрого запуска пользователя
echo @rem %%userprofile%%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch
echo @rem
echo @rem ****************************************************************************************************************************
echo @rem Описание параметров скрипта
echo @rem "Папка, где создаём ярлык" "хвост к папке" "Путь к программе" "Путь к рабочей папке" "Имя ярлыка" "путь к файлу с иконкой" 
echo @rem ****************************************************************************************************************************
echo @rem
echo @cscript /nologo /e:jscript "%%~f0" "" "%%userprofile%%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch" "C:\Windows\System32\notepad.exe" 				"C:\WINDOWS\system32" 			"Блокнот" 		"C:\Windows\System32\notepad.exe"
echo 
echo @exit /b */
echo 
echo sh=WScript.CreateObject^("WScript.Shell"^)
echo MyFolderPart=sh.SpecialFolders^(WScript.Arguments^(0^)^)
echo MyFolderPart=MyFolderPart+WScript.Arguments^(1^)
echo lk=sh.CreateShortcut^(MyFolderPart+"\\"+WScript.Arguments^(4^)+".lnk"^)
echo lk.TargetPath = WScript.Arguments^(2^)
echo lk.WorkingDirectory = WScript.Arguments^(3^)
echo lk.WindowStyle = 1
echo lk.Hotkey = ""
echo lk.IconLocation = WScript.Arguments^(5^)
echo lk.Description = ""
echo lk.Arguments = ""
echo lk.Save^(^)
echo
) > %windir%\temp\myquiklnk.bat


rem Установим ярлыки на рабочем столе
	call %windir%\temp\mylnk.bat

rem включим режим электропитания "Экономия энергии"
powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a

EXIT /B
