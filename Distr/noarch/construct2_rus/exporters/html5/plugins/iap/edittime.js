function GetPluginSettings()
{
	return {
		"name":			"IAP",					// as appears in 'insert object' dialog, can be changed as long as "id" stays the same
		"id":			"IAP",				// this is used to identify this plugin and is saved to the project; never change it
		"version":		"1.0",					// (float in x.y format) Plugin version - C2 shows compatibility warnings based on this
		"description":	"Ручка в приложение покупки (IAP) на различных платформах.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/173/iap",
		"category":		"Монетизация",			// Prefer to re-use existing categories, but you can set anything here
		"type":			"object",				// either "world" (appears in layout and is drawn), else "object"
		"rotatable":	false,					// only used when "type" is "world".  Enables an angle property on the object.
		"dependency":	"Amazon-Web-App-API.min.js;Amazon-Web-App-API-tester.min.js;tizen-iap.js;cws-buy.js",
		"cordova-plugins":	"cc.fovea.plugins.inapppurchase;com.mcm.plugins.androidinappbilling",
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

AddStringParam("ID товара", "Идентификатор продукта, который был приобретен успешно.");
AddCondition(0, cf_trigger, "Успешная покупка", "IAP", "Товар <i>{0}</i> успешная покупка", "Срабатывает, когда конкретный идентификатор продукта был успешно куплен.", "OnPurchaseSuccess");

AddCondition(1, cf_trigger, "Любой успех покупка", "IAP", "Любой успех покупка", "Срабатывает, когда какой-либо продукт был успешно куплен.", "OnAnyPurchaseSuccess");

AddStringParam("ID товара", "Идентификатор продукта, который не в состоянии приобрести.");
AddCondition(2, cf_trigger, "Не удалось совершить покупку", "IAP", "Товар <i>{0}</i> не удалось совершить покупку", "Срабатывает, когда конкретный идентификатор продукта не удалось приобрести.", "OnPurchaseFail");

AddCondition(3, cf_trigger, "Любая покупка не удалась", "IAP", "Любая покупка не удалась", "Срабатывает, когда какой-либо продукт не удалось приобрести.", "OnAnyPurchaseFail");

AddCondition(4, cf_trigger, "Магазин успех листинга", "IAP", "Магазин успех листинга", "Срабатывает, когда магазин листинг получен успешно.", "OnStoreListingSuccess");

AddCondition(5, cf_trigger, "Магазин листинга не удалось", "IAP", "Магазин листинга не удалось", "Срабатывает, когда магазин листинг не удалось получить.", "OnStoreListingFail");

AddStringParam("ID товара", "Идентификатор продукта, чтобы проверить, если в собственности.");
AddCondition(6, cf_none, "Есть продукт", "IAP", "Есть продукт <i>{0}</i>", "Правда, если текущий пользователь приобрел данный идентификатор продукта.", "HasProduct");

AddCondition(7, cf_none, "Магазин доступен", "IAP", "Магазин доступен", "Правда, если магазин, из которого могут быть сделаны покупки доступно.", "IsAvailable");

AddCondition(8, cf_none, "Приобретённые приложение", "IAP", "Приобретённые приложение", "Правда, если приложение приобретено, или на некоторых платформах, если идентификатор продукта \"приложение\" принадлежит.", "IsAppPurchased");

////////////////////////////////////////
// Actions

// AddAction(id,				// any positive integer to uniquely identify this action
//			 flags,				// (see docs) af_none, af_deprecated
//			 list_name,			// appears in event wizard list
//			 category,			// category in event wizard list
//			 display_str,		// as appears in event sheet - use {0}, {1} for parameters and also <b></b>, <i></i>
//			 description,		// appears in event wizard dialog when selected
//			 script_name);		// corresponding runtime function name

AddStringParam("ID товара", "Разделенный запятыми список идентификаторов продукта для использования, e.g. \"product1,product2,product3\".");
AddAction(0, af_none, "Добавить ID продукта", "IAP", "Добавить продукт с ID <b>{0}</b>", "Добавьте идентификаторы продуктов, что приложение будет использовать для IAP.", "AddProductID");

AddStringParam("ID товара", "ID продукта для покупки.");
AddAction(1, af_none, "Покупка продукта", "IAP", "Покупка продукта <b>{0}</b>", "Подскажите пользователю приобрести продукт.", "PurchaseProduct");

AddAction(2, af_none, "Покупка приложения", "IAP", "Покупка приложения", "Подскажите пользователю приобрести приложение, или на некоторых платформах продукта ID \"app\".", "PurchaseApp");

AddAction(3, af_none, "Восстановить покупки", "IAP", "Восстановить покупки", "Восстановление государственных закупок из магазина.", "RestorePurchases");

AddAction(4, af_none, "Запрос предметов магазина", "IAP", "Запрос предметов магазина", "Запросить список доступных предметов из магазина.", "RequestStoreListing");

////////////////////////////////////////
// Expressions

// AddExpression(id,			// any positive integer to uniquely identify this expression
//				 flags,			// (see docs) ef_none, ef_deprecated, ef_return_number, ef_return_string,
//								// ef_return_any, ef_variadic_parameters (one return flag must be specified)
//				 list_name,		// currently ignored, but set as if appeared in event wizard
//				 category,		// category in expressions panel
//				 exp_name,		// the expression name after the dot, e.g. "foo" for "myobject.foo" - also the runtime function name
//				 description);	// description in expressions panel

AddStringParam("ProductID", "Product ID to get");
AddExpression(0, ef_return_string, "", "IAP", "ProductName", "Return the name of a product from its ID.");

AddStringParam("ProductID", "Product ID to get");
AddExpression(1, ef_return_string, "", "IAP", "ProductPrice", "Return the formatted price of a produce from its ID.");

AddExpression(2, ef_return_string, "", "IAP", "AppName", "Return the name of the app or product ID \"app\".");
AddExpression(3, ef_return_string, "", "IAP", "AppPrice", "Return the price of the app or product ID \"app\".");

AddExpression(4, ef_return_string, "", "IAP", "ProductID", "In a trigger, the relevant product ID.");

AddExpression(5, ef_return_string, "", "IAP", "ErrorMessage", "In a trigger, an error message if available.");

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
	new cr.Property(ept_combo,	"Test mode",		"Yes",	"Установите 'Да', чтобы проверить покупки, если магазин поддерживает тестирование. Обязательно установите 'Нет' при публикации.", "No|Yes"),
	
	new cr.Property(ept_section, "Настройки магазина Tizen", "", "Свойства, относящиеся к магазину Tizen."),
	new cr.Property(ept_text,	"Item group ID",	"",	"Элемент группы ID от продавца офис, чтобы использовать для этого приложения.")
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