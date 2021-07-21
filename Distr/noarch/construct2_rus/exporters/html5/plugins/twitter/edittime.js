﻿function GetPluginSettings()
{
	return {
		"name":			"Twitter",
		"id":			"Twitter",
		"version":		"1.0",
		"description":	"Создать кнопку Follow  или Tweet .",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/176/twitter",
		"category":		"Конкретная платформа",
		"type":			"world",			// appears in layout
		"rotatable":	false,
		"cordova-plugins": "org.apache.cordova.inappbrowser",
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
				
AddCondition(0, cf_trigger, "Кнопка загружается", "Twitter", "Кнопка загружается", "Срабатывает, когда кнопка загружена и готова к отображению.", "OnLoaded");

////////////////////////////////////////
// Actions

// AddAction(id,				// any positive integer to uniquely identify this action
//			 flags,				// (see docs) af_none, af_deprecated
//			 list_name,			// appears in event wizard list
//			 category,			// category in event wizard list
//			 display_str,		// as appears in event sheet - use {0}, {1} for parameters and also <b></b>, <i></i>
//			 description,		// appears in event wizard dialog when selected
//			 script_name);		// corresponding runtime function name

AddComboParamOption("Невидимый");
AddComboParamOption("Видимый");
AddComboParam("Видимость", "Выберите, нужно ли, чтобы скрыть или показать кнопку.");
AddAction(0, af_none, "Установить видимость", "Внешность", "Установить <b>{0}</b>", "Скрыть или показать кнопку.", "SetVisible");

AddStringParam("Поделиться", "Имя экрана, URL или хэш-тегов, которые будут использоваться (без @ или #).");
AddAction(1, af_none, "Установить 'Поделиться'", "Twitter", "Установить 'Поделиться' <i>{0}</i>", "Установите свойство 'Поделиться'.", "SetShare");

AddStringParam("Текст", "Текст для использования в твите.");
AddAction(2, af_none, "Установить текст", "Twitter", "Установить текст <i>{0}</i>", "Установите свойство 'Текст'.", "SetText");

AddStringParam("С помощью", "Имя экрана, чтобы сообщить чирикать как 'с помощью', если это применимо (без @).");
AddAction(3, af_none, "Установить 'С помощью'", "Twitter", "Установить 'С помощью' <i>{0}</i>", "Установите свойство 'С помощью'.", "SetVia");

AddStringParam("Хэштеги", "Разделителями-дополнительные хештегов приобщать без #, e.g. \"construct2,html5\"");
AddAction(4, af_none, "Установить хештеги", "Twitter", "Установить хештеги <i>{0}</i>", "Установите свойство 'Хэштеги'.", "SetHashtags");

AddAction(5, af_none, "Перезагрузить", "Twitter", "Перезагрузить кнопку", "Обновить кнопку для того чтобы использовать какие-либо новые установленные параметры.", "Reload");

////////////////////////////////////////
// Expressions

// AddExpression(id,			// any positive integer to uniquely identify this expression
//				 flags,			// (see docs) ef_none, ef_deprecated, ef_return_number, ef_return_string,
//								// ef_return_any, ef_variadic_parameters (one return flag must be specified)
//				 list_name,		// currently ignored, but set as if appeared in event wizard
//				 category,		// category in expressions panel
//				 exp_name,		// the expression name after the dot, e.g. "foo" for "myobject.foo" - also the runtime function name
//				 description);	// description in expressions panel

ACESDone();

// Property grid properties for this plugin
var property_list = [
	new cr.Property(ept_combo,	"Type",			"Follow",	"Вид кнопки для создания.", "Follow|Share|Mention|Hashtag"),
	new cr.Property(ept_text,	"Share",		"Scirra",	"Имя экрана, URL или хэш-тегов для использования с помощью кнопки (без @ или #)."),
	new cr.Property(ept_text,	"Text",			"Мой текст твит",	"Текст использовать в твите, если это применимо к кнопочного типа."),
	new cr.Property(ept_text,	"Via",			"",			"Имя экрана, чтобы сообщить чирикать как 'через', если это применимо (без @)."),
	new cr.Property(ept_text,	"Hashtags",		"",			"Разделителями-дополнительные хештегов добавить без #, например, construct2, html5"),
	new cr.Property(ept_combo,	"Initial visibility",		"Visible",	"Выберите, отображается ли при запуске кнопки.", "Invisible|Visible"),
	new cr.Property(ept_combo,	"Count",		"None",		"Независимо от того, чтобы показать счетчик для акции или следовать кнопки.", "None|Horizontal|Vertical"),
	new cr.Property(ept_combo,	"Size",			"Medium",	"Следует ли использовать средний или большой стиль.", "Medium|Large"),
	new cr.Property(ept_text,	"Language",		"en",		"Код 639-1 языка ISO использовать для кнопки.")
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
	this.font = null;
}

IDEInstance.prototype.OnCreate = function()
{
	this.instance.SetHotspot(new cr.vector2(0, 0));
}

IDEInstance.prototype.OnInserted = function()
{
	this.instance.SetSize(new cr.vector2(80, 30));
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
	if (!this.font)
		this.font = renderer.CreateFont("Arial", 14, false, false);
		
	renderer.SetTexture(null);
	var quad = this.instance.GetBoundingQuad();
	
	renderer.Fill(quad, cr.RGB(224, 224, 255));
	renderer.Outline(quad, cr.RGB(0, 0, 0));
	
	cr.quad.prototype.offset.call(quad, 0, 2);

	this.font.DrawText("Twitter " + this.properties["Type"],
						quad,
						cr.RGB(0, 0, 0),
						ha_center);
}

IDEInstance.prototype.OnRendererReleased = function(renderer)
{
	this.font = null;
}