function GetPluginSettings()
{
	return {
		"name":			"Касание",
		"id":			"Touch",
		"version":		"1.0",
		"description":	"Получить входной сигнал от устройств с сенсорным экраном, а также ориентацию устройства доступа и движения.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/119/touch",
		"category":		"Ввод",
		"type":			"object",			// not in layout
		"rotatable":	false,
		"flags":		pf_singleglobal
	};
};

//////////////////////////////////////////////////////////////
// Conditions
AddCondition(0, cf_trigger, "Любой сенсорный старт", "Касание", "Любой сенсорный старт", "Срабатывает, когда начинается любой сенсорный ввод.", "OnTouchStart");
AddCondition(1, cf_trigger, "Любой сенсорный конец", "Касание", "Любой сенсорный конец", "Срабатывает, когда любой сенсорный ввод заканчивается.", "OnTouchEnd");
AddCondition(2, 0,			"Находится в контакте", "Касание", "Находится в контакте", "Правда, если любое прикосновение в настоящее время в контакте с устройством.", "IsInTouch");

AddObjectParam("Объект", "Выберите объект для проверки прикосновения.");
AddCondition(3,	cf_trigger, "Прикоснулся объекта", "Касание", "Прикоснулся {0}", "Срабатывает, когда прикоснулся объекта.", "OnTouchObject");

AddObjectParam("Объект", "Выберите объект для проверки прикосновения.");
AddCondition(4, 0,			"В прикосании с объектом", "Касание", "В прикосании {0}", "Тест, если в контакте и сенсорной точки над объектом.", "IsTouchingObject");

AddCondition(5, cf_deprecated,			"Ориентация устройства поддерживается", "Ориентация и движение", "Ориентация устройства поддерживается", "Правда, если устройство поддерживает обнаружение ориентации.", "OrientationSupported");

AddCondition(6, cf_deprecated,			"Поддерживается движение устройства", "Ориентация и движение", "Поддерживается движение устройства", "Правда, если устройство поддерживает функцию обнаружения движения.", "MotionSupported");

AddNumberParam("Индекс касания", "Значение индекс прикосновения, чтобы проверить быстродействие. 0 является первым касанием.");
AddCmpParam("Сравнение", "Как сравнить скорости касания.");
AddNumberParam("Скорость", "Скорость, чтобы сравнить, в абсолютных пикселей в секунду.");
AddCondition(7, 0,			"Сравните скорость касания", "Касание", "Касание <b>{0}</b> скорость {1} <b>{2}</b>", "Сравните скорость прикосновения, например, для обнаружения салфетки.", "CompareTouchSpeed");

AddComboParamOption("Альфа");
AddComboParamOption("Бета");
AddComboParamOption("Гамма");
AddComboParam("Ориентация", "Выберите ориентацию для сравнения (альфа = направление компаса, бета = передней к задней части наклона, гамма = слева направо, правый наклон).");
AddCmpParam("Сравнение", "Как сравнить ориентацию.");
AddNumberParam("Угол", "Ориентация сравнить с, в градусах.")
AddCondition(8, 0,			"Сравнить ориентацию", "Ориентация и движение", "<b>{0}</b> ориентация {1} <b>{2}</b>", "Сравните текущую ориентацию (и наклон) устройства.", "CompareOrientation");

AddComboParamOption("X (с силой тяжести)");
AddComboParamOption("Y (с силой тяжести)");
AddComboParamOption("Z (с силой тяжести)");
AddComboParamOption("X (без гравитации)");
AddComboParamOption("Y (без гравитации)");
AddComboParamOption("Z (без гравитации)");
AddComboParam("Ось", "Выберите ось для сравнения ускорения, и должно ли измерение включать силу тяжести.");
AddCmpParam("Сравнение", "Как сравнить ускорение.");
AddNumberParam("Ускорение", "Ускорение сравнивать с, в м / с ^ 2.");
AddCondition(9, 0,			"Сравнить ускорение", "Ориентация и движение", "{0} ускорение {1} <b>{2}</b>", "Сравните ускорение устройства вдоль оси.", "CompareAcceleration");

AddNumberParam("Номер касания", "Введите индекс нулевой, основанный на прикосновения, чтобы проверить, например, 0 для первого прикосновения, 1 для второй и т.д.");
AddCondition(10, cf_trigger, "Сенсорное начало N", "Касание", "Касание {0} старт", "Срабатывает, когда начинается конкретная касания входного сигнала.", "OnNthTouchStart");

AddNumberParam("Номер касания", "Введите индекс нулевой, основанный на прикосновения, чтобы проверить, например, 0 для первого прикосновения, 1 для второй и т.д.");
AddCondition(11, cf_trigger, "Сенсорный конец N", "Касание", "Касание {0} конец", "Срабатывает, когда конкретный вход касания заканчивается.", "OnNthTouchEnd");

AddNumberParam("Номер касания", "Введите индекс нулевой, основанный на прикосновения, чтобы проверить, например, 0 для первого прикосновения, 1 для второй и т.д.");
AddCondition(12, 0,			"Имеет N прикосновений", "Касание", "Имеет касание {0}", "Правда если конкретная касание в настоящее время в контакте с устройством.", "HasNthTouch");

AddCondition(13, cf_trigger, "Задержано",		"Жестикуляция", "Удержание жеста", "Срабатывает, когда прикосновение проводятся в том же месте в течение времени.", "OnHoldGesture");

AddCondition(14, cf_trigger, "Нажато",		"Жестикуляция", "Нажатый жест", "Срабатывает, когда прикосновение быстро высвобождается из своего начального положения.", "OnTapGesture");

AddCondition(15, cf_trigger, "Двойное нажатие",	"Жестикуляция", "Дважды нажмите жест", "Срабатывает, когда два касания происходят в быстрой последовательности.", "OnDoubleTapGesture");

AddObjectParam("Объект", "Выберите объект для проверки.");
AddCondition(16, cf_trigger, "Задержано над объектом",		"Жестикуляция", "На удержание жеста над {0}", "Срабатывает, когда держание жеста сделан над объектом.", "OnHoldGestureObject");

AddObjectParam("Объект", "Выберите объект для проверки.");
AddCondition(17, cf_trigger, "Объект нажат",		"Жестикуляция", "Нажат на жест {0}", "Срабатывает, когда касанием жеста сделан на объекте.", "OnTapGestureObject");

AddObjectParam("Объект", "Выберите объект для проверки.");
AddCondition(18, cf_trigger, "На объекте дважды нажато",	"Жестикуляция", "Дважды нажмите на жеста {0}", "Срабатывает, когда двойное нажатие жеста делается на объекте.", "OnDoubleTapGestureObject");

//////////////////////////////////////////////////////////////
// Expressions
AddExpression(0, ef_return_number | ef_variadic_parameters, "Touch X position", "Touch", "X", "Get the primary touch X co-ordinate in the layout.");
AddExpression(1, ef_return_number | ef_variadic_parameters, "Touch Y position", "Touch", "Y", "Get the primary touch Y co-ordinate in the layout.");

AddExpression(2, ef_return_number, "Absolute touch X", "Touch", "AbsoluteX", "Get the primary touch X co-ordinate on the canvas.");
AddExpression(3, ef_return_number, "Absolute touch Y", "Touch", "AbsoluteY", "Get the primary touch Y co-ordinate on the canvas.");

AddExpression(4, ef_return_number, "Orientation alpha", "Orientation & motion", "Alpha", "The device compass direction, in degrees.");
AddExpression(5, ef_return_number, "Orientation beta", "Orientation & motion", "Beta", "The device front-to-back tilt, in degrees (front is positive).");
AddExpression(6, ef_return_number, "Orientation gamma", "Orientation & motion", "Gamma", "The device left-to-right tilt, in degrees (right is positive).");

AddExpression(7, ef_return_number, "X acceleration with gravity", "Orientation & motion", "AccelerationXWithG", "The device X acceleration with gravity, in m/s^2.");
AddExpression(8, ef_return_number, "Y acceleration with gravity", "Orientation & motion", "AccelerationYWithG", "The device Y acceleration with gravity, in m/s^2.");
AddExpression(9, ef_return_number, "Z acceleration with gravity", "Orientation & motion", "AccelerationZWithG", "The device Z acceleration with gravity, in m/s^2.");

AddExpression(10, ef_return_number, "X acceleration", "Orientation & motion", "AccelerationX", "The device X acceleration without gravity (if supported), in m/s^2.");
AddExpression(11, ef_return_number, "Y acceleration", "Orientation & motion", "AccelerationY", "The device Y acceleration without gravity (if supported), in m/s^2.");
AddExpression(12, ef_return_number, "Z acceleration", "Orientation & motion", "AccelerationZ", "The device Z acceleration without gravity (if supported), in m/s^2.");

AddExpression(13, ef_return_number, "", "Touch", "TouchCount", "Get the number of current touches.");

AddNumberParam("Index", "Zero-based index of the touch to get.");
AddExpression(14, ef_return_number | ef_variadic_parameters, "", "Touch", "XAt", "Get a touch X co-ordinate in the layout from a zero-based index of the touch.");
AddNumberParam("Index", "Zero-based index of the touch to get.");
AddExpression(15, ef_return_number | ef_variadic_parameters, "", "Touch", "YAt", "Get a touch Y co-ordinate in the layout from a zero-based index of the touch.");

AddNumberParam("Index", "Zero-based index of the touch to get.");
AddExpression(16, ef_return_number, "", "Touch", "AbsoluteXAt", "Get a touch X co-ordinate on the canvas from a zero-based index of the touch.");
AddNumberParam("Index", "Zero-based index of the touch to get.");
AddExpression(17, ef_return_number, "", "Touch", "AbsoluteYAt", "Get a touch Y co-ordinate on the canvas from a zero-based index of the touch.");

AddNumberParam("Index", "Zero-based index of the touch to get.");
AddExpression(18, ef_return_number, "", "Touch", "SpeedAt", "Get the speed of a touch, in absolute (screen) pixels per second.");

AddNumberParam("Index", "Zero-based index of the touch to get.");
AddExpression(19, ef_return_number, "", "Touch", "AngleAt", "Get the angle of motion of a touch, in degrees.");

AddExpression(20, ef_return_number, "", "Touch", "TouchIndex", "Get the index of the current touch.");

AddExpression(21, ef_return_number, "", "Touch", "TouchID", "Get the unique ID of the current touch.");

AddNumberParam("ID", "ID of the touch to get.");
AddExpression(22, ef_return_number | ef_variadic_parameters, "", "Touch", "XForID", "Get a touch X co-ordinate in the layout for a touch with a specific ID.");
AddNumberParam("ID", "ID of the touch to get.");
AddExpression(23, ef_return_number | ef_variadic_parameters, "", "Touch", "YForID", "Get a touch Y co-ordinate in the layout for a touch with a specific ID.");

AddNumberParam("ID", "ID of the touch to get.");
AddExpression(24, ef_return_number, "", "Touch", "AbsoluteXForID", "Get a touch X co-ordinate on the canvas for a touch with a specific ID.");
AddNumberParam("ID", "ID of the touch to get.");
AddExpression(25, ef_return_number, "", "Touch", "AbsoluteYForID", "Get a touch Y co-ordinate on the canvas for a touch with a specific ID.");

AddNumberParam("ID", "ID of the touch to get.");
AddExpression(26, ef_return_number, "", "Touch", "SpeedForID", "Get the speed of a touch with a specific ID, in absolute (screen) pixels per second.");

AddNumberParam("ID", "ID of the touch to get.");
AddExpression(27, ef_return_number, "", "Touch", "AngleForID", "Get the angle of motion of a touch with a specific ID, in degrees.");

AddNumberParam("ID", "ID of the touch to get.");
AddExpression(28, ef_return_number, "", "Touch", "WidthForID", "Get the width of a touch with a specific ID.");
AddNumberParam("ID", "ID of the touch to get.");
AddExpression(29, ef_return_number, "", "Touch", "HeightForID", "Get the height of a touch with a specific ID.");
AddNumberParam("ID", "ID of the touch to get.");
AddExpression(30, ef_return_number, "", "Touch", "PressureForID", "Get the pressure (from 0 to 1) of a touch with a specific ID.");

ACESDone();

// Property grid properties for this plugin
var property_list = [
	new cr.Property(ept_combo, "Use mouse input", "Да", "С помощью щелчков мыши, как одного сенсорного ввода (для тестирования).", "Нет|Да")
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
