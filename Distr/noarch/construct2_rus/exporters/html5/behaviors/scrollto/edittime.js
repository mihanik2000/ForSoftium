function GetBehaviorSettings()
{
	return {
		"name":			"Прокрутить до",
		"id":			"scrollto",
		"version":		"1.0",
		"description":	"Всегда центрировать вид на этом объекте, или в средней точке нескольких объектов.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/102/scroll-to",
		"category":		"Общее",
		"flags":		bf_onlyone
	};
};

// ACEs
AddNumberParam("Величина", "Прочность шейки, в максимальных точках для прокрутки.", "20");
AddNumberParam("Продолжительность", "Время, которое должно длиться, в секундах.", "0.4");
AddComboParamOption("Величина сокращения");
AddComboParamOption("Постоянная величина");
AddComboParam("Режим", "Выберите, будет ли величина постепенно сокращаться до нуля в течение длительности или оставаться постоянной.");
AddAction(0, 0, "Встряхнуть", "", "Встряхнуть {my} с величиной <i>{0}</i> для <i>{1}</i> секунд ({2})", "Пожмите экран в течение времени.", "Shake");

AddComboParamOption("отключен");
AddComboParamOption("включен");
AddComboParam("Состояние", "Включение или отключение поведения.");
AddAction(1, 0, "Установить включение", "", "Установить {my} {0}", "Включите или отключите поведение.", "SetEnabled");

ACESDone();

// Property grid properties for this plugin
var property_list = [
	new cr.Property(ept_combo, "Initial state", "Enable", "Следует ли изначально включить поведение или отключить.", "Disabled|Enabled")
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
