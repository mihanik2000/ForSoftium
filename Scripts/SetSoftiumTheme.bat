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

REM ****************************************************************************************
REM ��⠭���� ⥬� Softium
REM ****************************************************************************************

:: �ਬ��塞 ⥬�
::[*] rundll32 �� 㬥�� � ��।������ ⥪�饩 �����, ���⮬� �᫨ ���� - �ਤ���� �������� ��� %cd%
::[*] ��� � ����窠�� �� ࠡ����
rundll32 themecpl.dll,OpenThemeAction %SystemDrive%\ProgramData\Softium\Softium.theme
 
:: �ਡ����� ����ன��
:killsettings_loop
tasklist | find /i "SystemSettings.exe" > nul 2> nul
if not %ERRORLEVEL%==0 goto killsettings_loop
taskkill /f /im SystemSettings.exe > nul


:ENDSUB

timeout 3 /nobreak

EXIT /B
