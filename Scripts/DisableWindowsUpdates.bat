@echo off

::Скрипт отключения обновлений Windows на компьютерах Softium

::****************************************************************************************
::Проверяем наличие у пользователя админских прав...
::****************************************************************************************

SET HasAdminRights=0
FOR /F %%i IN ('WHOAMI /PRIV /NH') DO (
	IF "%%i"=="SeTakeOwnershipPrivilege" SET HasAdminRights=1
)

IF NOT %HasAdminRights%==1 (
	echo .
	MSG * "You need administrator rights to run!!!"
	echo .
	GOTO :END
)

::Отключим автоматическое обновление системы

echo Отключим автоматическое обновление системы
echo.

:: Блокировка через hosts файл
echo Добавляем записи в файл hosts
echo 0.0.0.0 fe1.update.microsoft.com >> %windir%\system32\drivers\etc\hosts
echo 0.0.0.0 fe2.update.microsoft.com >> %windir%\system32\drivers\etc\hosts
echo 0.0.0.0 fe3.update.microsoft.com >> %windir%\system32\drivers\etc\hosts

:: Основные настройки отключения обновлений
echo Отключаем обновления Windows

reg ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DoNotConnectToWindowsUpdateInternetLocations /t REG_DWORD /d 1 /f >nul 2>&1
reg ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DisableWindowsUpdateAccess /t REG_DWORD /d 1 /f >nul 2>&1
reg ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v TargetGroup /t REG_SZ /d "NoUpdates" /f >nul 2>&1
reg ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v TargetGroupEnabled /t REG_DWORD /d 1 /f >nul 2>&1

:: Очистка серверов обновлений
reg ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v WUServer /t REG_SZ /d "0.0.0.0" /f >nul 2>&1
reg ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v WUStatusServer /t REG_SZ /d "0.0.0.0" /f >nul 2>&1
reg ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v UpdateServiceUrlAlternate /t REG_SZ /d "0.0.0.0" /f >nul 2>&1

:: Настройки автоматических обновлений
reg ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v UseWUServer /t REG_DWORD /d 1 /f >nul 2>&1
reg ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f >nul 2>&1
reg ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v AUOptions /t REG_DWORD /d 1 /f >nul 2>&1

:: Дополнительные меры через службы
echo Останавливаем службы Windows Update...
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
net stop dosvc >nul 2>&1

:: Отключение служб
sc config wuauserv start= disabled >nul 2>&1
sc config bits start= disabled >nul 2>&1
sc config dosvc start= disabled >nul 2>&1

:: Блокировка через брандмауэр (Windows 10/11)
echo Добавляем правила в firewall...
netsh advfirewall firewall add rule name="Block Windows Update" dir=out action=block service="wuauserv" enable=yes >nul 2>&1

echo.
echo Готово! Обновление Windows запрещенo.

:END

timeout 10
