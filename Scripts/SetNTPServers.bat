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
	echo.
	echo Вам нужны права администратора для запуска этого скрипта!
	echo.
	GOTO ENDSUB
)

if NOT defined ScriptPath (
	echo.
	echo Не определена переменная ScriptPath
	echo.
	GOTO ENDSUB
)

echo.
echo Настройка параметров службы времени...
echo.

:: включение службы времени

echo Включаем/Запускаем службу времени
echo.

:: Установить автоматический запуск
sc config w32time start=auto  >nul 2>&1

:: Запустить службу (если остановлена)
net start w32time  >nul 2>&1

echo Указываем адреса NTP-серверов
echo.

:: Укажем несколько NTP-серверов
w32tm /config /manualpeerlist:"0.ru.pool.ntp.org,0x9 1.ru.pool.ntp.org,0x9" /syncfromflags:manual /update /reliable:yes  >nul 2>&1

echo Применяем сделанные настройки
echo.

:: Перезапустить службу
net stop w32time >nul 2>&1
net start w32time >nul 2>&1

echo Производим синхронизацию времени
:: Принудительная синхронизация
w32tm /resync >nul 2>&1

echo Настройка параметров службы времени завершена.
echo.

:ENDSUB

timeout 3 /nobreak

EXIT /B
