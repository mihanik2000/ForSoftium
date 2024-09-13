@echo off
REM ****************************************
REM
REM Автор скрипта Михаил Медведев aka mihanik
REM
REM https://mihanik.net
REM
REM        Требуется наличие прав администратора: ДА
REM Антивирусная программа должна быть отключена: желательно, но не обязательно
REM                                    Замечания: НЕТ
REM
REM Описание
REM
REM ****************************************

REM **************************************************
REM Проверяем наличие у пользователя админских прав.
REM Если таковых прав нет, завершаем работу скрипта...
REM **************************************************

SET HasAdminRights=0

FOR /F %%i IN ('WHOAMI /PRIV /NH') DO (
	IF "%%i"=="SeTakeOwnershipPrivilege" SET HasAdminRights=1
)

REM ****************************************************************************************
REM Удалим One Drive
REM ****************************************************************************************

taskkill /f /im OneDrive.exe
	If exist "%SystemDrive%\Program Files (x86)" (
		If exist "%SystemRoot%\SysWOW64\OneDriveSetup.exe" start "Title" /wait %SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
	 ) else (
 		If exist "%SystemRoot%\System32\OneDriveSetup.exe" start "Title" /wait %SystemRoot%\System32\OneDriveSetup.exe /uninstall
 	)

timeout 3 /nobreak

EXIT /B
