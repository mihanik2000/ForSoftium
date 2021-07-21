function GetBehaviorSettings()
{
	return {
		"name":			"Теневая трансляция",
		"id":			"shadowcaster",
		"version":		"1.0",
		"description":	"Сделать объект чтобы отбрасывал тени от объекта Свет.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/177/shadow-caster",
		"category":		"Атрибуты",
		"flags":		bf_onlyone
	};
};


AddCondition(0, 0, "Включено", "", "{my} включено", "Проверьте, включено ли поведение в данный момент.", "IsEnabled");

AddCmpParam("Сравнения", "Сравнение высоты.");
AddNumberParam("Высота", "Высота объекта для сравнения.");
AddCondition(1, 0, "Сравнить высоту", "", "{my} высота {0} {1}", "Сравните высоту объекта.", "CompareHeight");

//////////////////////////////////////
AddComboParamOption("Отключен");
AddComboParamOption("Включен");
AddComboParam("Состояние", "Задайте, считается ли объект сплошным или нет.", 1);
AddAction(0, 0, "Установить включение", "", "Установить {my} <b>{0}</b>", "Задайте, считается ли объект сплошным или нет.", "SetEnabled");

AddNumberParam("Высота", "Высота для задания объекта для определения длины вылитой тени.");
AddAction(1, 0, "Задать высоту", "", "Задать {my} высоту к <i>{0}</i>", "Задайте высоту объекта, чтобы определить, какая длина отбрасываются.", "SetHeight");

AddStringParam("Тег", "Новый тег, который требуется задать для теневого вещания.");
AddAction(2, af_none, "Задать тег", "", "Задать {my} тег к <i>{0}</i>", "Установите тег для теневого вещания.", "SetTag");

//////////////////////////////////////
AddExpression(0, ef_return_number, "", "", "Height", "The shadow caster object height.");
AddExpression(1, ef_return_string, "", "", "Tag", "The tag of the object.");

ACESDone();

// Property grid properties for this plugin
var property_list = [
	new cr.Property(ept_combo, "Initial state", "Enabled", "Следует ли изначально включить поведение или отключить.", "Disabled|Enabled"),
	new cr.Property(ept_integer, "Height", 100, "Высота объекта в пикселях, определении длины тени она бросает."),
	new cr.Property(ept_text, "Tag", "", "Тег, чтобы определить, какие огни, чтобы бросить тень от.")
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
