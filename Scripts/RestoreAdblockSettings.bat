@echo off
:: ****************************************
::
:: Автор скрипта Михаил Медведев aka mihanik
::
:: https://mihanik.net
::
::        Требуется наличие прав администратора: НЕТ
:: Антивирусная программа должна быть отключена: желательно, но не обязательно
::                                    Замечания: НЕТ
::
:: Описание
::
:: ****************************************

:: ****************************************************************************************
:: Описание процедуры
:: ****************************************************************************************

:: Закрываем Google Chrome

	taskkill /f /im chrome.exe

:: Удаляем текущие настройки Adblock Plus

	forfiles /P "C:\Users\Softium\AppData\Local\Google\Chrome\User Data\Default\IndexedDB" /m *cfhdojbkjhnklbpkdaibdccddilifddb* /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

:: Восстанавливаем настройки Adblock Plus

	mkdir "%SystemDrive%\Users\Softium\AppData\Local\Google\Chrome\User Data\Default"
	ICACLS "%SystemDrive%\Users\Softium\AppData\Local\Google\Chrome\User Data\Default" /setowner "Softium" /T /C
	
	"%ProgramFiles%\7-Zip\7z.exe" x -y  "%SystemDrive%\ProgramData\Softium\IndexedDB.zip" -o"%SystemDrive%\Users\Softium\AppData\Local\Google\Chrome\User Data\Default"

	ICACLS "%SystemDrive%\Users\Softium\AppData\Local\Google\Chrome\User Data\Default\IndexedDB" /setowner "Softium" /T /C
	ICACLS "%SystemDrive%\Users\Softium\AppData\Local\Google\Chrome\User Data\Default\IndexedDB" /grant Все:F
	ICACLS "%SystemDrive%\Users\Softium\AppData\Local\Google\Chrome\User Data\Default\IndexedDB" /grant Система:F
	ICACLS "%SystemDrive%\Users\Softium\AppData\Local\Google\Chrome\User Data\Default\IndexedDB" /grant Администраторы:F

:ENDSUB

timeout 3 /nobreak

EXIT /B
