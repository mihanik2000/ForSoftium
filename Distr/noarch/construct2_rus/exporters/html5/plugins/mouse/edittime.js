function GetPluginSettings()
{
	return {
		"name":			"Мышь",
		"id":			"Mouse",
		"version":		"1.0",
		"description":	"Получить ввод с помощью мыши.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/114/mouse",
		"category":		"Ввод",
		"type":			"object",			// not in layout
		"rotatable":	false,
		"flags":		pf_singleglobal
	};
};

//////////////////////////////////////////////////////////////
// Conditions
AddComboParamOption("Слева");
AddComboParamOption("Средний");
AddComboParamOption("Справо");
AddComboParam("Кнопка мыши", "Нажмите кнопку мыши, чтобы проверить.");
AddComboParamOption("Нажал");
AddComboParamOption("Дважды нажал");
//AddComboParamOption("Either single or double clicked");
AddComboParam("Тип клика", "Выберите, какой тип клика, чтобы проверить.");
AddCondition(0,	cf_trigger, "Кликните", "Мышь", "<b>{0}</b> кнопка <b>{1}</b>", "Срабатывает, когда кнопка мыши нажата или двойной щелчок.", "OnClick");

AddCondition(1,	cf_trigger, "При любом клике", "Мышь", "При любом клике", "Срабатывает, когда кнопка мыши нажата или двойной щелчок.", "OnAnyClick");

AddComboParamOption("Слева");
AddComboParamOption("Средний");
AddComboParamOption("Справо");
AddComboParam("Кнопка мыши", "Нажмите кнопку мыши, чтобы проверить.");
AddCondition(2, 0, "Кнопка мыши нажата", "Мышь", "<b>{0}</b> кнопка нажата", "Проверьте, если кнопка мыши в данный момент нажата.", "IsButtonDown");

AddComboParamOption("Слева");
AddComboParamOption("Средний");
AddComboParamOption("Справо");
AddComboParam("Кнопка мыши", "Нажмите кнопку мыши, чтобы проверить.");
AddCondition(3, cf_trigger, "Кнопка выпущена", "Мышь", "On <b>{0}</b> кнопка выпущена", "Срабатывает, когда кнопка мыши отпущена.", "OnRelease");

//AddCondition(4,	cf_trigger, "On wheel up", "Mouse", "On wheel up", "Triggered when the mouse wheel rolled up.", "OnWheelUp");
//AddCondition(5,	cf_trigger, "On wheel down", "Mouse", "On wheel down", "Triggered when the mouse wheel rolled down.", "OnWheelDown");

AddComboParamOption("Слева");
AddComboParamOption("Средний");
AddComboParamOption("Справо");
AddComboParam("Кнопка мыши", "Нажмите кнопку мыши, чтобы проверить.");
AddComboParamOption("Нажал");
AddComboParamOption("Дважды нажал");
//AddComboParamOption("Either single or double clicked");
AddComboParam("Тип клика", "Выберите, какой тип клика, чтобы проверить.");
AddObjectParam("Объект щелкнут", "Выберите объект для проверки нажатием на.");
AddCondition(6,	cf_trigger, "На объекте щелкнули", "Мышь", "<b>{0}</b> кнопка <b>{1}</b> {2}", "Срабатывает, когда кнопка мыши нажата или двойной щелчок на объекте.", "OnObjectClicked");

AddObjectParam("Объект", "Выберите объект для проверки мыши над.");
AddCondition(7,	0, "Курсор над объектом", "Мышь", "Курсор над {0}", "Проверьте, если курсор мыши находится над объектом.", "IsOverObject");

AddComboParamOption("вниз");
AddComboParamOption("вверх");
AddComboParam("Направление", "Выберите, какое направление для обнаружения колеса мыши прокрутки.");
AddCondition(8,	cf_trigger, "Колесик мыши", "Мышь", "Колесик мыши {0}", "Срабатывает, когда колесо мыши прокручивается.", "OnWheel");

//////////////////////////////////////////////////////////////
// Actions
AddComboParamOption("Нормальный");
AddComboParamOption("Стрелка");
AddComboParamOption("Текст выбора");
AddComboParamOption("Прицел");
AddComboParamOption("Движение");
AddComboParamOption("Помощь");
AddComboParamOption("Подождите");
AddComboParamOption("Ни один");
AddComboParam("Стиль курсора", "Выберите стиль курсора для установки.");
AddAction(0, 0, "Установить стиль курсора", "Mouse", "Установите курсор <b>{0}</b>", "Изменение стиля курсора мыши.", "SetCursor");

AddObjectParam("Спрайт", "Выберите объект спрайт для использования в качестве изображения курсора.");
AddAction(1, 0, "Установить курсор из спрайта", "Mouse", "Установить курсор из спрайта {0}", "Установите курсор мыши на тот же образ, используемый спрайтом.", "SetCursorSprite");

//////////////////////////////////////////////////////////////
// Expressions
AddExpression(0, ef_return_number | ef_variadic_parameters, "Mouse X position", "Cursor", "X", "Get the mouse cursor X co-ordinate in the layout.");
AddExpression(1, ef_return_number | ef_variadic_parameters, "Mouse Y position", "Cursor", "Y", "Get the mouse cursor Y co-ordinate in the layout.");

AddExpression(2, ef_return_number, "Absolute mouse X", "Cursor", "AbsoluteX", "Get the mouse cursor X co-ordinate on the canvas.");
AddExpression(3, ef_return_number, "Absolute mouse Y", "Cursor", "AbsoluteY", "Get the mouse cursor Y co-ordinate on the canvas.");

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
