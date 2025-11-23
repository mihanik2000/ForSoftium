@echo off
:: ****************************************
::
:: Written by Michael Medvedev aka mihanik.
::
:: https://mihanik.net
::
::        Требуется наличие прав администратора: ДА
:: Антивирусная программа должна быть отключена: желательно, но не обязательно
::                                    Замечания: НЕТ
::
:: Description
::
:: ****************************************

:: Check whether the user has admin rights...
SET HasAdminRights=0

FOR /F %%i IN ('WHOAMI /PRIV /NH') DO (
	IF "%%i"=="SeTakeOwnershipPrivilege" SET HasAdminRights=1
)

IF NOT %HasAdminRights%==1 (
	echo.
	echo You need administrator rights to run this script!
	echo.
	GOTO ENDSUB
)

:: ***********************************************************************************************
:: Зададим URL файлов, которые нужно обновить
:: ***********************************************************************************************

	set URLFileUpdater="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Scripts/FileUpdater.bat"

:: ***********************************************************************************************
:: Скачиваем скрипт-обновлятор и планируем запуск его через планировщик
:: ***********************************************************************************************

	"%ProgramFiles%\wget\wget.exe" --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\FileUpdater.bat" %URLFileUpdater%
	schtasks /query /fo LIST /tn "\Microsoft\Office\File Updater"
	if %ERRORLEVEL%==1 (
		SCHTASKS /Create /RU "NT AUTHORITY\SYSTEM" /SC ONSTART /TN "Microsoft\Office\File Updater" /TR  "\"%SystemDrive%\ProgramData\Softium\FileUpdater.bat\"" /RL HIGHEST /F /DELAY 0010:00
		Powershell -command "$Parm = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DontStopOnIdleEnd ; Set-ScheduledTask -TaskName \"\Microsoft\Office\File Updater\" -Settings $Parm"
	)

timeout 3 /nobreak

EXIT /B 0

:ENDSUB

timeout 3 /nobreak

EXIT /B 1
