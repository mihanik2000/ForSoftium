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

echo Запрет использования учетных записей Microsoft...

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

:: Запретим использование аккаунтов Microsoft на компьютере
:: https://www.elevenforum.com/t/enable-or-disable-microsoft-accounts-in-windows-11.23799/

:: Первый ключ - основной запрет
	echo Устанавливаем основной запрет...
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v NoConnectedUser /t REG_DWORD /d 3 /f >nul 2>&1
	
:: Второй ключ - дополнительная политика
	echo Устанавливаем дополнительную политику...
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\Settings\AllowYourAccount" /v AllowYourAccount /t REG_DWORD /d 3 /f >nul 2>&1
	
:: Дополнительные ключи для надежности
	echo Устанавливаем дополнительные настройки...
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\Accounts" /v AllowMicrosoftAccountConnection /t REG_DWORD /d 0 /f >nul 2>&1
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\Accounts" /v AllowConnectedAccounts /t REG_DWORD /d 0 /f >nul 2>&1

:: Принудительное обновление политик
	echo Обновляем политики...
	gpupdate /force >nul 2>&1

echo.
echo Готово! Учетные записи Microsoft запрещены.
echo Для применения изменений может потребоваться перезагрузка.

:ENDSUB

timeout 3 /nobreak

EXIT /B
