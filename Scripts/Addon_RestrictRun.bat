@echo off

REM ��ਯ� ��⠭���� ����� �ணࠬ� ��������� Softium

REM Windows XP �� �����ন������!!!
ver | find "5.1."

If %errorlevel%==0  (
	Echo Windows XP unsupported!!!
	timeout 10 /nobreak
	Exit /b 1
 ) 

REM ****************************************************************************************
REM �஢��塞 ����稥 � ���짮��⥫� �����᪨� �ࠢ.
REM �᫨ ⠪���� �ࠢ ���, �����蠥� ࠡ��� �ਯ�.
REM �᫨ ⠪���� �ࠢ ���, �����蠥� ࠡ��� �ਯ�...
REM ****************************************************************************************

SET HasAdminRights=0
FOR /F %%i IN ('WHOAMI /PRIV /NH') DO (
	IF "%%i"=="SeTakeOwnershipPrivilege" SET HasAdminRights=1
)

IF NOT %HasAdminRights%==1 (
	ECHO .
	ECHO ��� ����᪠ �⮣� �ਯ� ��� �㦭� �������� �ࠢ��� "���������⮠"
	ECHO .
	GOTO END
)

REM ����⨬ ���짮��⥫� Softium ����᪠�� ��譨� �ணࠬ��

net localgroup ������������ Softium /add

Powershell.exe -executionpolicy Bypass -File C:\ProgramData\Softium\RestrictRun.ps1

net localgroup ������������ Softium /del

:END

timeout 10 /nobreak

EXIT /B
