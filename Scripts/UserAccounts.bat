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

REM ****************************************************************************************
REM ����ࠨ���� ����� ����� ���짮��⥫�� �� ��������
REM ****************************************************************************************

REM ��⨢��㥬 ���஥����� �����������
net user ����������� "AdminPass" /active:yes /expires:never

Rem �ப ����⢨� ��஫� ����������� �� ��࠭�祭
wmic UserAccount where Name="�����������" set PasswordExpires=False

REM �������� ���짮��⥫� Softium � ��஫�� 321
if %BClearSoftiumProfile%==1 (
	Rem �����稬 ���짮��⥫� Sofium ���⮢� �ਯ�
	net user Softium "321" /add /expires:never /passwordchg:no /scriptpath:CleanUp.bat
	
	Rem �.�. ��䨫� ���짮��⥫� ��� �� ᮧ���, � ���� ����� �ਯ� �ਢ����
	Rem � ����ᠭ�� Windows �� �६� ᮧ����� ��䨫� ���짮��⥫�.
	Rem �⮡� �⮣� �� �ந��諮 �㦭� �� ��ࢮ� �室� � ��䨫� �ਯ� �� ��ࠡ��뢠� �� ����.
	
	REM ᮧ��� ����� ��� �࠭���� 䠩���
	mkdir "%SystemDrive%\ProgramData\Softium"
	
	Rem � �⮩ ����� ᮧ��� 䠩�-�ਧ��� ��� ⮣�, �⮡� ���⠯-�ਯ� ��� ������, �� �� ����᪠���� ���� ࠧ.
	echo yes > "%SystemDrive%\ProgramData\Softium\FirstRun.txt"
	
	Rem  �⪫�砥� � 䠩�� ��᫥������� �ࠢ NTFS � 㤠������ ᯨ᪠ ����㯠
	Rem �� �⮡� �ਯ� ����饭�� �� ����� ���짮��⥫� Softium ᬮ� 㤠���� 䠩�
	
	ICACLS "%SystemDrive%\ProgramData\Softium\FirstRun.txt" /inheritance:r
	
	Rem ��㯯�� <��>, <���⥬�>, <������������> ��� ����� ����� � ����

	ICACLS "%SystemDrive%\ProgramData\Softium\FirstRun.txt" /grant ��:F
	ICACLS "%SystemDrive%\ProgramData\Softium\FirstRun.txt" /grant ���⥬�:F
	ICACLS "%SystemDrive%\ProgramData\Softium\FirstRun.txt" /grant ������������:F
	
	) else (
	
	Rem �� �����砥� ���짮��⥫� Sofium ���⮢� �ਯ�
	net user Softium "321" /add /expires:never /passwordchg:no
	
	)

Rem �ப ����⢨� ��஫� ���짮��⥫� Softium �� ��࠭�祭
wmic UserAccount where Name="Softium" set PasswordExpires=False

:ENDSUB

timeout 3 /nobreak

EXIT /B
