function GetBehaviorSettings()
{
	return {
		"name":			"Перепрыжка через",
		"id":			"jumpthru",
		"version":		"1.0",
		"description":	"Даёт возможность прыгать на твердое поведение Платформа.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/97/jump-thru",
		"category":		"Атрибуты",
		"flags":		bf_onlyone
	};
};

AddCondition(0, 0, "Включено", "", "{my} Включено", "Проверьте, включено ли поведение в данный момент.", "IsEnabled");

AddComboParamOption("Отключен");
AddComboParamOption("Включен");
AddComboParam("Состояние", "Определяет, считается ли объект в качестве платформы или нет.", 1);
AddAction(0, 0, "Установить включение", "", "Установить {my} <b>{0}</b>", "Определяет, считается ли объект в качестве платформы или нет.", "SetEnabled");

ACESDone();

// Property grid properties for this plugin
var property_list = [
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
