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

IF NOT %HasAdminRights%==1 (
	ECHO .
	ECHO Вам нужны права администратора для запуска этого скрипта!
	ECHO .
	GOTO ENDSUB
)

if NOT defined ScriptPath (
	ECHO .
	ECHO Не определена переменная ScriptPath
	ECHO .
	GOTO ENDSUB
)

REM ****************************************************************************************
REM Устанавливаем SetuserFTA
REM ****************************************************************************************

set PathToSetuserFTA="%ScriptPath%Distr\noarch\SetUserFTA\*"

REM SetuserFTA - Программа для управления защищёнными настройками Windows 10.
REM Сайт разработчика: http://kolbi.cz/blog/2017/10/25/setuserfta-userchoice-hash-defeated-set-file-type-associations-per-user/
REM По русски: https://ru.desktopsupportpanel.com/izmenit-prilozheniya-po-umolchaniyu-brauzer-ili-sopostavleni

ECHO Install SetuserFTA...
ECHO .
mkdir  "%ProgramFiles%\SetuserFTA\"

copy /y %PathToSetuserFTA% "%ProgramFiles%\SetuserFTA\"


REM подробности тут: https://kolbi.cz/blog/2024/04/03/userchoice-protection-driver-ucpd-sys/
net stop UCPD
sc.exe delete UCPD
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UCPD" /v "Start" /t REG_DWORD /d 4 /f
schtasks /Change /TN "\Microsoft\Windows\AppxDeploymentClient\UCPD velocity" /Disable

:ENDSUB

timeout 3 /nobreak

EXIT /B
