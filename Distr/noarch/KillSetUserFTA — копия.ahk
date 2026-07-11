#Requires AutoHotkey v2.0
#SingleInstance Force

SetTitleMatchMode 2  ; 🔍 Ищем заголовки по подстроке

WinTitle := "SetUserFTA"
BtnText  := "OK"  ; Точный текст кнопки. Регистр важен! (OK / Ok / ОК / Готово)

; Бесконечный цикл мониторинга
Loop {
    if WinExist(WinTitle) {
        ; Активируем окно (опционально, но повышает стабильность)
        WinActivate(WinTitle)
        WinWaitActive(WinTitle, , 3)
        Sleep 200 ; Небольшая задержка для отрисовки UI
        
        ; 🔹 Вариант 1: Нажатие по видимому тексту кнопки
        ;ControlClick(BtnText, WinTitle)
        
        ; 🔹 Вариант 2 (если текст не совпал или меняется язык):
        ControlClick("Button1", WinTitle)  ; Обычно это первая кнопка в диалоге
        
        ; Ждём закрытия окна перед следующей проверкой
        WinWaitClose(WinTitle)
    }
    Sleep 300 ; Интервал опроса (мс)
}