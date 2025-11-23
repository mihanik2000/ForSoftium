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
:: Описание
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

IF NOT %HasAdminRights%==1 (
	echo.
	echo Вам нужны права администратора для запуска этого скрипта!
	echo.
	GOTO ENDSUB
)

:: ****************************************************************************************
:: Процедура обновления файлов
:: ****************************************************************************************

:: ****************************************************************************************
:: Обновление темы оформления
:: ****************************************************************************************

:: Удаляем имеющийся файл
del "%SystemDrive%\ProgramData\Softium\Softium.theme" /q /f

:: Скачиваем новый файл
wget.exe --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\Softium.theme" "https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/Softium.theme"

:: применяем тему
::[*] rundll32 не умеет определять текущую папку, поэтому если надо - придется подсунуть ему %cd%
::[*] пути с кавычками не работают
rundll32 themecpl.dll,OpenThemeAction %SystemDrive%\ProgramData\Softium\Softium.theme
 
:: прибиваем настройки
:killsettings_loop
tasklist | find /i "SystemSettings.exe" > nul 2> nul
if not %ERRORLEVEL%==0 goto killsettings_loop
taskkill /f /im SystemSettings.exe > nul

:: ****************************************************************************************
:: Обновляем групповую политику
:: ****************************************************************************************

:: Удаляем имеющийся файл
del "%SystemDrive%\ProgramData\Softium\GroupPolicy.7z" /q /f

:: Скачиваем новый файл
wget.exe --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\GroupPolicy.7z" "https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/GroupPolicy.7z"

:: Применяем политику

"%ProgramFiles%\7-Zip\7z.exe" x -y  "%SystemDrive%\ProgramData\Softium\GroupPolicy.7z" -o"%windir%\System32"

:: ****************************************************************************************
:: Обновляем скрипт очистки профиля пользователя
:: ****************************************************************************************

:: Удаляем имеющийся файл
del "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\StartUp\CleanUp.bat" /q /f

:: Скачиваем новый файл
wget.exe --no-check-certificate -O "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\StartUp\CleanUp.bat" "https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/step-3-user-CleanUp.bat"

:ENDSUB

timeout 3 /nobreak

EXIT /B
