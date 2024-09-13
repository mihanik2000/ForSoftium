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
REM Настроим дополнительные параметры электропитания
REM ****************************************************************************************

REM Никогда не отключать дисплей при питании от сети
powercfg /CHANGE -monitor-timeout-dc 0

REM Никогда не отключать диск при питании от сети
powercfg /CHANGE -disk-timeout-dc 0

REM Никогда не уходить в режим ожидания при питании от сети
powercfg /CHANGE -standby-timeout-dc 0

REM Никогда не уходить в режим сна при питании от сети
powercfg /CHANGE -hibernate-timeout-dc 0

REM отключаем спящий режим
powercfg -hibernate off
reg ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power /v HiberFileSizePercent /t REG_DWORD /d 0 /f
reg ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power /v HibernateEnabled /t REG_DWORD /d 0 /f

:ENDSUB

timeout 3 /nobreak

EXIT /B
