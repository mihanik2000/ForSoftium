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

REM **************************************************
REM Проверяем наличие у пользователя админских прав.
REM Если таковых прав нет, завершаем работу скрипта...
REM **************************************************

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
REM Запланируем на всякий случай ежедневное выключение в 21:00
REM ****************************************************************************************

SCHTASKS /Create /RU "NT AUTHORITY\SYSTEM" /SC DAILY /TN "Microsoft\Office\Office Shutdown" /TR  "\"%SystemDrive%\Windows\System32\shutdown.exe\" /s /f /t 00"  /ST 21:00 /RL HIGHEST /F
Powershell -command "$Parm = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DontStopOnIdleEnd ; Set-ScheduledTask -TaskName \"\Microsoft\Office\Office Shutdown\" -Settings $Parm"

:ENDSUB

timeout 3 /nobreak

EXIT /B
