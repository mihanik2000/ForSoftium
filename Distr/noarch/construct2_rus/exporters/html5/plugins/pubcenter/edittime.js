function GetPluginSettings()
{
	return {
		"name":			"pubCenter",
		"id":			"pubcenter",
		"version":		"1.0",
		"description":	"Показать объявление от Microsoft pubCenter в приложении Windows Store.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/185/pubcenter",
		"category":		"Монетизация",
		"type":			"object",
		"rotatable":	false,
		"flags":		pf_singleglobal
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

AddCondition(0, cf_none, "Является ли баннер демонстративным", "Объявления", "Является ли баннер демонстративным", "Правда, если рекламный баннер в данный момент отображается.", "IsBannerShowing");

AddCondition(1, cf_trigger, "Готов", "Интерстициальный", "Интерстициальное объявление готового", "Срабатывает, когда интерстициальный объявление готово будет отображаться.", "OnInterstitialReady");
AddCondition(2, cf_trigger, "В случае ошибки", "Интерстициальный", "Интерстициальная ошибка объявления", "Срабатывает, когда возникает ошибка отображения интерстициального объявления.", "OnInterstitialError");
AddCondition(3, cf_trigger, "Завершено", "Интерстициальный", "Интерстициальное объявление завершена", "Срабатывает, когда интерстициальное объявление завершается.", "OnInterstitialCompleted");
AddCondition(4, cf_trigger, "Отменен", "Интерстициальный", "Интерстициальное объявление отменено", "Срабатывает, когда интерстициальное объявление отменяется.", "OnInterstitialCancelled");

/*
AddCmpParam("Comparison", "How to compare the current progress.");
AddNumberParam("Value", "Progress value to compare to.");
AddCondition(1, cf_none, "Compare progress", "Progress bar", "Progress {0} <i>{1}</i>", "Compare the current progress value.", "CompareProgress");
*/

////////////////////////////////////////
// Actions

// AddAction(id,				// any positive integer to uniquely identify this action
//			 flags,				// (see docs) af_none, af_deprecated
//			 list_name,			// appears in event wizard list
//			 category,			// category in event wizard list
//			 display_str,		// as appears in event sheet - use {0}, {1} for parameters and also <b></b>, <i></i>
//			 description,		// appears in event wizard dialog when selected
//			 script_name);		// corresponding runtime function name

AddComboParamOption("Верхний левый");
AddComboParamOption("Верхняя центральная");
AddComboParamOption("В правом верхнем углу");
AddComboParamOption("Левый");
AddComboParamOption("Центр");
AddComboParamOption("Право");
AddComboParamOption("Нижняя левая");
AddComboParamOption("Нижняя центральная");
AddComboParamOption("Внизу справа");
AddComboParam("Позиция", "Где отображать объявления.", 3);
AddComboParamOption("160x600");
AddComboParamOption("250x250");
AddComboParamOption("300x250");
AddComboParamOption("300x600");
AddComboParamOption("728x90");
AddComboParam("Размер", "Размер объявления, чтобы показать, что должно соответствовать настройкам на pubCenter.");
AddAction(0, 0, "Показать объявление баннера", "Объявления", "Показать объявление баннера в положении <i>{0}</i> размер <i>{1}</i>", "Показать рекламный баннер на экране в то время как игра запущена.", "ShowBanner");

AddAction(1, 0, "Скрыть рекламный баннер", "Объявления", "Скрыть рекламный баннер", "Скрыть любой показ рекламного баннера в настоящее время.", "HideBanner");

AddStringParam("ID рекламного блока", "ID дополнительного альтернативного рекламного блока, использовать для интерстициальной. Оставьте пустым, чтобы использовать один набор в свойствах плагина.");
AddAction(2, 0, "Подготовить интерстициальную", "Интерстициальный", "Подготовить интерстициальный объявление с ID рекламного блока <i>{0}</i>", "Начало загрузки интерстициальных объявлений в фоновом режиме.", "PrepareInterstitial");

AddAction(3, 0, "Показать интерстициальную", "Интерстициальный", "Показать объявление интерстициальной", "Показать интерстициальные объявление, которое готово.", "ShowInterstitial");

////////////////////////////////////////
// Expressions

// AddExpression(id,			// any positive integer to uniquely identify this expression
//				 flags,			// (see docs) ef_none, ef_deprecated, ef_return_number, ef_return_string,
//								// ef_return_any, ef_variadic_parameters (one return flag must be specified)
//				 list_name,		// currently ignored, but set as if appeared in event wizard
//				 category,		// category in expressions panel
//				 exp_name,		// the expression name after the dot, e.g. "foo" for "myobject.foo" - also the runtime function name
//				 description);	// description in expressions panel

//AddExpression(0, ef_return_number, "", "Progress bar", "Progress", "Current progress value.");

ACESDone();

// Property grid properties for this plugin
var property_list = [
	new cr.Property(ept_text,	"Application ID",	"",		"Идентификатор приложения от Microsoft PubCenter."),
	new cr.Property(ept_text,	"Ad unit ID",		"",		"Идентификатор рекламного блока от Microsoft PubCenter.")
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
}

IDEInstance.prototype.OnInserted = function()
{
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
}

IDEInstance.prototype.OnRendererReleased = function(renderer)
{
}