@set @x=0 /*
@rem "Папка, где создаём ярлык" "хвост к папке" "Путь к программе" "Путь к рабочей папке" "Имя ярлыка" "путь к файлу с иконкой" 
@cscript /nologo /e:jscript "%~f0" "AllUsersDesktop" "" "C:\Windows\System32\notepad.exe" "C:\WINDOWS\system32" "Блокнот" "C:\Windows\System32\notepad.exe"
@rem cscript /nologo /e:jscript "%~f0" "AllUsersDesktop" "" "C:\Program Files\GIMP 2\bin\gimp-2.10.exe" "%USERPROFILE%" "GIMP" "C:\Program Files\GIMP 2\bin\gimp-2.10.exe"
@rem cscript /nologo /e:jscript "%~f0" "AllUsersDesktop" "" "C:\Program Files\Scratch 2\Scratch 2.exe" "C:\Program Files\Scratch 2" "Scratch" "C:\Program Files\Scratch 2\Scratch 2.exe"
@rem cscript /nologo /e:jscript "%~f0" "AllUsersDesktop" "" "C:\BabyType2000\BABYTYPE.EXE" "C:\BabyType2000" "BabyType" "%SystemRoot%\System32\SHELL32.dll,41"
@rem cscript /nologo /e:jscript "%~f0" "AllUsersDesktop" "" "C:\Program Files\SNAP\index.html" "C:\Program Files\SNAP" "SNAP!" "C:\Program Files\SNAP\favicon.ico"
@rem cscript /nologo /e:jscript "%~f0" "AllUsersDesktop" "" "C:\Program Files\Notepad++\notepad++.exe" "C:\Program Files\Notepad++" "notepad++" "C:\Program Files\Notepad++\notepad++.exe"
@rem cscript /nologo /e:jscript "%~f0" "AllUsersDesktop" "" "C:\Program Files\Construct 2\Construct2.exe" "C:\Program Files\Construct 2" "Construct 2" "C:\Program Files\Construct 2\Construct2.exe"
@rem cscript /nologo /e:jscript "%~f0" "AllUsersDesktop" "" "C:\Program Files\Animate\animate.swf" "C:\Program Files\Animate" "Создай Мульт" "C:\Program Files\Animate\animate.ico"
@rem cscript /nologo /e:jscript "%~f0" "AllUsersDesktop" "" "C:\Program Files\Softium\Softium.exe" "C:\Program Files\Softium" "Софтиум" "C:\Program Files\Softium\Softium.exe"
@rem Адрес панели быстрого запуска
@rem %userprofile%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch
@exit /b */

sh=WScript.CreateObject("WScript.Shell")
MyFolderPart=sh.SpecialFolders(WScript.Arguments(0))
lk=sh.CreateShortcut(MyFolderPart+"\\"+WScript.Arguments(3)+".lnk")
lk.TargetPath = WScript.Arguments(1)
lk.WorkingDirectory = WScript.Arguments(2)
lk.WindowStyle = 1
lk.Hotkey = ""
lk.IconLocation = WScript.Arguments(4)
lk.Description = ""
lk.Arguments = ""
lk.Save()
