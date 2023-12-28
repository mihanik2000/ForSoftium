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
REM ��⠭�������� wget
REM ****************************************************************************************

set PathToWget="%ScriptPath%Distr\x32\wget.exe"
set PathToWget-x64="%ScriptPath%Distr\x64\wget.exe"

ECHO .
ECHO Install wget...
ECHO .
mkdir  "%ProgramFiles%\wget\"
	If exist "%SystemDrive%\Program Files (x86)" (
		copy /y %PathToWget-x64% "%ProgramFiles%\wget\wget.exe"
	) else (
		copy /y %PathToWget% "%ProgramFiles%\wget\wget.exe"
	)

REM ������� ���� � wget � path
	setx PATH "%ProgramFiles%\wget\;%Path%"
	PATH=%ProgramFiles%\wget\;%Path%

REM ������塞 �⨫��� wget.exe � �᪫�祭�� �࠭����� Windows
	netsh advfirewall firewall del rule name="wget"
	netsh advfirewall firewall add rule name="wget" dir=in action=allow program="%ProgramFiles%\wget\wget.exe"

:ENDSUB

timeout 3 /nobreak

EXIT /B
