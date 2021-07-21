function GetPluginSettings()
{
	return {
		"name":			"Медиа Пользователь",			// as appears in 'insert object' dialog, can be changed as long as "id" stays the same
		"id":			"UserMedia",			// this is used to identify this plugin and is saved to the project; never change it
		"version":		"1.0",					// (float in x.y format) Plugin version - C2 shows compatibility warnings based on this
		"description":	"Получить средства массовой информации от пользователя с помощью камеры или микрофона, в том числе распознавания и синтеза речи.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/144/user-media",
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
						| pf_effects
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
				
AddCondition(0, cf_trigger, "Заявка на медиаплату утверждения", "Запрос носителя", "Заявка на медиаплату утверждения", "Активируется после того, как пользователь утвердит запрос из запроса носителя.", "OnApproved");
AddCondition(1, cf_trigger, "Запрос на носители отклонен", "Запрос носителя", "Запрос на носители отклонен", "Инициируется при ошибке или если пользователь отказывается от запроса в запросе носителя.", "OnDeclined");

AddCondition(2, cf_none, "Поддержка мультимедиа", "Пользовательские носители", "Поддержка мультимедиа", "Правда, если текущий браузер поддерживает доступ к носителю пользователя.", "SupportsUserMedia");

AddCondition(3, cf_none, "Поддержка распознавания речи", "Распознавание речи", "Поддержка распознавания речи", "Правда, если текущий браузер поддерживает распознавание речи.", "SupportsSpeechRecognition");

AddCondition(4, cf_trigger, "Старт", "Распознавание речи", "Запуск распознавания речи", "Запускается при запуске распознавания речи.", "OnSpeechRecognitionStart");

AddCondition(5, cf_trigger, "Конец", "Распознавание речи", "После завершения распознавания речи", "Активируется при окончании распознавания речи.", "OnSpeechRecognitionEnd");

AddCondition(6, cf_trigger, "Ошибка", "Распознавание речи", "Ошибка распознавания речи", "Активируется при возникновении ошибки при запуске речевого распознавания, например отказа в разрешении.", "OnSpeechRecognitionError");

AddCondition(7, cf_trigger, "В результате", "Распознавание речи", "В результате распознавания речи", "Активируется во время распознавания речи при обнаружении результатов.", "OnSpeechRecognitionResult");

AddCondition(8, cf_none, "Распознавание речи", "Распознавание речи", "Признается речь", "Правда, если распознавание речи в данный момент активен.", "IsRecognisingSpeech");

AddCondition(9, cf_trigger, "При чтении обновления", "Рассеянный свет", "При чтении обновления рассеянного света", "Активируется при чтении датчика рассеянного света устройства (если присутствует).", "OnDeviceLight");

AddCondition(10, cf_none, "Поддержка синтеза речи", "Синтез речи", "Поддержка синтеза речи", "Правда, если текущий браузер поддерживает синтез речи.", "SupportsSpeechSynthesis");

AddCondition(11, cf_none, "Говорит", "Синтез речи", "Говорит", "Правда, если в данный момент речь идет о тексте.", "IsSpeaking");

AddCondition(12, cf_trigger, "На извлеченных источниках мультимедиа", "Запрос носителя", "На извлеченных источниках мультимедиа", "Активируется после 'получения источников носителей' при наличии списка источников мультимедиа.", "OnMediaSources");

AddCondition(13, cf_trigger, "На холсте готовая запись", "Запись", "На холсте готовая запись", "Активируется после 'остановки записи полотна', когда запись доступна в канвасрекордингурл выражении.", "OnCanvasRecordingReady");

AddCondition(14, cf_none, "Поддерживается запись полотна", "Запись", "Поддерживается запись полотна", "Правда, если текущий браузер поддерживает запись полотна.", "SupportsCanvasRecording");


////////////////////////////////////////
// Actions

// AddAction(id,				// any positive integer to uniquely identify this action
//			 flags,				// (see docs) af_none, af_deprecated
//			 list_name,			// appears in event wizard list
//			 category,			// category in event wizard list
//			 display_str,		// as appears in event sheet - use {0}, {1} for parameters and also <b></b>, <i></i>
//			 description,		// appears in event wizard dialog when selected
//			 script_name);		// corresponding runtime function name

AddNumberParam("Источник", "Отсчитываемый от нуля индекс используемого источника камеры.");
AddAction(0, af_none, "Запросить камеру", "Запрос носителя", "Запрос источника камеры <i>{0}</i>", "Запрашивать у пользователя доступ к видеовходу с камеры, если таковой присутствует.", "RequestCamera");

AddAction(1, af_none, "Остановить", "Запрос носителя", "Stop", "Прекратить доступ к носителю пользователя.", "Stop");

AddComboParamOption("PNG");
AddComboParamOption("JPEG");
AddComboParam("Формат", "Выберите формат файла для сохранения моментального снимка. Формат PNG не имеет потерь, но JPEG-файлы меньше.");
AddNumberParam("Качество JPEG", "Если 'формат'— 'JPEG' то качество JPEG с 0 (наихудшее) до 100 (наилучшим образом). Игнорируется для PNG.", "75");
AddAction(2, af_none, "Снимок", "Запрос носителя", "Сделать снимок ({0}, качества <i>{1}</i>)", "Сделать снимок текущего изображения с камеры. Используйте выражение 'URL снимка' для получения результата.", "Snapshot");

AddStringParam("Тег", "Тег в объекте Аудио для маршрутизации входного микрофона.", "\"mic\"");
AddNumberParam("Источник", "Отсчитываемый от нуля индекс используемого источника звука.");
AddAction(3, af_none, "Запросить микрофон", "Запрос носителя", "Запрос источника микрофона <i>{1}</i> и маршрут к Аудио тегу {0}", "Запрашивать у пользователя доступ к звуковому вводу с микрофона, если он присутствует. Звуковой объект должен быть добавлен в проект.", "RequestMic");

AddStringParam("Язык", "Код языка для распознавания или пустой для текущего языка браузера.", "\"en\"");
AddComboParamOption("Непрерыв");
AddComboParamOption("Одинарная фраза");
AddComboParam("Режим", "Следует ли продолжать обнаруживать речь до остановки (непрерывного) или автоматически останавливаться при остановке речи (одинарная фраза).");
AddComboParamOption("Промежуточ");
AddComboParamOption("Окончательно");
AddComboParam("Результаты", "Следует ли допускать неопределенные (промежуточные) результаты или только окончательные результаты.");
AddAction(4, af_none, "Запрос распознавания речи", "Распознавание речи", "Запрос распознавания речи (язык <i>{0}</i>, {1} режим, {2} результаты)", "Запрашивать у пользователя ввод для распознавания речи с микрофона, если он присутствует.", "RequestSpeechRecognition");

AddAction(5, af_none, "Остановить распознавание речи", "Распознавание речи", "Остановить распознавание речи", "Остановите все активные входные данные распознавания речи.", "StepSpeechRecognition");

AddStringParam("Текст", "Текст, на который будет говориться.");
AddStringParam("Язык", "Язык текста, например, \ 'en-US \' для США. Оставьте пустым, чтобы использовать язык по умолчанию.");
AddStringParam("URI голосовой связи", "Голос для использования. Оставьте пустым, чтобы использовать голос по умолчанию.");
AddNumberParam("Громкость", "Громкость для разговора по тексту при ослаблении дБ.");
AddNumberParam("Темп", "Относительная скорость, с которой выговорить, например, 1 для нормальной, 0,5 на половину скорости.", "1");
AddNumberParam("Шаг", "Относительный шаг, на котором следует говорить, между 0 и 2.", "1");
AddAction(6, af_none, "Говорить текст", "Speech synthesis", "Говорить текст <b>{0}</b> (язык <i>{1}</i>, URI голосовой связи <i>{2}</i>, громкость <i>{3}</i> dB, темп <i>{4}</i>, шаг <i>{5}</i>", "Прочитайте текст с синтезом речи.", "SpeakText");

AddAction(7, af_none, "Прекрати говорить", "Синтез речи", "Прекрати говорить", "Отмена любого активного синтеза речи.", "StopSpeaking");

AddAction(8, af_none, "Приостановка речи", "Синтез речи", "Приостановка речи", "Приостановка любого активного синтеза речи.", "PauseSpeaking");

AddAction(9, af_none, "Возобновить речь", "Синтез речи", "Возобновить речь", "Возобновление ранее приостановленного синтеза речи.", "ResumeSpeaking");

AddAction(10, af_none, "Получение источников мультимедиа", "Запрос носителя", "Получение источников мультимедиа", "Запросить список доступных источников мультимедиа. ' на извлеченных носителях ' будет запущен вскоре после.", "GetMediaSources");

AddComboParamOption("VP8 (видео/vp8)");
AddComboParam("Формат", "Формат видео для кодирования записи полотна.");
AddNumberParam("Качества (kbps)", "Скорость данных для кодирования в килобайтах в секунду (kbps).", "2500");
AddNumberParam("Кадров", "Кадры в секунду для захвата в видео. Используйте 0 для частоты отображения.");
AddAction(11, af_none, "Начать запись холста", "Запись полотна", "Начать запись холста (<i>{0}</i> @ <i>{1}</i> kbps, <i>{2}</i> FPS)", "Запись видео активного полотна в реальном времени.", "StartRecordingCanvas");

AddAction(12, af_none, "Остановить запись полотна", "Запись полотна", "Остановить запись полотна", "Завершите запись видео полотна. Триггеры 'на полотне готовой записи' если они доступны.", "StopRecordingCanvas");


////////////////////////////////////////
// Expressions

// AddExpression(id,			// any positive integer to uniquely identify this expression
//				 flags,			// (see docs) ef_none, ef_deprecated, ef_return_number, ef_return_string,
//								// ef_return_any, ef_variadic_parameters (one return flag must be specified)
//				 list_name,		// currently ignored, but set as if appeared in event wizard
//				 category,		// category in expressions panel
//				 exp_name,		// the expression name after the dot, e.g. "foo" for "myobject.foo" - also the runtime function name
//				 description);	// description in expressions panel

AddExpression(0, ef_return_number, "", "User Media", "VideoWidth", "Return the width of the image from the device camera.");
AddExpression(1, ef_return_number, "", "User Media", "VideoHeight", "Return the height of the image from the device camera.");
AddExpression(2, ef_return_string, "", "User Media", "SnapshotURL", "Return a data URI containing image data from a snapshot. Can be set to a Sprite or Tiled Background.");

AddExpression(3, ef_return_string, "", "Speech recognition", "FinalTranscript", "Return the final recognised speech.");

AddExpression(4, ef_return_string, "", "Speech recognition", "InterimTranscript", "Return the interim recognised speech, which can change.");

AddExpression(5, ef_return_string, "", "Speech recognition", "SpeechError", "Return a string describing the type of error in 'On error'.");

AddExpression(6, ef_return_number, "", "Ambient light", "AmbientLux", "Return the device ambient light reading, if available, in lux.");

AddExpression(7, ef_return_number, "", "Speech synthesis", "VoiceCount", "Return the number of available voices.");

AddNumberParam("Index", "Zero-based index of the voice.");
AddExpression(8, ef_return_string, "", "Speech synthesis", "VoiceNameAt", "Return the name of a voice at an index.");

AddNumberParam("Index", "Zero-based index of the voice.");
AddExpression(9, ef_return_string, "", "Speech synthesis", "VoiceLangAt", "Return the language of a voice at an index.");

AddNumberParam("Index", "Zero-based index of the voice.");
AddExpression(10, ef_return_string, "", "Speech synthesis", "VoiceURIAt", "Return the URI of a voice at an index.");

AddExpression(11, ef_return_number, "", "User Media", "AudioSourceCount", "Return the number of audio sources available.");

AddNumberParam("Index", "Zero-based index of the audio source.");
AddExpression(12, ef_return_string, "", "User Media", "AudioSourceLabelAt", "Return the label of a given audio source.");

AddExpression(13, ef_return_number, "", "User Media", "CameraSourceCount", "Return the number of camera sources available.");

AddNumberParam("Index", "Zero-based index of the camera source.");
AddExpression(14, ef_return_string, "", "User Media", "CameraSourceLabelAt", "Return the label of a given camera source.");

AddNumberParam("Index", "Zero-based index of the camera source.");
AddExpression(15, ef_return_string, "", "User Media", "CameraSourceFacingAt", "Return the facing (e.g. front/back) of a given camera source.");

AddExpression(16, ef_return_string, "", "Canvas recording", "CanvasRecordingURL", "Return a URL of the canvas recording that can be downloaded with the Browser object.");

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
	renderer.Line(tl, tr, cr.RGB(255, 0, 0));
	renderer.Line(tr, br, cr.RGB(255, 0, 0));
	renderer.Line(br, bl, cr.RGB(255, 0, 0));
	renderer.Line(bl, tl, cr.RGB(255, 0, 0));
	renderer.Line(tl, br, cr.RGB(255, 0, 0));
	renderer.Line(bl, tr, cr.RGB(255, 0, 0));
}

// For rendered objects to release fonts or textures
IDEInstance.prototype.OnRendererReleased = function(renderer)
{
}