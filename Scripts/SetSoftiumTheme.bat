@echo off
REM ****************************************
REM
REM Автор скрипта Михаил Медведев aka mihanik
REM
REM https://mihanik.net
REM
REM        Требуется наличие прав администратора: ДА
REM Антивирусная программа должна быть отключена: желательно, но не обязательно
REM                                    Замечания: НЕТ
REM
REM Описание
REM
REM ****************************************

REM ****************************************************************************************
REM Установим тему Softium
REM ****************************************************************************************

:: применяем тему
::[*] rundll32 не умеет в определение текущей папки, поэтому если надо - придется подсунуть ему %cd%
::[*] пути с кавычками не работают
rundll32 themecpl.dll,OpenThemeAction %SystemDrive%\ProgramData\Softium\Softium.theme
 
:: прибиваем настройки
:killsettings_loop
tasklist | find /i "SystemSettings.exe" > nul 2> nul
if not %ERRORLEVEL%==0 goto killsettings_loop
taskkill /f /im SystemSettings.exe > nul


:ENDSUB

timeout 3 /nobreak

EXIT /B
