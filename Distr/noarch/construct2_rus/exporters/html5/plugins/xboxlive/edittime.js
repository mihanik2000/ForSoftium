function GetPluginSettings()
{
	return {
		"name":			"Xbox Live",			// as appears in 'insert object' dialog, can be changed as long as "id" stays the same
		"id":			"XboxLive",				// this is used to identify this plugin and is saved to the project; never change it
		"version":		"1.0",					// (float in x.y format) Plugin version - C2 shows compatibility warnings based on this
		"description":	"Доступ к службам Xbox Live для Windows 10 и Xbox.",
		"author":		"Scirra",
		"help url":		"https://www.scirra.com",
		"category":		"Конкретная платформа",	// Prefer to re-use existing categories, but you can set anything here
		"type":			"object",				// either "world" (appears in layout and is drawn), else "object"
		"rotatable":	false,					// only used when "type" is "world".  Enables an angle property on the object.
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
							
AddCondition(0, cf_none, "Доступна ли Xbox Live", "Xbox Live", "Доступна Xbox Live", "Проверьте, доступны ли функции Xbox Live.", "IsXboxLiveAvailable");

AddCondition(1, cf_trigger, "Успешный вход", "Xbox Live", "Успешный вход", "Срабатывает, когда вход успешно завершен.", "OnSignInSuccess");
AddCondition(2, cf_trigger, "Ошибка входа", "Xbox Live", "Ошибка входа", "Срабатывает, когда вход не удается завершить.", "OnSignInError");

AddCondition(8, cf_trigger, "При успешном входе", "Xbox Live", "При успешном входе", "Активируется при успешном завершении входа в автоматическом режиме.", "OnSilentSignInSuccess");
AddCondition(9, cf_trigger, "При неавтоматическом входе в систему", "Xbox Live", "При неавтоматическом входе в систему", "Запускается при незавершении входа в систему без уведомления.", "OnSilentSignInError");

AddCondition(3, cf_none, "Вход выполнен", "Xbox Live", "Вход выполнен", "Правда, если пользователь в данный момент входит в систему.", "IsSignedIn");

AddCondition(4, cf_trigger, "Успешное присутствие", "Xbox Live", "Успешное обновление присутствия", "Срабатывает, когда успешно установлено присутствие.", "OnPresenceUpdateSuccess");
AddCondition(5, cf_trigger, "Ошибка присутствия", "Xbox Live", "Ошибка обновления присутствия", "Срабатывает, когда не удалось установить присутствие.", "OnPresenceUpdateError");

AddCondition(6, cf_trigger, "Успешный профиль", "Xbox Live", "Успех в профиле", "Запущено при получении данных профиля.", "OnProfileInfoSuccess");
AddCondition(7, cf_trigger, "Ошибка профиля", "Xbox Live", "Ошибка в инфо профиля", "Срабатывает при сбое получения информации профиля.", "OnProfileInfoError");

////////////////////////////////////////
// Actions

// AddAction(id,				// any positive integer to uniquely identify this action
//			 flags,				// (see docs) af_none, af_deprecated
//			 list_name,			// appears in event wizard list
//			 category,			// category in event wizard list
//			 display_str,		// as appears in event sheet - use {0}, {1} for parameters and also <b></b>, <i></i>
//			 description,		// appears in event wizard dialog when selected
//			 script_name);		// corresponding runtime function name

AddAction(0, af_none, "Войти", "Xbox Live", "Войти", "Запрашивать вход пользователя, если он еще не выполнил вход.", "SignIn");

AddAction(3, af_none, "Вход в систему без уведомления", "Xbox Live", "Вход в систему без уведомления", "Попытка автоматического входа пользователя без запроса. Если это не удается, необходимо выполнить вход вручную.", "SignInSilently");

AddComboParamOption("не в заголовке");
AddComboParamOption("в заголовке");
AddComboParam("Присутствие", "Наличие или отсутствие пользователя в названии.");
AddAction(1, af_none, "Установить присутствие", "Xbox Live", "Установить присутствие <b>{0}</b>", "Установить присутствие пользователя в названии.", "SetPresence");

AddAction(2, af_none, "Запросить информацию профиля", "Xbox Live", "Запросить инфо профиля", "Запросите информацию о профиле пользователя, например, его счёт игры.", "RequestProfileInfo");

////////////////////////////////////////
// Expressions

// AddExpression(id,			// any positive integer to uniquely identify this expression
//				 flags,			// (see docs) ef_none, ef_deprecated, ef_return_number, ef_return_string,
//								// ef_return_any, ef_variadic_parameters (one return flag must be specified)
//				 list_name,		// currently ignored, but set as if appeared in event wizard
//				 category,		// category in expressions panel
//				 exp_name,		// the expression name after the dot, e.g. "foo" for "myobject.foo" - also the runtime function name
//				 description);	// description in expressions panel

AddExpression(0, ef_return_string, "", "Xbox Live", "ErrorMessage", "Return the last error message, if any.");
AddExpression(1, ef_return_string, "", "Xbox User", "AgeGroup", "Return the user's age group.");
AddExpression(2, ef_return_string, "", "Xbox User", "GamerTag", "Return the user's gamertag.");
AddExpression(3, ef_return_string, "", "Xbox User", "WebAccountId", "Return the user's web account ID.");
AddExpression(4, ef_return_string, "", "Xbox User", "XboxUserId", "Return the user's Xbox user ID.");

AddExpression(5, ef_return_string, "", "Profile info", "UserAppDisplayName", "Return the user's display name for application UI.");
AddExpression(6, ef_return_string, "", "Profile info", "UserGameDisplayName", "Return the user's display name for game UI.");
AddExpression(8, ef_return_string, "", "Profile info", "UserAppDisplayPictureUri", "Return a URI to the user's display picture for application UI.");
AddExpression(9, ef_return_string, "", "Profile info", "UserGameDisplayPictureUri", "Return a URI to the user's display picture for game UI.");
AddExpression(7, ef_return_string, "", "Profile info", "GamerScore", "Return the user's gamerscore.");

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
	new cr.Property(ept_integer, 	"Title ID",		0,		"The title ID (in decimal) that identifies this Xbox Live product."),
	new cr.Property(ept_text, 		"SCID",			"",		"The Service Configuration ID (SCID) for this Xbox Live product."),
	new cr.Property(ept_combo, 		"Xbox Live Creators Title",	"Yes",		"Enable for titles in the Xbox Live Creators Program. Disable for other titles (e.g. ID@Xbox).", "No|Yes")
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
		
	// Plugin-specific variables
	// this.myValue = 0...
}

// Called when inserted via Insert Object Dialog for the first time
IDEInstance.prototype.OnInserted = function()
{
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
}

// For rendered objects to release fonts or textures
IDEInstance.prototype.OnRendererReleased = function(renderer)
{
}