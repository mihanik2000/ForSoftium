@echo off

Rem ��ਯ� ��⠭���� ����� �ணࠬ� ��������� Softium

Rem Windows XP �� �����ন������!!!
ver | find "5.1."

If %errorlevel%==0  (
	Echo Windows XP unsupported!!!
	timeout 10 /nobreak
	Exit /b 1
 ) 

Rem ****************************************************************************************
Rem �஢��塞 ����稥 � ���짮��⥫� �����᪨� �ࠢ...
Rem ****************************************************************************************

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

Rem ����⨬ ���짮��⥫� Softium ����᪠�� ��譨� �ணࠬ��

net localgroup ������������ Softium /add

Powershell.exe -executionpolicy Bypass -File C:\ProgramData\Softium\RestrictRun.ps1

net localgroup ������������ Softium /del

Rem �⪫�稬 ������� �㭪樨 Windows
REM start "Title" /wait start "OOSU10" /wait %PathToOOSU10% %PathToOOSU10-CFG% /quiet /nosrp

:END

timeout 10 /nobreak

EXIT /B
