@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM        Require administrator rights: No
REM Antivirus software must be disabled: Not necessary
REM                        Dependencies: No
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

	"%ProgramFiles%\7-Zip\7z.exe" x -y  "%SystemDrive%\ProgramData\Softium\IndexedDB.zip" -o"C:\Users\Softium\AppData\Local\Google\Chrome\User Data\Default"

:ENDSUB

timeout 3 /nobreak

EXIT /B
