function GetPluginSettings()
{
	return {
		"name":			"AJAX",
		"id":			"AJAX",
		"version":		"1.0",
		"description":	"Запрашивать и получать другие веб-страницы. Примечание междоменные запросы должны быть разрешены для запросов на работу в режиме предварительного просмотра (с локального хоста).",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/107/ajax",
		"category":		"Сеть",
		"type":			"object",			// not in layout
		"rotatable":	false,
		"flags":		pf_singleglobal
	};
};

//////////////////////////////////////////////////////////////
// Conditions
AddStringParam("Тег", "Тег, который может быть все что угодно, чтобы различать между различными запросами AJAX.", "\"\"");
AddCondition(0,	cf_trigger, "Завершён", "AJAX", "<b>{0}</b> завершён", "Срабатывает когда запрос AJAX завершается успешно.", "OnComplete");

AddStringParam("Тег", "Тег, который может быть все что угодно, чтобы различать между различными запросами AJAX.", "\"\"");
AddCondition(1,	cf_trigger, "В случае ошибки", "AJAX", "<b>{0}</b> ошибка", "Срабатывает когда запрос AJAX терпит неудачу.", "OnError");

AddStringParam("Тег", "Тег, который может быть все что угодно, чтобы различать между различными запросами AJAX.", "\"\"");
AddCondition(2,	cf_trigger, "Прогресс", "AJAX", "<b>{0}</b> прогресс", "Срабатывает когда запрос AJAX имеет обновление прогресса.", "OnProgress");

//////////////////////////////////////////////////////////////
// Actions
AddStringParam("Тег", "Тег, который может быть все что угодно, чтобы различать между различными запросами AJAX.", "\"\"");
AddStringParam("URL", "URL для запроса. Примечание: большинство браузеров предотвратят кросс-доменных запросов.", "\"http://\"");
AddAction(0, 0, "Запрос URL", "AJAX", "Запрос <b>{1}</b> (тег <i>{0}</i>)", "Запрос URL запросом GET и получить ответ сервера.", "Request");

AddStringParam("Тег", "Тег, который может быть все что угодно, чтобы различать между различными запросами AJAX.", "\"\"");
AddFileParam("Файл", "Выберите файл проекта для запроса.");
AddAction(1, 0, "Запрос файла проекта", "AJAX", "Запрос <b>{1}</b> (тег <i>{0}</i>)", "Запрос файла в проекте и извлечь его содержимое.", "RequestFile");

AddStringParam("Тег", "Тег, который может быть все что угодно, чтобы различать между различными запросами AJAX.", "\"\"");
AddStringParam("URL", "URL для отправки сообщений. Примечание: большинство браузеров предотвратят сообщения между доменами.", "\"http://\"");
AddStringParam("Данные", "Данные для размещения, в форме запроса строки. Обязательно URLEncode любые данные, введенные пользователем.");
AddStringParam("Метод", "Метод HTTP для использования, как правило, '\POST\'.", "\"POST\"");
AddAction(2, 0, "Опубликовать в URL", "AJAX", "Отправить <b>{2}</b> к URL-адресу <b>{1}</b> (метод <i>{3}</i>, тег <i>{0}</i>)", "Отправка данных с запросом на URL и получить ответ сервера.", "Post");

AddNumberParam("Тайм-аут", "Тайм-аут для AJAX запросов в секундах. Используйте -1 для отсутствия тайм-аута.");
AddAction(3, 0, "Установить тайм-аут", "AJAX", "Установить тайм-аут для <i>{0}</i> секунд", "Установите максимальное время до того, как запрос считается несостоявшимся.", "SetTimeout");

AddStringParam("Заголовок", "Имя заголовка HTTP для установки по запросу.");
AddStringParam("Значение", "Строка значения, чтобы установить заголовок.");
AddAction(4, 0, "Установить заголовок запроса", "AJAX", "Установить заголовок запроса <i>{0}</i> to <i>{1}</i>", "Установите HTTP заголовок на следующий запрос, который сделан.", "SetHeader");

AddStringParam("Тип MIME", "Тип MIME интерпретировать ответ как.");
AddAction(5, 0, "Перекрыть тип MIME", "AJAX", "Перекрыть тип MIME с <b>{0}</b>", "В следующем запросе, переопределить тип MIME, указанный в ответе.", "OverrideMIMEType");

//////////////////////////////////////////////////////////////
// Expressions
AddExpression(0, ef_return_string, "Get last data", "AJAX", "LastData", "Get the data returned by the last successful request.");
AddExpression(1, ef_return_number, "Get progress", "AJAX", "Progress", "Get the progress, from 0 to 1, of the request in 'On progress'.");

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
