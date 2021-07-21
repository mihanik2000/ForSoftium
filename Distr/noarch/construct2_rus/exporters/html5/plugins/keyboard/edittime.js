function GetPluginSettings()
{
	return {
		"name":			"Клавиатура",
		"id":			"Keyboard",
		"version":		"1.0",
		"description":	"Получить ввод с клавиатуры.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/113/keyboard",
		"category":		"Ввод",
		"type":			"object",			// not in layout
		"rotatable":	false,
		"flags":		pf_singleglobal
	};
};

//////////////////////////////////////////////////////////////
// Conditions
AddKeybParam("Клавиша", "Выберите клавишу. Обратите внимание, что международные пользователи и пользователи различных операционных систем или устройств не могут иметь одни и те же доступные клавиши.");
AddCondition(0, cf_trigger, "Клавиша нажата", "Клавиатура", "<b>{0}</b> нажата", "Срабатывает при нажатии клавиши клавиатуры.", "OnKey");

AddCondition(1, cf_trigger, "При любом нажатии клавиши", "Клавиатура", "При любом нажатии клавиши", "Срабатывает при нажатии любой клавиши клавиатуры.", "OnAnyKey");

AddCondition(7, cf_trigger, "На любой выпущенной клавиши.", "Клавиатура", "На любой выпущенной клавиши.", "Срабатывает, при любой отпускании клавиши.", "OnAnyKeyReleased");

AddKeybParam("Клавиша", "Выберите клавишу.  Обратите внимание, что международные пользователи и пользователи различных операционных систем или устройств не могут иметь одни и те же клавиши доступны.");
AddCondition(2,	0,	"Клавиша нажата",	"Клавиатура", "<b>{0}</b> нажата", "Проверьте, если клавиша клавиатуры в настоящее время в нажатом положении.", "IsKeyDown");

AddKeybParam("Клавиша", "Выберите клавишу. Обратите внимание, что международные пользователи и пользователи различных операционных систем или устройств не могут иметь одни и те же доступные клавиши.");
AddCondition(3,	cf_trigger,	"Выпущенная клавиша",	"Клавиатура", "<b>{0}</b> выпущенная", "Срабатывает при отпускании клавиши.", "OnKeyReleased");

AddNumberParam("Код клавиши ", "Выберите числовой код клавиши для проверки.");
AddCondition(4, cf_trigger, "Код клавиши нажата", "Коды клавиш", "Код клавиши <b>{0}</b> нажата", "Тест для нажатой клавиши её числовой код клавиши.", "OnKeyCode");

AddNumberParam("Код клавиши ", "Выберите числовой код клавиши для проверки.");
AddCondition(5,	0,	"Нажатый код клавиши",	"Коды клавиш", "Код клавиши <b>{0}</b> нажата", "Тест, если клавиша клавиатуры в настоящее время удерживали ее числовой код клавиши.", "IsKeyCodeDown");

AddNumberParam("Код клавиши ", "Выберите числовой код клавиши для проверки.");
AddCondition(6,	cf_trigger,	"Выпущенный код клавиши",	"Коды клавиш", "Код клавиши <b>{0}</b> выпущенная", "Тест для ключа выпущен ее числовой код клавиши.", "OnKeyCodeReleased");

//////////////////////////////////////////////////////////////
// Expressions
AddExpression(0, ef_return_number, "", "Key codes", "LastKeyCode", "Get the key code for the last pressed key.");

AddNumberParam("Key code", "The key code to get a string from");
AddExpression(1, ef_return_string, "", "Key codes", "StringFromKeyCode", "Get a character string representing a key code.");

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
