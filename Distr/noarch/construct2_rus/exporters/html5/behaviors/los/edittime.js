function GetBehaviorSettings()
{
	return {
		"name":			"Поле зрения",		// as appears in 'add behavior' dialog, can be changed as long as "id" stays the same
		"id":			"LOS",					// this is used to identify this behavior and is saved to the project; never change it
		"version":		"1.0",					// (float in x.y format) Behavior version - C2 shows compatibility warnings based on this
		"description":	"Тест, если объект имеет прямой видимости (если он может видеть ) объект или позицию.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/163/line-of-sight",
		"category":		"Общее",				// Prefer to re-use existing categories, but you can set anything here
		"flags":		0						// uncomment lines to enable flags...
					//	| bf_onlyone			// can only be added once to an object, e.g. solid
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
// AddAudioFileParam(label, description)								// a dropdown list with all imported project audio files

////////////////////////////////////////
// Conditions

// AddCondition(id,					// any positive integer to uniquely identify this condition
//				flags,				// (see docs) cf_none, cf_trigger, cf_fake_trigger, cf_static, cf_not_invertible,
//									// cf_deprecated, cf_incompatible_with_triggers, cf_looping
//				list_name,			// appears in event wizard list
//				category,			// category in event wizard list
//				display_str,		// as appears in event sheet - use {0}, {1} for parameters and also <b></b>, <i></i>, and {my} for the current behavior icon & name
//				description,		// appears in event wizard dialog when selected
//				script_name);		// corresponding runtime function name
				
AddObjectParam("Объект", "Выберите объект для проверки, если покрывает лини. видимости.");
AddCondition(0, cf_static, "Имеет LOS к объекту", "", "Имеет {my} к {0}", "Проверьте, существует ли линия видимости для любого экземпляра типа объекта.", "HasLOSToObject");

AddNumberParam("X", "Координата X для проверки линейного визирования в точках.");
AddNumberParam("Y", "Координата Y для проверки линейного вида в пикселях.");
AddCondition(1, cf_none, "Имеет LOS к позиции", "", "Имеет {my} к (<i>{0}</i>, <i>{1}</i>)", "Проверьте, существует ли линия взгляда на позицию в макете.", "HasLOSToPosition");

////////////////////////////////////////
// Actions

// AddAction(id,				// any positive integer to uniquely identify this action
//			 flags,				// (see docs) af_none, af_deprecated
//			 list_name,			// appears in event wizard list
//			 category,			// category in event wizard list
//			 display_str,		// as appears in event sheet - use {0}, {1} for parameters and also <b></b>, <i></i>
//			 description,		// appears in event wizard dialog when selected
//			 script_name);		// corresponding runtime function name

AddNumberParam("Диапазон", "Новое максимальное расстояние в пикселах, которое может быть покрыто линией видимости.", "10000");
AddAction(0, af_none, "Задать диапазон", "", "Задать {my} диапазон к <i>{0}</i>", "Установите максимальный диапазон, который может быть покрыт линией видимости.", "SetRange");

AddNumberParam("Конус представления", "Новый диапазон углов в градусах относительно угла объекта, который может быть покрыт линией видимости.", "360");
AddAction(1, af_none, "Задать конус представления", "", "Задать {my} конус представления к <i>{0}</i>", "Задайте диапазон углов относительно угла объекта, который может прикрываться линией видимости.", "SetCone");

AddObjectParam("Препятствие", "Выберите объект, который требуется добавить в качестве препятствия, препятствующего линии видимости.");
AddAction(2, af_none, "Добавить препятствие", "", "Добавить {my} препятствие {0}", "Добавьте пользовательский объект как препятствие на пути к виду.", "AddObstacle");

AddAction(3, af_none, "Удалить препятствия", "", "Удалить {my} препятствия", "Удалите все добавленные объекты-препятствия.", "ClearObstacles");

////////////////////////////////////////
// Expressions

// AddExpression(id,			// any positive integer to uniquely identify this expression
//				 flags,			// (see docs) ef_none, ef_deprecated, ef_return_number, ef_return_string,
//								// ef_return_any, ef_variadic_parameters (one return flag must be specified)
//				 list_name,		// currently ignored, but set as if appeared in event wizard
//				 category,		// category in expressions panel
//				 exp_name,		// the expression name after the dot, e.g. "foo" for "myobject.foo" - also the runtime function name
//				 description);	// description in expressions panel

AddExpression(0, ef_return_number, "", "", "Range", "Return the current range in pixels that line-of-sight can cover.");
AddExpression(1, ef_return_number, "", "", "ConeOfView", "Return the current cone of view in degrees.");

////////////////////////////////////////
ACESDone();

////////////////////////////////////////
// Array of property grid properties for this plugin
// new cr.Property(ept_integer,		name,	initial_value,	description)		// an integer value
// new cr.Property(ept_float,		name,	initial_value,	description)		// a float value
// new cr.Property(ept_text,		name,	initial_value,	description)		// a string
// new cr.Property(ept_combo,		name,	"Item 1",		description, "Item 1|Item 2|Item 3")	// a dropdown list (initial_value is string of initially selected item)

var property_list = [
	new cr.Property(ept_combo, 	"Obstacles",		"Solids",		"Выберите твердые вещества которое препятствуют ПЗ или, если использовать пользовательские объекты, добавьте события.", "Solids|Custom"),
	new cr.Property(ept_float,	"Range",			10000,			"Максимальное расстояние в пикселях, что линия визирования может покрыть."),
	new cr.Property(ept_float,	"Cone of view",		360,			"Диапазон угла в градусах относительно угла объекта, который по линии прямой видимости может покрыть."),
	new cr.Property(ept_combo, "Use collision cells", "Yes", "Как правило, повышает производительность, но может быть медленнее на очень большие расстояния.", "No|Yes")
	];
	
// Called by IDE when a new behavior type is to be created
function CreateIDEBehaviorType()
{
	return new IDEBehaviorType();
}

// Class representing a behavior type in the IDE
function IDEBehaviorType()
{
	assert2(this instanceof arguments.callee, "Constructor called as a function");
}

// Called by IDE when a new behavior instance of this type is to be created
IDEBehaviorType.prototype.CreateInstance = function(instance)
{
	return new IDEInstance(instance, this);
}

// Class representing an individual instance of the behavior in the IDE
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
		
	// any other properties here, e.g...
	// this.myValue = 0;
}

// Called by the IDE after all initialization on this instance has been completed
IDEInstance.prototype.OnCreate = function()
{
}

// Called by the IDE after a property has been changed
IDEInstance.prototype.OnPropertyChanged = function(property_name)
{
}
