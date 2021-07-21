function GetPluginSettings()
{
	return {
		"name":			"Поле для ввода",
		"id":			"TextBox",
		"version":		"1.0",
		"description":	"Элемент формы текстовое поле для пользователя ввести текст и , для простого отображения текста, используйте вместо 'Текст' объект.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/117/textbox",
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
				
AddStringParam("Текст", "Текст для сравнения текста текстового поля с.");
AddComboParamOption("без учета регистра");
AddComboParamOption("с учетом регистра");
AddComboParam("Случай", "Выберите, должно ли быть чувствительным к регистру (FOO отличается от Foo) или регистронезависимым (FOO - то же, что и Foo).");
AddCondition(0, cf_none, "Сравнить текст", "Текстовое окно", "Текст {0} (<i>{1}</i>)", "Сравните введенный текст с текстовым полем.", "CompareText");

AddCondition(1, cf_trigger, "Текст изменен", "Текстовое окно", "Текст изменен", "Вызывается при изменении текста в текстовом поле.", "OnTextChanged");
AddCondition(2, cf_trigger, "Нажал", "Текстовое окно", "Нажал", "Вызывается при нажатии текстового поля.", "OnClicked");
AddCondition(3, cf_trigger, "Двойной щелчок", "Текстовое окно", "Двойной щелчок", "Вызывается при двойном щелчке текстового поля.", "OnDoubleClicked");

////////////////////////////////////////
// Actions

// AddAction(id,				// any positive integer to uniquely identify this action
//			 flags,				// (see docs) af_none, af_deprecated
//			 list_name,			// appears in event wizard list
//			 category,			// category in event wizard list
//			 display_str,		// as appears in event sheet - use {0}, {1} for parameters and also <b></b>, <i></i>
//			 description,		// appears in event wizard dialog when selected
//			 script_name);		// corresponding runtime function name

AddStringParam("Текст", "Текст, заданный в текстовом поле.");
AddAction(0, af_none, "Задать текст", "Текстовое поле", "Задать текст {0}", "Установите текст в текстовом поле.", "SetText");

AddStringParam("Местозаполнитель", "Новый местозаполнитель текстового поля.");
AddAction(1, af_none, "Задать заполнитель", "Текстовое поле", "Задать местозаполнитель {0}", "Задание местозаполнителя текстового поля.", "SetPlaceholder");

AddStringParam("Подсказка", "Подсказка, которая должна быть задана в текстовом поле.");
AddAction(2, af_none, "Задать подсказку", "Текстовое поле", "Установить подсказку {0}", "Установите подсказку для текстового поля.", "SetTooltip");

AddComboParamOption("Невидимый");
AddComboParamOption("Видимый");
AddComboParam("Видимость", "Выберите, следует ли скрывать или отображать текстовое поле.");
AddAction(3, af_none, "Установить видимость", "Appearance", "Установить <b>{0}</b>", "Скрытие или отображение текстового поля.", "SetVisible");

AddComboParamOption("Отключен");
AddComboParamOption("Включен");
AddComboParam("Режим", "Выберите, следует ли включать или отключать текстовое поле.");
AddAction(4, af_none, "Установить режим", "Текстовое поле", "Установить <b>{0}</b>", "Отключите или включите текстовое поле.", "SetEnabled");

AddComboParamOption("Только для чтения");
AddComboParamOption("Не только для чтения");
AddComboParam("Режим", "Выберите, следует ли включать или отключать режим только для чтения.");
AddAction(5, af_none, "Установка только для чтения", "Текстовое поле", "Установить <b>{0}</b>", "Включение или отключение только для чтения.", "SetReadOnly");

AddAction(6, af_none, "Установка фокуса", "Текстовое поле", "Установка фокуса", "Установите фокус ввода на текстовое поле.", "SetFocus");

AddStringParam("Имя свойства", "Имя свойства CSS, которое необходимо задать для элемента управления.", "\"цвет\"");
AddStringParam("Значение", "Строка, назначаемая в качестве значения для этого свойства CSS.", "\"красный\"");
AddAction(7, af_none, "Задать стиль CSS", "Внешность", "Задать стиль CSS {0} к {1}", "Задайте стиль CSS для элемента управления.", "SetCSSStyle");

AddAction(8, af_none, "Установка нефокусного", "Текстовое поле", "Установка нефокусного", "Удаление фокуса ввода из текстового поля.", "SetBlur");

AddAction(9, af_none, "Прокрутить вниз", "Текстовое поле", "Прокрутить вниз", "Прокрутите текстовое поле до нижней части текстового поля.", "ScrollToBottom");

////////////////////////////////////////
// Expressions

// AddExpression(id,			// any positive integer to uniquely identify this expression
//				 flags,			// (see docs) ef_none, ef_deprecated, ef_return_number, ef_return_string,
//								// ef_return_any, ef_variadic_parameters (one return flag must be specified)
//				 list_name,		// currently ignored, but set as if appeared in event wizard
//				 category,		// category in expressions panel
//				 exp_name,		// the expression name after the dot, e.g. "foo" for "myobject.foo" - also the runtime function name
//				 description);	// description in expressions panel

AddExpression(0, ef_return_string, "Get text", "Text box", "Text", "Get the text box's text.");

ACESDone();

// Property grid properties for this plugin
var property_list = [
	new cr.Property(ept_text,	"Text",					"",			"Исходный текст для текстового поля."),
	new cr.Property(ept_text,	"Placeholder",			"",			"Подсказка для отображения, когда текстовое поле пустое."),
	new cr.Property(ept_text,	"Tooltip",				"",			"Показать этот текст при наведении курсора мыши на элемент управления."),
	new cr.Property(ept_combo,	"Initial visibility",	"Visible",	"Выберите, отображается ли при запуске текстовое поле.", "Invisible|Visible"),
	new cr.Property(ept_combo,	"Enabled",				"Yes",		"Выберите, включен ли текстовое поле или отключить при запуске.", "No|Yes"),
	new cr.Property(ept_combo,	"Read-only",			"No",		"Выберите ли только для чтения текстового поля при запуске.", "No|Yes"),
	new cr.Property(ept_combo,	"Spell check",			"No",		"Разрешить браузеру проверку орфографии в текстовом поле, если эта функция поддерживается.", "No|Yes"),
	new cr.Property(ept_combo,	"Type",					"Text",		"Вид введенного текста, чтобы текстовое поле, что также влияет на экранные клавиатуры на сенсорных устройствах.", "Text|Password|Email|Number|Telephone number|URL|Textarea"),
	new cr.Property(ept_combo,	"Auto font size",		"Yes",		"Автоматически устанавливается размер шрифта в зависимости от масштаба слоя.", "No|Yes"),
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
	this.font = null;
}

IDEInstance.prototype.OnCreate = function()
{
	this.instance.SetHotspot(new cr.vector2(0, 0));
}

IDEInstance.prototype.OnInserted = function()
{
	this.instance.SetSize(new cr.vector2(150, 22));
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
	renderer.Fill(quad, this.properties["Enabled"] === "Yes" ? cr.RGB(255, 255, 255) : cr.RGB(224, 224, 224));
	renderer.Outline(quad, cr.RGB(0, 0, 0));
	
	cr.quad.prototype.offset.call(quad, 4, 2);
	
	if (this.properties["Text"].length)
	{
		this.font.DrawText(this.properties["Text"],
							quad,
							cr.RGB(0, 0, 0),
							ha_left);
	}
	else
	{
		this.font.DrawText(this.properties["Placeholder"],
							quad,
							cr.RGB(128, 128, 128),
							ha_left);
	}
}

IDEInstance.prototype.OnRendererReleased = function(renderer)
{
	this.font = null;
}