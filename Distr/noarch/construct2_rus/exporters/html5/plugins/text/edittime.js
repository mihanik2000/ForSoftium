function GetPluginSettings()
{
	return {
		"name":			"Текст",
		"id":			"Text",
		"version":		"1.0",
		"description":	"Отображает текст на экране.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/116/text",
		"category":		"Общее",
		"type":			"world",			// appears in layout
		"rotatable":	true,				// can be rotated in layout
		"flags":		pf_position_aces | pf_size_aces | pf_angle_aces | pf_appearance_aces | pf_zorder_aces | pf_effects
	};
};

// Conditions, actions and expressions
AddStringParam("Текст для сравнения", "Введите текст для сравнения с содержанием объекта.", "\"\"");
AddComboParamOption("Игнорировать регистр");
AddComboParamOption("С учетом регистра");
AddComboParam("Чувствительность к регистру", "Выберите, следует ли рассчитывать, как отличается от нижнего регистра заглавными буквами.  Если без учета регистра, \"ABC\" совпадения \"abc\".", 0);
AddCondition(0, 0, "Сравнить текст", "Текст", "Текст <b>{0}</b> <i>({1})</i>", "Сравните текст в этом объекте.", "CompareText");

////////////////////////
AddAnyTypeParam("Текст", "Введите текст, чтобы установить содержание объекта в.", "\"\"");
AddAction(0, 0, "Набор текста", "Текст", "Набор текста <i>{0}</i>", "Установите текст этого объекта.", "SetText");

AddAnyTypeParam("Текст", "Введите текст, который будет добавлен к содержанию объекта.", "\"\"");
AddAction(1, 0, "Добавить текст", "Текст", "Добавить <i>{0}</i>", "Добавить текст в конец существующего текста.", "AppendText");

AddStringParam("Имя шрифта", "Новое имя шрифта для установки.", "\"Arial\"");
AddComboParamOption("нормальный");
AddComboParamOption("жирный");
AddComboParamOption("наклонный");
AddComboParamOption("жирный и наклонный");
AddComboParam("Стиль", "Выберите стиль для данного шрифта.");
AddAction(2, 0, "Установить шрифт", "Внешность", "Установить шрифт <i>{0}</i> (<i>{1}</i>)", "Установить шрифт, используемый для отображения текста.", "SetFontFace");

AddNumberParam("Размер (pt)", "Новый размер шрифта.", "12");
AddAction(3, 0, "Установить размер шрифта", "Внешность", "Установить размер шрифта <i>{0}</i> pt", "Установить размер шрифта.", "SetFontSize");

AddNumberParam("Цвет", "Новый цвет шрифта, в виде кзч(красный, зеленый, чёрный).", "кзч(0, 0, 0)");
AddAction(4, 0, "Установить цвет шрифта", "Внешность", "Установить цвет шрифта <i>{0}</i>", "Установить цвет шрифта", "SetFontColor");

AddStringParam("Фамилия", "Введите имя семейства шрифтов.");
AddStringParam("CSS URL", "Введите веб-адрес к файлу CSS, ссылающегося на веб-шрифт.", "\"http://\"");
AddAction(5, 0, "Установить веб-шрифт", "Внешность", "Установить веб-шрифт <i>{0}</i> из <i>{1}</i>", "Установить шрифт из интернет-веб-шрифта.", "SetWebFont");

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
AddAction(6, 0, "Установить режим смешивания", "Внешность", "Установить режим смешивания <i>{0}</i>", "Установите режим смешивания фона для этого объекта.", "SetEffect");

////////////////////////
AddExpression(0,	ef_return_string,	"Get text",			"Text",			"Text",		"Get the object's text.");
AddExpression(1,	ef_return_string,	"Get face name",	"Appearance",	"FaceName",	"Get the current font face name.");
AddExpression(2,	ef_return_number,	"Get face size",	"Appearance",	"FaceSize",	"Get the current font face size (pt).");

AddExpression(3,	ef_return_number,	"Get text width",	"Text",			"TextWidth", "Get the width extent of the text in the object in pixels.");
AddExpression(4,	ef_return_number,	"Get text height",	"Text",			"TextHeight", "Get the height extent of the text in the object in pixels.");

ACESDone();

// Property grid properties for this plugin
var property_list = [
	new cr.Property(ept_text,		"Text",		lang("project\\misc\\text-initialtext"), "Текст для отображения."),
	new cr.Property(ept_combo, "Initial visibility",	"Visible",	"Выберите, отображается ли объект при запуске макета.", "Visible|Invisible"),
	new cr.Property(ept_font, 		"Font",		"Arial,-16",	"Выберите шрифт для отображения. Это относится ко всем экземплярам этого типа."),
	new cr.Property(ept_color,		"Color",	cr.RGB(0, 0, 0),	"Цвет текста."),
	new cr.Property(ept_combo,		"Horizontal alignment", "Left", "Горизонтальное выравнивание текста.", "Left|Center|Right"),
	new cr.Property(ept_combo,		"Vertical alignment", "Top", "Вертикальное выравнивание текста.", "Top|Center|Bottom"),
	new cr.Property(ept_combo,	"Hotspot",				"Top-left",	"Выберите расположение горячей точки в объекте.", "Top-left|Top|Top-right|Left|Center|Right|Bottom-left|Bottom|Bottom-right"),
	new cr.Property(ept_combo,	"Wrapping",		"Word",				"Перенос текста по слов, разделенных пробелами или ближайшего символа.", "Word|Character"),
	new cr.Property(ept_float,	"Line height",	0,					"Смещение высоты линии по умолчанию, в пикселях. 0 высота строки по умолчанию.")
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
		
	// Properties for font
	this.font_str = "Arial,-16";		// default font string
	this.old_font_str = "";				// last font string, in case not changed
	this.recreate_font = true;			// font not yet created
	this.font = null;					// handle to font in IDE
}

// Called when drawing the text and the font needs to be recreated
IDEInstance.prototype.RecreateFont = function(renderer)
{
	// The font hasn't really changed: don't actually recreate
	if (this.font_str == this.old_font_str)
	{
		this.recreate_font = false;
		return;
	}
		
	var had_font = false;
	
	// Release any existing font first
	if (this.font)
	{
		renderer.ReleaseFont(this.font);
		had_font = true;
	}
	
	// Parse the font details out of the font string
	var font_info = cr.ParseFontString(this.font_str);
	
	// Attempt to create the font as requested
	this.font = renderer.CreateFont(font_info.face_name, font_info.face_size, font_info.bold, font_info.italic);
	
	// Creating the font failed: fall back to arial
	if (!this.font)
	{
		this.font = renderer.CreateFont("Arial", font_info.face_size, false, false);
		
		// Notify the user if the font has been changed via the property grid.  Don't notify
		// if this error happens just loading a layout.
		if (had_font)
		{
			BalloonTipLastProperty("Font not supported",
								   "The font you chose does not appear to be supported by Construct 2, for technical reasons.  "
								   + "The object has fallen back to 'Arial'.  Click the help link for more information.",
								   bti_warning);
		}
	}
	else if (!this.font.exact_match && had_font)
	{
		// The font was not an exact match.  Notify the user, but only when the font was changed,
		// don't display this when loading a layout.
		BalloonTipLastProperty("Изменение шрифта не поддерживается",
							   "Точный шрифт, который вы выбрали, похоже, не будет поддерживаться Construct 2, по техническим причинам.  "
							   + "Объект упал обратно на другой вариации выбранного шрифта. Нажмите на ссылку справки для получения дополнительной информации.",
							   bti_warning);
	}
	
	assert2(this.font, "Failed to create font or default Arial font");
		
	// Font has been created
	this.recreate_font = false;
	this.old_font_str = this.font_str;
}

IDEInstance.prototype.OnCreate = function()
{
	this.instance.SetHotspot(GetHotspot(this.properties["Hotspot"]));
}

// Called by the IDE after all initialization on this instance has been completed
IDEInstance.prototype.OnInserted = function()
{
	// Default to 200x30 with top left hotspot
	this.instance.SetSize(new cr.vector2(200, 30));
	
	this.instance.SetHotspot(GetHotspot(this.properties["Hotspot"]));
}

// Called by the IDE after a property has been changed
IDEInstance.prototype.OnPropertyChanged = function(property_name)
{
	// Recreate font if font property changed
	if (property_name === "Font")
	{
		this.font_str = this.properties["Font"];
		this.recreate_font = true;
	}
	else if (property_name === "Hotspot")
	{
		this.instance.SetHotspot(GetHotspot(this.properties["Hotspot"]));
	}
}

IDEInstance.prototype.OnRendererInit = function(renderer)
{
}
	
// Called by the IDE to draw this instance in the editor
IDEInstance.prototype.Draw = function(renderer)
{
	// If the font is not yet created or needs recreating, recreate it
	if (!this.font || this.recreate_font)
		this.RecreateFont(renderer);
		
	// If there is a font present, draw it
	if (this.font)
	{
		var halign = ha_left;
		var valign = va_top;
		
		var hprop = this.properties["Horizontal alignment"];
		var vprop = this.properties["Vertical alignment"];
		
		if (hprop == "Center")
			halign = ha_center;
		else if (hprop == "Right")
			halign = ha_right;
			
		if (vprop == "Center")
			valign = ha_center;
		else if (vprop == "Bottom")
			valign = va_bottom;
		
		this.font.DrawText(this.properties["Text"],
								this.instance.GetBoundingQuad(),
								this.properties["Color"],
								halign,
								this.instance.GetOpacity(),
								this.instance.GetAngle(),
								(this.properties["Wrapping"] === "Word"),
								this.properties["Line height"],
								valign);
	}
}

IDEInstance.prototype.OnRendererReleased = function(renderer)
{
	this.font = null;		// drop reference to created font
	this.old_font_str = "";
}
