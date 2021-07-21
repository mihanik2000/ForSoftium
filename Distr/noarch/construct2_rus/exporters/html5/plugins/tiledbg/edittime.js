function GetPluginSettings()
{
	return {
		"name":			"Плиточный Фон",
		"id":			"TiledBg",
		"version":		"1.0",
		"description":	"Автоматически плитки изображение на площади. Плиточные Фоны намного быстрее, чем облицовка плиткой спрайтов.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/118/tiled-background",
		"category":		"Общее",
		"type":			"world",			// appears in layout
		"rotatable":	true,
		"defaultimage":	"default.png",
		"flags":		pf_texture | pf_position_aces | pf_size_aces | pf_angle_aces | pf_appearance_aces | pf_tiling | pf_zorder_aces | pf_effects | pf_predraw
	};
};

// Conditions, actions and expressions
AddCondition(0, cf_trigger, "URL изображения загружаются", "Web", "URL изображения загружаются", "Срабатывает после 'Загрузить изображение из URL', когда изображение завершает загрузку.", "OnURLLoaded");

AddComboParamOption("Нормальный");
AddComboParamOption("Добавка");
AddComboParamOption("XOR");
AddComboParamOption("Копия");
AddComboParamOption("Пункт назначения над");
AddComboParamOption("Источник в");
AddComboParamOption("Пункт назначения в");
AddComboParamOption("Источник из");
AddComboParamOption("Пункт назначения из");
AddComboParamOption("Источник на вершине");
AddComboParamOption("Пункт назначения на вершине");
AddComboParam("Режим смешивания", "Выберите новый режим смешивания для этого объекта.");
AddAction(1, 0, "Установите режим смешивания", "Внешность", "Установить режим смешивания <i>{0}</i>", "Установите режим смешивания фона для этого объекта.", "SetEffect");

AddStringParam("URI", "Введите URL-адрес в Интернете, или данные URI, образа для загрузки.", "\"http://\"");
AddAction(2, 0, "Загрузить изображение из URL", "Web", "Загрузить изображение из <i>{0}</i>", "Загрузите изображение с веб-адреса или данных URI.", "LoadURL");

AddExpression(0, ef_return_number, "", "Image", "ImageWidth", "The width of the current image, in pixels.");
AddExpression(1, ef_return_number, "", "Image", "ImageHeight", "The height of the current image, in pixels.");

ACESDone();

// Property grid properties for this plugin
var property_list = [
	new cr.Property(ept_link,	"Образ",				lang("project\\misc\\tiledbg-edit-link"), "Нажмите, чтобы изменить изображение объекта.", "firstonly"),
	new cr.Property(ept_combo,	"Initial visibility",	"Visible",	"Выберите, отображается ли объект при запуске макета.", "Visible|Invisible"),
	//new cr.Property(ept_combo,	"Effect",				"(none)",	"Choose an effect for this object.  (This does not preview in the layout, only when you run.)", "(none)|Additive|XOR|Copy|Destination over|Source in|Destination in|Source out|Destination out|Source atop|Destination atop"),
	new cr.Property(ept_combo,	"Hotspot",				"Top-left",	"Выберите расположение горячей точки в объекте.", "Top-left|Top|Top-right|Left|Center|Right|Bottom-left|Bottom|Bottom-right")
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
	this.just_inserted = false;
}

IDEInstance.prototype.OnCreate = function()
{
	this.instance.SetHotspot(GetHotspot(this.properties["Hotspot"]));
}

IDEInstance.prototype.OnInserted = function()
{
	this.just_inserted = true;
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
	else if (property_name === "Hotspot")
	{
		this.instance.SetHotspot(GetHotspot(this.properties["Hotspot"]));
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
	
	// First draw after insert: use 2x the size of the texture so user can see four tiles.
	// Done after SetTexture so the file is loaded and dimensions known, preventing
	// the file being loaded twice.
	if (this.just_inserted)
	{
		this.just_inserted = false;
		var sz = texture.GetImageSize();
		this.instance.SetSize(new cr.vector2(sz.x * 2, sz.y * 2));
		RefreshPropertyGrid();		// show new size
	}
	
	// Calculate tiling
	// This ignores cards without NPOT texture support but... meh.  Tiling by repeated quads is a massive headache.
	var texsize = texture.GetImageSize();
	var objsize = this.instance.GetSize();
	var uv = new cr.rect(0, 0, objsize.x / texsize.x, objsize.y / texsize.y);
	
	renderer.EnableTiling(true);
	renderer.Quad(this.instance.GetBoundingQuad(), this.instance.GetOpacity(), uv);
	renderer.EnableTiling(false);
}

IDEInstance.prototype.OnRendererReleased = function(renderer)
{
	renderer.ReleaseTexture(this.instance.GetTexture());
}