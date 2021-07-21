function GetPluginSettings()
{
	return {
		"name":			"Видео",				// as appears in 'insert object' dialog, can be changed as long as "id" stays the same
		"id":			"video",				// this is used to identify this plugin and is saved to the project; never change it
		"version":		"1.0",					// (float in x.y format) Plugin version - C2 shows compatibility warnings based on this
		"description":	"Воспроизведение видео в игре.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/181/video",
		"category":		"Медиа",				// Prefer to re-use existing categories, but you can set anything here
		"type":			"world",				// either "world" (appears in layout and is drawn), else "object"
		"rotatable":	false,					// only used when "type" is "world".  Enables an angle property on the object.
		"flags":		0						// uncomment lines to enable flags...
					//	| pf_singleglobal		// exists project-wide, e.g. mouse, keyboard.  "type" must be "object".
					//	| pf_texture			// object has a single texture (e.g. tiled background)
						| pf_position_aces		// compare/set/get x, y...
						| pf_size_aces			// compare/set/get width, height...
					//	| pf_angle_aces			// compare/set/get angle (recommended that "rotatable" be set to true)
						| pf_appearance_aces	// compare/set/get visible, opacity...
					//	| pf_tiling				// adjusts image editor features to better suit tiled images (e.g. tiled background)
					//	| pf_animations			// enables the animations system.  See 'Sprite' for usage
						| pf_zorder_aces		// move to top, bottom, layer...
					//  | pf_nosize				// prevent resizing in the editor
						| pf_effects			// allow WebGL shader effects to be added
					//  | pf_predraw			// set for any plugin which draws and is not a sprite (i.e. does not simply draw
												// a single non-tiling image the size of the object) - required for effects to work properly
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
							
AddCondition(0, cf_none, "Играет", "Видео", "Играет", "Правда, если видео воспроизводится в данный момент.", "IsPlaying");

AddCondition(1, cf_none, "Приостановлена", "Видео", "Приостановлена", "Правда, если видео в настоящее время приостановлена.", "IsPaused");

AddCondition(2, cf_none, "Закончился", "Видео", "Закончился", "Правда, если видео закончила играть.", "HasEnded");

AddCondition(3, cf_none, "Без звука", "Видео", "Без звука", "Правда, если у видео звук отключен.", "IsMuted");

AddComboParamOption("Может играть");			// 0
AddComboParamOption("Можно играть через");	// 1
AddComboParamOption("Закончилось");				// 2
AddComboParamOption("Ошибка");				// 3
AddComboParamOption("Начало загрузки");		// 4
AddComboParamOption("Играет");				// 5
AddComboParamOption("Приостановлена");				// 6
AddComboParamOption("Задержанный");				// 7
AddComboParam("Событие", "Событие воспроизведения для проверки.");
AddCondition(4, cf_trigger, "Воспроизведение событий", "Видео", "{0}", "Вызывается, когда происходит событие воспроизведения.", "OnPlaybackEvent");

////////////////////////////////////////
// Actions

// AddAction(id,				// any positive integer to uniquely identify this action
//			 flags,				// (see docs) af_none, af_deprecated
//			 list_name,			// appears in event wizard list
//			 category,			// category in event wizard list
//			 display_str,		// as appears in event sheet - use {0}, {1} for parameters and also <b></b>, <i></i>
//			 description,		// appears in event wizard dialog when selected
//			 script_name);		// corresponding runtime function name

AddStringParam("Источник WebM", "Название .webm видео файл, используя VP8 или VP9 кодек.");
AddStringParam("Источник Ogg Theora", "Название .ogv видео файла с помощью Theora / Vorbis кодек.");
AddStringParam("Источник H.264", "Название видео файла .mp4 с использованием кодека H.264.");
AddAction(0, af_none, "Установить источник", "Видео", "Установить источник видео <i>{0}</i> (WebM), <i>{1}</i> (Ogg Theora), <i>{2}</i> (H.264)", "Переключение на другой видео. Это автоматически не начать играть.", "SetSource");

AddNumberParam("Время", "Время воспроизведения в секундах, чтобы стремиться.");
AddAction(1, af_none, "Установить время воспроизведения", "Видео", "Установить время <b>{0}</b> секунд", "Установите текущее время воспроизведения в секундах.", "SetPlaybackTime");

AddComboParamOption("не зацикливаться");
AddComboParamOption("зацикливаться");
AddComboParam("Режим", "Независимо от того есть или нет видео должного цикла, когда он дойдет до конца.");
AddAction(2, af_none, "Установить зацикливание", "Видео", "Установить {0}", "Установить петли для видео, когда он достигает конца.", "SetLooping");

AddComboParamOption("не беззвучный");
AddComboParamOption("беззвучный");
AddComboParam("Режим", "Так или иначе звук должен быть заглушен.");
AddAction(3, af_none, "Установить беззвучность", "Видео", "Установить {0}", "Установите, будет ли приглушен звук.", "SetMuted");

AddNumberParam("Громкость", "Громкость звука, чтобы установить, в затухания дБ.", "-6");
AddAction(4, af_none, "Установить громкость", "Видео", "Установить громкость <b>{0}</b> dB", "Установите громкость сопровождающего звука.", "SetVolume");

AddAction(5, af_none, "Пауза", "Видео", "Пауза", "Пауза текущего воспроизведения.", "Pause");

AddAction(6, af_none, "Играть", "Видео", "Играть", "Начать воспроизведение видео, если остановлено или на паузе. На мобильных устройствах, может работать только в качестве триггера пользовательского ввода.", "Play");

////////////////////////////////////////
// Expressions

// AddExpression(id,			// any positive integer to uniquely identify this expression
//				 flags,			// (see docs) ef_none, ef_deprecated, ef_return_number, ef_return_string,
//								// ef_return_any, ef_variadic_parameters (one return flag must be specified)
//				 list_name,		// currently ignored, but set as if appeared in event wizard
//				 category,		// category in expressions panel
//				 exp_name,		// the expression name after the dot, e.g. "foo" for "myobject.foo" - also the runtime function name
//				 description);	// description in expressions panel

AddExpression(0, ef_return_number, "", "Video", "PlaybackTime", "Current playback time in seconds.");

AddExpression(1, ef_return_number, "", "Video", "Duration", "Video duration in seconds, if known.");

AddExpression(2, ef_return_number, "", "Video", "Volume", "Current video volume in dB attenuation.");

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
	new cr.Property(ept_text, 	"WebM source",		"",		"Название .webm видео файл, используя VP8 или VP9 кодек."),
	new cr.Property(ept_text, 	"Ogg Theora source", "",	"Название .ogv видео файла с помощью Theora / Vorbis кодек."),
	new cr.Property(ept_text, 	"H.264 source",		"",		"Название видео файла .mp4 с использованием кодека H.264."),
	new cr.Property(ept_combo,	"Autoplay",			"Yes",	"Если ничего не делать, начать загрузку, или начать играть после создания.", "No|Preload|Yes"),
	new cr.Property(ept_combo,	"Play in background",	"No",	"Продолжайте играть видео, даже если вкладка или приложение переходит в на задний план.", "No|Yes"),
	new cr.Property(ept_combo,	"Initial visibility",	"Visible",	"Выберите, отображается ли при запуске видео.", "Invisible|Visible")
	];
	
// Called by IDE when a new object type is to be created
function CreateIDEObjectType()
{
	return new IDEObjectType();
};

// Class representing an object type in the IDE
function IDEObjectType()
{
	assert2(this instanceof arguments.callee, "Constructor called as a function");
};

// Called by IDE when a new object instance of this type is to be created
IDEObjectType.prototype.CreateInstance = function(instance)
{
	return new IDEInstance(instance);
};

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
};

IDEInstance.prototype.OnCreate = function()
{
	this.instance.SetHotspot(new cr.vector2(0, 0));
}

// Called when inserted via Insert Object Dialog for the first time
IDEInstance.prototype.OnInserted = function()
{
	this.instance.SetSize(new cr.vector2(320, 240));
}

// Called when double clicked in layout
IDEInstance.prototype.OnDoubleClicked = function()
{
}

// Called after a property has been changed in the properties bar
IDEInstance.prototype.OnPropertyChanged = function(property_name)
{
}

// For rendered objects to load fonts or textures
IDEInstance.prototype.OnRendererInit = function(renderer)
{
}

// Called to draw self in the editor if a layout object
IDEInstance.prototype.Draw = function(renderer)
{
	var q = this.instance.GetBoundingQuad();
	var tl = new cr.vector2(q.tlx, q.tly);
	var tr = new cr.vector2(q.trx, q.try_);
	var br = new cr.vector2(q.brx, q.bry);
	var bl = new cr.vector2(q.blx, q.bly);
	var c = cr.RGB(0, 0, 255)
	renderer.Line(tl, tr, c);
	renderer.Line(tr, br, c);
	renderer.Line(br, bl, c);
	renderer.Line(bl, tl, c);
	renderer.Line(tl, br, c);
	renderer.Line(bl, tr, c);
}

// For rendered objects to release fonts or textures
IDEInstance.prototype.OnRendererReleased = function(renderer)
{
}