﻿function GetPluginSettings()
{
	return {
		"name":			"Словарь",			// as appears in 'insert object' dialog, can be changed as long as "id" stays the same
		"id":			"Dictionary",			// this is used to identify this plugin and is saved to the project; never change it
		"version":		"1.0",					// (float in x.y format) Plugin version - C2 shows compatibility warnings based on this
		"description":	"Хранить данные под названных ключей, например, установить ключ  в значение ... .",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/140/dictionary",
		"category":		"Хранилище данных",		// Prefer to re-use existing categories, but you can set anything here
		"type":			"object",				// either "world" (appears in layout and is drawn), else "object"
		"rotatable":	false,					// only used when "type" is "world".  Enables an angle property on the object.
		"flags":		0						// uncomment lines to enable flags...
					//	| pf_singleglobal		// exists project-wide, e.g. mouse, keyboard.  "type" must be "object".
					//	| pf_texture			// object has a single texture (e.g. tiled background)
					//	| pf_position_aces		// compare/set/get x, y...
					//	| pf_size_aces			// compare/set/get width, height...
					//	| pf_angle_aces			// compare/set/get angle (recommended that "rotatable" be set to true)
					//	| pf_appearance_aces	// compare/set/get visible, opacity...
					//	| pf_tiling				// adjusts image editor features to better suit tiled images (e.g. tiled background)
					//	| pf_animations			// enables the animations system.  See 'Sprite' for usage
					//	| pf_zorder_aces		// move to top, bottom, layer...
					//  | pf_nosize				// prevent resizing in the editor
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
							
AddStringParam("Ключ", "Имя ключа для проверки.");
AddCmpParam("Сравнение", "Как сравнить значение этого ключа.");
AddAnyTypeParam("Значение", "Значение, для сравнения.");
AddCondition(0, cf_none, "Сравнить значение", "Словарь", "Ключ <b>{0}</b> {1} <b>{2}</b>", "Сравните значение в качестве ключа.", "CompareValue");

AddCondition(1, cf_looping, "Для каждого ключа", "Для каждого", "Для каждого ключа", "Повторите это событие для каждой пары ключей / значениях, которое было сохранено.", "ForEachKey");

AddCmpParam("Сравнение", "Как сравнить значение текущего ключа в наличии для каждого цикла.");
AddAnyTypeParam("Значение", "Значение, для сравнения");
AddCondition(2, cf_none, "Сравнить текущее значение", "Для каждого", "Текущая значение {0} <b>{1}</b>", "Сравните значение в текущем ключе в наличии для каждого цикла.", "CompareCurrentValue");

AddStringParam("Ключ", "Название ключа, чтобы проверить, существует.");
AddCondition(3, cf_none, "Есть ключ", "Словарь", "Есть ключ <b>{0}</b>", "Проверьте, если имя ключа было сохранено.", "HasKey");

AddCondition(4, cf_none, "Пусто", "Словарь", "Пусто", "Правда, если ни одна клавиша не находятся в хранилище.", "IsEmpty");

////////////////////////////////////////
// Actions

// AddAction(id,				// any positive integer to uniquely identify this action
//			 flags,				// (see docs) af_none, af_deprecated
//			 list_name,			// appears in event wizard list
//			 category,			// category in event wizard list
//			 display_str,		// as appears in event sheet - use {0}, {1} for parameters and also <b></b>, <i></i>
//			 description,		// appears in event wizard dialog when selected
//			 script_name);		// corresponding runtime function name

AddStringParam("Ключ", "Имя ключа. Если он уже существует, то его значение будет перезаписана.");
AddAnyTypeParam("Значение", "Значение для хранения ключа.");
AddAction(0, af_none, "Добавить ключ", "Словарь", "Добавить ключ <i>{0}</i> со значением <i>{1}</i>", "Добавить новый ключ в хранении. Если он уже существует, то его значение будет перезаписана.", "AddKey");

AddStringParam("Ключ", "Имя ключа. Если он не существует, это не будет иметь никакого эффекта.");
AddAnyTypeParam("Значение", "Значение для хранения ключа.");
AddAction(1, af_none, "Установить ключ", "Словарь", "Установить ключ <i>{0}</i> со значением <i>{1}</i>", "Установить существующий ключ в хранении. Если он не существует, это не будет иметь никакого эффекта.", "SetKey");

AddStringParam("Ключ", "Название ключа для удаления.");
AddAction(2, af_none, "Удалить ключ", "Словарь", "Удалить ключ <i>{0}</i>", "Удалить ключ из хранилища.", "DeleteKey");

AddAction(3, af_none, "Очистить", "Словарь", "Очистить", "Удалить все ключи и значения из хранилища, возвращаясь к пустому.", "Clear");

AddStringParam("JSON", "Строка данных в формате JSON для загрузки.");
AddAction(4, 0, "Загрузить", "JSON", "Загрузка из строки JSON <i>{0}</i>", "Загрузить из словаря, предварительно кодированные в формате JSON.", "JSONLoad");

AddStringParam("Имя файла", "Имя файла для загрузки.", "\"data.json\"");
AddAction(5, 0, "Скачать", "JSON", "Скачать как данные в формате JSON с именем файла <i>{0}</i>", "Загрузить содержимое словаря в виде файла JSON.", "JSONDownload");

////////////////////////////////////////
// Expressions

// AddExpression(id,			// any positive integer to uniquely identify this expression
//				 flags,			// (see docs) ef_none, ef_deprecated, ef_return_number, ef_return_string,
//								// ef_return_any, ef_variadic_parameters (one return flag must be specified)
//				 list_name,		// currently ignored, but set as if appeared in event wizard
//				 category,		// category in expressions panel
//				 exp_name,		// the expression name after the dot, e.g. "foo" for "myobject.foo" - also the runtime function name
//				 description);	// description in expressions panel

AddStringParam("Key", "The name of the key to retrieve.");
AddExpression(0, ef_return_any, "Get", "Dictionary", "Get", "Get the value from a key.  0 is returned if it does not exist.");

AddExpression(1, ef_return_number, "KeyCount", "Dictionary", "KeyCount", "Get the number of keys in storage.");

AddExpression(2, ef_return_string, "CurrentKey", "For Each", "CurrentKey", "Get the current key name in a for-each loop.");
AddExpression(3, ef_return_any, "CurrentValue", "For Each", "CurrentValue", "Get the current key value in a for-each loop.");

AddExpression(4, ef_return_string, "Get as JSON", "JSON", "AsJSON", "Return the contents of the array in JSON format.");

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