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

:: ****************************************************************************************
:: Устанавливаем SWF_Player + Animate
:: ****************************************************************************************

set PathToPlayer="%ScriptPath%Distr\noarch\SWF.max-2.3.exe"
set PathToFlashOCX="%ScriptPath%Distr\noarch\Flash.ocx"

set PathToAnimate="%ScriptPath%Distr\noarch\animate.swf"
set PathToAnimateIco="%ScriptPath%Distr\noarch\animate.ico"

:: Устанавливаем программу SWF_Player

echo.
echo Install SWF_Player...
echo ВАЖНО!!!
echo Программу нужно устанавливать в ручном режиме.
echo Нет возможности установить программу автоматически.
echo.

cscript //nologo "%ScriptPath%Scripts\MsgBox.vbs" ^
		"ВАЖНО!!!`n`nПрограмму нужно устанавливать в ручном режиме.`nНет возможности установить программу автоматически!" ^
		64 ^
		"Требуется ручная установка программы!"

:: Устанавливаем SWF.max Flash Player

start "Title" /wait %PathToPlayer% /silent

copy /y %PathToFlashOCX% "C:\Program Files (x86)\SWF.max\Media\Binary\Flash.ocx" >nul 2>&1

:: Удалим с рабочего стола ярлык SWF.max Flash Player

cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\file_delete.js" "Desktop" "\SWF.max Flash Player.lnk" >nul 2>&1

:: Устанавливаем программу Animate (Создай мульт)
echo.
echo Устанавливаем "Создай Мульт"...
echo.

mkdir "%ProgramFiles%\Animate" >nul 2>&1
copy /y %PathToAnimate% "%ProgramFiles%\Animate\animate.swf" >nul 2>&1
copy /y %PathToAnimateIco% "%ProgramFiles%\Animate\animate.ico" >nul 2>&1
	
:: Создадим  ссылку на Animate

cscript /nologo /e:jscript "%SystemDrive%\ProgramData\Softium\lnk_create.js" "AllUsersDesktop"  "" "%ProgramFiles%\Animate\animate.swf" "C:\Users\Softium\Documents" "Сделай мульт" "%ProgramFiles%\Animate\animate.ico" "Animate (для начального уровня)." >nul 2>&1

:ENDSUB

timeout 3 /nobreak

EXIT /B
