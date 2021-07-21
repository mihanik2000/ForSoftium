function GetPluginSettings()
{
	return {
		"name":			"NW.js",			// as appears in 'insert object' dialog, can be changed as long as "id" stays the same
		"id":			"NodeWebkit",			// this is used to identify this plugin and is saved to the project; never change it
		"version":		"1.0",					// (float in x.y format) Plugin version - C2 shows compatibility warnings based on this
		"description":	"Доступ только функции, доступные при экспорте с NW.js, как доступ к файлам на диске.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/162/nwjs",
		"category":		"Конкретная платформа",	// Prefer to re-use existing categories, but you can set anything here
		"type":			"object",				// either "world" (appears in layout and is drawn), else "object"
		"rotatable":	false,					// only used when "type" is "world".  Enables an angle property on the object.
		"flags":		0						// uncomment lines to enable flags...
						| pf_singleglobal		// exists project-wide, e.g. mouse, keyboard.  "type" must be "object".
					//	| pf_texture			// object has a single texture (e.g. tiled background)
					//	| pf_position_aces		// compare/set/get x, y...
					//	| pf_size_aces			// compare/set/get width, height...
					//	| pf_angle_aces			// compare/set/get angle (recommended that "rotatable" be set to true)
					//	| pf_appearance_aces	// compare/set/get visible, opacity...
					//	| pf_tiling				// adjusts image editor features to better suit tiled images (e.g. tiled background)
					//	| pf_animations			// enables the animations system.  See 'Sprite' for usage
					//	| pf_zorder_aces		// move to top, bottom, layer...
					//  | pf_nosize				// prevent resizing in the editor
					//	| pf_effects			// allow WebGL shader effects to be added
					//  | pf_predraw			// set for any plugin which draws and is not a sprite (i.e. does not simply draw
												// a single non-tiling image the size of the object) - required for effects to work properly
	};
};

////////////////////////////////////////
// Parameter types:
// AddNumberParam(label, description [, initial_string = "0"])			// a number
// AddStringParam(label, description [, initial_string = "\"\""])		// a string
// AddAnyTypeParam(label, description [, initial_string = "0"])			// accepts either a number or string
// AddCmpParam(label, description)										// combo with equal, not equal, less, etc.
// AddComboParamOption(text)											// (repeat before "AddComboParam" to add combo items)
// AddComboParam(label, description [, initial_selection = 0])			// a dropdown list parameter
// AddObjectParam(label, description)									// a button to click and pick an object type
// AddLayerParam(label, description)									// accepts either a layer number or name (string)
// AddLayoutParam(label, description)									// a dropdown list with all project layouts
// AddKeybParam(label, description)										// a button to click and press a key (returns a VK)
// AddAnimationParam(label, description)								// a string intended to specify an animation name
// AddAudioFileParam(label, description)								// a dropdown list with all imported project audio files

////////////////////////////////////////
// Conditions

// AddCondition(id,					// any positive integer to uniquely identify this condition
//				flags,				// (see docs) cf_none, cf_trigger, cf_fake_trigger, cf_static, cf_not_invertible,
//									// cf_deprecated, cf_incompatible_with_triggers, cf_looping
//				list_name,			// appears in event wizard list
//				category,			// category in event wizard list
//				display_str,		// as appears in event sheet - use {0}, {1} for parameters and also <b></b>, <i></i>
//				description,		// appears in event wizard dialog when selected
//				script_name);		// corresponding runtime function name
				
		
AddStringParam("Путь", "Введите путь к файлу для проверки, если он существует.");
AddCondition(0, cf_none, "Путь существует", "Файловая система", "Путь <i>{0}</i> существует", "Проверьте, существует ли файл на диске.", "PathExists");

AddCondition(1, cf_trigger, "При загрузке файла", "Файловая система", "При загрузке файла", "Вызывается, когда пользователь перетаскивает файл в окно.", "OnFileDrop");

AddCondition(2, cf_trigger, "Открыть диалог OK", "Файловая система", "Открыть диалог OK", "Вызывается после файла, выбранного из открытого диалога.", "OnOpenDlg");

AddCondition(3, cf_trigger, "Диалоговое окно папки OK", "Файловая система", "Диалоговое окно папки OK", "Вызывается после папки, выбранной из диалогового окна папки.", "OnFolderDlg");

AddCondition(4, cf_trigger, "Сохранить диалог OK", "Файловая система", "Сохранить диалог OK", "Вызывается после файла, выбранного из диалогового окна сохранения.", "OnSaveDlg");

////////////////////////////////////////
// Actions

// AddAction(id,				// any positive integer to uniquely identify this action
//			 flags,				// (see docs) af_none, af_deprecated
//			 list_name,			// appears in event wizard list
//			 category,			// category in event wizard list
//			 display_str,		// as appears in event sheet - use {0}, {1} for parameters and also <b></b>, <i></i>
//			 description,		// appears in event wizard dialog when selected
//			 script_name);		// corresponding runtime function name

AddStringParam("Путь", "Введите путь к файлу для записи. Файл будет перезаписан!", "");
AddStringParam("Содержимое", "Введите текстовое содержимое для записи в файл.");
AddAction(0, af_none, "Записать файл", "Файловая система", "Записать <b>{1}</b> в файл <i>{0}</i>", "Запись текста в файл.", "WriteFile");

AddStringParam("Существующий файл", "Введите существующий путь к файлу для переименования.");
AddStringParam("Новое имя", "Введите новый путь к файлу для переименования.");
AddAction(1, af_none, "Переименовать файл", "Файловая система", "Переименовать <i>{0}</i> в <i>{1}</i>", "Переименуйте существующий файл.", "RenameFile");

AddStringParam("Путь", "Введите путь к файлу для удаления.");
AddAction(2, af_none, "Удалить файл", "Файловая система", "Удалить <i>{0}</i>", "Удаление файла.", "DeleteFile");

AddStringParam("Путь", "Введите путь к папке для создания.");
AddAction(3, af_none, "Создать папку", "Файловая система", "Создать папку <i>{0}</i>", "Создать новую папку на диске.", "CreateFolder");

AddStringParam("Путь", "Введите путь к файлу для добавления.", "");
AddStringParam("Содержимое", "Введите текстовое содержимое для добавления в файл.");
AddAction(4, af_none, "Добавить файл", "Файловая система", "Добавить <b>{1}</b> в файл <i>{0}</i>", "Добавление текста в конец файла.", "AppendFile");

AddStringParam("Путь", "Введите путь к папке для вывода списка файлов.");
AddAction(5, af_none, "Список файлов", "Файловая система", "Список файлов <i>{0}</i>", "Загрузка списка файлов в заданной папке. Используйте выражения после этого действия для получения числа и имен файлов.", "ListFiles");

AddStringParam("Принять", "Типы файлов для фильтрации. Оставьте пустым, чтобы показать все файлы, или например, \".txt\" или \".txt,.json\" или \"text/*\"");
AddAction(6, af_none, "Показать диал. окно открытия", "Диалоговые окна файлов", "Показать диал. окно открытия (принять <i>{0}</i>)", "Покажите диалог открытого файла, позволяющий пользователю выбрать файл.", "ShowOpenDlg");

AddAction(7, af_none, "Показать диал. окно папки", "Диалоговые окна файлов", "Показать диалоговое окно папки", "Отображение диалогового окна выбора папки, позволяющего пользователю выбрать папку.", "ShowFolderDlg");

AddStringParam("Принять", "Типы файлов для фильтрации. Оставьте пустым, чтобы показать все файлы, или например, \".txt\" или \".txt,.json\" или \"text/*\"");
AddAction(8, af_none, "Показать диал. окно сохранения", "Диалоговые окна файлов", "Показать диал. окно сохранения (принять <i>{0}</i>)", "Показать диалог сохранения файла.", "ShowSaveDlg");

AddStringParam("Путь", "Введите путь к файлу для копирования.");
AddStringParam("Назначения", "Введите путь к файлу для копирования.");
AddAction(9, af_none, "Копировать файл", "Файловая система", "Копировать <i>{0}</i> в <i>{1}</i>", "Сделайте идентичную копию файла.", "CopyFile");

AddStringParam("Путь", "Введите путь к файлу для перемещения.");
AddStringParam("Назначения", "Введите путь к файлу для перемещения.");
AddAction(10, af_none, "Переместить файл", "Файловая система", "Переместить <i>{0}</i> в <i>{1}</i>", "Скопируйте файл, затем удалите оригинал.", "MoveFile");

AddStringParam("Путь", "Введите путь к файлу для выполнения. Это также может включать аргументы, разделенные пробелами. Чтобы выполнить путь с пробелами в нем, заверните в двойные кавычки (например, \"\"\"C:\\Program Files\\file.exe\"\"\").");
AddAction(11, af_none, "Запустить файл", "Файловая система", "Выполнить <i>{0}</i>", "Запуск файла, например выполнение другой программы.", "RunFile");

AddNumberParam("X", "Координата X для перемещения окна на экран.");
AddAction(12, af_none, "Установить X", "Окно", "Установите окно X в <i>{0}</i>", "Установите X-положение окна на экране.", "SetWindowX");

AddNumberParam("Y", "Координата Y для перемещения окна на экран.");
AddAction(13, af_none, "Установить Y", "Окно", "Задать для окна Y <i>{0}</i>", "Задайте положение по оси Y окна на экране.", "SetWindowY");

AddNumberParam("Ширина", "Новая ширина окна.");
AddAction(14, af_none, "Установить ширину", "Окно", "Установить ширину окна <i>{0}</i>", "Задайте ширину окна.", "SetWindowWidth");

AddNumberParam("Высота", "Новая высота окна.");
AddAction(15, af_none, "Установить высоту", "Окно", "Установить высоту окна <i>{0}</i>", "Задайте высоту окна.", "SetWindowHeight");

AddStringParam("Название", "Строка, отображаемая в строке заголовка окна.");
AddAction(16, af_none, "Установить название", "Окно", "Задать заголовок окна <i>{0}</i>", "Задайте текст, отображаемый в строке заголовка окна.", "SetWindowTitle");

AddAction(17, af_none, "Свернуть", "Окно", "Свернуть окно", "Сверните окно.", "WindowMinimize");
AddAction(18, af_none, "Развернуть", "Окно", "Развернуть окно", "Разверните окно.", "WindowMaximize");
AddAction(19, af_none, "Развернуть окно", "Окно", "Развернуть окно", "Разворачивание окна (т. е. противоположность максимизации).", "WindowUnmaximize");
AddAction(20, af_none, "Восстановления", "Окно", "Окно восстановления", "Восстановить окно (т. е. Показать снова после минимизации).", "WindowRestore");

AddComboParamOption("Запросить внимание");
AddComboParamOption("Перестань обращать внимание");
AddComboParam("Режим", "Следует ли запросить внимание или отменить предыдущий запрос на внимание.");
AddAction(21, af_none, "Запросить внимание", "Окно", "Окно: {0}", "Запуск или остановка запроса внимания пользователя, например, путем мигания строки заголовка (зависит от ОС).", "WindowRequestAttention");

AddNumberParam("Макс ширина", "Максимальная ширина окна для установки в пикселях.");
AddNumberParam("Макс высота", "Максимальная высота окна для установки в пикселях.");
AddAction(22, af_none, "Установить макс размер", "Окно", "Установить максимальный размер окна <i>{0}</i> x <i>{1}</i>", "Установите максимальный размер окна.", "WindowSetMaxSize");

AddNumberParam("Мин ширина", "Минимальная ширина окна для установки в пикселях.");
AddNumberParam("Мин высота", "Минимальная высота окна для установки в пикселях.");
AddAction(23, af_none, "Установить мин размер", "Окно", "Установить минимальный размер окна <i>{0}</i> x <i>{1}</i>", "Задайте минимальный размер окна.", "WindowSetMinSize");

AddComboParamOption("неизменяемый размер");
AddComboParamOption("изменяемый размер");
AddComboParam("Режим", "Включение или отключение изменения размера в окне.");
AddAction(24, af_none, "Задать изменяемый размер", "Окно", "Установить окно {0}", "Включение или отключение изменения размера элементов управления в окне.", "WindowSetResizable");

AddComboParamOption("не всегда сверху");
AddComboParamOption("всегда сверху");
AddComboParam("Режим", "Включение или отключение окна всегда наверх.");
AddAction(25, af_none, "Установить всегда сверху", "Окно", "Установить окно {0}", "Включение или отключение окна всегда поверх других окон.", "WindowSetAlwaysOnTop");

AddAction(26, af_none, "Показать средства разработки", "Окно", "Показать средства разработки", "Отображение средств веб-разработчика, например для отладки JavaScript или проверки сообщений консоли.", "ShowDevTools");

AddStringParam("Текст", "Введите текст для копирования в буфер обмена.");
AddAction(27, af_none, "Задать текст буфера обмена", "Буфер обмена", "Задать текст в буфере обмена <i>{0}</i>", "Скопируйте текст в буфер обмена.", "SetClipboardText");

AddAction(28, af_none, "Очистить буфер обмена", "Буфер обмена", "Очистить буфер обмена", "Очистите буфер обмена, чтобы ничего не было скопировано.", "ClearClipboard");

AddStringParam("URL", "Веб-адрес, открываемый в браузере.");
AddAction(29, af_none, "Открыть браузер", "Файловая система", "Открыть браузер для URL-адреса <i>{0}</i>", "Откройте браузер по умолчанию для заданного URL-адреса.", "OpenBrowser");

////////////////////////////////////////
// Expressions

// AddExpression(id,			// any positive integer to uniquely identify this expression
//				 flags,			// (see docs) ef_none, ef_deprecated, ef_return_number, ef_return_string,
//								// ef_return_any, ef_variadic_parameters (one return flag must be specified)
//				 list_name,		// currently ignored, but set as if appeared in event wizard
//				 category,		// category in expressions panel
//				 exp_name,		// the expression name after the dot, e.g. "foo" for "myobject.foo" - also the runtime function name
//				 description);	// description in expressions panel

AddExpression(0, ef_return_string, "", "File system", "AppFolder", "Return the application's folder. Note it may not have write permission.");
AddExpression(1, ef_return_string, "", "File system", "UserFolder", "Return the current user's folder.");

AddStringParam("Path", "The file path to load.");
AddExpression(2, ef_return_string, "", "File system", "ReadFile", "Return the text content of a file on disk.");

AddStringParam("Path", "The file path to get the size of.");
AddExpression(3, ef_return_number, "", "File system", "FileSize", "Return the size of a file on disk, in bytes.");

AddExpression(4, ef_return_number, "", "File system", "ListCount", "Return the number of files after 'List files'.");

AddNumberParam("Index", "Zero-based index of file to retrieve.");
AddExpression(5, ef_return_string, "", "File system", "ListAt", "Return the filename at an index after 'List files'.");

AddExpression(6, ef_return_string, "", "File system", "DroppedFile", "Return the filename of a file dropped in to the window.");

AddExpression(7, ef_return_string, "", "File dialogs", "ChosenPath", "Return the chosen path after a file dialog.");

AddExpression(8, ef_return_number, "", "Window", "WindowX", "The X position of the window on the screen.");
AddExpression(9, ef_return_number, "", "Window", "WindowY", "The Y position of the window on the screen.");
AddExpression(10, ef_return_number, "", "Window", "WindowWidth", "The width of the UI window in the operating system.");
AddExpression(11, ef_return_number, "", "Window", "WindowHeight", "The height of the UI window in the operating system.");
AddExpression(12, ef_return_string, "", "Window", "WindowTitle", "The current window title bar text.");

AddExpression(13, ef_return_string, "", "Clipboard", "ClipboardText", "The current text copied to the clipboard, if any.");

////////////////////////////////////////
ACESDone();

////////////////////////////////////////
// Array of property grid properties for this plugin
// new cr.Property(ept_integer,		name,	initial_value,	description)		// an integer value
// new cr.Property(ept_float,		name,	initial_value,	description)		// a float value
// new cr.Property(ept_text,		name,	initial_value,	description)		// a string
// new cr.Property(ept_color,		name,	initial_value,	description)		// a color dropdown
// new cr.Property(ept_font,		name,	"Arial,-16", 	description)		// a font with the given face name and size
// new cr.Property(ept_combo,		name,	"Item 1",		description, "Item 1|Item 2|Item 3")	// a dropdown list (initial_value is string of initially selected item)
// new cr.Property(ept_link,		name,	link_text,		description, "firstonly")		// has no associated value; simply calls "OnPropertyChanged" on click

var property_list = [
	];
	
// Called by IDE when a new object type is to be created
function CreateIDEObjectType()
{
	return new IDEObjectType();
}

// Class representing an object type in the IDE
function IDEObjectType()
{
	assert2(this instanceof arguments.callee, "Constructor called as a function");
}

// Called by IDE when a new object instance of this type is to be created
IDEObjectType.prototype.CreateInstance = function(instance)
{
	return new IDEInstance(instance);
}

// Class representing an individual instance of an object in the IDE
function IDEInstance(instance, type)
{
	assert2(this instanceof arguments.callee, "Constructor called as a function");
	
	// Save the constructor parameters
	this.instance = instance;
	this.type = type;
	
	// Set the default property values from the property table
	this.properties = {};
	
	for (var i = 0; i < property_list.length; i++)
		this.properties[property_list[i].name] = property_list[i].initial_value;
		
	// Plugin-specific variables
	// this.myValue = 0...
}

// Called when inserted via Insert Object Dialog for the first time
IDEInstance.prototype.OnInserted = function()
{
}

// Called when double clicked in layout
IDEInstance.prototype.OnDoubleClicked = function()
{
}

// Called after a property has been changed in the properties bar
IDEInstance.prototype.OnPropertyChanged = function(property_name)
{
}

// For rendered objects to load fonts or textures
IDEInstance.prototype.OnRendererInit = function(renderer)
{
}

// Called to draw self in the editor if a layout object
IDEInstance.prototype.Draw = function(renderer)
{
}

// For rendered objects to release fonts or textures
IDEInstance.prototype.OnRendererReleased = function(renderer)
{
}