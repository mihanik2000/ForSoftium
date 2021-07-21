function GetBehaviorSettings()
{
	return {
		"name":			"Пуля",
		"id":			"Bullet",
		"version":		"1.0",
		"description":	"Перемещение объекта вперед на его текущий угол. Обычно используется для пуль и снарядов.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/90/bullet",
		"category":		"Движении",
		"flags":		0
	};
};

//////////////////////////////////////////////////////////////
// Conditions
AddCmpParam("Сравнения", "Выберите способ сравнения текущей скорости.");
AddNumberParam("Скорость", "Скорость (в точках в секунду) для сравнения текущей скорости с.");
AddCondition(0, 0, "Сравнить скорость", "", "{my} скорость {0} {1}", "Сравните текущую скорость объекта.", "CompareSpeed");

AddCmpParam("Сравнения", "Выберите способ сравнения пройденного расстояния.");
AddNumberParam("Расстояние", "Расстояние (в точках) для сравнения.");
AddCondition(1, 0, "Сравнить пройденное расстояние", "", "{my} пройденное расстояние {0} {1}", "Сравните расстояние, пройденное объектом.", "CompareTravelled");

//////////////////////////////////////////////////////////////
// Actions
AddNumberParam("Скорость", "Новая скорость установленного объекта в пикселях в секунду.");
AddAction(0, 0, "Установка скорости", "", "Установка {my} скорости к <i>{0}</i>", "Установите текущую скорость объекта.", "SetSpeed");

AddNumberParam("Ускорение", "Новое ускорение объекта, которое требуется задать, в пикселах на секунду в секунду.");
AddAction(1, 0, "Установить ускорение", "", "Установить {my} ускорение к <i>{0}</i>", "Задайте ускорение объекта.", "SetAcceleration");

AddNumberParam("Гравитация", "Новое ускорение, вызванное гравитацией, в пикселях на секунду в секунду.");
AddAction(2, 0, "Установить гравитацию", "", "Установить {my} гравитацию к <i>{0}</i>", "Задайте силу тяжести объекту.", "SetGravity");

AddNumberParam("Угол", "Новый угол движения в градусах.");
AddAction(3, 0, "Задать угол движения", "", "Задать {my} угол движения <i>{0}</i> градусов", "Задайте угол, на котором перемещается объект.", "SetAngleOfMotion");

AddObjectParam("Объект", "Объект, который требуется отражать.");
AddAction(4, 0, "Отскакивать от объекта", "", "Отскок {my} от {0}", "Отражать объект от объекта, к которому он в данный момент касается.", "Bounce");

AddComboParamOption("Отключен");
AddComboParamOption("Включен");
AddComboParam("Состояние", "Установите, следует ли включать или отключать поведение.");
AddAction(5, 0, "Установить включение", "", "Установить {my} <b>{0}</b>", "Установите, включено ли это поведение.", "SetEnabled");

AddNumberParam("Расстояние", "Новое расстояние в пикселах, заданное для выражения пройденного расстояния.");
AddAction(6, 0, "Задать пройденное расстояние", "", "Задать {my} пройденное расстояние <i>{0}</i>", "Изменение счетчика, используемого для отслеживания пройденного расстояния.", "SetDistanceTravelled");

//////////////////////////////////////////////////////////////
// Expressions
AddExpression(0, ef_return_number, "Get speed", "", "Speed", "The current object speed, in pixels per second.");
AddExpression(1, ef_return_number, "Get acceleration", "", "Acceleration", "The acceleration setting, in pixels per second per second.");
AddExpression(2, ef_return_number, "Get angle of motion", "", "AngleOfMotion", "The angle the object is currently moving at, in degrees.");
AddExpression(3, ef_return_number, "Get distance travelled", "", "DistanceTravelled", "The distance, in pixels, the object has travelled so far.");
AddExpression(4, ef_return_number, "Get gravity", "", "Gravity", "The current gravity in pixels per second per second.");

ACESDone();

// Property grid properties for this plugin
var property_list = [
	new cr.Property(ept_float, "Speed", 400, "Скорость в пикселях в секунду, объект движется."),
	new cr.Property(ept_float, "Acceleration", 0, "Скорость ускорения в пикселях в секунду за секунду. Отрицательные значения замедляться."),
	new cr.Property(ept_float, "Gravity", 0, "Сила тяжести на пуле, в пикселях в секунду за секунду."),
	new cr.Property(ept_combo, "Bounce off solids", "No", "Сделать объект отскакивающим от твердых предметов, когда он сталкивается с ними.", "No|Yes"),
	new cr.Property(ept_combo, "Set angle", "Yes", "Заданный угол объекта на угол движения.", "No|Yes"),
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
}
