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
REM ��⠭�������� BGInfo
REM ****************************************************************************************

set PathToBGInfo="%ScriptPath%Distr\noarch\BGInfo\*"

REM BGInfo - �ணࠬ�� ��� �뢥����� �� ࠡ�稩 �⮫ �孨�᪮� ���ଠ樨 � ��
REM ���� ࠧࠡ��稪�: https://learn.microsoft.com/en-us/sysinternals/downloads/bginfo

ECHO Install BGInfo...
ECHO .
mkdir  "%ProgramFiles%\BGInfo\"

copy /y %PathToBGInfo% "%ProgramFiles%\BGInfo\"

:ENDSUB

timeout 3 /nobreak

EXIT /B
