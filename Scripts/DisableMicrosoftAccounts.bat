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
REM ���ᠭ��
REM
REM ****************************************

rem �஢��塞 ����稥 � ���짮��⥫� �����᪨� �ࠢ...
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
REM ����⨬ �ᯮ�짮����� �����⮢ Microsoft �� ��������
REM https://www.elevenforum.com/t/enable-or-disable-microsoft-accounts-in-windows-11.23799/

	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v NoConnectedUser /t REG_DWORD /d 3 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\Settings\AllowYourAccount" /v AllowYourAccount /t REG_DWORD /d 3 /f

:ENDSUB

timeout 3 /nobreak

EXIT /B
