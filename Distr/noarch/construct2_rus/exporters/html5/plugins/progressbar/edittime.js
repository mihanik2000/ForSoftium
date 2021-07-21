function GetPluginSettings()
{
	return {
		"name":			"Индикатор",
		"id":			"progressbar",
		"version":		"1.0",
		"description":	"Браузер в стиле прогресс-бар, чтобы показать объем выполнения задачи.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/180/progress-bar",
		"category":		"Элементы управления форм",
		"type":			"world",			// appears in layout
		"rotatable":	false,
		"flags":		pf_position_aces | pf_size_aces
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
				
AddCondition(0, cf_trigger, "Нажал", "Индикатор", "Нажал", "Срабатывает, когда индикатор нажат.", "OnClicked");

AddCmpParam("Сравнение", "Как сравнить текущий индикатор.");
AddNumberParam("Значение", "Значение индикатора, для сравнения.");
AddCondition(1, cf_none, "Сравнить индикатор", "Индикатор", "Индикатор {0} <i>{1}</i>", "Сравните текущее значение индикатора.", "CompareProgress");

////////////////////////////////////////
// Actions

// AddAction(id,				// any positive integer to uniquely identify this action
//			 flags,				// (see docs) af_none, af_deprecated
//			 list_name,			// appears in event wizard list
//			 category,			// category in event wizard list
//			 display_str,		// as appears in event sheet - use {0}, {1} for parameters and also <b></b>, <i></i>
//			 description,		// appears in event wizard dialog when selected
//			 script_name);		// corresponding runtime function name

AddStringParam("Подсказка", "Подсказка для установки на индикаторе выполнения.");
AddAction(0, af_none, "Установить подсказку", "Индикатор", "Установить подсказку {0}", "Установите на индикатор всплывающую подсказку.", "SetTooltip");

AddComboParamOption("Невидимый");
AddComboParamOption("Видимый");
AddComboParam("Видимость", "Выберите, нужно ли, чтобы скрыть или отобразить индикатор выполнения.");
AddAction(1, af_none, "Установить видимость", "Внешность", "Установить <b>{0}</b>", "Скрыть или показать индикатор.", "SetVisible");

AddStringParam("Имя свойства", "Имя свойства CSS для установки на элементе управления.", "\"цвет\"");
AddStringParam("Значение", "Строка для назначения в качестве значения для этого CSS свойства.", "\"красный\"");
AddAction(2, af_none, "Установить стиль CSS", "Внешность", "Установить стиль CSS {0} к {1}", "Установить стиль CSS на элементе управления.", "SetCSSStyle");

AddNumberParam("Значение", "Значение, чтобы установить для индикатора.");
AddAction(3, af_none, "Установить индикатор", "Индикатор", "Установить индикатор <b>{0}</b>", "Установите значение для индикатора.", "SetProgress");

AddNumberParam("максимум", "Новое максимальное значение для индикатора.");
AddAction(4, af_none, "Установить максимум", "Индикатор", "Установить максимум <b>{0}</b>", "Установите максимальное значение для индикатора.", "SetMaximum");

AddAction(5, af_none, "Сделать неопределенными", "Индикатор", "Сделать неопределенными", "Делают индикатор неопределенным (неизвестно) прогресса.", "SetIndeterminate");

////////////////////////////////////////
// Expressions

// AddExpression(id,			// any positive integer to uniquely identify this expression
//				 flags,			// (see docs) ef_none, ef_deprecated, ef_return_number, ef_return_string,
//								// ef_return_any, ef_variadic_parameters (one return flag must be specified)
//				 list_name,		// currently ignored, but set as if appeared in event wizard
//				 category,		// category in expressions panel
//				 exp_name,		// the expression name after the dot, e.g. "foo" for "myobject.foo" - also the runtime function name
//				 description);	// description in expressions panel

AddExpression(0, ef_return_number, "", "Progress bar", "Progress", "Current progress value.");
AddExpression(1, ef_return_number, "", "Progress bar", "Maximum", "Current maximum progress value.");

ACESDone();

// Property grid properties for this plugin
var property_list = [
	new cr.Property(ept_float,	"Value",				"0",		"Начальное значение индикатора выполнения."),
	new cr.Property(ept_float,	"Maximum",				"100",		"Максимальное значение индикатора выполнения. Установите 0 для неопределенного индикатора выполнения."),
	new cr.Property(ept_text,	"Tooltip",				"",			"Показать этот текст при наведении курсора мыши на элемент управления."),
	new cr.Property(ept_combo,	"Initial visibility",	"Visible",	"Выберите, отображается ли при запуске индикатор выполнения.", "Invisible|Visible"),
	new cr.Property(ept_text,	"ID (optional)",		"",			"ID для управления позволяет ему быть стилизовано CSS со страницы HTML.")
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
	this.just_inserted = false;
}

IDEInstance.prototype.OnCreate = function()
{
	this.instance.SetHotspot(new cr.vector2(0, 0));
}

IDEInstance.prototype.OnInserted = function()
{
	this.instance.SetSize(new cr.vector2(200, 25));
}

IDEInstance.prototype.OnDoubleClicked = function()
{
}

// Called by the IDE after a property has been changed
IDEInstance.prototype.OnPropertyChanged = function(property_name)
{
}

IDEInstance.prototype.OnRendererInit = function(renderer)
{
}
	
// Called to draw self in the editor
IDEInstance.prototype.Draw = function(renderer)
{
	renderer.SetTexture(null);
	var quad = this.instance.GetBoundingQuad();

	renderer.Fill(quad, cr.RGB(224, 224, 224));
	renderer.Outline(quad, cr.RGB(0, 0, 0));
}

IDEInstance.prototype.OnRendererReleased = function(renderer)
{
}