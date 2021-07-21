function GetPluginSettings()
{
	return {
		"name":	"Локальное хранение данных",
		"id": "LocalStorage",
		"version":		"1.0",
		"description": "Хранить данные локально на устройстве пользователя.",
		"author": "Scirra",
		"help url": "https://www.scirra.com/manual/188/local-storage",
		"category": "Хранилище данных",
		"type": "object",
		"rotatable": false,
		"flags": pf_singleglobal
	};
}

//////////////
// Conditions
AddStringParam("Ключ", "Введите имя ключа, чтобы проверить его установку.");
AddCondition(0, cf_trigger, "Набор позиций", "Предметы", "Набор <i>{0}</i> позиций", "Срабатывает после 'Установить элемент', когда элемент был записан в локальное хранилище.", "OnItemSet");

AddStringParam("Ключ", "Введите имя ключа, чтобы проверить его на чтение.");
AddCondition(1, cf_trigger, "Элемент получен", "Предметы", "Элемент <i>{0}</i> получен", "Срабатывает после 'Получить элемент', когда значение элемента доступно.", "OnItemGet");

AddStringParam("Ключ", "Введите имя ключа, чтобы проверить его удаление.");
AddCondition(2, cf_trigger, "Элемент удален", "Предметы", "Элемент <i>{0}</i> удален", "Срабатывает после 'Удалить элемент', после того как элемент был удален из локального хранилища.", "OnItemRemoved");

AddCondition(3, cf_trigger, "Хранение очищено", "Локальное хранилище", "Хранение очищено", "Срабатывает после 'Очистить хранилище', когда локальное хранилище закончило очищаться.", "OnCleared");

AddCondition(4, cf_trigger, "Все ключевые имена загружены", "Локальное хранилище", "Все ключевые имена загружены", "Срабатывает после «Получить все имена ключей», когда список имен ключей готов.", "OnAllKeyNamesLoaded");

AddCondition(5, cf_trigger, "При ошибке", "Локальное хранилище", "При ошибке", "Запущена, если произошла ошибка при доступе к локальному хранилищу.", "OnError");

AddCondition(6, cf_trigger, "На любом установленном объекте", "Предметы", "На любом установленном объекте", "Срабатывает после любого действия 'Установить элемент', когда элемент был записан в локальное хранилище.", "OnAnyItemSet");

AddCondition(7, cf_trigger, "Любой элемент получен", "Предметы", "Любой элемент получен", "Срабатывает после любого действия 'Получить элемент', когда доступно значение элемента.", "OnAnyItemGet");

AddCondition(8, cf_trigger, "Любой элемент удален", "Предметы", "Любой элемент удален", "Срабатывает после любого действия 'Удалить элемент' после удаления элемента из локального хранилища.", "OnAnyItemRemoved");

AddStringParam("Ключ", "Введите имя ключа, чтобы проверить, существует ли он.");
AddCondition(9, cf_trigger, "Элемент существует", "Предметы", "Элемент <i>{0}</i> существует", "Срабатывает после того, как 'Проверить существующий элемент', если данный элемент существует в хранилище.", "OnItemExists");

AddStringParam("Ключ", "Введите имя ключа, чтобы проверить его отсутствие.");
AddCondition(10, cf_trigger, "Элемент отсутствует", "Предметы", "Элемент <i>{0}</i> отсутствует", "Срабатывает после 'Проверить существующий элемент', если данный элемент не существует в хранилище.", "OnItemMissing");

AddCmpParam("Сравнение", "Как сравнить текущий ключ.");
AddStringParam("Строка", "Строка для сравнения текущего ключа с.");
AddCondition(11, cf_none, "Сравнить ключ", "Локальное хранилище", "Ключ {0} {1}", "Сравните текущее имя ключа в триггере.", "CompareKey");

AddCmpParam("Сравнение", "Как сравнить текущее значение.");
AddAnyTypeParam("Значение", "Строка или число для сравнения текущего значения с.", "\"\"");
AddCondition(12, cf_none, "Сравнить значение", "Локальное хранилище", "Значение {0} {1}", "Сравните текущее значение элемента в триггере.", "CompareValue");

AddCondition(13, cf_none, "Если устанавливают элемент", "Прогресс", "Если устанавливают элемент", "Правда, если в настоящий момент обрабатываются какие-либо действия 'Установить элемент'.", "IsProcessingSets");

AddCondition(14, cf_none, "Если получает элемент", "Прогресс", "Если получает элемент", "Правда, если в настоящий момент обрабатываются какие-либо действия 'Получить элемент'.", "IsProcessingGets");

AddCondition(15, cf_trigger, "Все комплекты завершены", "Прогресс", "Все комплекты завершены", "Срабатывает после того, как завершены все текущие действия 'Установить элемент'.", "OnAllSetsComplete");

AddCondition(16, cf_trigger, "Всё элементы получены", "Прогресс", "Всё элементы получены", "Срабатывает после того, как все текущие действия 'Получить элемент' завершены.", "OnAllGetsComplete");

//////////////
// Actions
AddStringParam("Ключ", "Введите имя ключа, чтобы связать это значение с.");
AddAnyTypeParam("Значение", "Введите значение для сохранения.", "\"\"");
AddAction(0, af_none, "Указать элемент", "Предметы", "Указать элемент <i>{0}</i> к {1}", "Сохраняйте значение в локальном хранилище и запускайте 'Набор позиции' когда это будет сделано.", "SetItem");

AddStringParam("Ключ", "Введите имя ключа, чтобы получить значение. 'При загрузке элемента' будет срабатывать, когда значение будет готово.");
AddAction(1, af_none, "Получить элемент", "Предметы", "Получить элемент <i>{0}</i>", "Прочитайте значение из локального хранилища и активируйте 'Элемент получен', когда будете готовы.", "GetItem");

AddStringParam("Ключ", "Введите имя ключа для удаления. 'Элемент удален' будет срабатывать при завершении.");
AddAction(2, af_none, "Удалить элемент", "Предметы", "Удалить элемент <i>{0}</i>", "Удалите элемент из локального хранилища и нажмите 'Элемент удален' после завершения..", "RemoveItem");

AddAction(3, af_none, "Очистить хранилище", "Локальное хранилище", "Очистить хранилище", "Удалите все элементы из локального хранилища и нажмите 'Хранение очищено', когда это будет сделано.", "ClearStorage");

AddAction(4, af_none, "Получить все ключевые имена", "Локальное хранилище", "Получить все ключевые имена", "Запросите список всех имен ключей в локальном хранилище и триггер 'Все ключевые имена загружены', когда будете готовы.", "GetAllKeyNames");

AddStringParam("Ключ", "Введите имя ключа, чтобы проверить, существует ли он.");
AddAction(5, af_none, "Проверить элемент", "Предметы", "Элемент <i>{0}</i> существует", "Проверьте, существует ли элемент в локальном хранилище, вызывая 'Элемент существует' или 'Элемент отсутствует'.", "CheckItemExists");

//////////////
// Expressions
AddExpression(0, ef_return_any, "", "Items", "ItemValue", "In 'On item get', the item value retrieved.");

AddExpression(1, ef_return_string, "", "Items", "Key", "The current key name in a storage trigger.");

AddExpression(2, ef_return_number, "", "Local storage", "KeyCount", "After 'On all key names loaded', the key count.");

AddNumberParam("Index", "Zero-based index");
AddExpression(3, ef_return_string, "", "Local storage", "KeyAt", "After 'On all key names loaded', the key name at an index.");

AddExpression(4, ef_return_string, "", "Local storage", "ErrorMessage", "In 'On error', an error message if any available.");

/*
AddStringParam("Key", "Key name", "\"\"");
AddExpression(0,ef_return_string,"Get local value","Local","LocalValue","Get the value from a key in local storage.");

AddStringParam("Key", "Key name", "\"\"");
AddExpression(1,ef_return_string,"Get session value","Session","SessionValue","Get the value from a key in session storage.");

AddExpression(2,ef_return_number,"Get number of local values","Local","LocalCount","Get the number of keys in local storage.");
AddExpression(3,ef_return_number,"Get number of session values","Session","SessionCount","Get the number of keys in session storage.");

AddNumberParam("Index", "Index", "0");
AddExpression(4,ef_return_string,"Get Nth local value", "Local", "LocalAt", "Get the value stored in the Nth local key.");

AddNumberParam("Index", "Index", "0");
AddExpression(5,ef_return_string,"Get Nth session value", "Session", "SessionAt", "Get the value stored in the Nth session key.");

AddNumberParam("Index", "Index", "0");
AddExpression(6,ef_return_string,"Get Nth local key name", "Local", "LocalKeyAt", "Get the Nth local key's name.");

AddNumberParam("Index", "Index", "0");
AddExpression(7,ef_return_string,"Get Nth session key name", "Session", "SessionKeyAt", "Get the Nth session key's name.");

AddExpression(8, ef_return_string, "Get as JSON", "Local", "AsJSON", "Return the contents of all local storage in JSON format.");
*/

ACESDone();

var property_list = [
];

function CreateIDEObjectType()
{
	return new IDEObjectType();
}

function IDEObjectType()
{
	assert2(this instanceof arguments.callee,"Constructor called as a function");
}

IDEObjectType.prototype.CreateInstance = function(instance)
{
	return new IDEInstance(instance, this);
}

function IDEInstance(instance, type)
{
	assert2(this instanceof arguments.callee,"Constructor called as a function");
	
	this.instance = instance;
	this.type = type;
	
	this.properties = {};
	
	for(property in property_list)
		this.properties[property.name] = property.initial_value;
}

IDEInstance.prototype.OnCreate = function()
{
}

IDEInstance.prototype.OnPropertyChanged = function(property_name)
{
}

IDEInstance.prototype.Draw = function(renderer)
{
}

IDEInstance.prototype.OnRendererReleased = function()
{
}