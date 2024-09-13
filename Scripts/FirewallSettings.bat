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

REM ****************************************************************************************
REM Настроим межсетевой экран
REM ****************************************************************************************

REM Включим межсетевой экран
netsh advfirewall set allprofiles state on

REM Разрешим отвечать на ping 
netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol=icmpv4:8,any dir=in action=allow

:ENDSUB

timeout 3 /nobreak

EXIT /B
