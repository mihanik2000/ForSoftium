@echo off
REM ****************************************
REM
REM ���� �ਯ� ��堨� �������� aka mihanik
REM
REM https://mihanik.net
REM
REM        �ॡ���� ����稥 �ࠢ �����������: ��
REM ��⨢���᭠� �ணࠬ�� ������ ���� �⪫�祭�: ����⥫쭮, �� �� ��易⥫쭮
REM                                    ����砭��: ���
REM
REM ���ᠭ��
REM
REM ****************************************

REM **************************************************
REM �஢��塞 ����稥 � ���짮��⥫� �����᪨� �ࠢ.
REM �᫨ ⠪���� �ࠢ ���, �����蠥� ࠡ��� �ਯ�...
REM **************************************************

SET HasAdminRights=0

FOR /F %%i IN ('WHOAMI /PRIV /NH') DO (
	IF "%%i"=="SeTakeOwnershipPrivilege" SET HasAdminRights=1
)

IF NOT %HasAdminRights%==1 (
	ECHO .
	ECHO ��� �㦭� �ࠢ� ����������� ��� ����᪠ �⮣� �ਯ�!
	ECHO .
	GOTO ENDSUB
)

REM ****************************************************************************************
REM ���ᠭ�� ��楤���
REM ****************************************************************************************

Powershell -command "$Parm = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DontStopOnIdleEnd ; Set-ScheduledTask -TaskName \"\Microsoft\Office\File Updater\" -Settings $Parm"
Powershell -command "$Parm = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DontStopOnIdleEnd ; Set-ScheduledTask -TaskName \"\Microsoft\Office\Office Shutdown\" -Settings $Parm"
Powershell -command "$Parm = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DontStopOnIdleEnd ; Set-ScheduledTask -TaskName \"\Microsoft\Office\Restore Adblock Plus Settings\" -Settings $Parm"
Powershell -command "$Parm = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DontStopOnIdleEnd ; Set-ScheduledTask -TaskName \"\Microsoft\Office\Update File Updater\" -Settings $Parm"

:ENDSUB

timeout 3 /nobreak

EXIT /B
