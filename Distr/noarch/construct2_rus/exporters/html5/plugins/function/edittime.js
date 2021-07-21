function GetPluginSettings()
{
	return {
		"name":			"Функция",
		"id":			"Function",
		"version":		"1.0",
		"description":	"Запуск других событий в действии, как функции в языках программирования.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/149/function",
		"category":		"Общее",
		"type":			"object",			// not in layout
		"rotatable":	false,
		"flags":		pf_singleglobal
	};
};

//////////////////////////////////////////////////////////////
// Conditions
AddStringParam("Имя", "Имя функции, которая вызывается.", "\"\"");
AddCondition(0,	cf_trigger | cf_fast_trigger, "Функция", "Функция", "<b>{0}</b>", "Срабатывает, когда функция вызывается.", "OnFunction");

AddNumberParam("Индекс", "Индекс параметра для сравнения.");
AddCmpParam("Сравнение", "Как сравнить параметр функции.");
AddAnyTypeParam("Значение", "Значение, для сравнения.");
AddCondition(1, cf_none, "Сравните параметр", "Функция", "Параметр {0} {1} {2}", "Сравните значение параметра при вызове функции.", "CompareParam");

//////////////////////////////////////////////////////////////
// Actions
AddFunctionNameParam("Имя", "Имя функции для вызова.", "\"\"");
AddVariadicParams("Параметр {n}", "Параметр для передачи для вызова функции, которые могут быть доступны с функцией.Param({n}).");
AddAction(0, 0, "Вызов функции", "Функция", "Вызов <b>{0}</b> (<i>{...}</i>)", "Вызов функции, запустив его 'Функция' событие.", "CallFunction");

AddAnyTypeParam("Значение", "Число или какой-либо текст, чтобы вернуться из вызова функции.");
AddAction(1, 0, "Установить возвращаемое значение", "Функция", "Установленное значение возврата к <b>{0}</b>", "В 'Функция' события, установите возвращаемое значение.", "SetReturnValue");

AddAnyTypeParam("Выражение", "Выражение для запуска, как правило, в виде функции.Call(\"func\", ...)");
AddAction(2, 0, "Вызов выражения", "Функция", "Вызов выражения <b>{0}</b>", "Вызов функции с помощью типизированных выражений (через Function.call ()).", "CallExpression");

//////////////////////////////////////////////////////////////
// Expressions
AddExpression(0, ef_return_any, "", "Function", "ReturnValue", "Get the value set by 'Set return value'.");

AddExpression(1, ef_return_number, "", "Function", "ParamCount", "Get the number of parameters passed to this function.");

AddNumberParam("Index", "The zero-based index of the parameter to get.");
AddExpression(2, ef_return_any, "", "Function", "Param", "Get the value of a parameter passed to the function.");

AddStringParam("Name", "The name of the function to call.");
AddExpression(3, ef_return_any | ef_variadic_parameters, "", "Function", "Call", "Call a function with parameters and return its return value.");

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
