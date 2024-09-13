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
REM ��⠭���� �ணࠬ�� Softium ��� �����饣���
REM ****************************************************************************************

REM ᮧ��� ����� � ��୥ ��⥬���� ��᪠ ��� �࠭���� ࠡ��� 䠩���
	mkdir "%SystemDrive%\Softium"

	set PathToSoftium="%ScriptPath%Distr\noarch\softiumscan.exe"

REM �ணࠬ�� Softium ��� �����饣���
	copy /y %PathToSoftium% "%SystemDrive%\Softium\softiumscan.exe"

REM ������塞 �ணࠬ�� softiumscan � �᪫�祭�� �࠭����� Windows
	netsh advfirewall firewall del rule name="softiumscan"
	netsh advfirewall firewall add rule name="softiumscan" dir=in action=allow program="%SystemDrive%\Softium\softiumscan.exe"

REM ������ ��뫪� �� Softium �� ��饬 ࠡ�祬 �⮫�
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "C:\Softium\softiumscan.exe" "C:\Softium\" "�����" "C:\Softium\softiumscan.exe" "�����"

:ENDSUB

timeout 3 /nobreak

EXIT /B
