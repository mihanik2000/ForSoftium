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
REM ����ࠨ���� ����� ����� ���짮��⥫�� �� ��������
REM ****************************************************************************************

REM ��⨢��㥬 ���஥����� �����������
net user ����������� "AdminPass" /active:yes /expires:never

REM �������� ���짮��⥫� Softium � ��஫�� 321
net user Softium "321" /add /expires:never

REM ****************************************************************************************
REM ����ந� ������� ����室��� ��ࠬ���� 
REM ****************************************************************************************

:ENDSUB

timeout 3 /nobreak

EXIT /B
