/*
****************************************************************************************************************************
Скрипт для удаления файлов на компьютере
****************************************************************************************************************************
Вход
- %~0 - Имя SpecialFolder, в которой удаляем файл
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
	
- %~1 - Имя файла, который удаляем
		%~0 и %~1 можно комбинировать.
		%~0 или %~1 могут быть пустыми, в таком случае их нужно указывать в виде "" или "."
****************************************************************************************************************************

Пример использования 

cscript file_delete "." "%USERPROFILE%\Desktop\Myfile.txt"

*/

var a,b,sh,fso

if (WScript.Arguments.length!=2){
	WScript.Echo("Wrong arguments!!!")
	WScript.Quit()
}

a=WScript.Arguments(0)
b=WScript.Arguments(1)

if (a=="."){a=""}
if (b=="."){b=""}

sh=WScript.CreateObject("WScript.Shell")
	MyPath=sh.SpecialFolders(a)
	MyPath=MyPath+b

fso=WScript.CreateObject("Scripting.FileSystemObject")
	WScript.Echo("Deleting file: " + MyPath)
	fso.DeleteFile (MyPath, true)
