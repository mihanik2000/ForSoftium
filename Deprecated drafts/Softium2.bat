@Rem Отключаем вывод самих команд на экран
@echo off 

REM Переходим в папку со скриптом

set MyPath=%~dp0
set MyPath=%MyPath:~0,2%

%MyPath%
cd %~dp0

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
net user Софтиум /add 

rem ****************************************************************************************
rem Настроим некоторые параметры необходимые для удалённого администрирования.
rem ****************************************************************************************

rem включим режим электропитания "Высокая производительность"
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

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


rem включим режим электропитания "Экономия энергии"
powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a

:CONTINUE
	ECHO .
	ECHO Всё!
	ECHO .
	
:END

PAUSE

EXIT /B
