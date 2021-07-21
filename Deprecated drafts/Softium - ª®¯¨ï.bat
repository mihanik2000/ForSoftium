Rem Отключаем вывод самих команд на экран
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
rem Настраиваем учётные записи пользователей на компьютере
rem ****************************************************************************************

rem активируем встроенного Админа
net user Администратор MyPa$$w0rd /active:yes

rem Зададим пользователю admin пароль Pa$$w0rd
net user admin Pa$$w0rd

rem Создадим пользователя Софтиум без пароля
net user Софтиум1 /add 

rem ****************************************************************************************
rem Настроим некоторые параметры необходимые для удалённого администрирования.
rem ****************************************************************************************

rem включим режим электропитания "Экономия энергии"
powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a

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

REM Переходим в папку с дистрибутивами

D:

cd D:\data\Softium\

rem ****************************************************************************************
rem Настраиваем среду пользователя
rem ****************************************************************************************

ECHO Устанавливаем обои рабочего стола
ECHO ...

copy /Y "D:\data\Softium\Заставка для рабочего стола_full.jpg" C:\ProgramData\

reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "C:\ProgramData\Заставка для рабочего стола_full.jpg" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\BackUpWallpaper" /v Wallpaper /t REG_SZ /d "C:\ProgramData\Заставка для рабочего стола_full.jpg" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\Wallpaper" /v Wallpaper /t REG_SZ /d "C:\ProgramData\Заставка для рабочего стола_full.jpg" /f

rem Отбражаем Мой компьютере
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f

ECHO Отключаем режим планшета
ECHO ...
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v SignInMode /t REG_DWORD /d 2 /f


%SystemRoot%\System32\RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters

echo reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "C:\ProgramData\Заставка для рабочего стола_full.jpg" /f  > "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\wallpaper.bat"
echo reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\BackUpWallpaper" /v Wallpaper /t REG_SZ /d "C:\ProgramData\Заставка для рабочего стола_full.jpg" /f >> "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\wallpaper.bat"
echo reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\Wallpaper" /v Wallpaper /t REG_SZ /d "C:\ProgramData\Заставка для рабочего стола_full.jpg" /f >> "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\wallpaper.bat"

echo %SystemRoot%\System32\RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
echo reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f >> "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\wallpaper.bat"
echo reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v SignInMode /t REG_DWORD /d 2 /f >> "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\wallpaper.bat"
echo reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f >> "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\wallpaper.bat"

echo EXIT /B >> "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\wallpaper.bat"

rem ****************************************************************************************
rem Устанавливаем программы
rem ****************************************************************************************

rem Переходим в папку со скриптом
D:
cd D:\data\Softium\

ECHO Устанавливаем клиента коммуникации
ECHO ...
start /wait D:\data\Softium\em_dv6eDwnk_installer.msi /qn

ECHO Устанавливаем архиватор
ECHO ...
start /wait D:\data\Softium\7z1806.msi /qn

ECHO Устанавливаем Notepad++ 
ECHO ...
start /wait D:\data\Softium\npp.7.6.3.Installer.exe /S

ECHO Устанавливаем AdobeAIRInstaller 
ECHO ...
start /wait D:\data\Softium\AdobeAIRInstaller.exe -silent

ECHO Устанавливаем Scratch 
ECHO ...
start /wait D:\data\Softium\Scratch-460.exe -silent

ECHO Устанавливаем GIMP 
ECHO ...
start /wait D:\data\Softium\gimp-2.10.8-setup-2.exe /SILENT

ECHO Устанавливаем Chrome 
ECHO ...
start /wait D:\data\Softium\ChromeSetup.exe /silent /install

ECHO Устанавливаем BabyType 
ECHO ...
set PATH=%PATH%;C:\Program Files\7-Zip
cd c:\
7z x D:\data\Softium\BabyType.rar *
ren C:\BabyType BabyType2000
cd D:\data\Softium\

ECHO Устанавливаем SNAP 
ECHO ...
md "C:\Program Files\SNAP"
cd "C:\Program Files\SNAP"
7z x D:\data\Softium\snap.zip *
cd D:\data\Softium\

ECHO Устанавливаем SWF Player
ECHO ...
start /wait D:\data\Softium\SWFPlayer_2.2.exe /S

ECHO Устанавливаем construct2
ECHO ...
start /wait D:\data\Softium\construct2-r255-setup.exe /verysilent

ECHO Устанавливаем Animate
ECHO ...
md "C:\Program Files\Animate"
copy /Y D:\data\Softium\animate.* "C:\Program Files\Animate\"

ECHO Устанавливаем Softium
ECHO ...
md "C:\Program Files\Softium"
copy /Y D:\data\Softium\Softium.exe "C:\Program Files\Softium\"

:CONTINUE
	ECHO .
	ECHO Всё!
	ECHO .
	
:END

PAUSE

EXIT /B
