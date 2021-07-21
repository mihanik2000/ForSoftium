function GetBehaviorSettings()
{
	return {
		"name":			"8 направлении",
		"id":			"EightDir",
		"version":		"1.0",
		"description":	"Перемещает объект вверх, вниз, влево, вправо и по диагоналям.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/87/8-direction",
		"category":		"Движении",
		"flags":		0
	};
};

//////////////////////////////////////////////////////////////
// Conditions
AddCondition(0, 0, "Движется", "", "(my) перемещается", "Правда, когда объект движется.", "IsMoving");

AddCmpParam("Сравнения", "Выберите способ сравнения текущей скорости.");
AddNumberParam("Скорость", "Скорость (в точках в секунду) для сравнения текущей скорости с.");
AddCondition(1, 0, "Сравнить скорость", "", "{my} скорость {0} {1}", "Сравните текущую скорость объекта.", "CompareSpeed");

//////////////////////////////////////////////////////////////
// Actions
AddAction(0, 0, "Остановить", "", "Остановить {my}", "Установите нулевую скорость.", "Stop");
AddAction(1, 0, "Инвертировать", "", "Инвертировать {my}", "Инвертирование направления движения.", "Reverse");

AddComboParamOption("Прекратить игнорирование");
AddComboParamOption("Начать игнорирование");
AddComboParam("Ввод", "Установите, следует ли игнорировать элементы управления для данного перемещения.");
AddAction(2, 0, "Задать игнорирование ввода", "", "{0} {my} ввод пользователя", "Установите, следует ли игнорировать элементы управления для данного перемещения.", "SetIgnoreInput");

AddNumberParam("Скорость", "Новая скорость установленного объекта в пикселях в секунду.");
AddAction(3, 0, "Установка скорости", "", "Установить {my} скорость к <i>{0}</i>", "Установите текущую скорость объекта.", "SetSpeed");

AddNumberParam("Максимальная скорость", "Новая максимальная скорость установки объекта в пикселях в секунду.");
AddAction(4, 0, "Задать макс скорость", "", "Установить {my} максимальную скорость к <i>{0}</i>", "Задайте максимальную скорость объекта.", "SetMaxSpeed");

AddNumberParam("Ускорение", "Новое ускорение объекта, которое требуется задать, в пикселах на секунду в секунду.");
AddAction(5, 0, "Установить ускорение", "", "Установить {my} ускорение к <i>{0}</i>", "Задайте ускорение объекта.", "SetAcceleration");

AddNumberParam("Замедление", "Новое замедление объекта, которое необходимо установить, в пикселях на секунду в секунду.");
AddAction(6, 0, "Установить замедление", "", "Установить {my} замедление к <i>{0}</i>", "Задайте замедление объекта.", "SetDeceleration");

AddComboParamOption("Лево");
AddComboParamOption("Право");
AddComboParamOption("Вверх");
AddComboParamOption("Вниз");
AddComboParam("Управление", "Управление движением для имитации нажатия.");
AddAction(7, 0, "Симулировать движение", "", "Симулировать {my} нажат {0}", "Управление движением по событиям.", "SimulateControl");

AddComboParamOption("Отключен");
AddComboParamOption("Включен");
AddComboParam("Состояние", "Установите, следует ли включать или отключать поведение.");
AddAction(8, 0, "Установить включение", "", "Установить {my} <b>{0}</b>", "Установите, включено ли это поведение.", "SetEnabled");

AddNumberParam("Вектор X", "Компонент X для движения, который устанавливается в пикселах в секунду.");
AddAction(9, 0, "Задать вектор X", "", "Задать {my} вектор X к <b>{0}</b>", "Установите компонент X для движения.", "SetVectorX");

AddNumberParam("Вектор Y", "Компонент Y движения для установки в пикселах в секунду.");
AddAction(10, 0, "Задать вектор Y", "", "Задать {my} вектор Y к <b>{0}</b>", "Установите компонент Y для движения.", "SetVectorY");

//////////////////////////////////////////////////////////////
// Expressions
AddExpression(0, ef_return_number, "Get speed", "", "Speed", "The current object speed, in pixels per second.");
AddExpression(1, ef_return_number, "Get max speed", "", "MaxSpeed", "The maximum speed setting, in pixels per second.");
AddExpression(2, ef_return_number, "Get acceleration", "", "Acceleration", "The acceleration setting, in pixels per second per second.");
AddExpression(3, ef_return_number, "Get deceleration", "", "Deceleration", "The deceleration setting, in pixels per second per second.");
AddExpression(4, ef_return_number, "Get angle of motion", "", "MovingAngle", "The current angle of motion, in degrees.");
AddExpression(5, ef_return_number, "Get vector X", "", "VectorX", "The current X component of motion, in pixels per second.");
AddExpression(6, ef_return_number, "Get vector Y", "", "VectorY", "The current Y component of motion, in pixels per second.");

ACESDone();

// Property grid properties for this plugin
var property_list = [
	new cr.Property(ept_float, "Max speed", 200, "Максимальная скорость в пикселях в секунду, объект может перемещаться на уровне."),
	new cr.Property(ept_float, "Acceleration", 600, "Скорость ускорения в пикселях в секунду за секунду."),
	new cr.Property(ept_float, "Deceleration", 500, "Скорость замедления в пикселях в секунду за секунду."),
	new cr.Property(ept_combo, "Directions", "8 directions", "Число направлений доступных движений.", "Up & down|Left & right|4 directions|8 directions"),
	new cr.Property(ept_combo, "Set angle", "360 degree (smooth)", "Как установить угол объекта при перемещении.", "No|90-degree intervals|45-degree intervals|360 degree (smooth)"),
	new cr.Property(ept_combo, "Default controls", "Yes", "Если этот параметр включен, клавиши со стрелками управления движением включены. В противном случае используется , 'симулятор контроля ' действий.", "No|Yes"),
	new cr.Property(ept_combo, "Initial state", "Enabled", "Следует ли изначально включить поведение или отключить.", "Disabled|Enabled")
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
	// Set initial value for "default controls" if empty (added r51)
	if (property_name === "Default controls" && !this.properties["Default controls"])
		this.properties["Default controls"] = "Yes";
}
