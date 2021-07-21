// ECMAScript 5 strict mode
/* global cr,log,assert2 */
function GetPluginSettings()
{
	return {
		"name":			"Спрайт шрифта",
		"id":			"Spritefont2",
		"version":		"1.0",
		"description":	"Отображает текст на экране с помощью спрайт листа.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/166/sprite-font",
		"category":		"Общее",
		"type":			"world",			// appears in layout
		"rotatable":	true,				// can be rotated in layout
		"defaultimage":	"default_spritefont.png",
		"flags":		pf_position_aces | pf_size_aces | pf_angle_aces | pf_appearance_aces | pf_zorder_aces | pf_effects | pf_texture
						| pf_predraw
	};
}

// Conditions, actions and expressions
AddStringParam("Текст для сравнения", "Введите текст для сравнения с содержанием объекта.", "\"\"");
AddComboParamOption("Игнорировать регистр");
AddComboParamOption("С учетом регистра");
AddComboParam("Чувствительность к регистру", "Выберите, следует ли рассчитывать, как отличается от нижнего регистра заглавными буквами. Если без учета регистра, \"ABC\" совпадения \"abc\".", 0);
AddCondition(0, 0, "Сравнить текст", "Текст", "Текст <b>{0}</b> <i>({1})</i>", "Сравните текст в этом объекте.", "CompareText");

////////////////////////
AddAnyTypeParam("Текст", "Введите текст, чтобы установить содержание объекта в.", "\"\"");
AddAction(0, 0, "Набор текста", "Текст", "Установить текст <i>{0}</i>", "Установите текст этого объекта.", "SetText");

AddAnyTypeParam("Текст", "Введите текст для добавления к содержанию объекта.", "\"\"");
AddAction(1, 0, "Добавить текст", "Текст", "Добавить <i>{0}</i>", "Добавить текст в конец существующего текста.", "AppendText");

AddNumberParam("Масштаб", "Введите масштаб 'Изображение Спрайта' шрифта.", "1.0");
AddAction(2, 0, "Установить масштаб", "Текст", "Установить масштаб <i>{0}</i>", "Установите масштаб 'Изображение Спрайта' шрифта.", "SetScale");

AddNumberParam("Расстояние между символами", "Введите число пикселей для получения расстояния между символами.", "0");
AddAction(3, 0, "Установить интервал", "Текст", "Установить интервал <i>{0}</i>", "Установить интервал между каждым символом.", "SetCharacterSpacing");

AddNumberParam("Высота линии", "Введите число пикселей для получения расстояния между линиями.", "0");
AddAction(4, 0, "Установить высоту строки", "Текст", "Установить высоту строки <i>{0}</i>", "Установить интервал между каждой строки.", "SetLineHeight");

AddStringParam("Символ", "Введите один или несколько символов, чтобы изменить ширину (например, \ 'ABCD \').", "\"\"");
AddNumberParam("Ширина", "Введите число пикселей ширины если хотите чтобы персонаж занимался. Это должно быть меньше ширины ячейки.", "8");
AddAction(5, 0, "Установить ширину символов", "Текст", "Установить ширину символов <i>{1}</i> для <i>{0}</i>", "Изменение ширины некоторых символов.", "SetCharacterWidth");

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

AddComboParamOption("слева");
AddComboParamOption("центр");
AddComboParamOption("cправо");
AddComboParam("Горизонтальное выравнивание", "Выберите новое горизонтальное выравнивание текста.");
AddAction(7, 0, "Установить гориз. выравнивание", "Текст", "Установить <i>{0}</i>", "Установите горизонтальное выравнивание текста.", "SetHAlign");

AddComboParamOption("вверх");
AddComboParamOption("центр");
AddComboParamOption("вниз");
AddComboParam("Вертикальное выравнивание", "Выберите новое вертикальное выравнивание текста.");
AddAction(8, 0, "Установить вертик. выравнивание", "Текст", "Установить <i>{0}</i>", "Установите вертикальное выравнивание текста.", "SetVAlign");


////////////////////////
AddStringParam("Character", "Character to get width for (empty for default)", "\"\"");
AddExpression(0,	ef_return_number,	"Get character width","Text",			"CharacterWidth",		"Get the width of a character.");
AddExpression(1,	ef_return_number,	"Get character height","Text",			"CharacterHeight",		"Get the height of a character.");
AddExpression(2,	ef_return_number,	"Get character scale","Text",			"CharacterScale",		"Get the scale of the characters.");
AddExpression(3,	ef_return_number,	"Get character spacing","Text",			"CharacterSpacing",		"Get the spacing between characters.");
AddExpression(4,	ef_return_number,	"Get line height","Text",				"LineHeight",			"Get the line height.");
AddExpression(5,	ef_return_string,	"Get text",			"Text",			"Text",		"Get the object's text.");
AddExpression(6,	ef_return_number,	"Get text width",	"Text",			"TextWidth", "Get the width extent of the text in the object in pixels.");
AddExpression(7,	ef_return_number,	"Get text height",	"Text",			"TextHeight", "Get the height extent of the text in the object in pixels.");


ACESDone();

// Property grid properties for this plugin
var property_list = [
	new cr.Property(ept_link,	"Спрайт шрифта",			"Редактировать",		"Нажмите, чтобы изменить шрифт спрайт объекта.", "firstonly"),
	new cr.Property(ept_integer,"Character width",		16,			"Ширина каждой ячейки в изображении."),
	new cr.Property(ept_integer,"Character height",		16,			"Высота каждой ячейки в изображении."),
	new cr.Property(ept_text,	"Character set",		"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.,;:?!-_~#\"'&()[]|`\\/@°+=*$£€<>", "List of characters in the spritefont image, starting in the top-left."),
	new cr.Property(ept_text,	"Text",					"Text",		"Текст для отображения."),
	new cr.Property(ept_float,	"Scale",				1.0,		"Умножитель масштабировать нарисованный текст."),
	new cr.Property(ept_combo,	"Initial visibility",	"Visible",	"Выберите, отображается ли объект при запуске макета.", "Visible|Invisible"),
	new cr.Property(ept_combo,	"Horizontal alignment",	"Left",		"Горизонтальное выравнивание текста.", "Left|Center|Right"),
	new cr.Property(ept_combo,	"Vertical alignment",	"Top",		"Вертикальное выравнивание текста.", "Top|Center|Bottom"),
	new cr.Property(ept_combo,	"Hotspot",				"Top-left",	"Выберите расположение горячей точки в объекте.", "Top-left|Top|Top-right|Left|Center|Right|Bottom-left|Bottom|Bottom-right"),
	new cr.Property(ept_combo,	"Wrapping",				"Word",		"Перенос текста по слов, разделенных пробелами или ближайшего символа.", "Word|Character"),
	new cr.Property(ept_integer,"Character spacing",	0,			"Дополнительная ширина пикселя, чтобы добавить между символами."),
	new cr.Property(ept_float,	"Line height",			0,			"Смещение высоты линии по умолчанию, в пикселях. 0 высота строки по умолчанию.")
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

	// Properties for font
	this.charList = null;		// default font string
	this.lines = [];
}

IDEInstance.prototype.OnCreate = function()
{
	this.instance.SetHotspot(GetHotspot(this.properties["Hotspot"]));
};

// Called by the IDE after all initialization on this instance has been completed
IDEInstance.prototype.OnInserted = function()
{
	this.instance.SetSize(new cr.vector2(200, 30));
};

IDEInstance.prototype.OnDoubleClicked = function()
{
	this.instance.EditTexture();
};

// Called by the IDE after a property has been changed
IDEInstance.prototype.OnPropertyChanged = function(property_name)
{
	// Recreate font if font property changed
	if (property_name === "Спрайт шрифта")
	{
		this.instance.EditTexture();
	}
	else if (property_name === "Hotspot")
	{
		this.instance.SetHotspot(GetHotspot(this.properties["Hotspot"]));
	}
	else if (property_name === "Character set" ||
		property_name === "Character width" ||
		property_name === "Character height")
	{
		this.SplitSheet();
	}
};

IDEInstance.prototype.OnTextureEdited = function ()
{
	this.SplitSheet();
};

IDEInstance.prototype.SplitSheet = function() {
	var texture = this.instance.GetTexture();
	if (texture == null) return;

	var texSize      = texture.GetImageSize();
	var charWidth    = this.properties["Character width"];
	var charHeight   = this.properties["Character height"];
	var uvCharWidth  = charWidth/texSize.x;
	var uvCharHeight = charHeight/texSize.y;
	var charSet      = this.properties["Character set"];
	this.charList    = {};

	var cols = Math.floor(texSize.x/charWidth);
	var rows = Math.floor(texSize.y/charHeight);

	for ( var c = 0; c < charSet.length; c++) {
		// not enough texture space
		if  (c >= cols * rows) break;

		// create uvs for each characters
		var x = c%cols;
		var y = Math.floor(c/cols);
		this.charList[charSet.charAt(c)] =  new cr.rect(
			x * uvCharWidth,
			y * uvCharHeight,
			(x+1) * uvCharWidth,
			(y+1) * uvCharHeight
		);
	}
};


IDEInstance.prototype.OnRendererInit = function(renderer)
{
	renderer.LoadTexture(this.instance.GetTexture());
};

function rotateQuad(quad,cosa,sina) {
	var x_temp;

	x_temp   = (quad.tlx * cosa) - (quad.tly * sina);
	quad.tly = (quad.tly * cosa) + (quad.tlx * sina);
	quad.tlx = x_temp;

	x_temp    = (quad.trx * cosa) - (quad.try_ * sina);
	quad.try_ = (quad.try_ * cosa) + (quad.trx * sina);
	quad.trx  = x_temp;

	x_temp   = (quad.blx * cosa) - (quad.bly * sina);
	quad.bly = (quad.bly * cosa) + (quad.blx * sina);
	quad.blx = x_temp;

	x_temp    = (quad.brx * cosa) - (quad.bry * sina);
	quad.bry = (quad.bry * cosa) + (quad.brx * sina);
	quad.brx  = x_temp;

}

// Called by the IDE to draw this instance in the editor
IDEInstance.prototype.Draw = function(renderer)
{
	var texture = this.instance.GetTexture();
	var text    = this.properties["Text"];
	var scale   = this.properties["Scale"];
	var charWidth  = this.properties["Character width"] * scale;
	var charHeight = this.properties["Character height"] * scale;
	var EPSILON = 0.00001;
	
	if (text !== "" && texture != null) {
		if (this.charList === null) this.SplitSheet();
		renderer.SetTexture(texture);




		// we get all the parameters we need for computation
		var objsize = this.instance.GetSize();
		var wrapbyword = this.properties["Wrapping"] === "Word";
		var lines = [];
		WordWrap(this, text, this.lines, objsize.x, wrapbyword);

		var lineHeight = this.properties["Line height"];

		if (objsize.y < charHeight + lineHeight) {
			// not enough room to draw the first line
			return;
		}

		var hprop = this.properties["Horizontal alignment"];
		var vprop = this.properties["Vertical alignment"];

		// convert alignement properties to some usable values
		var ha = 0;
		ha = hprop === "Center" ? 0.5 : ha;
		ha = hprop === "Right"  ? 1.0 : ha;

		var va = 0;
		va = vprop === "Center" ? 0.5 : va;
		va = vprop === "Bottom" ? 1.0 : va;

		var texsize = texture.GetImageSize();
		var angle   = this.instance.GetAngle(); //radians
		var charSpace  = this.properties["Character spacing"];
		var lines = this.lines;
		var textHeight = lines.length * (charHeight + lineHeight);

		// we precompute cosine and sine 'cause we will use them a lot
		var cosa = Math.cos(angle);
		var sina = Math.sin(angle);

		// we compute the offsets for vertical alignement in object-space
		// but it can't be negative, else it would underflow the boundingbox
		var halign;
		var valign = va * Math.max(0,(objsize.y - textHeight));

		// we get the position of the top left corner of the bounding box
		var q = this.instance.GetBoundingQuad();
		var offx = q.tlx;
		var offy = q.tly;
		
		/**/
		if (angle == 0) {
			offx = Math.round(offx);
			offy = Math.round(offy);
		}
		//*/

		var drawX ;
		var drawY = valign;

		var dQuad = new cr.quad();

		for(var i = 0; i < lines.length; i++) {
			// for horizontal alignement, we need to work line by line
			var line       = lines[i].text;
			var lineWidth  = lines[i].width;

			// compute horizontal empty space
			// offset drawX according to horizontal alignement
			// indentation could be negative if long word in wrapbyword mode
			halign = ha * Math.max(0, objsize.x - lineWidth);
			drawX = halign;

			// we round to avoid pixel blurring
			drawY += lineHeight;
			for(var j = 0; j < line.length; j++) {

				var letter = line.charAt(j);
				// we skip unrecognized characters (creates a space)
				var clipUV = this.charList[letter];

				// check if next letter fits in bounding box
				if ( drawX + charWidth > objsize.x + EPSILON) {
					break;
				}

				if (clipUV !== undefined) {
					var clipWidth  = charWidth;
					var clipHeight = charHeight;

					// we build the quad
					dQuad.tlx  = drawX;
					dQuad.tly  = drawY;
					dQuad.trx  = drawX + clipWidth;
					dQuad.try_ = drawY ;
					dQuad.blx  = drawX;
					dQuad.bly  = drawY + clipHeight;
					dQuad.brx  = drawX + clipWidth;
					dQuad.bry  = drawY + clipHeight;

					// we then rotate the quad around 0,0
					rotateQuad(dQuad,cosa,sina);
					// we then apply the world space offset
					dQuad.offset(offx,offy);

					// and render
					renderer.Quad(dQuad, this.instance.GetOpacity(), clipUV);
				}
				drawX  += charWidth + charSpace;
			}
			drawY += charHeight;
			// check if next row fits in bounding box
			if ( drawY + charHeight + lineHeight > objsize.y) {
				break;
			}
		}
	}
};

IDEInstance.prototype.OnRendererReleased = function(renderer)
{
	renderer.ReleaseTexture(this.instance.GetTexture());
};



/*
 *	Word-Wrapping
 */
IDEInstance.prototype.measureWidth = function(text) {

	var scale     = this.properties["Scale"];
	var charWidth = this.properties["Character width"];
	var spacing   =  this.properties["Character spacing"];
	var len     = text.length;
	var width   = 0;
	for (var i = 0; i < len; i++) {
		width += charWidth * scale + spacing;
	}
	// we remove the trailing spacing
	width -= (width > 0) ? spacing : 0;
	return width;
};

function trimRight(text)
{
	return text.replace(/\s\s*$/, '');
}

function TokeniseWords(text)
{
	var wordsCache = [];

	var cur_word = "";
	var ch;

	// Loop every char
	var i = 0;

	while (i < text.length)
	{
		ch = text.charAt(i);

		if (ch === "\n")
		{
			// Dump current word if any
			if (cur_word.length)
			{
				wordsCache.push(cur_word);
				cur_word = "";
			}

			// Add newline word
			wordsCache.push("\n");

			++i;
		}
		// Whitespace or hyphen: swallow rest of whitespace and include in word
		else if (ch === " " || ch === "\t" || ch === "-")
		{
			do {
				cur_word += text.charAt(i);
				i++;
			}
			while (i < text.length && (text.charAt(i) === " " || text.charAt(i) === "\t"));

			wordsCache.push(cur_word);
			cur_word = "";
		}
		else if (i < text.length)
		{
			cur_word += ch;
			i++;
		}
	}

	// Append leftover word if any
	if (cur_word.length)
		wordsCache.push(cur_word);

	return wordsCache;
}

function addLine(inst,lines,lineIndex,cur_line) {
	var line;
	cur_line = trimRight(cur_line);
	// Recycle a line if possible
	line = {};
	line.text = cur_line;
	line.width = inst.measureWidth(cur_line);
	lines[lineIndex] = line;
}

function WordWrap(inst, text, lines, width, wrapbyword)
{
	lines.length = 0;
	if (!text || !text.length || width <= 2.0)
	{
		return;
	}

	// If under 100 characters (i.e. a fairly short string), try a short string optimisation: just measure the text
	// and see if it fits on one line, without going through the tokenise/wrap.
	// Text musn't contain a linebreak!
	var charWidth    = inst.properties["Character width"];
	var charScale    = inst.properties["Scale"];
	var charSpacing  = inst.properties["Character spacing"];
	if ( (text.length * (charWidth * charScale + charSpacing) - charSpacing) <= width && text.indexOf("\n") === -1)
	{
		var all_width = inst.measureWidth(text);

		if (all_width <= width)
		{
			// fits on one line
			lines.push({});
			lines[0].text = text;
			lines[0].width = all_width;
			return;
		}
	}

	this.WrapText(inst, text, lines, width, wrapbyword);
}

function WrapText(inst, text, lines, width, wrapbyword)
{
	var wordArray;
	lines.length = 0;
	if (wrapbyword) {
		wordArray = TokeniseWords(text);
	}
	else {
		wordArray = text;
	}

	var cur_line = "";
	var prev_line;
	var line_width;
	var i;
	var lineIndex = 0;
	var line;
	var ignore_newline = false;

	for (i = 0; i < wordArray.length; i++)
	{
		// Look for newline
		if (wordArray[i] === "\n")
		{
			if (ignore_newline === true) {
				// if a newline as been added by the wrapping
				// we ignore any happening just after
				ignore_newline = false;
			} else {
				// Flush line.  
				addLine(inst,lines,lineIndex,cur_line);
				lineIndex++;
			}
			cur_line = "";
			continue;
		}
		ignore_newline = false;

		// Otherwise add to line
		prev_line = cur_line;
		cur_line += wordArray[i];

		// Measure line
		line_width = inst.measureWidth(trimRight(cur_line));

		// Line too long: wrap the line before this word was added
		if (line_width > width)
		{

			if (prev_line === "") {
				// if it's the first word, we push it on the line
				// to avoid an unnecessary blank line
				// and since we are wrapping, we ignore the next newline if any
				addLine(inst,lines,lineIndex,cur_line);
				cur_line = "";
				ignore_newline = true;
			} else {
				// else we push the previous line
				addLine(inst,lines,lineIndex,prev_line);
				cur_line = wordArray[i];
			}

			lineIndex++;

			// Wrapping by character: avoid lines starting with spaces
			if (!wrapbyword && cur_line === " ")
				cur_line = "";
		}
	}

	// Add any leftover line
	if (trimRight(cur_line).length)
	{
		addLine(inst,lines,lineIndex,cur_line);

		lineIndex++;
	}
}

