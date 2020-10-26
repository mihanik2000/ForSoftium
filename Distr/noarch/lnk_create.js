/*
****************************************************************************************************************************
Скрипт для создания ярлыков к программам и файлам на компьютере
****************************************************************************************************************************
Вход
- %~0 - Имя SpecialFolder, в которой создаём арлык
    AllUsersDesktop
    AllUsersStartMenu
    AllUsersPrograms
    AllUsersStartup
    Desktop
    Favorites
    Fonts
    MyDocuments
    NetHood
    PrintHood
    Programs
    Recent
    SendTo
    StartMenu
    Startup
    Template
	
- %~1 - Имя Folder, в которой создаём арлык.
		%~0 и %~1 можно комбинировать.
		%~0 или %~1 могут быть пустыми, в таком случае их нужно указывать в виде "" или "."
- %~2 - Путь к папке/файлу
- %~3 - Путь к рабочей папке
- %~4 - Название ярлыка
- %~5 - Путь к иконке ярлыка
- %~0 - Описание ярлыка
****************************************************************************************************************************

Пример использования 

cscript lnk_create.js "." "%USERPROFILE%\Desktop" "%windir%\system32\notepad.exe" "%HOMEDRIVE%%HOMEPATH%" "Мой Блокнот" "%windir%\system32\notepad.exe" "Блокнот"

*/

var a,b,sh

if (WScript.Arguments.length!=7){
	WScript.Echo("Wrong arguments!!!")
	WScript.Quit()
}

a=WScript.Arguments(0)
b=WScript.Arguments(1)

if (a=="."){a=""}
if (b=="."){b=""}

sh=WScript.CreateObject("WScript.Shell")
	MyFolderPart=sh.SpecialFolders(a)
	MyFolderPart=MyFolderPart+b
	lk=sh.CreateShortcut(MyFolderPart+"\\"+WScript.Arguments(4)+".lnk")
	lk.TargetPath = WScript.Arguments(2)
	lk.WorkingDirectory = WScript.Arguments(3)
	lk.WindowStyle = 1
	lk.Hotkey = ""
	lk.IconLocation = WScript.Arguments(5)
	lk.Description = WScript.Arguments(6)
	lk.Arguments = ""
	lk.Save()
