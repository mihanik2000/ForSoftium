@echo off
REM ****************************************
REM
REM ���� �ਯ� ��堨� �������� aka mihanik
REM
REM https://mihanik.net
REM
REM        �ॡ���� ����稥 �ࠢ �����������: ���
REM ��⨢���᭠� �ணࠬ�� ������ ���� �⪫�祭�: ����⥫쭮, �� �� ��易⥫쭮
REM                                    ����砭��: ���
REM
REM ���ᠭ��
REM
REM ****************************************

REM ****************************************************************************************
REM ���ᠭ�� ��楤���
REM ****************************************************************************************

REM ����뢠�� Google Chrome

	taskkill /f /im chrome.exe

REM ����塞 ⥪�騥 ����ன�� Adblock Plus

	forfiles /P "C:\Users\Softium\AppData\Local\Google\Chrome\User Data\Default\IndexedDB" /m *cfhdojbkjhnklbpkdaibdccddilifddb* /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

REM ����⠭�������� ����ன�� Adblock Plus

	mkdir "%SystemDrive%\Users\Softium\AppData\Local\Google\Chrome\User Data\Default"
	ICACLS "%SystemDrive%\Users\Softium\AppData\Local\Google\Chrome\User Data\Default" /setowner "Softium" /T /C
	
	"%ProgramFiles%\7-Zip\7z.exe" x -y  "%SystemDrive%\ProgramData\Softium\IndexedDB.zip" -o"%SystemDrive%\Users\Softium\AppData\Local\Google\Chrome\User Data\Default"

	ICACLS "%SystemDrive%\Users\Softium\AppData\Local\Google\Chrome\User Data\Default\IndexedDB" /setowner "Softium" /T /C
	ICACLS "%SystemDrive%\Users\Softium\AppData\Local\Google\Chrome\User Data\Default\IndexedDB" /grant ��:F
	ICACLS "%SystemDrive%\Users\Softium\AppData\Local\Google\Chrome\User Data\Default\IndexedDB" /grant ���⥬�:F
	ICACLS "%SystemDrive%\Users\Softium\AppData\Local\Google\Chrome\User Data\Default\IndexedDB" /grant ������������:F

:ENDSUB

timeout 3 /nobreak

EXIT /B
