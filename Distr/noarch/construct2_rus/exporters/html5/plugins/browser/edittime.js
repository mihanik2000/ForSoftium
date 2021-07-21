function GetPluginSettings()
{
	return {
		"name":			"Браузер",
		"id":			"Browser",
		"version":		"1.0",
		"description":	"Доступ к браузеру, на котором выполняется приложение HTML5.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/110/browser",
		"category":		"Сеть",
		"type":			"object",			// not in layout
		"rotatable":	false,
		"cordova-plugins": "org.apache.cordova.inappbrowser",	// for window.open(..., "_system")
		"flags":		pf_singleglobal
	};
};

//////////////////////////////////////////////////////////////
// Conditions
AddCondition(0, 0, "Включен Cookies", "Браузер", "Cookies включены", "Браузер имеет активирован функция cookies.", "CookiesEnabled");
AddCondition(1, 0, "В сети", "Браузер", "В сети", "Браузер онлайн (т.е. не в автономном режиме просмотра).", "IsOnline");
AddCondition(2, cf_deprecated, "Java поддерживается", "Браузер", "Java поддерживается", "Браузер поддерживает Java.", "HasJava");

AddCondition(3, cf_trigger, "Онлайн", "Браузер", "Онлайн", "Срабатывает, когда пользователь находится вне сети и соединение становится доступным.", "OnOnline");
AddCondition(4, cf_trigger, "Не в сети", "Браузер", "Не в сети", "Срабатывает, когда пользователь находится в сети и соединение становится недоступным.", "OnOffline");

AddCondition(5, 0, "Скачивает обновления", "Не в сети кэша", "Скачивает обновления", "Правда, когда браузер запущен из кэша вне сети, но загрузки обновлений в фоновом режиме.", "IsDownloadingUpdate");
AddCondition(6, cf_trigger, "Обновление готова", "Не в сети кэша", "Обновление готова", "Срабатывает, когда обновление завершения загрузки. Вы можете подсказать пользователю, чтобы перезагрузить страницу.", "OnUpdateReady");

AddCondition(7, 0, "Страница видна", "Страница", "Страница видна", "Правда, если страница в настоящее время видны пользователю (например, в активной вкладке или мобильное приложение находится на переднем плане).", "PageVisible");
AddCondition(8, cf_trigger, "Возобновился", "Страница", "Возобновился", "Триггеры при возобновлении (переключается обратно на вкладку, восстановленное окно, мобильное приложение возвращается на передний план и т.д.)", "OnPageVisible");
AddCondition(9, cf_trigger, "Приостановленно", "Страница", "Приостановленно", "Триггеры При остановке (коммутируемой вкладку, свернутое окно, мобильное приложение подходит для фона и т.д.)", "OnPageHidden");

AddCondition(10, 0, "Полноэкранный", "Страница", "Полноэкранный", "Правда, если страница находится в полноэкранном режиме.", "IsFullscreen");

AddCondition(11, cf_trigger, "Кнопка меню", "Мобильный", "Кнопка меню нажата", "Триггеры при нажатии кнопки устройства 'Меню'. Обратите внимание, что не все устройства имеют кнопку 'Menu'.", "OnMenuButton");
AddCondition(12, cf_trigger, "Кнопка поиска", "Мобильный", "Кнопка меню поиска нажата", "Триггеры при нажатии кнопки устройства 'Поиск'. Обратите внимание, что не все устройства имеют кнопку 'Поиск'.", "OnSearchButton");

AddCondition(13, cf_deprecated, "Дозируется", "Подключение", "Подключение дозируется", "Правда, если соединение дозируется (например, с разовой платой за использование). Ложь, если нет, или если неизвестно.", "IsMetered");

AddCondition(14, 0, "Зарядки", "Батарея", "Батарея заряжается", "Ложь, если устройство работает от батарей и не подключен, в противном случае верно.", "IsCharging");

AddCondition(15, cf_trigger, "Измененный размер", "Браузер", "Измененный размер", "Срабатывает при текущем видовом экране браузера изменяется.", "OnResize");

AddComboParamOption("Портрет");
AddComboParamOption("Пейзаж");
AddComboParam("Ориентация", "Выберите ориентацию для тестирования.");
AddCondition(16, 0, "Является ли портрет / пейзаж", "Мобильный", "Является {0}", "Проверьте текущую ориентацию устройства.", "IsPortraitLandscape");

AddCondition(17, cf_trigger, "Кнопка назад", "Мобильный", "Мобильная кнопка назад нажата", "Триггеры при нажатии кнопки устройства 'Назад'. Обратите внимание, что не все устройства имеют кнопку 'Назад'.", "OnBackButton");

AddCondition(18, cf_none, "Поддерживает запрашивающий полноэкранном режиме", "Окно", "Поддерживает запрашивающий полноэкранном режиме", "Проверьте, если текущий браузер / платформа поддерживает полноэкранное действие.", "SupportsFullscreen");

//////////////////////////////////////////////////////////////
// Actions
AddAnyTypeParam("Сообщение", "Введите сообщение для отображения в боевой готовности.", "\"\"");
AddAction(0, 0,	"Тревога", "Окно", "Тревога {0}", "Всплывающие окно сообщения с сообщением и кнопкой OK.", "Alert");
AddAction(1, 0,	"Закрыть", "Окно", "Закрыть", "Закрыть текущее окно браузера или вкладку. Браузер может подсказать пользователю, чтобы подтвердить.", "Close");
AddAction(2, 0,	"Направление", "Окно", "Направление", "Направление текущего окна браузера или вкладку.", "Focus");
AddAction(3, 0,	"Размытие", "Окно", "Размытие", "Размытие (не сфокусировалось) текущее окно или вкладка браузера.", "Blur");

AddAction(4, 0,	"Возвращаться", "Навигация", "Возвращаться", "Переход к предыдущей странице в истории браузера.", "GoBack");
AddAction(5, 0,	"Идти вперед", "Навигация", "Идти вперед", "Перейти на следующую страницу в истории браузера.", "GoForward");
AddAction(6, 0,	"Идти домой", "Навигация", "Идти домой", "Перейти на главную страницу браузера.", "GoHome");

AddStringParam("URL", "Введите полный URL, чтобы перейти к.", "\"http://\"");
AddComboParamOption("сам");
AddComboParamOption("исходный");
AddComboParamOption("верх");
AddComboParam("Цель", "Какой кадр уровня для навигации. Влияет только при использовании кадров в веб-браузере.");
AddAction(7, 0,	"Перейти к URL", "Навигация", "Идти к {0} (цель <i>{1}</i>)", "Перейдите к URL-адресу.", "GoToURL");

AddStringParam("URL", "Введите полный URL, чтобы перейти к.", "\"http://\"");
AddStringParam("Тег", "Строка для идентификации этого окна. Вы можете повторно использовать существующее окно, многократно используя его тег.", "\"NewWindow\"");
AddAction(8, 0,	"Открыть URL в новом окне", "Навигация", "Идти к {0} в новом окне (<i>{1}</i>)", "Откройте новое окно и перейдите к URL-адресу.", "GoToURLWindow");

AddAction(9, 0, "Перезагружать", "Навигация", "Перезагружать", "Обновить текущую страницу. Также обновляется, если 'Обновление готова' событие вызвало.", "Reload");

AddComboParamOption("Сосредоточенный");
AddComboParamOption("Натяжкой (обрезать)");
AddComboParamOption("Натяжкой (внешний масштаб)");
AddComboParamOption("Натяжкой (Почтовый ящик рок)");
AddComboParamOption("Натяжкой (целое число, масштаб в стиле почтового)");
AddComboParamOption("Натяжкой (внутренний масштаб)");
AddComboParam("Режим", "Определите, как отображается игра видового экрана в зоне монитора.");
AddAction(10, 0, "Запрос на весь экран", "Окно", "Запрос на весь экран - {0}", "Запрос пользователю ввести полноэкранный режим. Как правило, это работает только в качестве триггера пользовательского ввода.", "RequestFullScreen");

AddAction(11, 0, "Отменить весь экран", "Окно", "Отменить весь экран", "Выход из полноэкранного режима.", "CancelFullScreen");

AddStringParam("Шаблон", "Разделенный запятыми строка со списком раз в миллисекундах, описывая картину колебаний и пауз.", "\"200,100,200\"");
AddAction(12, 0, "Вибрировать", "Устройство", "Вибрируйте с рисунком <i>{0}</i>", "Вибрируйте с заданным шаблоном, если устройство (например, телефон) поддерживает его.", "Vibrate");

AddStringParam("URL", "Данные URI, файл проекта, или любой адрес веб-сайта, чтобы вызвать в качестве загрузки.");
AddStringParam("Имя файла", "Имя файла, чтобы дать загруженный файл.");
AddAction(13, 0, "Призовите скачать", "Навигация", "Призовите загрузку <b>{0}</b> с именем файла <i>{1}</i>", "Запустите файл загрузки данных в URI, файл проекта или веб-адрес.", "InvokeDownload");

AddComboParamOption("Журнал");
AddComboParamOption("Предупредить");
AddComboParamOption("Ошибка");
AddComboParam("Тип", "Выберите тип сообщения для входа в консоль браузера.");
AddAnyTypeParam("Сообщение", "Введите текст сообщения для входа в консоль браузера.");
AddAction(14, 0, "Вход", "Консоль", "{0} в консоли: <i>{1}</i>", "Вход сообщения для консоли браузера, который может быть полезен для отладки.", "ConsoleLog");

AddStringParam("Имя группы", "Введите имя группы, чтобы добавить к консоли браузера.");
AddAction(15, 0, "Старт группы", "Консоль", "Запустите консоль группу <i>{0}</i>", "Начать группу сообщений в консоли браузера.", "ConsoleGroup");

AddAction(16, 0, "Конец группы", "Консоль", "Конец консоли группы", "Завершение группу сообщений в консоли браузера.", "ConsoleGroupEnd");

AddStringParam("Javascript", "Строка кода javascript для выполнения. Остерегайтесь вызывая уязвимости в системе безопасности это может привести к ошибкам, которые нарушают игру! Обратитесь к документации для получения дополнительной консультации. Везде, где это возможно, предпочитают использовать Construct 2 в Javascript SDK вместо этого.", "\"myFunction();\"");
AddAction(17, 0, "Выполнить Javascript", "Браузер", "Выполнение JavaScript <i>{0}</i>", "Выполнить строку JavaScript в браузере. Используйте с осторожностью!", "ExecJs");

AddComboParamOption("портрет");
AddComboParamOption("пейзаж");
AddComboParamOption("первичный портрет");
AddComboParamOption("вторичный портрет");
AddComboParamOption("первичный пейзаж");
AddComboParamOption("вторичный пейзаж");
AddComboParam("Ориентация", "Ориентация для блокировки устройства в положение. Это может занять только эффект, если уже в полноэкранном режиме.");
AddAction(18, 0, "Блокировка ориентации", "Окно", "Блокировка ориентации <b>{0}</b>", "Предотвратить ориентацию изменения устройства.", "LockOrientation");

AddAction(19, 0, "Разблокировка ориентации", "Окно", "Разблокировка ориентации", "Восстановить ориентацию нормального устройства после блокировки.", "UnlockOrientation");

AddStringParam("Строка", "Строка данных для загрузки в виде файла, например, JSON данные из выражения AsJSON.");
AddStringParam("Тип MIME", "MIME тип приведенных данных.", "\"application/json\"");
AddStringParam("Имя файла", "Имя файла, чтобы дать загруженный файл.", "\"mydata.json\"");
AddAction(20, 0, "Призовите загрузку строки", "Навигация", "Призовите загрузку строки <b>{0}</b> с MIME-типа <i>{1}</i> и имя файла <i>{2}</i>", "Начать загрузку файла данных, приведенных в строке, например, В формате JSON.", "InvokeDownloadString");

//////////////////////////////////////////////////////////////
// Expressions
//AddExpression(3, ef_return_number, "Absolute mouse Y", "Cursor", "AbsoluteY", "Get the mouse cursor Y co-ordinate on the canvas.");
AddExpression(0, ef_return_string, "Get current URL", "Navigation", "URL", "Get the current browser URL.");
AddExpression(1, ef_return_string, "Get protocol", "Navigation", "Protocol", "Get the current protocol, e.g. http:.");
AddExpression(2, ef_return_string, "Get domain", "Navigation", "Domain", "Get the current domain, e.g. scirra.com.");
AddExpression(3, ef_return_string, "Get path name", "Navigation", "PathName", "Get the path relative to domain.");
AddExpression(4, ef_return_string, "Get hash", "Navigation", "Hash", "Get the hash from the URL, e.g. #myAnchor.");
AddExpression(5, ef_return_string, "Get referrer", "Navigation", "Referrer", "Get the referrer (the page that linked to this page).");

AddExpression(6, ef_return_string, "Get title", "Document", "Title", "Get the page title.");

AddExpression(7, ef_return_string, "Get name", "Browser", "Name", "Get the browser application name.");
AddExpression(8, ef_return_string, "Get version", "Browser", "Version", "Get the browser application version.");
AddExpression(9, ef_return_string, "Get language", "Browser", "Language", "Get the browser language.");
AddExpression(10, ef_return_string, "Get platform", "Browser", "Platform", "Get the browser platform (e.g. Windows, Mac).");
AddExpression(11, ef_return_string, "Get product", "Browser", "Product", "Get the browser product name (e.g. Gecko).");
AddExpression(12, ef_return_string, "Get vendor", "Browser", "Vendor", "Get the browser vendor.");
AddExpression(13, ef_return_string, "Get user agent", "Browser", "UserAgent", "Get the full browser user agent string.");

AddExpression(14, ef_return_string, "Get query string", "Navigation", "QueryString", "Get the full query string, including the ?.");

AddStringParam("name", "Query string parameter name.");
AddExpression(15, ef_return_string, "Get query string parameter", "Navigation", "QueryParam", "Get a query string parameter by name.");

AddExpression(16, ef_return_number, "Estimated bandwidth", "Connection", "Bandwidth", "Estimated connection bandwidth in megabits/s if known (infinity if unknown).");

AddExpression(17, ef_return_number, "Battery level", "Battery", "BatteryLevel", "Get battery charge level from 0 to 1, or 1 if unknown.");
AddExpression(18, ef_return_number, "Battery discharge time", "Battery", "BatteryTimeLeft", "Get the time left in seconds before battery is fully discharged, if not charging.");

AddStringParam("Javascript", "A string of Javascript code to execute.");
AddExpression(19, ef_return_any, "", "Browser", "ExecJS", "Execute a string of javascript code and return a string or number. Wherever possible, prefer to use Construct 2's Javascript SDK instead.");

AddExpression(20, ef_return_number, "", "Display", "ScreenWidth", "Get the width of the user's entire screen in pixels.");
AddExpression(21, ef_return_number, "", "Display", "ScreenHeight", "Get the height of the user's entire screen in pixels.");

AddExpression(22, ef_return_number, "", "Display", "DevicePixelRatio", "The display pixels per CSS pixel.");

AddExpression(23, ef_return_string, "", "Connection", "ConnectionType", "Type of connection in use if known e.g. \"wifi\" or \"cellular\".");

AddExpression(24, ef_return_number, "", "Display", "WindowInnerWidth", "Get the width of the window client area in pixels.");
AddExpression(25, ef_return_number, "", "Display", "WindowInnerHeight", "Get the height of the window client area in pixels.");
AddExpression(26, ef_return_number, "", "Display", "WindowOuterWidth", "Get the width of the window outer area in pixels.");
AddExpression(27, ef_return_number, "", "Display", "WindowOuterHeight", "Get the height of the window outer area in pixels.");

ACESDone();

// Property grid properties for this plugin
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
	return new IDEInstance(instance, this);
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
}

// Called by the IDE after all initialization on this instance has been completed
IDEInstance.prototype.OnCreate = function()
{
}

// Called by the IDE after a property has been changed
IDEInstance.prototype.OnPropertyChanged = function(property_name)
{
}
	
// Called by the IDE to draw this instance in the editor
IDEInstance.prototype.Draw = function(renderer)
{
}

// Called by the IDE when the renderer has been released (ie. editor closed)
// All handles to renderer-created resources (fonts, textures etc) must be dropped.
// Don't worry about releasing them - the renderer will free them - just null out references.
IDEInstance.prototype.OnRendererReleased = function()
{
}
