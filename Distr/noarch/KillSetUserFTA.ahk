#Requires AutoHotkey v2.0
#SingleInstance Force

SetTitleMatchMode 2  ; 🔍 Ищем заголовки по подстроке

WinTitle := "SetUserFTA"

WinTitle2 := "Скрипт"

; Бесконечный цикл мониторинга
Loop {
    if WinExist(WinTitle) {
        ; Активируем окно (опционально, но повышает стабильность)
        WinActivate(WinTitle)
        WinWaitActive(WinTitle, , 3)
		
        Sleep 200 ; Небольшая задержка для отрисовки UI

        ControlClick("Button1", WinTitle)  ; Обычно это первая кнопка в диалоге
        
        ; Ждём закрытия окна перед следующей проверкой
        WinWaitClose(WinTitle)
    }

    if WinExist(WinTitle2) {
		
		ExitApp

    }

    Sleep 300 ; Интервал опроса (мс)
}