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

if NOT defined ScriptPath (
	ECHO.
	ECHO Не определена переменная ScriptPath
	ECHO.
	GOTO ENDSUB
)

:: ****************************************************************************************
:: Устанавливаем SWF_Player + Animate
:: ****************************************************************************************

set PathToPlayer="%ScriptPath%Distr\noarch\SWF.max-2.3.exe"
set PathToFlashOCX="%ScriptPath%Distr\noarch\Flash.ocx"

set PathToAnimate="%ScriptPath%Distr\noarch\animate.swf"
set PathToAnimateIco="%ScriptPath%Distr\noarch\animate.ico"

:: Устанавливаем программу SWF_Player

ECHO.
ECHO Install SWF_Player...
ECHO ВАЖНО!!!
ECHO Программу нужно устанавливать в ручном режиме.
ECHO Нет возможности установить программу автоматически.
ECHO.
	start "Title" /wait %PathToPlayer% /silent
	If exist "%SystemDrive%\Program Files (x86)" (
			copy /y %PathToFlashOCX% "C:\Program Files (x86)\SWF.max\Media\Binary\Flash.ocx"
	 ) else (
			copy /y %PathToFlashOCX% "C:\Program Files\SWF.max\Media\Binary\Flash.ocx"
	)

:: Удалим с рабочего стола ярлык SWF.max Flash Player
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\file_delete.js" "Desktop" "\SWF.max Flash Player.lnk"

:: Устанавливаем программу Animate (Создай мульт)
ECHO.
ECHO Install Animate...
ECHO.
	mkdir "%ProgramFiles%\Animate"
	copy /y %PathToAnimate% "%ProgramFiles%\Animate\animate.swf"
	copy /y %PathToAnimateIco% "%ProgramFiles%\Animate\animate.ico"
	
:: Создадим  ссылку на Animate
	cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\Animate\animate.swf" "%USERPROFILE%" "Сделай мульт" "%ProgramFiles%\Animate\animate.ico" "Animate (для начального уровня)."

:ENDSUB

timeout 3 /nobreak

EXIT /B
