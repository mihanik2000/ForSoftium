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
REM Windows Machine Guid:
REM HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\MachineGuid
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

REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Google\Chrome\Enrollment" /va /f
REG DELETE "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Google\Enrollment" /va /f

:ENDSUB

timeout 3 /nobreak

EXIT /B
