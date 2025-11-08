@echo off
:: ****************************************
::
:: Автор скрипта Михаил Медведев aka mihanik
::
:: https://mihanik.net
::
::        Требуется наличие прав администратора: ДА
:: Антивирусная программа должна быть отключена: желательно, но не обязательно
::                                    Замечания: НЕТ
::
:: Описание
::
:: ****************************************

:: **************************************************
:: Проверяем наличие у пользователя админских прав.
:: Если таковых прав нет, завершаем работу скрипта...
:: **************************************************

SET HasAdminRights=0

FOR /F %%i IN ('WHOAMI /PRIV /NH') DO (
	IF "%%i"=="SeTakeOwnershipPrivilege" SET HasAdminRights=1
)

IF NOT %HasAdminRights%==1 (
	ECHO.
	ECHO Вам нужны права администратора для запуска этого скрипта!
	ECHO.
	GOTO ENDSUB
)

:: ****************************************************************************************
:: Настроим дополнительные параметры электропитания
:: ****************************************************************************************

REM :: Никогда не отключать дисплей при питании от сети
REM powercfg /CHANGE -monitor-timeout-dc 0

REM :: Никогда не отключать диск при питании от сети
REM powercfg /CHANGE -disk-timeout-dc 0

REM :: Никогда не уходить в режим ожидания при питании от сети
REM powercfg /CHANGE -standby-timeout-dc 0

REM :: Никогда не уходить в режим сна при питании от сети
REM powercfg /CHANGE -hibernate-timeout-dc 0

REM :: отключаем спящий режим
REM powercfg -hibernate off
REM reg ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power /v HiberFileSizePercent /t REG_DWORD /d 0 /f
REM reg ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power /v HibernateEnabled /t REG_DWORD /d 0 /f

echo Настройка параметров электропитания...
echo.
:: ===== НАСТРОЙКА ДЛЯ ПИТАНИЯ ОТ СЕТИ (AC) =====
echo Устанавливаем настройки для питания от сети...

:: Никогда не отключать дисплей при питании от сети
powercfg /change %scheme% -monitor-timeout-ac 0 >nul 2>&1

:: Никогда не отключать диск при питании от сети  
powercfg /change %scheme% -disk-timeout-ac 0

:: Никогда не уходить в режим ожидания при питании от сети
powercfg /change %scheme% -standby-timeout-ac 0 >nul 2>&1

:: ===== НАСТРОЙКА ДЛЯ ПИТАНИЯ ОТ БАТАРЕИ (DC) =====
echo Устанавливаем настройки для питания от батареи...

:: Никогда не отключать дисплей при питании от батареи
powercfg /change %scheme% -monitor-timeout-dc 0 >nul 2>&1

:: Никогда не отключать диск при питании от батареи
powercfg /change %scheme% -disk-timeout-dc 0 >nul 2>&1

:: Никогда не уходить в режим ожидания при питании от батареи
powercfg /change %scheme% -standby-timeout-dc 0 >nul 2>&1

:: ===== ОТКЛЮЧЕНИЕ ГИБЕРНАЦИИ =====
echo Отключаем гибернацию...

:: Отключаем гибернацию (это также удаляет файл hiberfil.sys)
powercfg -h off >nul 2>&1

echo.
echo Настройки электропитания применены !

:ENDSUB

timeout 3 /nobreak

EXIT /B
