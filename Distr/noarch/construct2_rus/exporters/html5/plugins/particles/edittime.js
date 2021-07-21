function GetPluginSettings()
{
	return {
		"name":			"Частицы",			// as appears in 'insert object' dialog, can be changed as long as "id" stays the same
		"id":			"Particles",			// this is used to identify this plugin and is saved to the project; never change it
		"version":		"1.0",					// (float in x.y format) Plugin version - C2 shows compatibility warnings based on this
		"description":	"Создание спрея частиц. Полезно для визуальных эффектов.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/135/particles",
		"category":		"Общее",				// Prefer to re-use existing categories, but you can set anything here
		"type":			"world",				// either "world" (appears in layout and is drawn), else "object"
		"rotatable":	true,					// only used when "type" is "world".  Enables an angle property on the object.
		"flags":		0						// uncomment lines to enable flags...
					//	| pf_singleglobal		// exists project-wide, e.g. mouse, keyboard.  "type" must be "object".
						| pf_texture			// object has a single texture (e.g. tiled background)
						| pf_position_aces		// compare/set/get x, y...
					//	| pf_size_aces			// compare/set/get width, height...
						| pf_angle_aces			// compare/set/get angle (recommended that "rotatable" be set to true)
						| pf_appearance_aces	// compare/set/get visible, opacity...
					//	| pf_tiling				// adjusts image editor features to better suit tiled images (e.g. tiled background)
					//	| pf_animations			// enables the animations system.  See 'Sprite' for usage
						| pf_zorder_aces		// move to top, bottom, layer...
						| pf_effects
						| pf_predraw
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
				
AddCondition(0, cf_none, "Распыление", "Распыление частиц", "Распыление", "Правда, если непрерывный спрей в данный момент включен.", "IsSpraying");

////////////////////////////////////////
// Actions

// AddAction(id,				// any positive integer to uniquely identify this action
//			 flags,				// (see docs) af_none, af_deprecated
//			 list_name,			// appears in event wizard list
//			 category,			// category in event wizard list
//			 display_str,		// as appears in event sheet - use {0}, {1} for parameters and also <b></b>, <i></i>
//			 description,		// appears in event wizard dialog when selected
//			 script_name);		// corresponding runtime function name

AddComboParamOption("не распылять");
AddComboParamOption("распылять");
AddComboParam("Состояние", "Включен ли в данный момент распыление.");
AddAction(0, af_none, "Установка распыления", "Распыление частиц", "Установлен {0}", "Включите или отключите непрерывный спрей.", "SetSpraying");

AddNumberParam("Темп", "Количество частиц, создаваемых в секунду.");
AddAction(1, af_none, "Установить темп", "Распыление частиц", "Установите скорость {0}", "Задайте количество частиц, созданных в секунду.", "SetRate");

AddNumberParam("Спрей-конус", "Количество степеней, через которые создаются частицы.");
AddAction(2, af_none, "Установка конуса распыления", "Распыление частиц", "Установить конус для распыления {0} градусов", "Задайте количество степеней, с помощью которых создаются частицы.", "SetSprayCone");

AddComboParamOption("Нормальный");
AddComboParamOption("Аддитив");
AddComboParamOption("XOR");
AddComboParamOption("Копия");
AddComboParamOption("Место назначения");
AddComboParamOption("Источник в");
AddComboParamOption("Место назначения в");
AddComboParamOption("Источник");
AddComboParamOption("Назначение");
AddComboParamOption("Источник на вершине");
AddComboParamOption("Место назначения на вершине");
AddComboParam("Режим наложения", "Выберите новый режим наложения для данного объекта.");
AddAction(3, 0, "Установка режима наложения", "Внешность", "Установить режим наложения <i>{0}</i>", "Задайте режим перехода в фоновом режиме для данного объекта.", "SetEffect");

AddNumberParam("Скорость", "Начальная скорость частиц в пикселях в секунду.");
AddAction(4, af_none, "Установка скорости", "Исходные свойства частиц", "Установить начальную скорость частиц {0}", "Установите начальную скорость частиц.", "SetInitSpeed");

AddNumberParam("Размер", "Начальный размер каждой частицы в пикселях.");
AddAction(5, af_none, "Задать размер", "Исходные свойства частиц", "Задать начальный размер частицы {0}", "Задать начальный размер каждой частицы.", "SetInitSize");

AddNumberParam("Помутнение", "Начальная непрозрачность каждой частицы, от 0 (прозрачная) до 100 (непрозрачный).");
AddAction(6, af_none, "Задать непрозрачность", "Исходные свойства частиц", "Задать непрозрачность начальных частиц {0}", "Установите непрозрачность начальных частиц.", "SetInitOpacity");

AddNumberParam("Рост", "Скорость изменения размера с течением времени в пикселах в секунду.");
AddAction(7, af_none, "Установить коэффициент роста", "Исходные свойства частиц", "Установить коэффициент роста {0}", "Установить скорость роста начальной частицы.", "SetGrowRate");

AddNumberParam("X рандомисер", "Случайное смещение по оси X при создании.");
AddAction(8, af_none, "Установить X рандомисер", "Исходные свойства частиц", "Установить начальную частицу X рандомисер {0}", "Установите начальную частицу X рандомисер.", "SetXRandomiser");

AddNumberParam("Y рандомисер", "Случайное смещение по оси Y при создании.");
AddAction(9, af_none, "Установить Y рандомисер", "Исходные свойства частиц", "Установить начальную частицу Y рандомисер {0}", "Установите начальную частицу Y рандомисер.", "SetYRandomiser");

AddNumberParam("Скорость рандомисер", "Случайное добавление к скорости частиц при создании.");
AddAction(10, af_none, "Установить скорость рандомисер", "Исходные свойства частиц", "Установить начальную скорость частиц рандомисер {0}", "Установите случайное добавление к скорости частиц при создании.", "SetSpeedRandomiser");

AddNumberParam("Размер рандомисер", "Случайное добавление к размеру частиц при создании.");
AddAction(11, af_none, "Установить размер рандомисер", "Исходные свойства частиц", "Установить начальный размер частиц рандомисер {0}", "Установите случайное добавление к размеру частиц при создании.", "SetSizeRandomiser");

AddNumberParam("Коэффициент роста рандомисер", "Случайное сложение частиц по мере создания.");
AddAction(12, af_none, "Установить коэф. роста ранд.", "Исходные свойства частиц", "Установить коэффициент роста первоначальной частицы рандомисер {0}", "Установите значение случайного сложения частиц при создании.", "SetGrowRateRandomiser");

AddNumberParam("Ускорение", "Ускорение частиц в пикселах в секунду.");
AddAction(13, af_none, "Установить ускорение", "Свойства времени жизни частиц", "Установить ускорение частиц {0}", "Установите ускорение частиц.", "SetParticleAcc");

AddNumberParam("Сила тяжести", "Сила тяжести, в пикселях за секунду.");
AddAction(14, af_none, "Установить гравитацию", "Свойства времени жизни частиц", "Установить гравитацию частиц {0}", "Задайте силу тяжести.", "SetGravity");

AddNumberParam("Угол рандомисер", "Максимальное случайное отклонение угла в градусах в секунду.");
AddAction(15, af_none, "Задать угол рандомисер", "Свойства времени жизни частиц", "Задать угол частицы рандомисер {0}", "Установите максимальный случайный отклонение угла в секунду.", "SetAngleRandomiser");

AddNumberParam("Скорость рандомисер", "Максимальная частота случайной скорости в секунду, в пикселах в секунду.");
AddAction(16, af_none, "Установить скорость рандомисер", "Свойства времени жизни частиц", "Установить скорость частиц рандомисер {0}", "Установите максимальную частоту случайной скорости в секунду.", "SetLifeSpeedRandomiser");

AddNumberParam("Непрозрачность рандомисер", "Максимальная регулировка непрозрачности случайных чисел в секунду.");
AddAction(17, af_none, "Установить непрозрачность ранд.", "Свойства времени жизни частиц", "Установить непрозрачность частиц рандомисер {0}", "Установите максимальную степень непрозрачности случайных чисел в секунду.", "SetOpacityRandomiser");

AddNumberParam("Ожидания", "Время в секундах, в течение которого таймаут или становится невидимым (в зависимости от режима уничтожения).");
AddAction(18, af_none, "Установить тайм-аут", "Свойства времени жизни частиц", "Установить тайм-аут для частиц {0}", "Установите время ожидания удаления или затухание до невидимого времени.", "SetTimeout");

////////////////////////////////////////
// Expressions

// AddExpression(id,			// any positive integer to uniquely identify this expression
//				 flags,			// (see docs) ef_none, ef_deprecated, ef_return_number, ef_return_string,
//								// ef_return_any, ef_variadic_parameters (one return flag must be specified)
//				 list_name,		// currently ignored, but set as if appeared in event wizard
//				 category,		// category in expressions panel
//				 exp_name,		// the expression name after the dot, e.g. "foo" for "myobject.foo" - also the runtime function name
//				 description);	// description in expressions panel

AddExpression(0, ef_return_number, "Get particle count", "Particle spray", "ParticleCount", "Return the number of particles.");
AddExpression(1, ef_return_number, "Get rate", "Particle spray", "Rate", "The number of particles created per second.");
AddExpression(2, ef_return_number, "Get spray cone", "Particle spray", "SprayCone", "The number of degrees through which particles are created.");

AddExpression(3, ef_return_number, "Get speed", "Initial particle properties", "InitSpeed",		"The initial particle speed, in pixels per second.");
AddExpression(4, ef_return_number, "Get size", "Initial particle properties", "InitSize",		"The initial particle size, in pixels.");
AddExpression(5, ef_return_number, "Get opacity", "Initial particle properties", "InitOpacity",		"The initial particle opacity, from 0 (transparent) to 100 (opaque).");
AddExpression(6, ef_return_number, "Get grow rate", "Initial particle properties", "InitGrowRate",		"The initial particle grow rate, in pixels per second.");
AddExpression(7, ef_return_number, "Get X randomiser", "Initial particle properties", "XRandom",		"The random X offset on creation.");
AddExpression(8, ef_return_number, "Get Y randomiser", "Initial particle properties", "YRandom",		"The random Y offset on creation.");
AddExpression(9, ef_return_number, "Get speed randomiser", "Initial particle properties", "InitSpeedRandom",		"The random addition to particle speed on creation.");
AddExpression(10, ef_return_number, "Get size randomiser", "Initial particle properties", "InitSizeRandom",		"The random addition to particle size on creation.");
AddExpression(11, ef_return_number, "Get grow rate randomiser", "Initial particle properties", "InitGrowRandom",		"The random addition to particle grow rate on creation.");

AddExpression(12, ef_return_number, "Get acceleration", "Particle lifetime properties", "ParticleAcceleration", "The particle acceleration in pixels per second per second.");
AddExpression(13, ef_return_number, "Get gravity", "Particle lifetime properties", "Gravity", "The force of gravity in pixels per second per second.");
AddExpression(14, ef_return_number, "Get angle randomiser", "Particle lifetime properties", "ParticleAngleRandom", "The maximum random angle deflection in degrees per second.");
AddExpression(15, ef_return_number, "Get speed randomiser", "Particle lifetime properties", "ParticleSpeedRandom", "The maximum random change in speed in pixels per second per second.");
AddExpression(16, ef_return_number, "Get opacity randomiser", "Particle lifetime properties", "ParticleOpacityRandom", "The maximum change in opacity per second.");
AddExpression(17, ef_return_number, "Get timeout", "Particle lifetime properties", "Timeout", "The destroy or fade to invisible timeout.");

////////////////////////////////////////
ACESDone();

////////////////////////////////////////
// Array of property grid properties for this plugin
// new cr.Property(ept_integer,		name,	initial_value,	description)		// an integer value
// new cr.Property(ept_float,		name,	initial_value,	description)		// a float value
// new cr.Property(ept_text,		name,	initial_value,	description)		// a string
// new cr.Property(ept_color,		name,	initial_value,	description)		// a color dropdown
// new cr.Property(ept_font,		name,	"Arial,-16", 	description)		// a font with the given face name and size
// new cr.Property(ept_combo,		name,	"Item 1",		description, "Item 1|Item 2|Item 3")	// a dropdown list (initial_value is string of initially selected item)
// new cr.Property(ept_link,		name,	link_text,		description, "firstonly")		// has no associated value; simply calls "OnPropertyChanged" on click

var property_list = [
	// Properties
	new cr.Property(ept_float, 	"Rate",			50,					"Число частиц для создания в секунду, или общее количество за один выстрел."),
	new cr.Property(ept_float,	"Spray cone",	60,					"Число градусов, через которые созданы частицы."),
	new cr.Property(ept_combo,	"Type",			"Continuous spray",	"Либо спрей или один выстрел взрыв частиц.", "Continuous spray|One-shot"),
	new cr.Property(ept_link,	"Образ",		lang("project\\misc\\particles-edit-link"), "Нажмите для редактирования изображения частиц.", "firstonly"),
	//new cr.Property(ept_combo,	"Effect",		"(none)",			"Choose an effect for this object.  (This does not preview in the layout, only when you run.)", "(none)|Additive|XOR|Copy|Destination over|Source in|Destination in|Source out|Destination out|Source atop|Destination atop"),
	
	// Creation settings
	new cr.Property(ept_section, "Initial particle properties", "",	"Свойства, влияющие на создание каждой частицы."),
	new cr.Property(ept_float,	"Speed",		200,				"Начальная скорость частиц в пикселях в секунду."),
	new cr.Property(ept_float,	"Size",			32,					"Начальный размер каждой частицы в пикселях."),
	new cr.Property(ept_float,	"Opacity",		100,				"Первоначальная непрозрачности каждой частицы, от 0 (полностью прозрачный) до 100 (непрозрачный)."),
	new cr.Property(ept_float,	"Grow rate",	0,					"Оценить изменения размера с течением времени, в пикселях в секунду."),
	new cr.Property(ept_float,	"X randomiser",	0,					"Случайная X смещение координат по созданию."),
	new cr.Property(ept_float,	"Y randomiser",	0,					"Случайная Y смещение координат по созданию."),
	new cr.Property(ept_float,	"Speed randomiser ", 0,				"Случайное добавление к скорости частиц при создании."),
	new cr.Property(ept_float,	"Size randomiser", 0,				"Случайное добавление к размеру частиц по созданию."),
	new cr.Property(ept_float,	"Grow rate randomiser", 0,			"Случайное добавление к скорости роста частиц по созданию."),
	
	// Particle lifetime settings
	new cr.Property(ept_section, "Particle lifetime properties", "", "Свойства, влияющие на поведение каждой частицы."),
	new cr.Property(ept_float,	"Acceleration",	-150,				"Ускорение каждой частицы в пикселях в секунду за секунду."),
	new cr.Property(ept_float,	"Gravity",		0,					"Сила тяжести, в пикселях в секунду за секунду."),
	new cr.Property(ept_float,	"Angle randomiser", 0,				"Максимальный случайный угол отклонения в градусах в секунду."),
	new cr.Property(ept_float,	"Speed randomiser", 800,			"Максимальная случайная регулировка скорости в секунду, в пикселях в секунду за секунду."),
	new cr.Property(ept_float,	"Opacity randomiser", 0,			"Максимальная случайная регулировка непрозрачности в секунду."),
	new cr.Property(ept_combo,	"Destroy mode",	"Fade to invisible", "Выберите, когда каждая отдельная частица разрушается.", "Fade to invisible|Timeout expired|Particle stopped"),
	new cr.Property(ept_float,	"Timeout",		1,					"Время в секундах для тайм-аута или замирания к невидимым (в зависимости от режима уничтожения).")
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
}

IDEInstance.prototype.OnCreate = function()
{
	// Always use middle-left hotspot
	this.instance.SetHotspot(new cr.vector2(0, 0.5));
}

IDEInstance.prototype.OnInserted = function()
{
	this.instance.SetSize(new cr.vector2(128, 128));
}

IDEInstance.prototype.OnDoubleClicked = function()
{
	this.instance.EditTexture();
}

// Called by the IDE after a property has been changed
IDEInstance.prototype.OnPropertyChanged = function(property_name)
{
	// Edit image link
	if (property_name === "Образ")
	{
		this.instance.EditTexture();
	}
}

IDEInstance.prototype.OnRendererInit = function(renderer)
{
	renderer.LoadTexture(this.instance.GetTexture());
}
	
// Called to draw self in the editor
IDEInstance.prototype.Draw = function(renderer)
{
	var texture = this.instance.GetTexture();
	renderer.SetTexture(this.instance.GetTexture());
	var sz = texture.GetImageSize();
	
	// Draw particle image in middle
	var q = this.instance.GetBoundingQuad();
	var imgx = cr.quad.prototype.midX.apply(q) - sz.x / 2;
	var imgy = cr.quad.prototype.midY.apply(q) - sz.y / 2;
	var q2 = new cr.quad();
	q2.set_from_rect(new cr.rect(imgx, imgy, imgx + sz.x, imgy + sz.y));
	
	renderer.Quad(q2, this.instance.GetOpacity());
	
	// Draw lines indicating spray cone, 100px long
	var origin = new cr.vector2((q.tlx + q.blx) / 2, (q.tly + q.bly) / 2);
	
	var a = this.instance.GetAngle();
	var da = cr.to_radians(this.properties["Spray cone"]) / 2;
	
	var end1 = new cr.vector2(origin.x + Math.cos(a - da) * 100, origin.y + Math.sin(a - da) * 100);
	var end2 = new cr.vector2(origin.x + Math.cos(a + da) * 100, origin.y + Math.sin(a + da) * 100);
	renderer.Line(origin, end1, cr.RGB(255, 0, 0));
	renderer.Line(origin, end2, cr.RGB(255, 0, 0));
}

IDEInstance.prototype.OnRendererReleased = function(renderer)
{
	renderer.ReleaseTexture(this.instance.GetTexture());
}