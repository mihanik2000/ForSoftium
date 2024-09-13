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

REM ****************************************************************************************
REM ����ந� �������⥫�� ��ࠬ���� ���ய�⠭��
REM ****************************************************************************************

REM ������� �� �⪫���� ��ᯫ�� �� ��⠭�� �� ��
powercfg /CHANGE -monitor-timeout-dc 0

REM ������� �� �⪫���� ��� �� ��⠭�� �� ��
powercfg /CHANGE -disk-timeout-dc 0

REM ������� �� �室��� � ०�� �������� �� ��⠭�� �� ��
powercfg /CHANGE -standby-timeout-dc 0

REM ������� �� �室��� � ०�� ᭠ �� ��⠭�� �� ��
powercfg /CHANGE -hibernate-timeout-dc 0

REM �⪫�砥� ��騩 ०��
powercfg -hibernate off
reg ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power /v HiberFileSizePercent /t REG_DWORD /d 0 /f
reg ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power /v HibernateEnabled /t REG_DWORD /d 0 /f

:ENDSUB

timeout 3 /nobreak

EXIT /B
