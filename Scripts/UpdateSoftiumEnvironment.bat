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
REM ��楤�� ���������� 䠩���
REM ****************************************************************************************

REM ****************************************************************************************
REM ���������� ⥬� ��ଫ����
REM ****************************************************************************************

REM ����塞 ����騩�� 䠩�
del "%SystemDrive%\ProgramData\Softium\Softium.theme" /q /f

REM ���稢��� ���� 䠩�
wget.exe --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\Softium.theme" "https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/Softium.theme"

REM �ਬ��塞 ⥬�
REM[*] rundll32 �� 㬥�� ��।����� ⥪���� �����, ���⮬� �᫨ ���� - �ਤ���� �������� ��� %cd%
REM[*] ��� � ����窠�� �� ࠡ����
rundll32 themecpl.dll,OpenThemeAction %SystemDrive%\ProgramData\Softium\Softium.theme
 
REM �ਡ����� ����ன��
:killsettings_loop
tasklist | find /i "SystemSettings.exe" > nul 2> nul
if not %ERRORLEVEL%==0 goto killsettings_loop
taskkill /f /im SystemSettings.exe > nul

REM ****************************************************************************************
REM ������塞 ��㯯���� ����⨪�
REM ****************************************************************************************

REM ����塞 ����騩�� 䠩�
del "%SystemDrive%\ProgramData\Softium\GroupPolicy.7z" /q /f

REM ���稢��� ���� 䠩�
wget.exe --no-check-certificate -O "%SystemDrive%\ProgramData\Softium\GroupPolicy.7z" "https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/noarch/GroupPolicy.7z"

REM �ਬ��塞 ����⨪�

"%ProgramFiles%\7-Zip\7z.exe" x -y  "%SystemDrive%\ProgramData\Softium\GroupPolicy.7z" -o"%windir%\System32"

REM ****************************************************************************************
REM ������塞 �ਯ� ���⪨ ��䨫� ���짮��⥫�
REM ****************************************************************************************

REM ����塞 ����騩�� 䠩�
del ""%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\StartUp\CleanUp.bat" /q /f

REM ���稢��� ���� 䠩�
wget.exe --no-check-certificate -O ""%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\StartUp\CleanUp.bat" "https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/step-3-user-CleanUp.bat"

:ENDSUB

timeout 3 /nobreak

EXIT /B
