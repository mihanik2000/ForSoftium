@echo off
REM ****************************************
REM
REM Автор скрипта Михаил Медведев aka mihanik
REM
REM https://mihanik.net
REM
REM        Требуется наличие прав администратора: НЕТ
REM Антивирусная программа должна быть отключена: желательно, но не обязательно
REM                                    Замечания: НЕТ
REM
REM Описание
REM
REM ****************************************

REM ****************************************************************************************
REM Описание процедуры
REM ****************************************************************************************

REM Закрываем Google Chrome

	taskkill /f /im chrome.exe

REM Удаляем текущие настройки Adblock Plus

	forfiles /P "C:\Users\Softium\AppData\Local\Google\Chrome\User Data\Default\IndexedDB" /m *cfhdojbkjhnklbpkdaibdccddilifddb* /C "cmd /c (if @isdir==TRUE rmdir /q /s @file)"

REM Восстанавливаем настройки Adblock Plus

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
