function GetPluginSettings()
{
	return {
		"name":			"Список",
		"id":			"List",
		"version":		"1.0",
		"description":	"Окно списка или выпадающий список для выбора опции из.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/155/list",
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
				
AddCmpParam("Сравнение", "Выберите, как сравнить текущий выбор.");
AddNumberParam("Индекс", "Индекс выбранного элемента для сравнения с.");
AddCondition(0, cf_none, "Сравнить выбор", "Список", "Выбранный элемент {0} <b>{1}</b>", "Сравните индекс текущего выбранного элемента.", "CompareSelection");

AddCondition(1, cf_trigger, "Выбор изменен", "Список", "Выбор изменен", "Вызывается, когда выбранный элемент изменяется.", "OnSelectionChanged");
AddCondition(2, cf_trigger, "Нажал", "Список", "Нажал", "Вызывается при нажатии на список.", "OnClicked");
AddCondition(3, cf_trigger, "Двойной щелчок", "Список", "Двойной щелчок", "Вызывается при двойном щелчке по списку.", "OnDoubleClicked");

AddStringParam("Текст для сравнения", "Введите текст для сравнения с текстом выбранного элемента.", "\"\"");
AddComboParamOption("Игнорировать регистр");
AddComboParamOption("С учетом регистра");
AddComboParam("Чувствительность к регистру", "Укажите, считаются ли заглавные буквы разными или строчными. Если игнорировать регистр, \"ABC\" совпадения \"abc\".", 0);
AddCondition(4, 0, "Сравнить выбранный текст", "Список", "Текст выбранного элемента <b>{0}</b> <i>({1})</i>", "Сравните текст текущего выбранного элемента.", "CompareSelectedText");

AddNumberParam("Индекс", "Отсчитываемый с нуля индекс текста элемента для сравнения.");
AddStringParam("Текст для сравнения", "Введите текст для сравнения с текстом элемента.", "\"\"");
AddComboParamOption("Игнорировать регистр");
AddComboParamOption("С учетом регистра");
AddComboParam("Чувствительность к регистру", "Укажите, считаются ли заглавные буквы разными или строчными. Если игнорировать регистр, \"ABC\" совпадения \"abc\".", 0);
AddCondition(5, 0, "Сравнить текст элемента в", "Список", "Пункт <b>{0}</b> текст <b>{1}</b> <i>({2})</i>", "Сравнить текст элемента в списке.", "CompareTextAt");

////////////////////////////////////////
// Actions

// AddAction(id,				// any positive integer to uniquely identify this action
//			 flags,				// (see docs) af_none, af_deprecated
//			 list_name,			// appears in event wizard list
//			 category,			// category in event wizard list
//			 display_str,		// as appears in event sheet - use {0}, {1} for parameters and also <b></b>, <i></i>
//			 description,		// appears in event wizard dialog when selected
//			 script_name);		// corresponding runtime function name

AddNumberParam("Индекс", "Отсчитываемый от нуля индекс элемента, который требуется выбрать.");
AddAction(0, af_none, "Выбор набора", "Элементы", "Выберите элемент <i>{0}</i>", "Выберите элемент в списке.", "Select");

AddStringParam("Подсказка", "Подсказка для установки в списке.");
AddAction(1, af_none, "Задать подсказку", "Список", "Установить подсказку <i>{0}</i>", "Задайте подсказку списка.", "SetTooltip");

AddComboParamOption("Невидимый");
AddComboParamOption("Видимый");
AddComboParam("Видимость", "Выберите, следует ли скрывать или отображать список.");
AddAction(2, af_none, "Установить видимость", "Внешность", "Установить <b>{0}</b>", "Скрытие или отображение списка.", "SetVisible");

AddComboParamOption("Отключен");
AddComboParamOption("Включен");
AddComboParam("Режим", "Выберите, следует ли включать или отключать список.");
AddAction(3, af_none, "Установить режим", "Список", "Установить <b>{0}</b>", "Отключите или включите список.", "SetEnabled");

AddAction(4, af_none, "Установка фокуса", "Список", "Установка фокуса", "Установка фокуса ввода на список.", "SetFocus");
AddAction(5, af_none, "Установка нефокусного", "Список", "Установка нефокусного", "Удалите фокус ввода из списка.", "SetBlur");

AddStringParam("Имя свойства", "Имя свойства CSS, которое необходимо задать для элемента управления.", "\"цвет\"");
AddStringParam("Значение", "Строка, назначаемая в качестве значения для этого свойства CSS.", "\"красный\"");
AddAction(6, af_none, "Задать стиль CSS", "Внешность", "Задать стиль CSS {0} к {1}", "Задание стиля CSS для элемента управления.", "SetCSSStyle");

AddStringParam("Текст", "Добавляемый текст элемента.");
AddAction(7, af_none, "Добавить элемент", "Элементы", "Добавить элемент <i>{0}</i>", "Добавление нового элемента в список.", "AddItem");

AddNumberParam("Индекс", "Отсчитываемый от нуля индекс элемента, который требуется вставить перед.");
AddStringParam("Текст", "Добавляемый текст элемента.");
AddAction(8, af_none, "Добавить элемент", "Элементы", "Добавить элемент <i>{1}</i> по индексу <i>{0}</i>", "Добавление нового элемента в определенное место списка.", "AddItemAt");

AddNumberParam("Индекс", "Отсчитываемый от нуля индекс удаляемого элемента.");
AddAction(9, af_none, "Удалить", "Элементы", "Удалить элемент <i>{0}</i>", "Удаление элемента из списка.", "Remove");

AddNumberParam("Индекс", "Отсчитываемый от нуля индекс изменяемого элемента.");
AddStringParam("Текст", "Добавляемый текст элемента.");
AddAction(10, af_none, "Задать текст элемента", "Элементы", "Задать элемент <i>{0}</i> текст <i>{1}</i>", "Задайте текст элемента в списке.", "SetItemText");

AddAction(11, af_none, "Очистить", "Элементы", "Очистить все элементы", "Удаление всех элементов из списка.", "Clear");

////////////////////////////////////////
// Expressions

// AddExpression(id,			// any positive integer to uniquely identify this expression
//				 flags,			// (see docs) ef_none, ef_deprecated, ef_return_number, ef_return_string,
//								// ef_return_any, ef_variadic_parameters (one return flag must be specified)
//				 list_name,		// currently ignored, but set as if appeared in event wizard
//				 category,		// category in expressions panel
//				 exp_name,		// the expression name after the dot, e.g. "foo" for "myobject.foo" - also the runtime function name
//				 description);	// description in expressions panel

AddExpression(0, ef_return_number, "", "List", "ItemCount", "The number of items in the list.");
AddExpression(1, ef_return_number, "", "List", "SelectedIndex", "The zero-based index of the currently selected item.");
AddExpression(2, ef_return_string, "", "List", "SelectedText", "The text of the currently selected item.");
AddExpression(3, ef_return_number, "", "List", "SelectedCount", "In a multi-select list box, the number of currently selected items.");

AddNumberParam("Index", "Selected item number to get.");
AddExpression(4, ef_return_number, "", "List", "SelectedIndexAt", "In a multi-select list box, the index of the Nth selected item.");

AddNumberParam("Index", "Selected item number to get.");
AddExpression(5, ef_return_string, "", "List", "SelectedTextAt", "In a multi-select list box, the text of the Nth selected item.");

AddNumberParam("Index", "Item number to get.");
AddExpression(6, ef_return_string, "", "List", "ItemTextAt", "The text of the Nth item in the list.");

ACESDone();

// Property grid properties for this plugin
var property_list = [
	new cr.Property(ept_text,	"Items",				"Пункт 1;Пункт 2;Пункт 3",			"Первоначальный список элементов, разделенных точкой с запятой."),
	new cr.Property(ept_text,	"Tooltip",				"",			"Показать этот текст при наведении курсора мыши на элемент управления."),
	new cr.Property(ept_combo,	"Initial visibility",	"Visible",	"Выберите, отображается ли при запуске список.", "Invisible|Visible"),
	new cr.Property(ept_combo,	"Enabled",				"Yes",		"Выберите, включен ли список или отключить при запуске.", "No|Yes"),
	new cr.Property(ept_combo,	"Type",					"Dropdown list",		"Вид контроля использования.", "List box|Dropdown list"),
	new cr.Property(ept_combo,	"Multi-select",			"No",		"Для списков, следует ли разрешить множественный выбор.", "No|Yes"),
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
	
	if (this.properties["Type"] === "List box")
	{
		this.font.DrawText(this.properties["Items"].replace(/;/g, "\n"),
							quad,
							cr.RGB(0, 0, 0),
							ha_left);
	}
	else
	{
		var items = this.properties["Items"].split(";");
		
		if (items.length)
		{
			this.font.DrawText(items[0],
								quad,
								cr.RGB(0, 0, 0),
								ha_left);
			
			cr.quad.prototype.offset.call(quad, -4, -2);			
			quad.tlx = quad.trx - 20;
			quad.blx = quad.brx - 20;
			renderer.Fill(quad, cr.RGB(224, 224, 224));
			renderer.Outline(quad, cr.RGB(0, 0, 0));
			
			var arr = new cr.vector2(quad.trx - 10, (quad.try_ + quad.bly) / 2 + 3);
			var arr1 = new cr.vector2(arr.x - 6, arr.y - 6);
			var arr2 = new cr.vector2(arr.x + 6, arr.y - 6);
			renderer.Line(arr, arr1, cr.RGB(0, 0, 0));
			renderer.Line(arr, arr2, cr.RGB(0, 0, 0));
		}
	}
}

IDEInstance.prototype.OnRendererReleased = function(renderer)
{
	this.font = null;
}