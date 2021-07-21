function GetPluginSettings()
{
	return {
		"name":			"Ползунок",
		"id":			"sliderbar",
		"version":		"1.0",
		"description":	"Ползунок позволяет пользователю выбрать значение между двумя значениями.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/179/slider-bar",
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
				
AddCondition(0, cf_trigger, "Нажал", "Ползунок", "Нажал", "Срабатывает, когда ползунок нажат.", "OnClicked");

AddCmpParam("Сравнение", "Как сравнить текущее значение.");
AddNumberParam("Значение", "Значение, для сравнения.");
AddCondition(1, cf_none, "Сравнить значение", "Ползунок", "Значение ползунка {0} <i>{1}</i>", "Сравните текущее значение.", "CompareValue");

AddCondition(2, cf_trigger, "Изменено", "Ползунок", "Изменено", "Срабатывает, когда значение ползунка изменяется.", "OnChanged");

////////////////////////////////////////
// Actions

// AddAction(id,				// any positive integer to uniquely identify this action
//			 flags,				// (see docs) af_none, af_deprecated
//			 list_name,			// appears in event wizard list
//			 category,			// category in event wizard list
//			 display_str,		// as appears in event sheet - use {0}, {1} for parameters and also <b></b>, <i></i>
//			 description,		// appears in event wizard dialog when selected
//			 script_name);		// corresponding runtime function name

AddStringParam("Подсказка", "Подсказка для установки на панели слайдера.");
AddAction(0, af_none, "Набор подсказки", "Ползунок", "Набор подсказки {0}", "Установите ползунку всплывающую подсказку.", "SetTooltip");

AddComboParamOption("Невидимый");
AddComboParamOption("Видимый");
AddComboParam("Видимость", "Выберите, нужно ли, чтобы скрыть или показать ползунок.");
AddAction(1, af_none, "Установить видимость", "Внешность", "Установить <b>{0}</b>", "Скрыть или показать ползунок.", "SetVisible");

AddStringParam("Имя свойства", "Имя свойства CSS для установки на элементе управления.", "\"цвет\"");
AddStringParam("Значение", "Строка для назначения в качестве значения для этого CSS свойства.", "\"красный\"");
AddAction(2, af_none, "Установить стиль CSS", "Внешность", "Установить стиль CSS {0} к {1}", "Установить стиль CSS на элементе управления.", "SetCSSStyle");

AddNumberParam("Значение", "Значение, которое устанавливается для ползунка.");
AddAction(3, af_none, "Установить значение", "Ползунок", "Установить значение <b>{0}</b>", "Установите значение для бара.", "SetValue");

AddNumberParam("Максимум", "Новое максимальное значение для ползунка.");
AddAction(4, af_none, "Установить максимум", "Ползунок", "Установить максимум <b>{0}</b>", "Установите максимальное значение ползунка для бара.", "SetMaximum");

AddNumberParam("Минимум", "Новое минимальное значение для ползунка.");
AddAction(5, af_none, "Установить минимум", "Ползунок", "Установить минимум <b>{0}</b>", "Установить минимальное значение ползунка для бара.", "SetMinimum");

AddNumberParam("Шаг", "Новое значение степпинга для ползунка.");
AddAction(6, af_none, "Установить шаг", "Ползунок", "Установить шаг <b>{0}</b>", "Установите значение шага слайдера для бара.", "SetStep");

AddComboParamOption("Отключено");
AddComboParamOption("Включено");
AddComboParam("Режим", "Укажите, следует ли включить или отключить ползунок.");
AddAction(7, af_none, "Установить режим", "Ползунок", "Установить <b>{0}</b>", "Отключить или включить ползунок.", "SetEnabled");


////////////////////////////////////////
// Expressions

// AddExpression(id,			// any positive integer to uniquely identify this expression
//				 flags,			// (see docs) ef_none, ef_deprecated, ef_return_number, ef_return_string,
//								// ef_return_any, ef_variadic_parameters (one return flag must be specified)
//				 list_name,		// currently ignored, but set as if appeared in event wizard
//				 category,		// category in expressions panel
//				 exp_name,		// the expression name after the dot, e.g. "foo" for "myobject.foo" - also the runtime function name
//				 description);	// description in expressions panel

AddExpression(0, ef_return_number, "", "Slider bar", "Value", "Current slider value.");
AddExpression(1, ef_return_number, "", "Slider bar", "Maximum", "Current maximum value.");
AddExpression(2, ef_return_number, "", "Slider bar", "Minimum", "Current minimum value.");
AddExpression(3, ef_return_number, "", "Slider bar", "Step", "Current step value.");

ACESDone();

// Property grid properties for this plugin
var property_list = [
	new cr.Property(ept_float,	"Value",				"0",		"Начальное значение ползунка."),
	new cr.Property(ept_float,	"Minimum",				"0",		"Минимальное значение ползунка."),
	new cr.Property(ept_float,	"Maximum",				"100",		"Максимальное значение ползунка."),
	new cr.Property(ept_float,	"Step",					"1",		"Значение шага, давая приращения вдоль ползунка."),
	new cr.Property(ept_text,	"Tooltip",				"",			"Показать этот текст при наведении курсора мыши на элемент управления."),
	new cr.Property(ept_combo,	"Initial visibility",	"Visible",	"Выберите, отображается ли при запуске ползунок.", "Invisible|Visible"),
	new cr.Property(ept_combo,	"Enabled",				"Yes",		"Выберите, включен ли ползунок или отключить при запуске.", "No|Yes"),
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