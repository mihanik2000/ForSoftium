@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM        Требуется наличие прав администратора: ДА
REM Антивирусная программа должна быть отключена: желательно, но не обязательно
REM                                    Замечания: НЕТ
REM
REM Description
REM
REM ****************************************

REM Check whether the user has admin rights...
SET HasAdminRights=0

FOR /F %%i IN ('WHOAMI /PRIV /NH') DO (
	IF "%%i"=="SeTakeOwnershipPrivilege" SET HasAdminRights=1
)

IF NOT %HasAdminRights%==1 (
	ECHO .
	ECHO You need administrator rights to run this script!
	ECHO .
	GOTO ENDSUB
)

REM ***********************************************************************************************
REM Зададим URL файлов, которые нужно обновить
REM ***********************************************************************************************

	set URLFileUpdater="https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Scripts/FileUpdater.bat"

REM ***********************************************************************************************
REM Скачиваем скрипт-обновлятор и планируем запуск его через планировщик
REM ***********************************************************************************************

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
