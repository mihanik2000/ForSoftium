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
REM Описание
REM
REM ****************************************

rem Проверяем наличие у пользователя админских прав...
SET HasAdminRights=0

FOR /F %%i IN ('WHOAMI /PRIV /NH') DO (
	IF "%%i"=="SeTakeOwnershipPrivilege" SET HasAdminRights=1
)

IF NOT %HasAdminRights%==1 (
	ECHO .
	ECHO Вам нужны права администратора для запуска этого скрипта!
	ECHO .
	GOTO ENDSUB
)

REM Удаляем лишние файлы и ярлыки

	del "C:\Users\Softium\Desktop\Microsoft Edge.lnk" /q /f
	del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\step 3 - user - CleanUp.bat" /q /f
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\file_delete.js" "AllUsersDesktop" "\Microsoft Edge.lnk"
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\file_delete.js" "AllUsersDesktop" "\Configure Kodu Game Lab.lnk"

REM Очищаем корзину

	rd /s /q %systemdrive%\$Recycle.bin

:ENDSUB

timeout 3 /nobreak

EXIT /B
