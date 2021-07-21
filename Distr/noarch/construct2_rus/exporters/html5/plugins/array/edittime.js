function GetPluginSettings()
{
	return {
		"name":			"Массив",
		"id":			"Arr",
		"version":		"1.0",
		"description":	"Храните массив значений в срок до 3-х измерениях.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/108/array",
		"category":		"Хранилище данных",
		"type":			"object",			// not in layout
		"rotatable":	false,
		"flags":		0
	};
};

//////////////////////////////////////////////////////////////
// Conditions
AddNumberParam("X", "Индекс X (от 0) значения массива для сравнения.", "0");
AddCmpParam("Сравнение", "Как сравнить значение.");
AddAnyTypeParam("Значение", "Значение для сравнения значения массива в.", "0");
AddCondition(0,	0, "Сравните по X", "Массив", "Значение на <b>{0}</b> {1} <b>{2}</b>", "Сравните значение на позиции X (1D) в массиве.", "CompareX");

AddNumberParam("X", "Индекс X (от 0) значения массива для сравнения.", "0");
AddNumberParam("Y", "Индекс Y (от 0) значения массива для сравнения.", "0");
AddCmpParam("Сравнение", "Как сравнить значение.");
AddAnyTypeParam("Значение", "Значение для сравнения значения массива в.", "0");
AddCondition(1,	0, "Сравните по XY", "Массив", "Значение на (<b>{0}</b>, <b>{1}</b>) {2} <b>{3}</b>", "Сравните значение на X, Y положение (2D) в массиве.", "CompareXY");

AddNumberParam("X", "Индекс X (от 0) значения массива для сравнения.", "0");
AddNumberParam("Y", "Индекс Y (от 0) значения массива для сравнения.", "0");
AddNumberParam("Z", "Индекс Z (от 0) значения массива для сравнения.", "0");
AddCmpParam("Сравнение", "Как сравнить значение.");
AddAnyTypeParam("Значение", "Значение для сравнения значения массива в.", "0");
AddCondition(2,	0, "Сравните по XYZ", "Массив", "Значение на (<b>{0}</b>, <b>{1}</b>, <b>{2}</b>) {3} <b>{4}</b>", "Сравните значение на X, Y, Z положение (3D) в массиве.", "CompareXYZ");

AddComboParamOption("XYZ");
AddComboParamOption("XY");
AddComboParamOption("X");
AddComboParam("Оси", "Выберите, какие размеры итерировать. Например, если у вас есть 3D-массив, но вы хотите перебрать в 2D, выберите 'XY'.");
AddCondition(3, cf_looping, "Для каждого элемента", "Для каждого", "Для каждого {0} элемента", "Повторите это событие для каждого элемента в массиве.", "ArrForEach");

AddCmpParam("Сравнение", "Как сравнить текущее значение в наличии для каждого цикла.");
AddAnyTypeParam("Значение", "Значение для сравнения значения массива в.", "0");
AddCondition(4,	0, "Сравнить текущее значение", "Для каждого", "Текущая значение {0} <b>{1}</b>", "Сравните значение текущего элемента в наличии для каждого цикла.", "CompareCurrent");

AddAnyTypeParam("Значение", "Значение, чтобы проверить, если в массиве.", "0");
AddCondition(5,	0, "Содержит значение", "Массив", "Содержит значение {0}", "Проверьте, если массив содержит значение (на любом элементе).", "Contains");

AddCondition(6,	0, "Пусто", "Массив", "Пусто", "Тест, если массив пуст и не содержит элементов.", "IsEmpty");

AddComboParamOption("X");
AddComboParamOption("Y");
AddComboParamOption("Z");
AddComboParam("Ось", "Выберите ось для сравнения.");
AddCmpParam("Сравнение", "Как сравнить размер данной оси.");
AddNumberParam("Значение", "Значение, для сравнения.");
AddCondition(7, cf_none, "Сравнить размер", "Массив", "{0} размер {1} <b>{2}</b>", "Сравните размер одного из измерений массива.", "CompareSize");

//////////////////////////////////////////////////////////////
// Actions
AddAction(0, 0, "Очистить", "Массив", "Очистить", "Сбросить все значения к нулю.", "Clear");

AddNumberParam("Ширина", "Новое число элементов на оси X.", "1");
AddNumberParam("Высота", "Новое число элементов на оси Y.", "1");
AddNumberParam("Глубина", "Новое число элементов на оси Z.", "1");
AddAction(1, 0, "Установить размер", "Массив", "Установить размер для (<i>{0}</i>, <i>{1}</i>, <i>{2}</i>)", "Установите количество элементов на каждой оси массива.", "SetSize");

AddNumberParam("X", "Индекс X (от 0) значения массива для установки.", "0");
AddAnyTypeParam("Значение", "Значение для хранения в массиве.", "0");
AddAction(2, 0, "Установите на X", "Массив", "Установленное значение в <i>{0}</i> to <i>{1}</i>", "Установите значение на позиции X (1D) в массиве.", "SetX");

AddNumberParam("X", "Индекс X (от 0) значения массива для установки.", "0");
AddNumberParam("Y", "Индекс Y (от 0) значения массива для установки.", "0");
AddAnyTypeParam("Значение", "Значение для хранения в массиве.", "0");
AddAction(3, 0, "Установите на XY", "Массив", "Установленное значение в (<i>{0}</i>, <i>{1}</i>) to <i>{2}</i>", "Установите значение на X, Y позиции (2D) в массиве.", "SetXY");

AddNumberParam("X", "Индекс X (от 0) значения массива для установки.", "0");
AddNumberParam("Y", "Индекс Y (от 0) значения массива для установки.", "0");
AddNumberParam("Z", "Индекс Z (от 0) значения массива для установки.", "0");
AddAnyTypeParam("Значение", "Значение для хранения в массиве.", "0");
AddAction(4, 0, "Установить на XYZ", "Массив", "Установленное значение в (<i>{0}</i>, <i>{1}</i>, <i>{2}</i>) to <i>{3}</i>", "Установите значение на X, Y, Z положение (3D) в массиве.", "SetXYZ");

AddComboParamOption("назад");
AddComboParamOption("перед");
AddComboParam("Где", "Независимо от того, чтобы вставить в начале или в конце массива.");
AddAnyTypeParam("Значение", "Значение для вставки в массив.", "0");
AddComboParamOption("X");
AddComboParamOption("Y");
AddComboParamOption("Z");
AddComboParam("Ось", "Ось для вставки.");
AddAction(5, 0, "Нажим", "Манипуляция", "Нажим {0} <i>{1}</i> on {2} ось", "Добавить новый элемент в передней или задней оси.", "Push");

AddComboParamOption("назад");
AddComboParamOption("перед");
AddComboParam("Где", "Независимо от того, чтобы вставить в начале или в конце массива.");
AddComboParamOption("X");
AddComboParamOption("Y");
AddComboParamOption("Z");
AddComboParam("Ось", "Ось для вставки.");
AddAction(6, 0, "Поп", "Манипуляция", "Поп {0} на {1} ось", "Удалить элемент из передней или задней оси.", "Pop");

AddComboParamOption("X");
AddComboParamOption("Y");
AddComboParamOption("Z");
AddComboParam("Ось", "Ось для разворота.");
AddAction(7, 0, "Обратный", "Манипуляция", "Обратный {0} ось", "Обратный порядок элементов на оси.", "Reverse");

AddComboParamOption("X");
AddComboParamOption("Y");
AddComboParamOption("Z");
AddComboParam("Ось", "Ось для сортировки.");
AddAction(8, 0, "Сортировать", "Манипуляция", "Сортировать {0} ось", "Сортировка элементов по оси.", "Sort");

AddNumberParam("Индекс", "Индекс с нуля, чтобы удалить.");
AddComboParamOption("X");
AddComboParamOption("Y");
AddComboParamOption("Z");
AddComboParam("Ось", "Ось для удаления из.");
AddAction(9, 0, "Удалить", "Манипуляция", "Удалить индекс {0} из {1} ось", "Удалить элемент из оси.", "Delete");

AddAnyTypeParam("Значение", "Значение для вставки в массив.");
AddNumberParam("Индекс", "Индекс с нуля, чтобы удалить.");
AddComboParamOption("X");
AddComboParamOption("Y");
AddComboParamOption("Z");
AddComboParam("Ось", "Ось для вставки.");
AddAction(10, 0, "Вставить", "Манипуляция", "Вставить <i>{0}</i> по индексу <i>{1}</i> on {2} ось", "Вставьте новый элемент в индексе на оси.", "Insert");

AddStringParam("JSON", "Строка данных в формате JSON для загрузки.");
AddAction(11, 0, "Загрузите", "JSON", "Загрузка из строки JSON <i>{0}</i>", "Загрузите из массива, предварительно кодированные в формате JSON.", "JSONLoad");

AddStringParam("Имя файла", "Имя файла для загрузки.", "\"data.json\"");
AddAction(12, 0, "Скачать", "JSON", "Скачать как данные в формате JSON с именем файла <i>{0}</i>", "Загрузите содержимое массива в виде файла JSON.", "JSONDownload");

//////////////////////////////////////////////////////////////
// Expressions
AddNumberParam("X", "The X index (0-based) of the array value to get.", "0");
AddExpression(0, ef_return_any | ef_variadic_parameters, "Get value at", "Array", "At", "Get value from the array.  Add second or third parameters to specify Y and Z indices.");

AddExpression(1, ef_return_number, "Get width", "Array", "Width", "Get the number of elements on the X axis of the array.");
AddExpression(2, ef_return_number, "Get height", "Array", "Height", "Get the number of elements on the Y axis of the array.");
AddExpression(3, ef_return_number, "Get depth", "Array", "Depth", "Get the number of elements on the Z axis of the array.");

AddExpression(4, ef_return_number, "Current X", "For Each", "CurX", "Get the current X index in a For Each loop.");
AddExpression(5, ef_return_number, "Current Y", "For Each", "CurY", "Get the current Y index in a For Each loop.");
AddExpression(6, ef_return_number, "Current Z", "For Each", "CurZ", "Get the current Z index in a For Each loop.");
AddExpression(7, ef_return_any, "Current Value", "For Each", "CurValue", "Get the current value in a For Each loop.");

AddExpression(8, ef_return_any, "Front value", "Array", "Front", "Get the front value on the X axis (at 0, 0, 0).");
AddExpression(9, ef_return_any, "Back value", "Array", "Back", "Get the back value on the X axis (at w-1, 0, 0).");

AddAnyTypeParam("Value", "Value to search for.");
AddExpression(10, ef_return_number, "Index of", "Array", "IndexOf", "Find first X index of matching value, or -1 if not found.");

AddAnyTypeParam("Value", "Value to search for.");
AddExpression(11, ef_return_number, "Last index of", "Array", "LastIndexOf", "Find last X index of matching value, or -1 if not found.");

AddExpression(12, ef_return_string, "Get as JSON", "JSON", "AsJSON", "Return the contents of the array in JSON format.");

ACESDone();

// Property grid properties for this plugin
var property_list = [
		new cr.Property(ept_integer,		"Width",		10,			"Начальное количество элементов на оси X."),
		new cr.Property(ept_integer,		"Height",		1,			"Начальное количество элементов на оси Y."),
		new cr.Property(ept_integer,		"Depth",		1,			"Начальное количество элементов на оси Z."),
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
	if (this.properties["Width"] < 0)
		this.properties["Width"] = 0;
		
	if (this.properties["Height"] < 0)
		this.properties["Height"] = 0;
		
	if (this.properties["Depth"] < 0)
		this.properties["Depth"] = 0;
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
