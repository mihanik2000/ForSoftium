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

REM ����塞 ��譨� 䠩�� � ��모

	del "C:\Users\Softium\Desktop\Microsoft Edge.lnk" /q /f
	del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\step 3 - user - CleanUp.bat" /q /f
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\file_delete.js" "AllUsersDesktop" "\Microsoft Edge.lnk"
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\file_delete.js" "AllUsersDesktop" "\Configure Kodu Game Lab.lnk"

REM ��頥� ��২��

	rd /s /q %systemdrive%\$Recycle.bin

:ENDSUB

timeout 3 /nobreak

EXIT /B
