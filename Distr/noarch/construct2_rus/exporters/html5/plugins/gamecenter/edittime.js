function GetPluginSettings()
{
	return {
		"name":			"Игровой центр",			// as appears in 'insert object' dialog, can be changed as long as "id" stays the same
		"id":			"gamecenter",			// this is used to identify this plugin and is saved to the project; never change it
		"version":		"1.0",					// (float in x.y format) Plugin version - C2 shows compatibility warnings based on this
		"description":	"Доступ к Game Center на прошивки с Кордова.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/186/game-center",
		"category":		"Конкретная платформа",	// Prefer to re-use existing categories, but you can set anything here
		"type":			"object",				// either "world" (appears in layout and is drawn), else "object"
		"rotatable":	false,					// only used when "type" is "world".  Enables an angle property on the object.
		"cordova-plugins":	"uk.co.ilee.gamecenter",
		"flags":		0						// uncomment lines to enable flags...
						| pf_singleglobal		// exists project-wide, e.g. mouse, keyboard.  "type" must be "object".
					//	| pf_texture			// object has a single texture (e.g. tiled background)
					//	| pf_position_aces		// compare/set/get x, y...
					//	| pf_size_aces			// compare/set/get width, height...
					//	| pf_angle_aces			// compare/set/get angle (recommended that "rotatable" be set to true)
					//	| pf_appearance_aces	// compare/set/get visible, opacity...
					//	| pf_tiling				// adjusts image editor features to better suit tiled images (e.g. tiled background)
					//	| pf_animations			// enables the animations system.  See 'Sprite' for usage
					//	| pf_zorder_aces		// move to top, bottom, layer...
					//  | pf_nosize				// prevent resizing in the editor
					//	| pf_effects			// allow WebGL shader effects to be added
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
				
AddCondition(0, cf_trigger, "Успех", "Аутентификация", "Аутентификация успешна", "Срабатывает, когда проверка подлинности успешна.", "OnAuthSuccess");

AddCondition(1, cf_trigger, "Неудача", "Аутентификация", "Ошибка аутентификации", "Срабатывает при возникновении ошибки с проверкой подлинности.", "OnAuthFail");

AddCondition(2, cf_trigger, "Игрок получил изображение", "Аутентификация", "Игрок получил изображение", "Срабатывает после того, как 'Запрос игрока изображения', когда URL был успешно получен.", "OnPlayerImageSuccess");

AddCondition(3, cf_trigger, "Изображение игрока терпет неудачу", "Аутентификация", "Изображение игрока терпет неудачу", "Срабатывает, когда возникает ошибка пытается запросить изображение игрока..", "OnPlayerImageError");

AddCondition(4, cf_trigger, "Счёт представляет успех", "Таблица лидеров", "Счёт представляет успех", "Срабатывает после представления счета завершается успешно.", "OnScoreSubmitSuccess");

AddCondition(5, cf_trigger, "Счет представляет неудачу", "Таблица лидеров", "Счет представляет неудачу", "Срабатывает, когда происходит ошибка подачи баллов.", "OnScoreSubmitFail");

AddCondition(6, cf_trigger, "Таблица лидеров отображается", "Таблица лидеров", "Таблица лидеров отображается", "Срабатывает, когда таблица лидеров успешно отображается.", "OnShowLeaderboardSuccess");

AddCondition(7, cf_trigger, "Ошибка таблицы лидеров", "Таблица лидеров", "Ошибка таблицы лидеров", "Срабатывает, когда возникает ошибка пытается отобразить список лидеров.", "OnShowLeaderboardError");

AddCondition(8, cf_trigger, "Успех отчета достижений", "Достижения", "Успех отчета достижений", "Срабатывает, когда достижение успешно сообщается.", "OnAchievementReportSuccess");

AddCondition(9, cf_trigger, "Сообщить об ошибке достижений", "Достижения", "Сообщить об ошибке достижений", "Срабатывает при возникновении ошибки отчетности достижений.", "OnAchievementReportError");

AddCondition(10, cf_trigger, "Успех сброса достижений", "Достижения", "Успех сброса достижений", "Срабатывает, когда достижения успешно сбросаны.", "OnAchievementResetSuccess");

AddCondition(11, cf_trigger, "Ошибка сброса достижений", "Достижения", "Ошибка сброса достижений", "Срабатывает, когда возникает ошибка сброса достижений.", "OnAchievementResetError");

AddCondition(12, cf_trigger, "Список достижений получен", "Достижения", "Список достижений получен", "Срабатывает, когда список достижений получен ..", "OnAchievementList");

AddCondition(13, cf_trigger, "Ошибка в списке достижений", "Достижения", "Ошибка в списке достижений", "Срабатывает при возникновении ошибки запроса списка достижение.", "OnAchievementListError");

////////////////////////////////////////
// Actions

// AddAction(id,				// any positive integer to uniquely identify this action
//			 flags,				// (see docs) af_none, af_deprecated
//			 list_name,			// appears in event wizard list
//			 category,			// category in event wizard list
//			 display_str,		// as appears in event sheet - use {0}, {1} for parameters and also <b></b>, <i></i>
//			 description,		// appears in event wizard dialog when selected
//			 script_name);		// corresponding runtime function name

AddAction(0, af_none, "Аутентификация", "Аутентификация", "Аутентификация пользователя", "Аутентифицировать пользователя, так можно использовать функции Игровой центр.", "Auth");

AddAction(1, af_none, "Запрос об изображении игрока", "Аутентификация", "Запрос об изображении игрока", "Запрос URL к изображению игрока.", "RequestPlayerImage");

AddNumberParam("Счёт", "Счет представить на Таблицу лидеров.");
AddStringParam("ID Лидер таблицы", "Идентификатор лидеров представить счет до.");
AddAction(2, af_none, "Добавить балл", "Таблица лидеров", "Добавить балл <b>{0}</b> для Таблицу лидеров <i>{1}</i>", "Отправка счета для Таблицу лидеров.", "SubmitScore");

AddStringParam("ID Лидер таблицы", "ID лидеров, чтобы отобразить.", "\"\"", 1);
AddAction(3, af_none, "Показать Таблицу лидеров", "Таблица лидеров", "Показать Таблицу лидеров <i>{0}</i>", "Покажите нативный игровой центр лидеров.", "ShowLeaderboard");

AddStringParam("ID достижения", "ID достижения, чтобы сообщить.");
AddNumberParam("Процент", "Процент завершения, от 0-100.", "100");
AddAction(4, af_none, "Отчет достижения", "Достижения", "Отчет достижения <i>{0}</i> в <i>{1}</i> процент", "Сообщить о достижении пользователя.", "ReportAchievement");

AddAction(5, af_none, "Сбросить достижения", "Достижения", "Сбросить достижения", "Сбросить достижения пользователя и Таблицы лидеров.", "ResetAchievements");

AddAction(6, af_none, "Запрос достижения", "Достижения", "Запрос достижения", "Запросить список достижений если пользователь завершил.", "RequestAchievements");

////////////////////////////////////////
// Expressions

// AddExpression(id,			// any positive integer to uniquely identify this expression
//				 flags,			// (see docs) ef_none, ef_deprecated, ef_return_number, ef_return_string,
//								// ef_return_any, ef_variadic_parameters (one return flag must be specified)
//				 list_name,		// currently ignored, but set as if appeared in event wizard
//				 category,		// category in expressions panel
//				 exp_name,		// the expression name after the dot, e.g. "foo" for "myobject.foo" - also the runtime function name
//				 description);	// description in expressions panel

AddExpression(0, ef_return_string, "", "Authentication", "UserAlias", "After auth success, the user alias.");
AddExpression(1, ef_return_string, "", "Authentication", "PlayerID", "After auth success, the user's player ID.");
AddExpression(2, ef_return_string, "", "Authentication", "UserDisplayName", "After auth success, the name to display for the user.");
AddExpression(3, ef_return_string, "", "Authentication", "PlayerImageURL", "After 'On player image received', the URL to the image.");

AddExpression(4, ef_return_number, "", "Achievements", "AchievementCount", "After 'On achievement list received', the number of achievements.");

AddNumberParam("Index", "Index of achievement");
AddExpression(5, ef_return_string, "", "Achievements", "AchievementAt", "After 'On achievement list received', the achievement at an index.");


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
	//new cr.Property(ept_integer, 	"My property",		77,		"An example property.")
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
		
	// Plugin-specific variables
	// this.myValue = 0...
};

// Called when inserted via Insert Object Dialog for the first time
IDEInstance.prototype.OnInserted = function()
{
};

// Called when double clicked in layout
IDEInstance.prototype.OnDoubleClicked = function()
{
};

// Called after a property has been changed in the properties bar
IDEInstance.prototype.OnPropertyChanged = function(property_name)
{
};

// For rendered objects to load fonts or textures
IDEInstance.prototype.OnRendererInit = function(renderer)
{
};

// Called to draw self in the editor if a layout object
IDEInstance.prototype.Draw = function(renderer)
{
};

// For rendered objects to release fonts or textures
IDEInstance.prototype.OnRendererReleased = function(renderer)
{
};