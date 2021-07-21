function GetBehaviorSettings()
{
	return {
		"name":			"Платформа",
		"id":			"Platform",
		"version":		"1.0",
		"description":	"Бегать и прыгать между платформами (твердыми предметами).",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/100/platform",
		"category":		"Движении",
		"flags":		0
	};
};

//////////////////////////////////////////////////////////////
// Conditions
AddCondition(0, 0, "Движется", "", "{my} движется", "Правда, когда объект движется.", "IsMoving");

AddCmpParam("Сравнения", "Выберите способ сравнения текущей скорости.");
AddNumberParam("Скорость", "Скорость (в точках в секунду) для сравнения текущей скорости с.");
AddCondition(1, 0, "Сравнить скорость", "", "{my} скорость {0} {1}", "Сравните текущую скорость объекта.", "CompareSpeed");

AddCondition(2, 0, "На полу", "", "{my} на полу", "Правда, когда объект находится на вершине твердого тела или платформы.", "IsOnFloor");

AddCondition(3, 0, "Вверх", "", "{my} вверх", "Правда, когда объект движется вверх (т.е. прыжки).", "IsJumping");

AddCondition(4, 0, "Падает", "", "{my} падает", "Правда, когда объект движется вниз (т.е. падение).", "IsFalling");

AddCondition(5, cf_trigger, "В прыжке", "Триггеры анимации", "{my} в прыжке", "Запускается при прыжке.", "OnJump");
AddCondition(6, cf_trigger, "Падение", "Триггеры анимации", "{my} падение", "Срабатывает при падении.", "OnFall");
AddCondition(7, cf_trigger, "Остановлено", "Триггеры анимации", "{my} остановлено", "Запускается при остановке перемещения.", "OnStop");
AddCondition(8, cf_trigger, "При перемещении", "Триггеры анимации", "{my} при перемещении", "Запускается при запуске перемещения.", "OnMove");
AddCondition(9, cf_trigger, "При приземлении", "Триггеры анимации", "{my} при приземлении", "Срабатывает при первом попадании на пол.", "OnLand");

AddComboParamOption("слева");
AddComboParamOption("вправо");
AddComboParam("Сторона", "Выберите сторону для проверки стены.");
AddCondition(10, 0, "По стене", "", "{my} имеет стену {0}", "Проверьте, имеет ли объект стену слева или справа.", "IsByWall");

AddCondition(11, 0, "Двойной прыжок включен", "", "{my} двойной прыжок включен", "Правда, если двойной прыжок в настоящее время включен.", "IsDoubleJumpEnabled");

//////////////////////////////////////////////////////////////
// Actions
AddComboParamOption("Прекратить игнорирование");
AddComboParamOption("Начать игнорирование");
AddComboParam("Ввод", "Установите, следует ли игнорировать элементы управления для данного перемещения.");
AddAction(0, 0, "Задать игнорирование ввода", "", "{0} {my} ввод пользователя", "Установите, следует ли игнорировать элементы управления для данного перемещения.", "SetIgnoreInput");

AddNumberParam("Макс скорость", "Новая максимальная скорость установки объекта в пикселях в секунду.");
AddAction(1, 0, "Задать макс скорость", "", "Задать {my} максимальная скорость <i>{0}</i>", "Задайте максимальную скорость объекта.", "SetMaxSpeed");

AddNumberParam("Ускорение", "Новое ускорение объекта, которое требуется задать, в пикселах на секунду в секунду.");
AddAction(2, 0, "Установить ускорение", "", "Установить {my} ускорение <i>{0}</i>", "Задайте ускорение объекта.", "SetAcceleration");

AddNumberParam("Замедление", "Новое замедление объекта, которое необходимо установить, в пикселях на секунду в секунду.");
AddAction(3, 0, "Установить замедление", "", "Установить {my} замедление <i>{0}</i>", "Задайте замедление объекта.", "SetDeceleration");

AddNumberParam("Сила прыжка", "Новая скорость, с которой начинается переход, в пикселях в секунду.");
AddAction(4, 0, "Установка силы прыжка", "", "Установка {my} переход к прыжку <i>{0}</i>", "Задание силы прыжка объекта.", "SetJumpStrength");

AddNumberParam("Гравитация", "Новое ускорение от силы тяжести, в пикселах на секунду в секунду.");
AddAction(5, 0, "Установить гравитацию", "", "Установить {my} гравитацию <i>{0}</i>", "Задайте гравитацию объекта.", "SetGravity");

AddNumberParam("Максимальная скорость падения", "Новый объект максимальной скорости может попасть в падение, в точках в секунду.");
AddAction(6, 0, "Задать макс скорость падения", "", "Установить {my} макс скорость падения <i>{0}</i>", "Задайте максимальную скорость падения для объекта.", "SetMaxFallSpeed");

AddComboParamOption("В лево");
AddComboParamOption("В право");
AddComboParamOption("Прыгать");
AddComboParam("Control", "Элемент управления движением для имитации нажатия.");
AddAction(7, 0, "Установить управление", "", "Установить {my} управление {0}", "Управление движением по событиям.", "SimulateControl");

AddNumberParam("Вектор X", "Новый горизонтальный вектор перемещения, в пикселях в секунду.");
AddAction(8, 0, "Задать вектор X", "", "Задать {my} вектор X <i>{0}</i>", "Установите компонент X для движения.", "SetVectorX");

AddNumberParam("Вектор Y", "Новый вертикальный вектор перемещения, в пикселях в секунду.");
AddAction(9, 0, "Задать вектор Y", "", "Задать {my} вектор Y <i>{0}</i>", "Задайте для движения компонент Y.", "SetVectorY");

AddNumberParam("Угол", "Угол гравитации в градусах.");
AddAction(10, 0, "Задать угол гравитации", "", "Задать {my} угол гравитации <i>{0}</i> градусов", "Измените угол, на который попадает игрок.", "SetGravityAngle");

AddComboParamOption("Отключен");
AddComboParamOption("Включен");
AddComboParam("Состояние", "Установите, следует ли включать или отключать поведение.");
AddAction(11, 0, "Установить состояние", "", "Установить {my} <b>{0}</b>", "Установите, включено ли это поведение.", "SetEnabled");

AddAction(12, 0, "Проваливаться", "", "Падение {my} вниз через переход", "Подпадает под переходную платформу.", "FallThrough");

AddComboParamOption("Отключен");
AddComboParamOption("Включен");
AddComboParam("Состояние", "Установите, следует ли включать или отключать двойные прыжки.");
AddAction(13, 0, "Установить двойной прыжок", "", "Установить {my} двойной прыжок <b>{0}</b>", "Установите, включен ли двойной прыжок.", "SetDoubleJumpEnabled");

AddNumberParam("Переход на устойчивый", "Новый прыжок в миллисекундах для поддержания скорости перехода.");
AddAction(14, 0, "Установка перехода", "", "Установка {my} переход на <b>{0}</b> мс", "Установите свойство 'переход на устойчивое'", "SetJumpSustain");

//////////////////////////////////////////////////////////////
// Expressions
AddExpression(0, ef_return_number, "Get speed", "", "Speed", "The current object speed, in pixels per second.");
AddExpression(1, ef_return_number, "Get max speed", "", "MaxSpeed", "The maximum speed setting, in pixels per second.");
AddExpression(2, ef_return_number, "Get acceleration", "", "Acceleration", "The acceleration setting, in pixels per second per second.");
AddExpression(3, ef_return_number, "Get deceleration", "", "Deceleration", "The deceleration setting, in pixels per second per second.");
AddExpression(4, ef_return_number, "Get jump strength", "", "JumpStrength", "The jump strength setting, in pixels per second.");
AddExpression(5, ef_return_number, "Get gravity", "", "Gravity", "The gravity setting, in pixels per second per second.");
AddExpression(6, ef_return_number, "Get max fall speed", "", "MaxFallSpeed", "The maximum fall speed setting, in pixels per second.");
AddExpression(7, ef_return_number, "Get angle of motion", "", "MovingAngle", "The current angle of motion, in degrees.");
AddExpression(8, ef_return_number, "Get vector X", "", "VectorX", "The current X component of motion, in pixels.");
AddExpression(9, ef_return_number, "Get vector Y", "", "VectorY", "The current Y component of motion, in pixels.");

AddExpression(10, ef_return_number, "Get gravity angle", "", "GravityAngle", "The angle of gravity, in degrees.");

AddExpression(11, ef_return_number, "", "", "JumpSustain", "The jump sustain property, in milliseconds.");

ACESDone();

// Property grid properties for this plugin
var property_list = [
	new cr.Property(ept_float, "Max speed", 330, "Максимальная скорость в пикселях в секунду, объект может разгоняться до."),
	new cr.Property(ept_float, "Acceleration", 1500, "Скорость ускорения в пикселях в секунду за секунду."),
	new cr.Property(ept_float, "Deceleration", 1500, "Скорость замедления в пикселях в секунду за секунду."),
	new cr.Property(ept_float, "Jump strength", 650, "Скорость, при которой прыжки старт в пикселях в секунду."),
	new cr.Property(ept_float, "Gravity", 1500, "Ускорение от силы тяжести, в пикселях в секунду за секунду."),
	new cr.Property(ept_float, "Max fall speed", 1000, "Максимальная скорость объекта может достигать в свободном падении, в пикселях в секунду."),
	new cr.Property(ept_combo, "Double jump", "Disabled", "Разрешить единственный дополнительный прыжок в то время как в воздухе перед посадкой.", "Disabled|Enabled"),
	new cr.Property(ept_float, "Jump sustain", 0, "Время в миллисекундах, чтобы прыгать, чтобы выдержать в течение, достигнув выше, если холдинг дольше."),
	new cr.Property(ept_combo, "Default controls", "Yes", "Если этот параметр включен, клавиши со стрелками управления движением работают. В противном случае используйте  'симулятор контроля' действия.", "No|Yes"),
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
