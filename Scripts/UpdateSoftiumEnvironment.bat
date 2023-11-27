@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM        Require administrator rights: YES
REM Antivirus software must be disabled: Not necessary
REM                        Dependencies: No
REM
REM Описание
REM
REM ****************************************

rem Проверяем наличие у пользователя админских прав...
SET HasAdminRights=0

FOR /F %%i IN ('WHOAMI /PRIV /NH') DO (
	IF "%%i"=="SeTakeOwnershipPrivilege" SET HasAdminRights=1
)

IF NOT %HasAdminRights%==1 (
	ECHO .
	ECHO Вам нужны права администратора для запуска этого скрипта!
	ECHO .
	GOTO ENDSUB
)

REM ****************************************************************************************
REM Процедура обновления файлов
REM ****************************************************************************************

REM ****************************************************************************************
REM Обновление темы оформления
REM ****************************************************************************************

REM Удаляем имеющийся файл
del "%SystemDrive%\ProgramData\Softium\Softium.theme" /q /f

REM Скачиваем новый файл
wget.exe --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\Softium.theme" "https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/Softium.theme"

REM применяем тему
REM[*] rundll32 не умеет определять текущую папку, поэтому если надо - придется подсунуть ему %cd%
REM[*] пути с кавычками не работают
rundll32 themecpl.dll,OpenThemeAction %SystemDrive%\ProgramData\Softium\Softium.theme
 
REM прибиваем настройки
:killsettings_loop
tasklist | find /i "SystemSettings.exe" > nul 2> nul
if not %ERRORLEVEL%==0 goto killsettings_loop
taskkill /f /im SystemSettings.exe > nul

REM ****************************************************************************************
REM Обновляем групповую политику
REM ****************************************************************************************

REM Удаляем имеющийся файл
del "%SystemDrive%\ProgramData\Softium\GroupPolicy.7z" /q /f

REM Скачиваем новый файл
wget.exe --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\GroupPolicy.7z" "https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/GroupPolicy.7z"

REM Применяем политику

"%ProgramFiles%\7-Zip\7z.exe" x -y  "%SystemDrive%\ProgramData\Softium\GroupPolicy.7z" -o"%windir%\System32"

REM ****************************************************************************************
REM Обновляем скрипт очистки профиля пользователя
REM ****************************************************************************************

REM Удаляем имеющийся файл
del ""%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\StartUp\CleanUp.bat" /q /f

REM Скачиваем новый файл
wget.exe --no-check-certificate -O ""%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\StartUp\CleanUp.bat" "https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/step-3-user-CleanUp.bat"

:ENDSUB

timeout 3 /nobreak

EXIT /B
