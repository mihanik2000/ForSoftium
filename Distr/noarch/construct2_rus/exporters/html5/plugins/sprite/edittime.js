function GetPluginSettings()
{
	return {
		"name":			"Спрайт",
		"id":			"Sprite",
		"version":		"1.0",
		"description":	"Анимированный объект, который является строительным блоком большинства проектов.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/115/sprite",
		"category":		"Общее",
		"type":			"world",			// appears in layout
		"rotatable":	true,
		"flags":		pf_animations | pf_position_aces | pf_size_aces | pf_angle_aces | pf_appearance_aces | pf_zorder_aces | pf_effects
	};
};

////////////////////////////////////////
// Conditions
AddObjectParam("Объект", "Выберите объект для проверки на столкновения.");
AddCondition(0, cf_fake_trigger | cf_static, "В столкновении с другим объектом", "Столкновения", "В столкновении с {0}", "Срабатывает, когда объект сталкивается с другим объектом.", "OnCollision");

AddObjectParam("Объект", "Выберите объект для проверки на перекрытия с.");
AddCondition(1, 0, "Перекрывается другим объектом", "Столкновения", "Перекрывается {0}", "Проверьте, если объект перекрывает другой объект.", "IsOverlapping");

AddAnimationParam("Анимация", "Введите имя анимации, чтобы проверить, если играет.")
AddCondition(2, 0, "Играет", "Анимации", "Анимация {0} играя", "Тест, который анимации объекта воспроизводится в данный момент.", "IsAnimPlaying");

AddCmpParam("Сравнение", "Как сравнить номер текущего кадра анимации (от 0).");
AddNumberParam("Номер", "Номер кадра анимации для сравнения с (от 0).");
AddCondition(3, 0, "Сравнить кадр", "Анимации", "Анимация кадра {0} {1}", "Тест, который кадр анимации в данный момент отображается.", "CompareFrame");

AddAnimationParam("Анимация", "Введите имя анимации, который закончил.")
AddCondition(4, cf_trigger, "Завершена", "Анимации", "Анимация {0} завершена", "Срабатывает, когда анимация завершена.", "OnAnimFinished");

AddCondition(5, cf_trigger, "Любая завершена", "Анимации", "Любая анимация завершена", "Срабатывает, когда любая анимация закончена.", "OnAnyAnimFinished");

AddCondition(6, cf_trigger, "Кадр изменен", "Анимации", "Кадр изменен", "Срабатывает, когда текущий кадр анимации изменен.", "OnFrameChanged");

AddCondition(7, 0, "Отражается", "Внешность", "Отражается", "Правда, если объект был зеркальным с 'Установить отражение' действия.", "IsMirrored");
AddCondition(8, 0, "Перевернуто", "Внешность", "Перевернуто", "Правда, если объект был переворачивается с 'Установить переворачивание' действия.", "IsFlipped");

AddObjectParam("Объект", "Выберите объект для проверки на перекрытия с.");
AddNumberParam("Смещение X", "Сумма смещения координата Х (в пикселях) перед проверкой столкновения.");
AddNumberParam("Смещение Y", "Сумма смещения координата Y (в пикселях) перед проверкой столкновения.");
AddCondition(9, 0, "Перекрывается со смещением", "Столкновения", "Перекрывается {0} по смещению (<i>{1}</i>, <i>{2}</i>)", "Проверьте, если объект перекрывает другой объект смещенной позиции.", "IsOverlappingOffset");

AddCondition(10, cf_trigger, "URL изображения загружается", "Web", "URL изображения загружается", "Срабатывает после 'Загрузить изображение из URL', когда изображение завершает загрузку.", "OnURLLoaded");

AddCondition(11, 0, "Коллизии включены", "Столкновения", "Коллизии включены", "Правда, если столкновения объекта включены и будет стрелять события столкновения.", "IsCollisionEnabled");

AddCmpParam("Сравнение", "Как сравнить текущую скорость анимации.");
AddNumberParam("Номер", "Скорость анимации, для сравнения.");
AddCondition(12, 0, "Сравнить скорость", "Анимации", "Скорость анимации {0} {1}", "Сравните текущую скорость анимации.", "CompareAnimSpeed");

////////////////////////////////////////
// Actions
AddObjectParam("Объект", "Выберите тип объекта нового экземпляра, чтобы создать.");
AddLayerParam("Слой", "Имя или номер слоя, чтобы создать экземпляр в.");
AddAnyTypeParam("Точка изображения", "Используйте 0 для координат объекта, либо имя или номер точки изображения, чтобы создать объект из.", "0");
AddAction(0, 0, "Создать другой объект", "Разное", "Создать {0} на слое <b>{1}</b> <i>(точка изображения {2})</i>", "Создайте еще один объект на этом объекте.", "Spawn");

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

AddAction(2, 0, "Стоп",		"Анимации",	"Остановить анимацию",	"Остановить текущую анимацию от игры.", "StopAnim");

AddComboParamOption("текущий кадр");
AddComboParamOption("начало");
AddComboParam("Из", "Выберите, следует ли возобновить или перематывать анимацию к первому кадру.");
AddAction(3, 0, "Старт",	"Анимации",	"Запустить анимацию из {0}",	"Начало текущей анимации, если оно было остановлено.", "StartAnim");

AddAnimationParam("Анимация", "Название анимации для установки.");
AddComboParamOption("текущий кадр");
AddComboParamOption("начало");
AddComboParam("Из", "Выберите, будет ли играть с того же номера кадра или перематывать анимацию к первому кадру.", 1);
AddAction(4, 0, "Установить анимацию", "Анимации", "Установить анимацию <b>{0}</b> (играть с {1})", "Установить текущую анимацию", "SetAnim");

AddNumberParam("Номер кадра", "Число кадров анимации для установки (от 0).");
AddAction(5, 0, "Установить кадр", "Анимации", "Установить кадр анимации <b>{0}</b>", "Установить номер текущего кадра анимации.", "SetAnimFrame");

AddNumberParam("Speed", "The new animation speed, in animation frames per second.");
AddAction(6, 0, "Set speed", "Animations", "Set animation speed to <b>{0}</b>", "Set the current animation speed.", "SetAnimSpeed");

AddComboParamOption("Отражаемый");
AddComboParamOption("Не отражаемый");
AddComboParam("Состояние", "Выберите, нужно ли горизонтально отразить объект или установить его обратно в нормальное русло.");
AddAction(7, 0, "Установить отражение", "Внешность", "Установить <b>{0}</b>", "Установить объект горизонтально зеркальное отображение или вернуться к нормальной состоянии.", "SetMirrored");

AddComboParamOption("Перевернутый");
AddComboParamOption("Не перевернутый");
AddComboParam("Состояние", "Выберите, нужно ли вертикально перевернуть объект или установить его обратно в нормальное русло.");
AddAction(8, 0, "Установить переворачивание", "Внешность", "Установить <b>{0}</b>", "Установить объект вертикально или переворачивается обратно в нормальное русло.", "SetFlipped");

AddNumberParam("Масштаб", "Ширина и высота объекта для установки, основываясь на кратное первоначальных размеров, например 1 = оригинальный размер, 2 = двойной размер, 0.5 = половина размер и т.д.", "1");
AddAction(9, 0, "Установить масштаб", "Размер и позиция", "Установить масштаб <i>{0}</i>", "Установите ширину и высоту как кратное его первоначального размера.", "SetScale");

AddStringParam("URI", "Введите URL-адрес в Интернете, или данные URI, образа для загрузки.", "\"http://\"");
AddComboParamOption("Изменение размера до размера изображения");
AddComboParamOption("Держите текущий размер");
AddComboParam("Размер", "Независимо от того, чтобы изменить размер спрайта с размером загруженного изображения, или растянуть его к текущему размеру.");
AddAction(10, 0, "Загрузить изображение из URL", "Web", "Загрузить изображение из <i>{0}</i> ({1})", "Заменить текущий кадр анимации отображения с изображением загруженного с веб-адреса или данных URI.", "LoadURL");

AddComboParamOption("Отключено");
AddComboParamOption("Включено");
AddComboParam("Столкновения", "Независимо от того, чтобы включить или отключить столкновений для данного объекта.");
AddAction(11, 0, "Установить режим столкновения", "Разное", "Установить столкновения <b>{0}</b>", "Установить, будет ли объект регистрировать события столкновения или нет.", "SetCollisions");

AddNumberParam("Номер кадра", "Номер кадра анимации, чтобы повторить (от 0).");
AddAction(12, 0, "Установить повтор кадра", "Анимации", "Установить повтор к кадру <b>{0}</b>", "Установите количество кадров анимации, чтобы повторить в перекручивания анимации.", "SetAnimRepeatToFrame");

////////////////////////////////////////
// Expressions
AddExpression(0, ef_return_number, "Get animation frame", "Animations", "AnimationFrame", "The current animation frame number (0-based).");

AddExpression(1, ef_return_number, "Get animation frame count", "Animations", "AnimationFrameCount", "The number of animation frames in the current animation.");

AddExpression(2, ef_return_string, "Get animation name", "Animations", "AnimationName", "The name of the current animation.");

AddExpression(3, ef_return_number, "Get animation speed", "Animations", "AnimationSpeed", "The speed of the current animation, in animation frames per second.");

AddAnyTypeParam("ImagePoint", "Name or number of image point to get.");
AddExpression(4, ef_return_number, "Get image point X",		"Size & Position",	"ImagePointX", "The X position of one of the object's image points.");

AddAnyTypeParam("ImagePoint", "Name or number of image point to get.");
AddExpression(5, ef_return_number, "Get image point Y",		"Size & Position",	"ImagePointY", "The Y position of one of the object's image points.");

AddExpression(6, ef_return_number, "Get image width", "Animations", "ImageWidth", "The width of the current animation frame image, in pixels.");
AddExpression(7, ef_return_number, "Get image height", "Animations", "ImageHeight", "The height of the current animation frame image, in pixels.");

AddExpression(8, ef_return_number, "", "Size & Position", "ImagePointCount", "The number of image points the current frame has.");

ACESDone();

// Property grid properties for this plugin
var property_list = [
	new cr.Property(ept_link,	"Анимации",			lang("project\\misc\\sprite-edit-link"), "Нажмите для редактирования анимации объекта.", "firstonly"),
	new cr.Property(ept_link,	"Размер",					lang("project\\misc\\sprite-make11-link"), "Нажмите, чтобы установить объект такого же размера, как его образ.", "worldundo"),
	new cr.Property(ept_combo,	"Initial visibility",	"Visible",	"Выберите, отображается ли объект при запуске макета.", "Visible|Invisible"),
	new cr.Property(ept_text,	"Initial animation",	"Default",	"Начальная анимация показ."),
	new cr.Property(ept_integer,"Initial frame",		0,			"Начальная анимация кадр показ."),
	new cr.Property(ept_combo,	"Collisions",			"Включено",	"Является ли объект будущим регистрированным событиям столкновения или нет.", "Отключено|Включено")
	//new cr.Property(ept_combo,	"Effect",				"(none)",	"Choose an effect for this object.  (This does not preview in the layout, only when you run.)", "(none)|Additive|XOR|Copy|Destination over|Source in|Destination in|Source out|Destination out|Source atop|Destination atop")
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
	this.texture_loaded = false;
	this.last_imgsize = new cr.vector2(0, 0);
	this.last_texture = null;
	this.last_texture_id = "";
}

IDEInstance.prototype.OnAfterLoad = function ()
{
	// Must initialise last_imgsize for correct updating of sprites on layouts without a tab open
	var texture = this.instance.GetTexture(this.properties["Initial frame"], this.properties["Initial animation"]);
	this.last_imgsize = texture.GetImageSize();
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
	// Edit animations link
	if (property_name == "Анимации")
	{
		this.instance.EditTexture();
	}
	// Make 1:1 link
	else if (property_name == "Размер")
	{
		if (this.texture_loaded)
			this.just_inserted = true;		// will scale to texture size when redrawn and update property grid
		else
		{
			// The object could be resized, but we can't refresh the property grid here.
			// Just assume the layout is always open, and prompt if not.
			alert("The object cannot be scaled to original size unless the layout containing it is open.");
		}
	}
}

IDEInstance.prototype.OnRendererInit = function(renderer)
{
	this.last_texture = this.instance.GetTexture(this.properties["Initial frame"], this.properties["Initial animation"]);
	this.last_texture_id = this.last_texture.GetID();
	
	renderer.LoadTexture(this.last_texture);
	this.texture_loaded = true;
	
	this.instance.SetHotspot(this.last_texture.GetHotspot());
}
	
// Called to draw self in the editor
IDEInstance.prototype.Draw = function(renderer)
{
	var texture = this.instance.GetTexture(this.properties["Initial frame"], this.properties["Initial animation"]);
	var texture_id = texture.GetID();
	
	if (this.last_texture_id !== "" && this.last_texture_id !== texture_id)
	{
		// Texture has changed: unload old and reload new.
		if (this.last_texture)
			renderer.ReleaseTexture(this.last_texture);
			
		renderer.LoadTexture(texture);
		this.instance.SetHotspot(texture.GetHotspot());
	}
	
	this.last_texture = texture;
	this.last_texture_id = texture_id;
	
	renderer.SetTexture(texture);
	
	var imgsize = texture.GetImageSize();
	
	// First draw after insert: use size of texture.
	// Done after SetTexture so the file is loaded and dimensions known, preventing
	// the file being loaded twice.
	if (this.just_inserted)
	{
		this.just_inserted = false;
		this.instance.SetSize(imgsize);
		
		RefreshPropertyGrid();		// show new size
	}
	// If not just inserted and the sprite texture has been edited and changed size, scale the texture accordingly.
	else if ((imgsize.x !== this.last_imgsize.x || imgsize.y !== this.last_imgsize.y)
		&& (this.last_imgsize.x !== 0 && this.last_imgsize.y !== 0))
	{
		var sz = new cr.vector2(imgsize.x / this.last_imgsize.x, imgsize.y / this.last_imgsize.y);
		var instsize = this.instance.GetSize();
		
		sz.mul(instsize.x, instsize.y);
		this.instance.SetSize(sz);
		this.instance.SetHotspot(texture.GetHotspot());
		
		RefreshPropertyGrid();		// show new size
	}

	this.last_imgsize = imgsize;
	
	if (renderer.SupportsFullSmoothEdges())
	{
		// Get the object size and texture size
		var objsize = this.instance.GetSize();
		var texsize = texture.GetImageSize();
		
		// Calculate pixels per texel, then get a quad padded with a texel padding
		var pxtex = new cr.vector2(objsize.x / texsize.x, objsize.y / texsize.y);
		var q = this.instance.GetBoundingQuad(new cr.vector2(pxtex.x, pxtex.y));
		
		// Calculate the size of a texel in texture coordinates, then calculate texture coordinates
		// for the texel padded quad
		var tex = new cr.vector2(1.0 / texsize.x, 1.0 / texsize.y);
		var uv = new cr.rect(-tex.x, -tex.y, 1.0 + tex.x, 1.0 + tex.y);
		
		// Render a quad with a half-texel padding for smooth edges
		renderer.Quad(q, this.instance.GetOpacity(), uv);
	}
	else
	{
		// Fall back to half-smoothed or jagged edges, depending on what the renderer supports
		renderer.Quad(this.instance.GetBoundingQuad(), this.instance.GetOpacity());
	}
}

IDEInstance.prototype.OnRendererReleased = function(renderer)
{
	this.texture_loaded = false;
	renderer.ReleaseTexture(this.last_texture);
}

IDEInstance.prototype.OnTextureEdited = function ()
{
	var texture = this.instance.GetTexture(this.properties["Initial frame"], this.properties["Initial animation"]);
	this.instance.SetHotspot(texture.GetHotspot());
	
	var imgsize = texture.GetImageSize();
	
	// If sprite texture has been edited and changed size, scale the texture accordingly.
	if ((imgsize.x !== this.last_imgsize.x || imgsize.y !== this.last_imgsize.y)
		&& (this.last_imgsize.x !== 0 && this.last_imgsize.y !== 0))
	{
		var sz = new cr.vector2(imgsize.x / this.last_imgsize.x, imgsize.y / this.last_imgsize.y);
		var instsize = this.instance.GetSize();
		
		sz.mul(instsize.x, instsize.y);
		this.instance.SetSize(sz);
		
		this.last_imgsize = imgsize;
	}
}