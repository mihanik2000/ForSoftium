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

if NOT defined ScriptPath (
	ECHO .
	ECHO �� ��।����� ��६����� ScriptPath
	ECHO .
	GOTO ENDSUB
)

REM ****************************************************************************************
REM ��⠭�������� Google Chrome
REM ****************************************************************************************

set PathToGoogleChrome="%ScriptPath%Distr\x32\GoogleChromeStandaloneEnterprise.msi"
set PathToGoogleChrome-x64="%ScriptPath%Distr\x64\GoogleChromeStandaloneEnterprise64.msi"
Set PathToChromeForcelist="%ScriptPath%Distr\noarch\ChromeForcelist.reg"

reg import %PathToChromeForcelist%

ECHO .
ECHO Install Google Chrome...
ECHO .
	If exist "%SystemDrive%\Program Files (x86)" (
		start "Install Google Chrome..." /wait %PathToGoogleChrome-x64% /passive /norestart
	 ) else (
 		start "Install Google Chrome..." /wait %PathToGoogleChrome% /passive /norestart
 	)
	
REM ������� Chrome ��㧥஬ ��-㬮�砭��.
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  http ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  https ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  .htm ChromeHTML
"%ProgramFiles%\SetuserFTA\SetUserFTA.exe"  .html ChromeHTML

:ENDSUB

timeout 3 /nobreak

EXIT /B
