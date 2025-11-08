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

:: Удаляем лишние файлы и ярлыки

	del "C:\Users\Softium\Desktop\Microsoft Edge.lnk" /q /f
	del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\step 3 - user - CleanUp.bat" /q /f
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\file_delete.js" "AllUsersDesktop" "\Microsoft Edge.lnk"
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\file_delete.js" "AllUsersDesktop" "\Configure Kodu Game Lab.lnk"

:: Очищаем корзину

	rd /s /q %systemdrive%\$Recycle.bin

:ENDSUB

timeout 3 /nobreak

EXIT /B
