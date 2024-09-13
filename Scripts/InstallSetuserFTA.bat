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
REM ��⠭�������� SetuserFTA
REM ****************************************************************************************

set PathToSetuserFTA="%ScriptPath%Distr\noarch\SetUserFTA\*"

REM SetuserFTA - �ணࠬ�� ��� �ࠢ����� �����묨 ����ன���� Windows 10.
REM ���� ࠧࠡ��稪�: http://kolbi.cz/blog/2017/10/25/setuserfta-userchoice-hash-defeated-set-file-type-associations-per-user/
REM �� ���᪨: https://ru.desktopsupportpanel.com/izmenit-prilozheniya-po-umolchaniyu-brauzer-ili-sopostavleni

ECHO Install SetuserFTA...
ECHO .
mkdir  "%ProgramFiles%\SetuserFTA\"

copy /y %PathToSetuserFTA% "%ProgramFiles%\SetuserFTA\"


REM ���஡���� ���: https://kolbi.cz/blog/2024/04/03/userchoice-protection-driver-ucpd-sys/
net stop UCPD
sc.exe delete UCPD
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UCPD" /v "Start" /t REG_DWORD /d 4 /f
schtasks /Change /TN "\Microsoft\Windows\AppxDeploymentClient\UCPD velocity" /Disable

:ENDSUB

timeout 3 /nobreak

EXIT /B
