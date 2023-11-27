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

if NOT defined ScriptPath (
	ECHO .
	ECHO �� ��।����� ��६����� ScriptPath
	ECHO .
	GOTO ENDSUB
)

REM ****************************************************************************************
REM ��⠭�������� Kodu
REM ****************************************************************************************

set PathToxnafx="%ScriptPath%Distr\noarch\xnafx40_redist.msi"
set PathToKodu="%ScriptPath%Distr\noarch\KoduSetup_1.6.18.0.msi"

ECHO .
ECHO Install Kodu...
ECHO .
	start "Title" /wait %PathToxnafx% /passive /norestart
	start "Title" /wait %PathToKodu% /passive /norestart

REM ������ ����� ��뫪� Kodu
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\file_delete.js" "AllUsersDesktop" "\Configure Kodu Game Lab.lnk"

:ENDSUB

timeout 3 /nobreak

EXIT /B
