@Rem �⪫�砥� �뢮� ᠬ�� ������ �� �࠭
@echo off
rem chcp 866

Rem �।��������, �� �� Windows XP �ਯ� ����᪠���� ����������஬.
Rem ��� ����� ����� ��⥬ �� ����୮.

rem ����砥� ����� ��
ver | find "5.1."

rem Windows XP ?
If %errorlevel%==0  (
	rem �ய�᪠�� �஢��� �����᪨� �ࠢ
	GOTO SKIPADMIN
 )
 
SET HasAdminRights=0

FOR /F %%i IN ('WHOAMI /PRIV /NH') DO (
	IF "%%i"=="SeTakeOwnershipPrivilege" SET HasAdminRights=1
)

IF NOT %HasAdminRights%==1 (
	ECHO .
	ECHO ��� �ਯ� ����室��� ����᪠�� �� ����� �����������.
	ECHO .
	GOTO END
)

:SKIPADMIN

start /wait C:\Python27\python.exe "%~dp0main.py"

ECHO .
ECHO ���!
ECHO .
	
:END

PAUSE

EXIT /B