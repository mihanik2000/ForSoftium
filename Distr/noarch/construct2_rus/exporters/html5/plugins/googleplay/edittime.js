function GetPluginSettings()
{
	return {
		"name":			"Google Play",			// as appears in 'insert object' dialog, can be changed as long as "id" stays the same
		"id":			"googleplay",			// this is used to identify this plugin and is saved to the project; never change it
		"version":		"1.0",					// (float in x.y format) Plugin version - C2 shows compatibility warnings based on this
		"description":	"Доступ игровых сервисов Google Play.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/175/google-play",
		"category":		"Конкретная платформа",	// Prefer to re-use existing categories, but you can set anything here
		"type":			"object",				// either "world" (appears in layout and is drawn), else "object"
		"rotatable":	false,					// only used when "type" is "world".  Enables an angle property on the object.
		"dependency":	"cordova.oauth2.js",
		"cordova-plugins": "org.apache.cordova.inappbrowser",
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
				
AddCondition(0, cf_trigger, "При загрузке", "Игровые сервисы Google Play", "При загрузке", "Запускается, когда игровые службы загружены и готовы к использованию.", "OnLoaded");

AddCondition(1, cf_none, "Загружено", "Игровые сервисы Google Play", "Загружено", "Правда, если 'загружен' был запущен, а подключаемый модуль готов к использованию.", "IsLoaded");

AddCondition(2, cf_trigger, "При подписании", "Игровые сервисы Google Play", "При подписании", "Активируется, когда пользователь успешно подписывается.", "OnSignedIn");

AddCondition(3, cf_none, "Вход в систему", "Игровые сервисы Google Play", "Вход в систему", "Правда, если пользователь в данный момент вошел в систему.", "IsSignedIn");

AddCondition(4, cf_trigger, "При ошибке", "Игровые сервисы Google Play", "При ошибке", "Активируется при возникновении ошибки в игровых службах.", "OnError");

AddCondition(5, cf_trigger, "О получении сведений об игроке", "Игровые сервисы Google Play", "О получении сведений об игроке", "Активируется после получения ответа 'запрос об игроке', когда получен ответ.", "OnPlayerDetails");

AddCondition(6, cf_trigger, "При выходе", "Игровые сервисы Google Play", "При выходе", "Вызывается, когда пользователь выходит из систему.", "OnSignedOut");

AddCondition(7, cf_trigger, "Ошибка автоматического входа", "Игровые сервисы Google Play", "Ошибка автоматического входа", "Запускается при запуске, если пользователь не может автоматически войти в систему. Необходимо будет использовать действие 'вход'.", "OnAutoSignInFailed");

AddCondition(8, cf_trigger, "Успешное представление результатов", "Турнирная таблица", "Успешное представление результатов", "Активируется после выполнения действия 'Отправить балл', если оценка была успешно отправлена.", "OnScoreSubmitSuccess");

AddCondition(9, cf_trigger, "Сбой при отправке оценки", "Турнирная таблица", "Сбой при отправке оценки", "Активируется после выполнения действия 'Отправить балл' если оценка не была успешно отправлена.", "OnScoreSubmitFail");

AddCondition(10, cf_trigger, "Успешное завершение запроса с высоким разрешением", "Турнирная таблица", "Успешное завершение запроса с высоким разрешением", "Активируется после выполнения действия 'запрос Хи-балл', если баллы были получены успешно.", "OnHiScoreRequestSuccess");

AddCondition(11, cf_trigger, "Сбой при запросе на оценку", "Турнирная таблица", "Сбой при запросе на оценку", "Активируется после выполнения действия 'запрос Хи-балл', если запрос не прошел.", "OnHiScoreRequestFail");

AddCondition(12, cf_trigger, "В списке результатов успешно", "Достижения", "В списке результатов успешно", "Активируется после выполнения действия 'список достижений'при успешном получении списка.", "OnAchievementsRequestSuccess");

AddCondition(13, cf_trigger, "Ошибка в списке результатов", "Достижения", "Ошибка в списке результатов", "Активируется после выполнения действия 'список достижений' в случае сбоя запроса.", "OnAchievementsRequestFail");

AddNumberParam("Индекс", "Индекс достижения.");
AddComboParamOption("скрыт");
AddComboParamOption("показал");
AddComboParamOption("разблокировано");
AddComboParam("Состояние", "Состояние достижения для испытания.");
AddCondition(14, cf_none, "Сравнить достижения", "Достижения", "Достижения <i>{0}</i> is {1}", "Протестируйте, скрывается ли достижение по индексу и обнаруживается или разблокируется.", "CompareAchievementState");

AddCondition(15, cf_trigger, "Успешное выполнение метаданных", "Достижения", "Успешное выполнение метаданных", "Активируется после выполнения действия 'Получение метаданных' если данные получены успешно.", "OnAchievementsMetadataSuccess");

AddCondition(16, cf_trigger, "Ошибка при достижении метаданных", "Достижения", "Ошибка при достижении метаданных", "Активируется после выполнения действия 'Получение метаданных' в случае сбоя запроса.", "OnAchievementsMetadataFail");

AddStringParam("Код достижения", "Идентификатор достижения, который был раскрыт.")
AddCondition(17, cf_trigger, "О достигнутых достижениях", "Достижения", "По достижению <b>{0}</b> показал", "Активируется после 'Показать', когда достижение успешно раскрыто.", "OnAchievementRevealed");

AddStringParam("Код достижения", "Идентификатор достижения, который был разблокирован.")
AddCondition(18, cf_trigger, "О достигнутых успехах", "Достижения", "По достижению <b>{0}</b> разблокировано", "Активируется после 'разблокировать'или когда выполняются шаги добавочного достижения.", "OnAchievementUnlocked");

////////////////////////////////////////
// Actions

// AddAction(id,				// any positive integer to uniquely identify this action
//			 flags,				// (see docs) af_none, af_deprecated
//			 list_name,			// appears in event wizard list
//			 category,			// category in event wizard list
//			 display_str,		// as appears in event sheet - use {0}, {1} for parameters and also <b></b>, <i></i>
//			 description,		// appears in event wizard dialog when selected
//			 script_name);		// corresponding runtime function name

AddAction(0, af_none, "Запрос сведений об игроке", "Google Play Игровые услуги", "Запрос сведений об игроке", "При подписании, запросите сведения о подписанном проигрывателе.", "RequestPlayerDetails");

AddAction(1, af_none, "Войти", "Google Play Игровые услуги", "Войти", "Вход игрока в систему.", "SignIn");

AddAction(2, af_none, "Выйти", "Google Play Игровые услуги", "Выйти", "Выход, если он уже вошел.", "SignOut");

AddStringParam("ID Таблицы лидеров", "Идентификатор лидера, чтобы отправить счет.");
AddNumberParam("Счёт", "Счет, который должен быть представлен в таблицу лидеров.");
AddStringParam("Тег", "До 64 дополнительных символов, которые необходимо отправить вместе с данным счетом.");
AddAction(3, af_none, "Отправить балл", "Турнирная таблица", "Отправить балл <b>{1}</b> (тег <i>{2}</i>) в таблицу лидеров <i>{0}</i>", "Отправьте счет в таблицу лидеров.", "SubmitScore");

AddStringParam("ID Таблицы лидеров", "Идентификатор турнира для отправки оценки.");
AddComboParamOption("общественный");
AddComboParamOption("социальный");
AddComboParam("Коллекции", "Возвращает ли все баллы или баллы, относящиеся к текущему игроку.");
AddComboParamOption("все время");
AddComboParamOption("еженедельно");
AddComboParamOption("ежедневно");
AddComboParam("Интервал времени", "Возврат верхних баллов за заданный промежуток времени.");
AddNumberParam("Результаты", "Количество результатов оценки, возвращаемых с 1 по 25.", "25");
AddComboParamOption("вверх");
AddComboParamOption("окно");
AddComboParam("Тип", "Возвращает верхние баллы или окно баллов за лучшую оценку текущего игрока.");
AddAction(4, af_none, "Запросить баллы", "Турнирная таблица", "Запрос {1} {2} количество баллов <b>{0}</b> (<i>{3}</i> результаты, <i>{4}</i>)", "Запросите список баллов из списка.", "RequestHiScores");

AddComboParamOption("все");
AddComboParamOption("скрыт");
AddComboParamOption("показал");
AddComboParamOption("разблокировано");
AddComboParam("Который", "Какие достижения, чтобы запросить список.");
AddAction(5, af_none, "Список достижений", "Достижения", "Список запросов {0} достижения", "Запросить список достижений для текущего игрока.", "RequestAchievements");

AddAction(6, af_none, "Получение метаданных", "Достижения", "Запрос метаданных достижений", "Запрашивать метаданные о достижениях (имя, описание и т. д.), позволяющие соответствующим выражениям вернуть правильные значения.", "RequestAchievementMetadata");

AddStringParam("Код достижения", "Идентификатор достижения для отображения.");
AddAction(7, af_none, "Показать", "Достижения", "Показать достижения <b>{0}</b>", "Показать скрытые достижения.", "RevealAchievement");

AddStringParam("Код достижения", "Идентификатор достижения для разблокировки.");
AddAction(8, af_none, "Разблокировать", "Достижения", "Разблокировать достижение <b>{0}</b>", "Разблокировать достижение.", "UnlockAchievement");

AddStringParam("Код достижения", "Идентификатор достижения для приращения.");
AddNumberParam("Шаги", "Число шагов для увеличения достижения.");
AddAction(9, af_none, "Добавить шаги", "Достижения", "Увеличение достижения <b>{0}</b> by <i>{1}</i> шаги", "Добавьте шаги к добавочному достижению.", "IncrementAchievement");

AddStringParam("Код достижения", "Идентификатор достижения для приращения.");
AddNumberParam("Шаги", "Число шагов, которые должны быть заданы для достижения прогресса. Шаги не могут быть уменьшены.");
AddAction(10, af_none, "Установка шагов", "Достижения", "Установить достижения <b>{0}</b> шаги <i>{1}</i>", "Установка этапов выполнения инкрементного достижения.", "SetStepsAchievement");

////////////////////////////////////////
// Expressions

// AddExpression(id,			// any positive integer to uniquely identify this expression
//				 flags,			// (see docs) ef_none, ef_deprecated, ef_return_number, ef_return_string,
//								// ef_return_any, ef_variadic_parameters (one return flag must be specified)
//				 list_name,		// currently ignored, but set as if appeared in event wizard
//				 category,		// category in expressions panel
//				 exp_name,		// the expression name after the dot, e.g. "foo" for "myobject.foo" - also the runtime function name
//				 description);	// description in expressions panel

AddExpression(0, ef_return_string, "", "Google Play Game Services", "ErrorMessage", "In 'On error', return the error message if available.");

AddExpression(1, ef_return_string, "", "Player details", "MyID", "The ID of the signed in player.");
AddExpression(2, ef_return_string, "", "Player details", "MyDisplayName", "The display name of the signed in player.");
AddExpression(3, ef_return_string, "", "Player details", "MyAvatarUrl", "The URL to the avatar image of the signed in player.");
AddExpression(4, ef_return_string, "", "Player details", "MyGivenName", "The given name of the signed in player.");
AddExpression(5, ef_return_string, "", "Player details", "MyFamilyName", "The family name of the signed in player.");

AddExpression(6, ef_return_number, "", "Hi-scores", "HiScoreTotalCount", "The total number of scores in the leaderboard.");
AddExpression(7, ef_return_number, "", "Hi-scores", "HiScoreMyBest", "The current player's best score on the returned leaderboard.");
AddExpression(8, ef_return_string, "", "Hi-scores", "HiScoreMyBestTag", "The tag for the current player's best score.");
AddExpression(9, ef_return_number, "", "Hi-scores", "HiScoreCount", "The number of scores returned for the current page.");

AddNumberParam("Index", "Score index");
AddExpression(10, ef_return_string, "", "Hi-scores", "HiScoreNameAt", "Player name at an index in the returned page.");

AddNumberParam("Index", "Score index");
AddExpression(11, ef_return_number, "", "Hi-scores", "HiScoreRankAt", "Score rank at an index in the returned page.");

AddNumberParam("Index", "Score index");
AddExpression(12, ef_return_number, "", "Hi-scores", "HiScoreAt", "Score value at an index in the returned page.");

AddNumberParam("Index", "Score index");
AddExpression(13, ef_return_string, "", "Hi-scores", "HiScoreTagAt", "Score tag at an index in the returned page.");

AddNumberParam("Index", "Score index");
AddExpression(14, ef_return_string, "", "Hi-scores", "HiScoreFormattedAt", "Formatted score value at an index in the returned page.");

AddNumberParam("Index", "Score index");
AddExpression(15, ef_return_string, "", "Hi-scores", "HiScoreFormattedRankAt", "Formatted score rank (e.g. \"1st\") at an index in the returned page.");

AddExpression(16, ef_return_string, "", "Hi-scores", "HiScoreMyFormattedBest", "The formatted version of the current player's best score.");
AddExpression(17, ef_return_number, "", "Hi-scores", "HiScoreMyBestRank", "The rank of the current player's best score.");
AddExpression(18, ef_return_string, "", "Hi-scores", "HiScoreMyBestFormattedRank", "The formatted rank (e.g. \"1st\") of the current player's best score.");

AddExpression(19, ef_return_number, "", "Achievements", "AchievementsCount", "The number of returned achievements in the list.");

AddNumberParam("Index", "Achievement index");
AddExpression(20, ef_return_string, "", "Achievements", "AchievementIDAt", "The ID of an achievement at an index.");

AddNumberParam("Index", "Achievement index");
AddExpression(21, ef_return_number, "", "Achievements", "AchievementStepsAt", "The current steps for an incremental achievement at an index.");

AddNumberParam("Index", "Achievement index");
AddExpression(22, ef_return_string, "", "Achievements", "AchievementNameAt", "The metadata name of an achievement at an index.");

AddNumberParam("Index", "Achievement index");
AddExpression(23, ef_return_string, "", "Achievements", "AchievementDescriptionAt", "The metadata description of an achievement at an index.");

AddNumberParam("Index", "Achievement index");
AddExpression(24, ef_return_string, "", "Achievements", "AchievementTypeAt", "The metadata type (\"standard\" or \"incremental\" of an achievement at an index.");

AddNumberParam("Index", "Achievement index");
AddExpression(25, ef_return_number, "", "Achievements", "AchievementTotalStepsAt", "The metadata total steps of an incremental achievement at an index.");

AddNumberParam("Index", "Achievement index");
AddExpression(26, ef_return_string, "", "Achievements", "AchievementRevealedIconURLAt", "The metadata icon image URL of a revealed achievement at an index.");

AddNumberParam("Index", "Achievement index");
AddExpression(27, ef_return_string, "", "Achievements", "AchievementUnlockedIconURLAt", "The metadata icon image URL of an unlocked achievement at an index.");

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
	new cr.Property(ept_text, 	"Application ID",	"",		"Идентификатор приложения из консоли разработчика Google Play."),
	new cr.Property(ept_text, 	"Client ID",		"",		"Идентификатор клиента из консоли разработчика Google Play."),
	new cr.Property(ept_text, 	"Client secret",	"",		"Клиент в тайне от консоли разработчика Google Play.")
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