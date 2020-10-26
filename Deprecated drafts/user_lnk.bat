@set @x=0 /*
@rem
@rem ****************************************************************************************************************************
@rem Скрипт для создания ярлыков к программам и файлам на компьютере
@rem ****************************************************************************************************************************
@rem
@rem ЗАМЕТКИ НА ПОЛЯХ :-)
@rem Адрес панели быстрого запуска пользователя
@rem %userprofile%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch
@rem
@rem ****************************************************************************************************************************
@rem Описание параметров скрипта
@rem "Папка, где создаём ярлык" "хвост к папке" "Путь к программе" "Путь к рабочей папке" "Имя ярлыка" "путь к файлу с иконкой" 
@rem ****************************************************************************************************************************
@rem
@cscript /nologo /e:jscript "%~f0" "AllUsersDesktop" "" "C:\Windows\System32\notepad.exe" 				"C:\WINDOWS\system32" 			"Блокнот" 		"C:\Windows\System32\notepad.exe"
@cscript /nologo /e:jscript "%~f0" "AllUsersDesktop" "" "C:\Program Files\GIMP 2\bin\gimp-2.10.exe" 	"C:\Program Files\GIMP 2\bin" 	"GIMP" 			"C:\Program Files\GIMP 2\bin\gimp-2.10.exe"
@cscript /nologo /e:jscript "%~f0" "AllUsersDesktop" "" "C:\Program Files\Scratch 2\Scratch 2.exe" 		"C:\Program Files\Scratch 2" 	"Scratch" 		"C:\Program Files\Scratch 2\Scratch 2.exe"
@cscript /nologo /e:jscript "%~f0" "AllUsersDesktop" "" "C:\BabyType2000\BABYTYPE.EXE" 					"C:\BabyType2000" 				"BabyType" 		"%SystemRoot%\System32\SHELL32.dll,41"
@cscript /nologo /e:jscript "%~f0" "AllUsersDesktop" "" "C:\Program Files\SNAP\index.html" 				"C:\Program Files\SNAP" 		"SNAP!" 		"C:\Program Files\SNAP\favicon.ico"
@cscript /nologo /e:jscript "%~f0" "AllUsersDesktop" "" "C:\Program Files\Notepad++\notepad++.exe" 		"C:\Program Files\Notepad++" 	"notepad++" 	"C:\Program Files\Notepad++\notepad++.exe"
@cscript /nologo /e:jscript "%~f0" "AllUsersDesktop" "" "C:\Program Files\Construct 2\Construct2.exe" 	"C:\Program Files\Construct 2" 	"Construct 2" 	"C:\Program Files\Construct 2\Construct2.exe"
@cscript /nologo /e:jscript "%~f0" "AllUsersDesktop" "" "C:\Program Files\Animate\animate.swf" 			"C:\Program Files\Animate" 		"Создай Мульт" 	"C:\Program Files\Animate\animate.ico"
@cscript /nologo /e:jscript "%~f0" "AllUsersDesktop" "" "C:\Program Files\Softium\Softium.exe" 			"C:\Program Files\Softium" 		"Софтиум" 		"C:\Program Files\Softium\Softium.exe"

@exit /b */

sh=WScript.CreateObject("WScript.Shell")
MyFolderPart=sh.SpecialFolders(WScript.Arguments(0))
MyFolderPart=MyFolderPart+WScript.Arguments(1)
lk=sh.CreateShortcut(MyFolderPart+"\\"+WScript.Arguments(4)+".lnk")
lk.TargetPath = WScript.Arguments(2)
lk.WorkingDirectory = WScript.Arguments(3)
lk.WindowStyle = 1
lk.Hotkey = ""
lk.IconLocation = WScript.Arguments(5)
lk.Description = ""
lk.Arguments = ""
lk.Save()


