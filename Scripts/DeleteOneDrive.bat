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

:: ****************************************************************************************
:: Удалим One Drive
:: ****************************************************************************************

taskkill /f /im OneDrive.exe
	If exist "%SystemDrive%\Program Files (x86)" (
		If exist "%SystemRoot%\SysWOW64\OneDriveSetup.exe" start "Title" /wait %SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
	 ) else (
 		If exist "%SystemRoot%\System32\OneDriveSetup.exe" start "Title" /wait %SystemRoot%\System32\OneDriveSetup.exe /uninstall
 	)

timeout 3 /nobreak

EXIT /B
