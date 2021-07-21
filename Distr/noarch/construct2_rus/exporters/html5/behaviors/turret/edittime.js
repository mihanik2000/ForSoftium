function GetBehaviorSettings()
{
	return {
		"name":			"Турель",			// as appears in 'add behavior' dialog, can be changed as long as "id" stays the same
		"id":			"Turret",			// this is used to identify this behavior and is saved to the project; never change it
		"version":		"1.0",				// (float in x.y format) Behavior version - C2 shows compatibility warnings based on this
		"description":	"Обнаружение объектов в диапазоне, вращающихся по отношению к ним и обжиг.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/152/turret",
		"category":		"Движении",		// Prefer to re-use existing categories, but you can set anything here
		"flags":		0					// uncomment lines to enable flags...
					//	| bf_onlyone		// can only be added once to an object, e.g. solid
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
							
AddCondition(0, cf_none, "Имеет цель", "", "{my} имеет цель", "Правда, если турель в настоящее время имеет цель стремиться.", "HasTarget");

AddCondition(1, cf_trigger, "При стрельбе", "", "{my} при стрельбе", "Срабатывает, когда турель может стрелять в своей мишени.", "OnShoot");

AddCondition(2, cf_trigger, "На целевом объекте", "", "{my} на целевом объекте", "Срабатывает на турели, найдя новую цель в пределах досягаемости.", "OnTargetAcquired");

////////////////////////////////////////
// Actions

// AddAction(id,				// any positive integer to uniquely identify this action
//			 flags,				// (see docs) af_none, af_deprecated
//			 list_name,			// appears in event wizard list
//			 category,			// category in event wizard list
//			 display_str,		// as appears in event sheet - use {0}, {1} for parameters and also <b></b>, <i></i>
//			 description,		// appears in event wizard dialog when selected
//			 script_name);		// corresponding runtime function name

AddObjectParam("Цель", "Выберите объект для башни, который должен быть специально предназначен, если в диапазоне.");
AddAction(0, af_none, "Получение целевого объекта", "", "{my} получение целевого объекта {0}", "Нацеливание на конкретный объект, если он находится в диапазоне.", "AcquireTarget");

AddObjectParam("Цель", "Выберите объект или семейство для башни, чтобы автоматически определить как целевые объекты.");
AddAction(1, af_none, "Добавить объект к цели", "", "Добавить {my} цель {0}", "Добавьте объект или семейство для автоматического назначения.", "AddTarget");

AddAction(2, af_none, "Очистить целевые объекты", "", "Очистить {my} цели", "Удалите все объекты для назначения автоматически.", "ClearTargets");

AddAction(3, af_none, "Неполучение цели", "", "Неполучение {my} цели", "Невозможно получить текущую целевую цель, чтобы можно было приобрести другой целевой объект.", "UnacquireTarget");

AddComboParamOption("отключен");
AddComboParamOption("включен");
AddComboParam("Состояние", "Выберите, следует ли включать или отключать поведение.");
AddAction(5, af_none, "Установить состояние", "Параметры", "Установить {my} {0}", "Включите или отключите поведение.", "SetEnabled");

AddNumberParam("Диапазон", "Диапазон для установки в пикселях.");
AddAction(6, af_none, "Задать диапазон", "Параметры", "Задать {my} диапазон <i>{0}</i>", "Установите диапазон револьверной головки.", "SetRange");

AddNumberParam("Коэффициент огня", "Частота огня, установленная в секундах.");
AddAction(7, af_none, "Установить частоту огня", "Параметры", "Установить {my} коэффициент огня <i>{0}</i>", "Установить скорость огня.", "SetRateOfFire");

AddComboParamOption("отключен");
AddComboParamOption("включен");
AddComboParam("Поворот", "Выберите, следует ли автоматически вращаться в целевые объекты.");
AddAction(8, af_none, "Задать авто-поворот", "Параметры", "Задать {my} поворот {0}", "Включение или отключение поворота в целевые объекты.", "SetRotate");

AddNumberParam("Скорость вращения", "Скорость вращения для установки в градусах в секунду.");
AddAction(9, af_none, "Задать скорость вращения", "Параметры", "Задать {my} повернуть скорость на <i>{0}</i>", "Задайте скорость вращения.", "SetRotateSpeed");

AddComboParamOption("Первый в диапазоне");
AddComboParamOption("ближайшего");
AddComboParam("Цель", "Выбор способа решения нескольких задач.");
AddAction(10, af_none, "Установить режим целения", "Параметры", "Установить {my} конечный режим <i>{0}</i>", "Задайте способ решения нескольких задач.", "SetTargetMode");

AddComboParamOption("отключен");
AddComboParamOption("включен");
AddComboParam("Прогнозируемая цель", "Выберите, следует ли использовать прогнозируемую цель.");
AddAction(11, af_none, "Установить прогнозируемую цель", "Параметры", "Установить {my} прогнозируемая цель {0}", "Установите, следует ли использовать прогнозируемую цель.", "SetPredictiveAim");

AddNumberParam("Скорость вращения", "Скорость вращения, установленная для прогнозируемой цели, в пикселях в секунду.");
AddAction(12, af_none, "Установка скорости вращения", "Параметры", "Установить {my} скорость вращения <i>{0}</i>", "Установите скорость вращения для прогнозируемой цели на работу.", "SetProjectileSpeed");

////////////////////////////////////////
// Expressions

// AddExpression(id,			// any positive integer to uniquely identify this expression
//				 flags,			// (see docs) ef_none, ef_deprecated, ef_return_number, ef_return_string,
//								// ef_return_any, ef_variadic_parameters (one return flag must be specified)
//				 list_name,		// currently ignored, but set as if appeared in event wizard
//				 category,		// category in expressions panel
//				 exp_name,		// the expression name after the dot, e.g. "foo" for "myobject.foo" - also the runtime function name
//				 description);	// description in expressions panel

AddExpression(0, ef_return_number, "", "", "TargetUID", "Get the unique ID (UID) of the current target object.");

AddExpression(1, ef_return_number, "", "", "Range", "Get the current range in pixels.");
AddExpression(2, ef_return_number, "", "", "RateOfFire", "Get the current rate of fire in seconds.");
AddExpression(3, ef_return_number, "", "", "RotateSpeed", "Get the current rotate speed in degrees per second.");

////////////////////////////////////////
ACESDone();

////////////////////////////////////////
// Array of property grid properties for this plugin
// new cr.Property(ept_integer,		name,	initial_value,	description)		// an integer value
// new cr.Property(ept_float,		name,	initial_value,	description)		// a float value
// new cr.Property(ept_text,		name,	initial_value,	description)		// a string
// new cr.Property(ept_combo,		name,	"Item 1",		description, "Item 1|Item 2|Item 3")	// a dropdown list (initial_value is string of initially selected item)

var property_list = [
	new cr.Property(ept_float, 	"Range",			300,		"Диапазон в пикселях револьверная головка может обнаруживать цели."),
	new cr.Property(ept_float, 	"Rate of fire",		1,			"Время стрельбы в секундах."),
	new cr.Property(ept_combo, 	"Rotate",			"Yes",		"Автоматический поворот в сторону цели.", "No|Yes"),
	new cr.Property(ept_float, 	"Rotate speed",		180,		"Скорость вращения в градусах в секунду, если 'Поворот' включен."),
	new cr.Property(ept_combo, 	"Target mode",		"First in range",	"Как бороться с несколькими целями.", "First in range|Nearest"),
	new cr.Property(ept_combo, 	"Predictive aim",	"No",		"Цель, где цели собираются, а не там, где они есть.", "No|Yes"),
	new cr.Property(ept_float, 	"Projectile speed",	500,		"Скорость снаряда для прогнозной цели работать в пикселях в секунду."),
	new cr.Property(ept_combo, "Initial state", "Enabled", "Следует ли изначально включить поведение или отключить.", "Disabled|Enabled"),
	new cr.Property(ept_combo, "Use collision cells", "Yes", "Как правило, повышает производительность, но может быть медленнее, с очень длинными диапазонами.", "No|Yes")
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
