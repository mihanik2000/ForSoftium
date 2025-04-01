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
REM ����ࠨ���� ����� ����� ���짮��⥫�� �� ��������
REM ****************************************************************************************

REM ��⨢��㥬 ���஥����� �����������
net user ����������� "AdminPass" /active:yes /expires:never

REM �ப ����⢨� ��஫� ����������� �� ��࠭�祭
wmic UserAccount where Name="�����������" set PasswordExpires=False

REM �������� ���짮��⥫� Softium � ��஫�� 321
if %BClearSoftiumProfile%==1 (
	REM �����稬 ���짮��⥫� Sofium ���⮢� �ਯ�
	REM https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc771865(v=ws.11)
	REM /scriptpath:<Path>
	REM Sets a path for the user's logon script. <Path> cannot be an absolute path. <Path> is relative to %systemroot%\System32\Repl\Import\Scripts.
	
	net user Softium "321" /add /expires:never /passwordchg:no /scriptpath:CleanUp.bat
	
	REM �.�. ��䨫� ���짮��⥫� ��� �� ᮧ���, � ���� ����� �ਯ� �ਢ����
	REM � ����ᠭ�� Windows �� �६� ᮧ����� ��䨫� ���짮��⥫�.
	REM �⮡� �⮣� �� �ந��諮 �㦭� �� ��ࢮ� �室� � ��䨫� �ਯ� �� ��ࠡ��뢠� �� ����.
	
	REM ᮧ��� ����� ��� �࠭���� 䠩���
	mkdir "%SystemDrive%\ProgramData\Softium"
	
	REM � �⮩ ����� ᮧ��� 䠩�-�ਧ��� ��� ⮣�, �⮡� ���⠯-�ਯ� ��� ������, �� �� ����᪠���� ���� ࠧ.
	echo yes > "%SystemDrive%\ProgramData\Softium\FirstRun.txt"
	
	REM  �⪫�砥� � 䠩�� ��᫥������� �ࠢ NTFS � 㤠������ ᯨ᪠ ����㯠
	REM �� �⮡� �ਯ� ����饭�� �� ����� ���짮��⥫� Softium ᬮ� 㤠���� 䠩�
	
	ICACLS "%SystemDrive%\ProgramData\Softium\FirstRun.txt" /inheritance:r
	
	REM ��㯯�� <��>, <���⥬�>, <������������> ��� ����� ����� � ����

	ICACLS "%SystemDrive%\ProgramData\Softium\FirstRun.txt" /grant ��:F
	ICACLS "%SystemDrive%\ProgramData\Softium\FirstRun.txt" /grant ���⥬�:F
	ICACLS "%SystemDrive%\ProgramData\Softium\FirstRun.txt" /grant ������������:F
	
	) else (
	
	REM �� �����砥� ���짮��⥫� Sofium ���⮢� �ਯ�
	net user Softium "321" /add /expires:never /passwordchg:no
	
	)

REM �ப ����⢨� ��஫� ���짮��⥫� Softium �� ��࠭�祭
wmic UserAccount where Name="Softium" set PasswordExpires=False

:ENDSUB

timeout 3 /nobreak

EXIT /B
