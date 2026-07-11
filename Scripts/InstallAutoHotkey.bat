@echo off
:: ****************************************
::
:: Автор скрипта Михаил Медведев aka mihanik
::
:: https://mihanik.net
::
::        Требуется наличие прав администратора: ДА
:: Антивирусная программа должна быть отключена: желательно, но не обязательно
::                                    Замечания: НЕТ
::
:: Описание:
::		
::
:: ****************************************

:: **************************************************
:: Проверяем наличие у пользователя админских прав.
:: Если таковых прав нет, завершаем работу скрипта...
:: **************************************************

SET HasAdminRights=0

FOR /F %%i IN ('WHOAMI /PRIV /NH') DO (
	IF "%%i"=="SeTakeOwnershipPrivilege" SET HasAdminRights=1
)

IF /I NOT "%HasAdminRights%"=="1" (
	echo.
	echo Вам нужны права администратора для запуска этого скрипта!
	echo.
	GOTO ENDSUB
)

if NOT defined ScriptPath (
	echo.
	echo Не определена переменная ScriptPath
	echo.
	GOTO ENDSUB
)

:: ****************************************************************************************
:: Устанавливаем программу AutoHotkey
:: ****************************************************************************************

set "PathToAutoHotkey=%ScriptPath%Distr\noarch\AutoHotkey_2.0.24_setup.exe"

echo.
echo ========================================
echo  Установка AutoHotkey
echo ========================================
echo.

:: ****************************************************************************************
:: Добавим программу AutoHotkey в исключения защитника Windows
:: ****************************************************************************************

powershell -NoProfile -ExecutionPolicy Bypass -Command "Add-MpPreference -ExclusionPath 'C:\Program Files\AutoHotkey\v2'"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Add-MpPreference -ExclusionPath 'C:\Program Files\AutoHotkey\v2\AutoHotkey.exe'"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Add-MpPreference -ExclusionPath 'C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe'"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Add-MpPreference -ExclusionPath 'C:\Program Files\AutoHotkey\v2\AutoHotkey32.exe'"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Add-MpPreference -ExclusionPath 'C:\Program Files\AutoHotkey\v2\AutoHotkey32_UIA.exe'"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Add-MpPreference -ExclusionPath 'C:\Program Files\AutoHotkey\v2\AutoHotkey64_UIA.exe'"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Add-MpPreference -ExclusionPath 'C:\Program Files\AutoHotkey\UX'"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Add-MpPreference -ExclusionPath 'C:\Program Files\AutoHotkey\UX\AutoHotkeyUX.exe'"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Add-MpPreference -ExclusionPath 'C:\Program Files\AutoHotkey\v2'"

:: ****************************************************************************************
:: Непосредственная установка AutoHotkey
:: ****************************************************************************************

start "AutoHotkey" /wait "%PathToAutoHotkey%" /silent

:: ****************************************************************************************
:: Теперь копируем скрипты для AutoHotkey в папку C:\ProgramData\Softium
:: ****************************************************************************************

copy /y "%ScriptPath%Distr\noarch\*.ahk" "%ProgramData%\Softium\" >nul 2>&1


:ENDSUB

timeout 3 /nobreak

EXIT /B
