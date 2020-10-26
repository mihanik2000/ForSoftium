# -*- coding: UTF-8 -*-

#-------------------------------------------------------------------------------
# Name:		ForSoftium
# Purpose:
#
# Author:	  mihanik
#
# Created:	 05.09.2020
# Copyright:   (c) mihanik 2020
# Licence:	 <your licence>
#-------------------------------------------------------------------------------

import os
import sys
import ctypes
import win32com.client
import urllib2

Distr_Folder = r'C:\Distr'

def Create_Log_Entry( MyList = 'APPLICATION', MyType = 'INFORMATION', MySource = 'eventcreate', MyID = 1, MyDef = 'Description not specified.' ):
	'''Cоздаёт событие в системном журнале

	Parameters
	----------
	MyList : str
			Указывает имя журнала событий, в котором будет создано событие. Допустимые имена журналов — APPLICATION или SYSTEM.

	MyType : str
			 Тип создаваемого события. Допустимые типы: SUCCESS, ERROR, WARNING, INFORMATION.

	MySource : str
			   Источник для этого события (если не указан, по умолчанию используется "eventcreate").
			   Допустимым источником является любая строка, представляющая приложение или компонент, создающий это событие.

	MyID : int
		   Код события для этого события.
		   Допустимым кодом события является любое число в диапазоне от 1 до 1000.

	MyDef : str
			Описание для создаваемого события.

	Returns
	-------
	bool
		true - событие создано успешно;
		false - при создании события произошла ошибка

	Warns
	-----
		Для работы функции часто требуются права администратора. Кириллицу в параметрах не использовать!!!

	'''

	MyCommandLine =  r'EVENTCREATE.EXE /L ' + MyList + r' /T ' + MyType + r' /SO "' + MySource + r'" /ID ' + str(MyID) + r' /D "' + MyDef + '"'
	MyResult = os.system(MyCommandLine)
	return MyResult == 0

def Simple_Log_Entry ( MyType=4, MyMessage = 'Событие'):
	'''Протоколирует событие в журнале Windows

	Parameters
	----------
	MyType : int
				тип сообщения.

				Код	 Описание
				0	SUCCESS.
				1	ERROR.
				2	WARNING.
				4	INFORMATION.
				8	AUDIT_SUCCESS.
				16	AUDIT_FAILURE.

	MyMessage : str
				строка, текст сообщения.

	Returns
	-------
	bool
		true - событие создано успешно;
		false - при создании события произошла ошибка
	'''

	MyShell = win32com.client.Dispatch("WScript.Shell")
	return MyShell.LogEvent ( MyType, MyMessage.decode('utf-8'))

def Special_Folder_Name( SFName ):
	'''Возвращает полный путь к специальным папкам типа меню Пуск.

	Parameters
	----------
	SFName : str
			 Название специальной папки

	Примерный список доступных папок:
		AllUsersDesktop, AllUsersStartMenu, AllUsersPrograms, AllUsersStartup,
		Desktop, Favorites, Fonts, MyDocuments, NetHood, PrintHood, Programs,
		Recent, SendTo, StartMenu, Startup, Templates.

	Returns
	-------
	str
		Путь к указанной специальной папке.
	'''

	MyResult = None
	if len(SFName)<1:
		return MyResult
	MyShell = win32com.client.Dispatch("WScript.Shell")
	MyResult = MyShell.SpecialFolders( SFName )
	return MyResult

def Create_Shortcut( ShortcutName, TargetPath, Arguments=' ', Description='Описание ярлыка', WorkingDirectory= r'%USERPROFILE%', WindowStyle=4, IconLocation=r'%SystemRoot%\System32\SHELL32.dll,0', Hotkey='CTRL+ALT+S'):
	'''Функция создаёт в нужном месте ярлык на файл или папку. "Падение" данной функции не должно вызывать "падение" всей программы, поэтому всё "обернул" в try

	Parameters
	----------
	ShortcutName : str
		Полный путь к расположению самого ярлыка
	TargetPath : str
		Местоположение файла/папки куда мы будем ссылаться.
	Arguments : str
		Данное свойство задает аргументы командной строки для приложения, на которое надо ссылаться.
	Description: str
		В это свойство мы можем прописать описание.
	WorkingDirectory : str
		Рабочая папка для ярлыка
	WindowStyle : int
		Определяет параметры окна для приложения при его запуске, может принимать только целые значения:
		4 – стандартный размер окна;
		3 – развернутый вид (максимизировано);
		7 – свернутое окно (минимизировано).
	IconLocation : str
		Хранит в себе местоположение иконки.
	Hotkey : str
		Данное свойство отвечает за "Горячую" клавишу, как правило, тут прописываются комбинации клавиш для запуска того приложения, на которое надо сослаться.
		
	Returns
	-------
	int
		0 - при выполнении ошибок не было;
		1 - при выполнении были ошибки
	'''
	try:
		MyShell = win32com.client.Dispatch("WScript.Shell")
		MyShortcut = MyShell.CreateShortcut( ShortcutName.decode('utf-8') )
		MyShortcut.TargetPath = TargetPath.decode('utf-8')
		MyShortcut.Arguments = Arguments.decode('utf-8')
		MyShortcut.Description = Description.decode('utf-8')
		MyShortcut.WorkingDirectory = WorkingDirectory.decode('utf-8')
		MyShortcut.WindowStyle = WindowStyle
		MyShortcut.IconLocation = IconLocation.decode('utf-8')
		MyShortcut.Hotkey = Hotkey.decode('utf-8')
		MyShortcut.Save()
		return 0
	except:
		return 1
		

def Is_Admin():
	'''
	Функция проверки наличия прав администратора

	Returns
	-------
	bool
		 true - Права администратора имеются;
		 false - Прав администратора нет.
	'''
	try:
		return ctypes.windll.shell32.IsUserAnAdmin()
	except:
		return False

def System_x64():
	'''Функция определения разрядности операционной системы.
	
	Parameters
	----------
		Нет

	Returns
	-------
	bool
		 true  - Система 64-разрядная;
		 false - Система 32-разрядная
	'''
	if  os.path.exists(r'C:\Program Files (x86)'):
		return True
	else:
		return False

def Url_Ok( url, timeout=5 ):
	'''Функция проверки доступности URL

	Parameters
	----------
	url : str
		Проверяемый URL

	imeout : int
		timeout ожидания

	Returns
	-------
	bool
		true - URL доступен
		false - URL недоступен

	'''
	try:
		return urllib2.urlopen(url,timeout=timeout).getcode() == 200
	except:
		return False

def Download_File(myurl,mypath):
	'''
	Функция скачивания файла

	Parameters
	----------
	myurl : str
		   Откуда скачиваем файл

	mypath : str
			куда скачиваем файл

	Returns
	-------
	bool
		true  - успешное скачивание
		false - скачивание не удалось

	'''
	if not Url_Ok(myurl, 5):
		Simple_Log_Entry (1, "Файл недоступен: " + myurl)
		return False
	Simple_Log_Entry (0, "Файл доступен: " + myurl)

	try:
		mycontent = urllib2.urlopen(myurl)
		output = open(mypath,'wb')
		output.write(mycontent.read())
		output.close()
	except urllib2.HTTPError, error:
		Simple_Log_Entry (1, "Ошибка: " + + error.read())
		Simple_Log_Entry (1, "Файл не загружен: " + myurl)
		return False
	except:
		Simple_Log_Entry (1, "Что-то пошло не так при загрузке файла: " + myurl)
		return False
	else:
		Simple_Log_Entry (0, "Был успешно загружен файл: " + myurl)
		return True

def Download_Page(myurl = 'http://zbx.mihanik.net/'):
	'''
	Функция скачивания страницы по URL в память ПК

	Parameters
	----------
	myurl : str
		   Откуда скачиваем файл

	Returns
	-------
	str
		Полный текст страницы

	'''
	if not Url_Ok(myurl, 5):
		Simple_Log_Entry (1, "Страница недоступна: " + myurl)
		return 'None'

	Simple_Log_Entry (0, "Страница доступна: " + myurl)

	try:
		mycontent = urllib2.urlopen(myurl)
		return mycontent.read()
	except urllib2.HTTPError, error:
		Simple_Log_Entry (1, 'Error: ' + error.read())
		Simple_Log_Entry (1, 'Страница не загружена: ' + myurl)
		return 'None'
	except:
		Simple_Log_Entry (1, 'Что-то пошло не так при загрузке страницы: ' + myurl)
		return 'None'

def Install_7Zip():
	print 'Скачиваем и устанавливаем 7-Zip.'.decode('utf-8')

	if System_x64():
		if Download_File('http://repo.mihanik.net/7-Zip/7z1900-x64.msi', Distr_Folder+ r'\7z1900-x64.msi'):
			MyResult = os.system( Distr_Folder+ r'\7z1900-x64.msi /qn')
			if MyResult == 0:
				print '7-Zip установлен успешно.'.decode('utf-8')
			else:
				print 'При установке 7-Zip произошли ошибки.'.decode('utf-8')
				return 1
		else:
			print 'Скачать 7-Zip не удалось.'.decode('utf-8')
			return 1
	else:
		if Download_File('http://repo.mihanik.net/7-Zip/7z1900.msi', Distr_Folder+ r'\7z1900.msi'):
			MyResult = os.system( Distr_Folder+ r'\7z1900.msi /qn')
			if MyResult == 0:
				print '7-Zip установлен успешно.'.decode('utf-8')
			else:
				print 'При установке 7-Zip произошли ошибки.'.decode('utf-8')
				return 1
		else:
			print 'Скачать 7-Zip не удалось.'.decode('utf-8')
			return 1

	return 0

def Install_Scratch_Desktop():
	print 'Устанавливаем Scratch Desktop.'.decode('utf-8')
	
	if Download_File('http://repo.mihanik.net/softium/ScratchDesktopSetup3.15.0.exe', Distr_Folder+ r'\ScratchDesktopSetup3.15.0.exe'):
		MyResult = os.system( Distr_Folder+ r'\ScratchDesktopSetup3.15.0.exe /S /allusers')
		if MyResult == 0:
			print 'Scratch Desktop установлен успешно.'.decode('utf-8')
			return 0
		else:
			print 'При установке Scratch Desktop произошли ошибки.'.decode('utf-8')
			return 1
	else:
		print 'Скачать Scratch Desktop не удалось.'.decode('utf-8')
		return 1

def Install_AdobeAIR():
	print 'Устанавливаем AdobeAIR'.decode('utf-8')
	
	if Download_File('http://repo.mihanik.net/softium/AdobeAIRInstaller.exe', Distr_Folder+ r'\AdobeAIRInstaller.exe'):
		MyResult = os.system( Distr_Folder+ r'\AdobeAIRInstaller.exe -silent')
		if MyResult == 0:
			print 'AdobeAIR установлен успешно.'.decode('utf-8')
			return 0
		else:
			print 'При установке AdobeAIR произошли ошибки.'.decode('utf-8')
			return 1
	else:
		print 'Скачать AdobeAIR не удалось.'.decode('utf-8')
		return 1

def Install_Scratch_Offline():
	print 'Устанавливаем Scratch offline editor'.decode('utf-8')
	
	if Download_File('http://repo.mihanik.net/softium/Scratch-461.exe', Distr_Folder+ r'\Scratch-461.exe'):
		MyResult = os.system( Distr_Folder+ r'\Scratch-461.exe -silent')
		if MyResult == 0:
			print 'Scratch offline editor установлен успешно.'.decode('utf-8')
			return 0
		else:
			print 'При установке Scratch offline editor произошли ошибки.'.decode('utf-8')
			return 1
	else:
		print 'Скачать Scratch offline editor не удалось.'.decode('utf-8')
		return 1

def Install_GIMP():
	print 'Устанавливаем GIMP'.decode('utf-8')
	
	if Download_File('http://repo.mihanik.net/softium/gimp-2.10.20-setup-1.exe', Distr_Folder+ r'\gimp-2.10.20-setup-1.exe'):
		MyResult = os.system( Distr_Folder+ r'\gimp-2.10.20-setup-1.exe /SILENT')
		if MyResult == 0:
			print 'GIMP установлен успешно.'.decode('utf-8')
			return 0
		else:
			print 'При установке GIMP произошли ошибки.'.decode('utf-8')
			return 1
	else:
		print 'Скачать GIMP не удалось.'.decode('utf-8')
		return 1

def Install_Chrome():
	print 'Устанавливаем Chrome'.decode('utf-8')
	
	if Download_File('http://repo.mihanik.net/softium/ChromeSetup.exe', Distr_Folder+ r'\ChromeSetup.exe'):
		MyResult = os.system( Distr_Folder+ r'\ChromeSetup.exe /silent /install')
		if MyResult == 0:
			print 'Chrome установлен успешно.'.decode('utf-8')
			return 0
		else:
			print 'При установке Chrome произошли ошибки.'.decode('utf-8')
			return 1
	else:
		print 'Скачать Chrome не удалось.'.decode('utf-8')
		return 1

def Install_BABYTYPE2000():
	print 'Устанавливаем BABYTYPE2000'.decode('utf-8')
	
	if Download_File('http://repo.mihanik.net/softium/BABYTYPE2000.zip', Distr_Folder+ r'\BABYTYPE2000.zip'):
		Command_Line =  r'"C:\Program Files\7-Zip\7z.exe" x -y ' + Distr_Folder + r'\BABYTYPE2000.zip -oc:'
		print Command_Line
		MyResult = os.system( Command_Line )
		if MyResult == 0:
			print 'BABYTYPE2000 установлен успешно.'.decode('utf-8')
			return 0
		else:
			print 'При установке BABYTYPE2000 произошли ошибки.'.decode('utf-8')
			return 1
	else:
		print 'Скачать BABYTYPE2000 не удалось.'.decode('utf-8')
		return 1

def Install_Snap():
	print 'Устанавливаем Snap'.decode('utf-8')
	
	if Download_File('http://repo.mihanik.net/softium/Snap-6.1.4.zip', Distr_Folder+ r'\snap.zip'):
		if os.path.exists(r'C:\Program Files\SNAP'):
			pass
		else:
			os.mkdir(r'C:\Program Files\SNAP')

		os.chdir(r'C:\Program Files\SNAP')

		Command_Line =  r'"C:\Program Files\7-Zip\7z.exe" x -y ' + Distr_Folder + r'\snap.zip *'
		MyResult = os.system( Command_Line )
		if MyResult == 0:
			print 'Snap установлен успешно.'.decode('utf-8')
			return 0
		else:
			print 'При установке  произошли ошибки.'.decode('utf-8')
			return 1
	else:
		print 'Скачать Snap не удалось.'.decode('utf-8')
		return 1

def Install_Notepad():
	print 'Устанавливаем Notepad++'.decode('utf-8')
	
	if System_x64():
		if Download_File('http://repo.mihanik.net/softium/npp.7.8.9.Installer.x64.exe', Distr_Folder+ r'\npp.7.8.9.Installer.x64.exe'):
			MyResult = os.system( Distr_Folder+ r'\npp.7.8.9.Installer.x64.exe /S')
			if MyResult == 0:
				print 'Notepad++ установлен успешно.'.decode('utf-8')
				return 0
			else:
				print 'При установке Notepad++ произошли ошибки.'.decode('utf-8')
				return 1
		else:
			print 'Скачать Notepad++ не удалось.'.decode('utf-8')
			return 1
	else:
		if Download_File('http://repo.mihanik.net/softium/npp.7.8.9.Installer.exe', Distr_Folder+ r'\npp.7.8.9.Installer.exe'):
			MyResult = os.system( Distr_Folder+ r'\npp.7.8.9.Installer.exe /S')
			if MyResult == 0:
				print 'Notepad++ установлен успешно.'.decode('utf-8')
				return 0
			else:
				print 'При установке Notepad++ произошли ошибки.'.decode('utf-8')
				return 1
		else:
			print 'Скачать Notepad++ не удалось.'.decode('utf-8')
			return 1	

def Install_Construct():
	print 'Устанавливаем Сonstruct2'.decode('utf-8')
	
	if Download_File('http://repo.mihanik.net/softium/construct2-r279-setup.exe', Distr_Folder+ r'\construct2-r279-setup.exe'):
		MyResult = os.system( Distr_Folder+ r'\construct2-r279-setup.exe /verysilent')
		if MyResult == 0:
			print 'Сonstruct2 установлен успешно.'.decode('utf-8')
			return 0
		else:
			print 'При установке Сonstruct2 произошли ошибки.'.decode('utf-8')
			return 1
	else:
		print 'Скачать Сonstruct2 не удалось.'.decode('utf-8')
		return 1

def Install_SWF_Player():
	print 'Устанавливаем SWF_Player'
	
	if Download_File('http://repo.mihanik.net/softium/SWF%20Player_2.2.exe', Distr_Folder+ r'\SWF.max-2.2.exe'):
		MyResult = os.system( Distr_Folder+ r'\SWF.max-2.2.exe /S')
		if MyResult == 0:
			print 'SWF_Player установлен успешно.'.decode('utf-8')
			return 0
		else:
			print 'При установке SWF_Player произошли ошибки.'.decode('utf-8')
			return 1
	else:
		print 'Скачать SWF_Player не удалось.'.decode('utf-8')
		return 1

def Install_Animate():
	print 'Устанавливаем Animate'.decode('utf-8')

	if os.path.exists(r'C:\Program Files\Animate'):
		pass
	else:
		os.mkdir(r'C:\Program Files\Animate')

	if Download_File('http://repo.mihanik.net/softium/animate.swf', r'C:\Program Files\Animate\animate.swf'):
		pass
	else:
		print 'При установке Animate произошли ошибки.'.decode('utf-8')
		return 1

	if Download_File('http://repo.mihanik.net/softium/animate.ico', r'C:\Program Files\Animate\animate.ico'):
		pass
	else:
		print 'При установке Animate произошли ошибки.'.decode('utf-8')
		return 1

	print 'Animate установлен успешно.'.decode('utf-8')
	return 0


def main():

	# Устанавливаем кодировку по умолчанию.
	reload(sys)
	sys.setdefaultencoding('utf8')

	if Is_Admin:
		print 'Пользователь имеет права администратора.\nПродолжаем.'.decode('utf-8')
	else:
		print 'Скрипт следует запускать от имени "Администратора"'.decode('utf-8')
		return 1

	# включим режим электропитания "Высокая производительность"
	os.system(r'powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c')

	# Отключим защитника Windows
	os.system(r'reg ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f')

	# Выясняем путь до общего рабочего стола
	MyDesktop = Special_Folder_Name('AllUsersDesktop')
	print 'Путь до общего рабочего стола: '.decode('utf-8') + MyDesktop

	print 'Создаём папку для дистрибутивов.'.decode('utf-8')
	if os.path.exists(Distr_Folder):
		print 'Папка уже существует.'.decode('utf-8')
	else:
		try:
			os.mkdir(Distr_Folder)
		except:
			print 'Что-то пошло не так при создании папки.'.decode('utf-8')
			return 1
		else:
			print 'Папка успешно создана.'.decode('utf-8')

	# Устанавливаем 7-Zip
	if Install_7Zip() == 1:
		print 'Во время установки произошла ошибка.'.decode('utf-8')
		# Без архиватора нет смысла продолжать. Выходим с ошибкой.
		return 1
		
	# Устанавливаем AdobeAIR
	if Install_AdobeAIR() == 1:
		print 'Во время установки произошла ошибка.'.decode('utf-8')

	# Устанавливаем Scratch offline editor
	if Install_Scratch_Offline() == 1:
		print 'Во время установки произошла ошибка.'.decode('utf-8')

	# Создаём на рабочем столе ярлычок на Scratch offline editor
	if System_x64():
		Create_Shortcut( MyDesktop + '\Scratch 2.lnk', r'C:\Program Files (x86)\Scratch 2\Scratch 2.exe', '' , 'Офлайн-редактор Scratch 2.0', r'%USERPROFILE%', 4, r'C:\Program Files (x86)\Scratch 2\Scratch 2.exe')
	else:
		Create_Shortcut( MyDesktop + '\Scratch 2.lnk', r'C:\Program Files\Scratch 2\Scratch 2.exe', '' , 'Офлайн-редактор Scratch 2.0', r'%USERPROFILE%', 4, r'C:\Program Files\Scratch 2\Scratch 2.exe')


	# Устанавливаем Scratch Desktop
	if Install_Scratch_Desktop() == 1:
		print 'Во время установки произошла ошибка.'.decode('utf-8')

	# Устанавливаем GIMP
	if Install_GIMP() == 1:
		print 'Во время установки произошла ошибка.'.decode('utf-8')

	# Создадим  ссылку на GIMP
	Create_Shortcut( MyDesktop + '\GIMP.lnk', r'C:\Program Files\GIMP 2\bin\gimp-2.10.exe', '' , 'Графический редактор GIMP 2.10.20', r'%USERPROFILE%', 4, r'C:\Program Files\GIMP 2\bin\gimp-2.10.exe')

	# Устанавливаем Chrome
	if Install_Chrome() == 1:
		print 'Во время установки произошла ошибка.'.decode('utf-8')

	# Создадим  ссылку на Chrome
	if System_x64():
		Create_Shortcut( MyDesktop + '\Google Chrome.lnk', r'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe', '' , 'Доступ в Интернет', r'C:\Program Files (x86)\Google\Chrome\Application', 4, r'%ProgramFiles% (x86)\Google\Chrome\Application\chrome.exe')
	else:
		Create_Shortcut( MyDesktop + '\Google Chrome.lnk', r'C:\Program Files\Google\Chrome\Application\chrome.exe', '' , 'Доступ в Интернет', r'C:\Program Files\Google\Chrome\Application', 4, r'%ProgramFiles%\Google\Chrome\Application\chrome.exe')

	# Устанавливаем BABYTYPE2000
	if Install_BABYTYPE2000() == 1:
		print 'Во время установки произошла ошибка.'.decode('utf-8')

	# Создадим  ссылку на BABYTYPE
	Create_Shortcut( MyDesktop + '\BabyType.lnk', r'C:\BABYTYPE2000\BABYTYPE.EXE', '' , 'Тренажер печати BabyType', r'C:\BABYTYPE2000', 4, r'%SystemRoot%\System32\SHELL32.dll,41')

	# Устанавливаем Snap
	if Install_Snap() == 1:
		print 'Во время установки произошла ошибка.'.decode('utf-8')

	# Создадим  ссылку на Snap
	Create_Shortcut( MyDesktop + '\Snap!.lnk', r'C:\Program Files\SNAP\Snap-6.1.4\index.html', '' , 'SNAP! Оффлайн версия', r'C:\Program Files\SNAP\Snap-6.1.4', 4, r'C:\Program Files\SNAP\Snap-6.1.4\src\favicon.ico')

	# Устанавливаем Устанавливаем Notepad++
	if Install_Notepad() == 1:
		print 'Во время установки произошла ошибка.'.decode('utf-8')

	# Создадим  ссылку на Snap
	Create_Shortcut( MyDesktop + '\Notepad++.lnk', r'C:\Program Files\Notepad++\notepad++.exe', '' , 'Текстовый редактор Notepad++', r'C:\Program Files\Notepad++', 4, r'C:\Program Files\Notepad++\notepad++.exe')

	# Устанавливаем construct2
	if Install_Construct() == 1:
		print 'Во время установки произошла ошибка.'.decode('utf-8')

	# Создадим  ссылку на construct2
	Create_Shortcut( MyDesktop + '\Construct2.lnk', r'C:\Program Files\Construct 2\Construct2.exe', '' , 'The HTML5 game and app creator by Scirra.', r'C:\Program Files\Construct 2', 4, r'C:\Program Files\Construct 2\Construct2.exe')

	# Устанавливаем SWF_Player
	if Install_SWF_Player() == 1:
		print 'Во время установки произошла ошибка.'.decode('utf-8')

	# Ассоциируем файлы с проигрывателем
	# Тут ещё не доделано...
	# os.system(r'setx PATH "C:\Program Files (x86)\SWF.max\;%Path%"')
	os.system(r'assoc .swf=application.x-shockwave-flash')
	if System_x64():
		os.system(r'ftype application.x-shockwave-flash="C:\Program Files (x86)\SWF.max\SWF.max.exe"  "%1"')
	else:
		os.system(r'ftype application.x-shockwave-flash="C:\Program Files\SWF.max\SWF.max.exe"  "%1"')

	# Устанавливаем Animate
	if Install_Animate() == 1:
		print 'Во время установки произошла ошибка.'.decode('utf-8')

	# Создадим  ссылку на Animate
	Create_Shortcut( MyDesktop + '\Animate.lnk', r'C:\Program Files\Animate\animate.swf', '' , 'Animate (для начального уровня). ', r'%USERPROFILE%', 4, r'C:\Program Files\Animate\animate.ico')

	# включим режим электропитания "Экономия энергии"
	# os.system('powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a')

	# Включим защитника Windows
	os.system(r'reg ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 0 /f')

if __name__ == '__main__':
	main()
