'****************************************************************************************************************************
' Скрипт для создания ярлыка общей папки на рабочем столе.
'****************************************************************************************************************************

'****************************************************************************************************************************
' Сначала определим внешний белый IP-адрес.
' На основании внешнего IP-адреса мы сможем вычислить место расположения компьютера софтика
'****************************************************************************************************************************
Set https = CreateObject("MSXML2.XMLHTTP")

	https.Open "GET", "https://2ip.ru", False
	https.SetRequestHeader "User-Agent", "curl/7.81.0"
	https.Send

	' Извлекаем IP из ответа
	responseText = https.ResponseText
	
Set https = Nothing

' Устанавливаем пустое значение пути ярлыка общей папки на рабочем столе.
MyTargetPath = ""

' Теперь на основании полученного внешнего IP-адреса задаём правильное значение MyTargetPath
' Офис
if instr (responseText, "84.42.29.51") then
		MyTargetPath = "\\192.168.69.47\SharedFolder"
End if

' Лётное поле
if instr (responseText, "85.91.97.212") then
		MyTargetPath = "\\SOFTIUM1\SharedFolder"
End if

Set WshShell = WScript.CreateObject("WScript.Shell")

	strDesktop = WshShell.SpecialFolders("Desktop")

	Set oShellLink = WshShell.CreateShortcut(strDesktop & "\Общая папка.lnk")
		oShellLink.TargetPath = MyTargetPath
		oShellLink.WindowStyle = 1
		oShellLink.IconLocation = "%SystemRoot%\System32\SHELL32.dll,103"
		oShellLink.Description = "Общая папка для хранения файлов ""Софтиков"""
		oShellLink.WorkingDirectory = MyTargetPath
		oShellLink.Arguments = ""
		oShellLink.Hotkey = ""
		oShellLink.Save
	Set oShellLink = Nothing

Set WshShell = Nothing
