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

REM ****************************************************************************************
REM ������ One Drive
REM ****************************************************************************************

taskkill /f /im OneDrive.exe
	If exist "%SystemDrive%\Program Files (x86)" (
		If exist "%SystemRoot%\SysWOW64\OneDriveSetup.exe" start "Title" /wait %SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
	 ) else (
 		If exist "%SystemRoot%\System32\OneDriveSetup.exe" start "Title" /wait %SystemRoot%\System32\OneDriveSetup.exe /uninstall
 	)

timeout 3 /nobreak

EXIT /B
