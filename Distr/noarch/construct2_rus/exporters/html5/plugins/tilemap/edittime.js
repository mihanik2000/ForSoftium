function GetPluginSettings()
{
	return {
		"name":			"Карта плитки",				// as appears in 'insert object' dialog, can be changed as long as "id" stays the same
		"id":			"Tilemap",				// this is used to identify this plugin and is saved to the project; never change it
		"version":		"1.0",					// (float in x.y format) Plugin version - C2 shows compatibility warnings based on this
		"description":	"Создание плитки на основе уровня конструкции. TMX карты также поддерживаются.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/172/tilemap",
		"category":		"Общее",				// Prefer to re-use existing categories, but you can set anything here
		"type":			"world",				// either "world" (appears in layout and is drawn), else "object"
		"rotatable":	false,					// only used when "type" is "world".  Enables an angle property on the object.
		"defaultimage":	"default_tilemap.png",
		"flags":		0						// uncomment lines to enable flags...
					//	| pf_singleglobal		// exists project-wide, e.g. mouse, keyboard.  "type" must be "object".
						| pf_texture			// object has a single texture (e.g. tiled background)
						| pf_position_aces		// compare/set/get x, y...
						| pf_size_aces			// compare/set/get width, height...
					//	| pf_angle_aces			// compare/set/get angle (recommended that "rotatable" be set to true)
						| pf_appearance_aces	// compare/set/get visible, opacity...
					//	| pf_tiling				// adjusts image editor features to better suit tiled images (e.g. tiled background)
					//	| pf_animations			// enables the animations system.  See 'Sprite' for usage
						| pf_zorder_aces		// move to top, bottom, layer...
					//  | pf_nosize				// prevent resizing in the editor
						| pf_effects			// allow WebGL shader effects to be added
						| pf_predraw			// set for any plugin which draws and is not a sprite (i.e. does not simply draw
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

AddNumberParam("Плитка X", "X индекс плитки (в плитках).");
AddNumberParam("Плитка Y", "Y индекс плитки (в плитках).");
AddCmpParam("Сравнение", "Как сравнить плитку на данной позиции.");
AddNumberParam("Плитка", "Число плитки, для сравнения.");
AddCondition(0, cf_none, "Сравнить плитку", "Карта Плитки", "Плитка ({0}, {1}) {2} {3}", "Сравните номер плитки в положении.", "CompareTileAt");

AddNumberParam("Плитка X", "X индекс плитки (в плитках).");
AddNumberParam("Плитка Y", "Y индекс плитки (в плитках).");
AddComboParamOption("нормальный");
AddComboParamOption("перевернутый горизонтально");
AddComboParamOption("перевернутый вертикально");
AddComboParamOption("поворачивается на 90°");
AddComboParamOption("поворачивается на 180°");
AddComboParamOption("поворачивается на 270°");
AddComboParamOption("поворачивается на 90°, перевернуто вертикально");
AddComboParamOption("поворачивается на 270°, перевернуто вертикально");
AddComboParam("Состояние", "Состояние, чтобы проверить, если данная плитка соответствует.");
AddCondition(1, cf_none, "Сравните состояние плитки", "Карта Плитки", "Плитка ({0}, {1}) является {2}", "Compare the flipped or rotated state of a tile at a position.", "CompareTileStateAt");

AddCondition(2, cf_trigger, "URL изображения загружается", "Web", "URL изображения загружается", "Срабатывает после 'Загрузить изображение из URL', когда изображение завершает загрузку.", "OnURLLoaded");

////////////////////////////////////////
// Actions

// AddAction(id,				// any positive integer to uniquely identify this action
//			 flags,				// (see docs) af_none, af_deprecated
//			 list_name,			// appears in event wizard list
//			 category,			// category in event wizard list
//			 display_str,		// as appears in event sheet - use {0}, {1} for parameters and also <b></b>, <i></i>
//			 description,		// appears in event wizard dialog when selected
//			 script_name);		// corresponding runtime function name

AddNumberParam("Плитка X", "X индекс плитки, чтобы удалить (в плитках).");
AddNumberParam("Плитка Y", "Y индекс плитки, чтобы удалить (в плитках).");
AddAction(0, af_none, "Удаление плитки", "Карта Плитки", "Удаление плитки (<i>{0}</i>, <i>{1}</i>)", "Сотрите плитку в положении.", "EraseTile");

AddNumberParam("Плитка X", "X индекс плитки, чтобы установить (в плитках).");
AddNumberParam("Плитка Y", "Y индекс плитки, чтобы установить (в плитках).");
AddNumberParam("Плитка", "Номер плитки для установки в заданном положении.");
AddComboParamOption("нормальный");
AddComboParamOption("перевернутый горизонтально");
AddComboParamOption("перевернутый вертикально");
AddComboParamOption("поворачивается на 90°");
AddComboParamOption("поворачивается на 180°");
AddComboParamOption("поворачивается на 270°");
AddComboParamOption("поворачивается на 90°, перевернуто вертикально");
AddComboParamOption("поворачивается на 270°, перевернуто вертикально");
AddComboParam("Состояние", "Независимо от того, чтобы повернуть или зеркально отразить эту плитку.");
AddAction(1, af_none, "Установить плитку", "Карта Плитки", "Установить плитку (<i>{0}</i>, <i>{1}</i>) для плитки <b>{2}</b> (<i>{3}</i>)", "Изменение плитки в положении.", "SetTile");

AddNumberParam("Плитка X", "X индекс первой плитки, чтобы удалить (в плитках).");
AddNumberParam("Плитка Y", "Y индекс первой плитки, чтобы удалить (в плитках).");
AddNumberParam("Ширина", "Количество плиток в ширину чтобы стереть.", "1");
AddNumberParam("Высота", "Количество плитки в высоту, чтобы стереть.", "1");
AddAction(2, af_none, "Стереть диапазон плитки", "Карта Плитки", "Стереть диапазон плитки (<i>{0}</i>, <i>{1}</i>) площадь <i>{2}</i> x <i>{3}</i>", "Стереть прямоугольную область плитки.", "EraseTileRange");

AddNumberParam("Плитка X", "X индекс первой плитки для установки (в плитки).");
AddNumberParam("Плитка Y", "Y индекс первой плитки для установки (в плитки).");
AddNumberParam("Ширина", "Количество плиток в ширину для установки.", "1");
AddNumberParam("Высота", "Количество плиток в высоту для установки.", "1");
AddNumberParam("Плитка", "Номер плитки для установки в заданном диапазоне.");
AddComboParamOption("нормальный");
AddComboParamOption("перевернутый горизонтально");
AddComboParamOption("перевернутый вертикально");
AddComboParamOption("поворачивается на 90°");
AddComboParamOption("поворачивается на 180°");
AddComboParamOption("поворачивается на 270°");
AddComboParamOption("поворачивается на 90°, перевернуто вертикально");
AddComboParamOption("поворачивается на 270°, перевернуто вертикально");
AddComboParam("Состояние", "Поворачивать или переворачивать плитки.");
AddAction(3, af_none, "Установить диапазон плиток", "Карта Плитки", "Установить диапазон (<i>{0}</i>, <i>{1}</i>) с площадью <i>{2}</i> x <i>{3}</i> плитку <b>{4}</b> (<i>{5}</i>)", "Установите прямоугольную область плитки.", "SetTileRange");

AddNumberParam("Плитка X", "X индекс плитки для изменения (в плитки).");
AddNumberParam("Плитка Y", "Y индекс плитки для изменения (в плитки).");
AddComboParamOption("нормальный");
AddComboParamOption("перевернутый горизонтально");
AddComboParamOption("перевернутый вертикально");
AddComboParamOption("поворачивается на 90°");
AddComboParamOption("поворачивается на 180°");
AddComboParamOption("поворачивается на 270°");
AddComboParamOption("поворачивается на 90°, перевернуто вертикально");
AddComboParamOption("поворачивается на 270°, перевернуто вертикально");
AddComboParam("Состояние", "Поворачивать или переворачивать эту плитку.");
AddAction(6, af_none, "Установить состояние плитки", "Карта Плитки", "Установить плитку (<i>{0}</i>, <i>{1}</i>) состояние <i>{2}</i>", "Измените состояние перевернутого или повернутого фрагмента.", "SetTileState");

AddNumberParam("Плитка X", "X индекс первой плитки для изменения (в плитки).");
AddNumberParam("Плитка Y", "Y индекс первой плитки для изменения (в плитки).");
AddNumberParam("Ширина", "Количество плиток для установки.", "1");
AddNumberParam("Высота", "Количество плиток для установки.", "1");
AddComboParamOption("нормальный");
AddComboParamOption("перевернутый горизонтально");
AddComboParamOption("перевернутый вертикально");
AddComboParamOption("поворачивается на 90°");
AddComboParamOption("поворачивается на 180°");
AddComboParamOption("поворачивается на 270°");
AddComboParamOption("поворачивается на 90°, перевернуто вертикально");
AddComboParamOption("поворачивается на 270°, перевернуто вертикально");
AddComboParam("Состояние", "Поворачивать или переворачивать плитки.");
AddAction(7, af_none, "Установить диапазон состояния плитки", "Карта Плитки", "Настроить плитки в (<i>{0}</i>, <i>{1}</i>) с площадью <i>{2}</i> x <i>{3}</i> состояние <i>{4}</i>", "Измените отраженное или повернутое состояние прямоугольной области плиток.", "SetTileStateRange");

AddStringParam("JSON", "Строка для загрузки плитки из 'Карта плитки' в формате JSON из предыдущего использования выражения ПлиткиJSON.");
AddAction(4, af_none, "Загрузить", "JSON", "Загрузить карту плитки из JSON <b>{0}</b>", "Загрузка плитки из строки JSON.", "LoadFromJSON");

AddStringParam("Имя файла", "Имя загружаемого файла.", "\"tilemap.json\"");
AddAction(5, 0, "Скачать", "JSON", "Загружать данные JSON с именем файла <i>{0}</i>", "Загрузите данные 'Карта плитки' как файл JSON.", "JSONDownload");

AddStringParam("URI", "Введите URL-адрес в Интернете или URI данных изображения для загрузки.", "\"http://\"");
AddAction(8, 0, "Загрузить изображение с URL-адреса", "Web", "Загрузить изображение из <i>{0}</i>", "Загрузите исходное изображение с карты плтики с веб-адреса или URI данных.", "LoadURL");

////////////////////////////////////////
// Expressions

// AddExpression(id,			// any positive integer to uniquely identify this expression
//				 flags,			// (see docs) ef_none, ef_deprecated, ef_return_number, ef_return_string,
//								// ef_return_any, ef_variadic_parameters (one return flag must be specified)
//				 list_name,		// currently ignored, but set as if appeared in event wizard
//				 category,		// category in expressions panel
//				 exp_name,		// the expression name after the dot, e.g. "foo" for "myobject.foo" - also the runtime function name
//				 description);	// description in expressions panel

AddNumberParam("TileX", "X position in tiles");
AddNumberParam("TileY", "Y position in tiles");
AddExpression(0, ef_return_number, "", "Tilemap", "TileAt", "Return the tile number at a position in tiles.");

AddNumberParam("X", "X co-ordinate");
AddExpression(1, ef_return_number, "", "Tilemap", "PositionToTileX", "Convert an X co-ordinate to a tile X index.");

AddNumberParam("Y", "Y co-ordinate");
AddExpression(2, ef_return_number, "", "Tilemap", "PositionToTileY", "Convert a Y co-ordinate to a tile Y index.");

AddNumberParam("TileX", "X position in tiles");
AddExpression(3, ef_return_number, "", "Tilemap", "TileToPositionX", "Convert a tile X index to X co-ordinate.");

AddNumberParam("TileY", "Y position in tiles");
AddExpression(4, ef_return_number, "", "Tilemap", "TileToPositionY", "Convert a tile Y index to Y co-ordinate.");

AddNumberParam("X", "X co-ordinate");
AddExpression(5, ef_return_number, "", "Tilemap", "SnapX", "Snap an X co-ordinate to the nearest tile X.");

AddNumberParam("Y", "Y co-ordinate");
AddExpression(6, ef_return_number, "", "Tilemap", "SnapY", "Snap a Y co-ordinate to the nearest tile Y.");

AddExpression(7, ef_return_string, "", "JSON", "TilesJSON", "Get tilemap data as a JSON-formatted string.");

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
	new cr.Property(ept_link,	"Image",				"Редактировать",		"Нажмите, чтобы изменить изображение объекта.", "firstonly"),
	new cr.Property(ept_combo,	"Initial visibility",	"Visible",	"Выберите, отображается ли объект при запуске макета.", "Visible|Invisible"),
	new cr.Property(ept_integer, "Tile width",			32,			"Ширина в пикселях каждой плитки."),
	new cr.Property(ept_integer, "Tile height",			32,			"Высота в пикселях каждой плитки."),
	new cr.Property(ept_integer, "Tile X offset",		0,			"Смещение по X в образе первой плитки."),
	new cr.Property(ept_integer, "Tile Y offset",		0,			"Смещение по Y в образе первой плитки."),
	new cr.Property(ept_integer, "Tile X spacing",		0,			"Промежуток по горизонтали в пикселях между каждой плитки."),
	new cr.Property(ept_integer, "Tile Y spacing",		0,			"Вертикальный зазор в пикселях между каждой плитки."),
	new cr.Property(ept_combo,	"Seamless mode",		"Enabled",		"Используйте более медленный, но плавный метод рендеринга.", "Disabled|Enabled")
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

IDEInstance.prototype.OnCreate = function()
{
	this.instance.SetHotspot(new cr.vector2(0, 0));
};

// Called when inserted via Insert Object Dialog for the first time
IDEInstance.prototype.OnInserted = function()
{
	this.instance.SetHotspot(new cr.vector2(0, 0));
	this.instance.SetPosition(new cr.vector2(0, 0));
	this.instance.SetSize(this.instance.GetLayoutSize());
};

// Called when double clicked in layout
IDEInstance.prototype.OnDoubleClicked = function()
{
	this.instance.EditTexture();
};

// Called after a property has been changed in the properties bar
IDEInstance.prototype.OnPropertyChanged = function(property_name)
{
	// Edit image link
	if (property_name === "Образ")
	{
		this.instance.EditTexture();
	}
};

// For rendered objects to load fonts or textures
IDEInstance.prototype.OnRendererInit = function(renderer)
{
	renderer.LoadTexture(this.instance.GetTexture());
};

// Called to draw self in the editor if a layout object
IDEInstance.prototype.Draw = function(renderer)
{
	var texture = this.instance.GetTexture();
	renderer.SetTexture(this.instance.GetTexture());
	
	// Tile rendering happens via magic on the editor side
	this.instance.DrawTilemap();
};

// For rendered objects to release fonts or textures
IDEInstance.prototype.OnRendererReleased = function(renderer)
{
	renderer.ReleaseTexture(this.instance.GetTexture());
};