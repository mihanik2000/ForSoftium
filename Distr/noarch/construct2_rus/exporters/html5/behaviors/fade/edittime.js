function GetBehaviorSettings()
{
	return {
		"name":			"Исчезать",
		"id":			"Fade",
		"version":		"1.0",
		"description":	"Измените непрозрачность объекта с течением времени. Полезно для создания объектов которое постепенно исчезают.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/95/fade",
		"category":		"Общее",
		"flags":		0
	};
};

//////////////////////////////////////////////////////////////
// Conditions
AddCondition(0, cf_trigger, "При завершении затухания", "", "{my} затухание завершено", "Активируется при завершении затухания.", "OnFadeOutEnd");

AddCondition(1, cf_trigger, "При плавном завершении", "", "{my} плавное завершение", "Активируется при завершении слияния с фоном.", "OnFadeInEnd");

AddCondition(2, cf_trigger, "Ожидание завершено", "", "{my} ожидание завершено", "Активируется при завершении ожидания.", "OnWaitEnd");

//////////////////////////////////////////////////////////////
// Actions
AddAction(0, 0, "Перезапустить слияние", "", "{my}: перезапустить слияние", "Снова запустить слияние.", "RestartFade");
AddAction(1, 0, "Начало слияния", "", "{my}: начало слияния", "Запуск слияния с фоном, если он не активен при запуске.", "StartFade");

AddNumberParam("Время затухания", "Время в секундах, которое необходимо потратить на фазу постепенного исчезновения.");
AddAction(2, 0, "Задать время затухания", "", "{my}: установить время затухания <i>{0}</i>", "Задайте свойства времени слияния.", "SetFadeInTime");

AddNumberParam("Время ожидания", "Время в секундах, которое необходимо потратить на этап ожидания.");
AddAction(3, 0, "Задать время ожидания", "", "{my}: установить время ожидания <i>{0}</i>", "Задайте свойство времени ожидания.", "SetWaitTime");

AddNumberParam("Время затухания", "Время в секундах, которое необходимо потратить на фазу затухания.");
AddAction(4, 0, "Задать время затухания", "", "{my}: установить время затухания <i>{0}</i>", "Задайте свойства времени затухания.", "SetFadeOutTime");

//////////////////////////////////////////////////////////////
// Expressions
AddExpression(0, ef_return_number, "", "", "FadeInTime", "The fade-in time in seconds.");
AddExpression(1, ef_return_number, "", "", "WaitTime", "The wait time in seconds.");
AddExpression(2, ef_return_number, "", "", "FadeOutTime", "The fade-out time in seconds.");

ACESDone();

// Property grid properties for this plugin
var property_list = [
	new cr.Property(ept_combo, "Active at start", "Yes", "Будет ли замирание немедленно начинает работать, или на действии 'Пуск'.", "No|Yes"),
	new cr.Property(ept_float, "Fade in time", 0, "Продолжительность в секундах наплывом , или ноль, чтобы пропустить."),
	new cr.Property(ept_float, "Wait time", 0, "Продолжительность в секундах время ожидания между выцветанию и исчезать-аут, или ноль, чтобы пропустить."),
	new cr.Property(ept_float, "Fade out time", 1, "Продолжительность в секундах постепенного исчезновения, или ноль, чтобы пропустить."),
	new cr.Property(ept_combo, "Destroy", "After fade out", "Уничтожить объект после того, как он затухает.", "No|After fade out")
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
	// Clamp values
	if (this.properties["Fade in time"] < 0)
		this.properties["Fade in time"] = 0;
		
	if (this.properties["Wait time"] < 0)
		this.properties["Wait time"] = 0;
		
	if (this.properties["Fade out time"] < 0)
		this.properties["Fade out time"] = 0;
}
