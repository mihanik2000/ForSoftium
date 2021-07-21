function GetPluginSettings()
{
	return {
		"name":			"Facebook",
		"id":			"Facebook",
		"version":		"1.0",
		"description":	"Доступ к Facebook функции API.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/112/facebook",
		"category":		"Конкретная платформа",
		"type":			"object",			// not in layout
		"rotatable":	false,
		"flags":		pf_singleglobal,
		"cordova-plugins": "org.apache.cordova.inappbrowser",
		"dependency":	"channel.html"
	};
};

//////////////////////////////////////////////////////////////
// Conditions
AddCondition(0,	0, "Готово", "Facebook", "Готово", "Правда, когда API Facebook загружен и готов к использованию.", "IsReady");
AddCondition(1,	0, "Пользователь зарегистрировался в", "Facebook", "Пользователь зарегистрировался в", "Правда, если в настоящее время рассматривается в Facebook с помощью вошедшего в систему пользователя.", "IsLoggedIn");

AddCondition(2, cf_trigger, "Пользователь вошел в систему", "Facebook", "Пользователь вошел в систему", "Вызывается, когда пользователь успешно входит в систему.", "OnLogIn");
AddCondition(3, cf_trigger, "Пользователь вышел из системы", "Facebook", "Пользователь вышел из системы", "Вызывается, когда пользователь выходит из системы.", "OnLogOut");
AddCondition(4, cf_trigger, "Имя доступно", "Facebook", "Имя доступно", "Срабатывает после входа в систему, когда имя пользователя становится доступным.", "OnNameAvailable");

AddCondition(5, cf_trigger, "Наивысший балл, доступно для пользователя", "Лучшие результаты (при входе с разрешения)", "Наивысший балл, доступно для пользователя", "Срабатывает после 'запроса пользователя' Лучший результат действия.", "OnUserTopScoreAvailable");

AddCondition(6, cf_trigger, "Хи-оценка", "Лучшие результаты (при входе с разрешения)", "Хи-оценка", "Срабатывает для каждого наивысший балл после 'запроса хи-табло' действие.", "OnHiscore");

AddCondition(7, cf_trigger, "Результат, представленный", "Лучшие результаты (при входе с разрешения)", "Результат, представленный", "Срабатывает, когда действие 'публикует счет' завершается.", "OnScoreSubmitted");

AddCondition(8,	cf_trigger, "Готов", "Facebook", "Готов", "Срабатывает, когда API Facebook загружен и готов к использованию.", "OnReady");

//////////////////////////////////////////////////////////////
// Actions
AddComboParamOption("Нечего");
AddComboParamOption("Опубликовать в поток");
AddComboParam("Разрешение потока", "Запрашивают у пользователя разрешение на автоматическое (без запроса) опубликовать поток пользователя. Не просите разрешения вам не нужны!");
AddComboParamOption("Нечего");
AddComboParamOption("Опубликовать баллы");
AddComboParam("Разрешение действия", "Запрашивают у пользователя разрешение на публикацию оценки для пользователя. App Secret требуется опубликовать результаты. Не входите в App секрет, если вы не используете баллы.");
AddAction(2, af_deprecated, "Авторизоваться", "Facebook", "Авторизоваться (запрос <i>{0}</i>, <i>{1}</i>)", "Вход пользователя в приложение, так что их детали могут быть доступны.", "LogIn");

AddAction(3, 0, "Выйти", "Facebook", "Выйти", "Выход пользователя.", "LogOut");

AddAction(4, 0, "Подскажите сообщение стены", "Подскажите (не требуется никаких разрешений)", "Подскажите сообщение стены", "Поднимают диалог, в котором пользователь может поделиться каким-нибудь текстом на стене или выбрать для отмены.", "PromptWallPost");

AddStringParam("Имя", "Имя приложения, которое будет отображаться в диалоговом окне Share.");
AddStringParam("Подпись", "Надпись появляется под именем в диалоге Share.");
AddStringParam("Описание", "Описание появляется под заголовком в диалоге Share.");
AddStringParam("URL изображения (необязательно)", "URL образа на сервере, чтобы использовать в диалоге Share. Должен включать http://. По умолчанию экспортируемого loading-logo.png.");
AddAction(5, 0, "Подскажите, чтобы поделиться этим приложением", "Подскажите (не требуется никаких разрешений)", "Подскажите, чтобы поделиться этим приложением (<i>{0}</i>, <i>{1}</i>, <i>{2}</i>, <i>{3}</i>)", "Поднимают диалог, в котором пользователь может поделиться ссылкой на приложение на стене или выбрать для отмены.", "PromptToShareApp");

AddStringParam("URL", "Ссылка для общего доступа.", "\"http://\"");
AddStringParam("Имя", "Текст ссылки, который будет отображаться в диалоговом окне Share.");
AddStringParam("Подпись", "Надпись появляется под текстом ссылки в диалоге Share.");
AddStringParam("Описание", "Описание появляется под заголовком в диалоге Share.");
AddStringParam("URL изображения (необязательно)", "URL образа на сервере, чтобы использовать в диалоге Share. Должен включать http: //");
AddAction(6, 0, "Подскажите поделиться ссылкой", "Подскажите (не требуется никаких разрешений)", "Подскажите поделиться ссылкой <b>{0}</b> (<i>{1}</i>, <i>{2}</i>, <i>{3}</i>, <i>{4}</i>)", "Поднимают диалог, в котором пользователь может поделиться ссылкой на их стене или выбрать для отмены.", "PromptToShareLink");

AddStringParam("Сообщение", "Текст для публикации на ленту пользователя. Рекомендуется делать это только когда пользователь инициирует действие.");
AddAction(7, 0, "Опубликовать запись на стене", "Публикация на поток (при входе с разрешения)", "Опубликовать запись на стене с текстом <i>{0}</i>", "Опубликовать сообщение на стене пользователя. Пользователь должен явным образом инициировать это.", "PublishToWall");

AddStringParam("Сообщение", "Текст для публикации на ленту пользователя. Рекомендуется делать это только когда пользователь инициирует действие.");
AddStringParam("URL", "Ссылка для общего доступа.", "\"http://\"");
AddStringParam("Имя", "Текст ссылки.");
AddStringParam("Подпись", "Надпись появляется под текстом ссылки.");
AddStringParam("Описание", "Описание появляется под заголовком.");
AddStringParam("URL изображения (необязательно)", "URL образа на сервере, чтобы использовать в диалоге Share. Должен включать http: //");
AddAction(8, 0, "Опубликовать ссылку", "Публикация на поток (при входе с разрешения)", "Опубликовать ссылку <b>{1}</b> (<i>{0}</i>, <i>{2}</i>, <i>{3}</i>, <i>{4}</i>, <i>{5}</i>)", "Опубликовать ссылку на стене пользователя. Пользователь должен явным образом инициировать это.", "PublishLink");

AddNumberParam("Счет", "Счет пользователя для этой игры, чтобы опубликовать.");
AddAction(9, 0, "Опубликовать счет", "Лучшие результаты (при входе с разрешения)", "Опубликовать счет <b>{0}</b>", "Опубликовать оценку для этого пользователя.", "PublishScore");

AddAction(10, 0, "Запрос пользователю c наивысшим баллом", "Лучшие результаты (при входе с разрешения)", "Запрос пользователю c наивысшим баллом", "Запрос наивысшим баллом пользователя, вызвав 'на пользователя наивысший балл доступно ', когда они получены.", "RequestUserHiscore");

AddNumberParam("Количество баллов", "Число хи-баллов, чтобы получить.", "10");
AddAction(11, 0, "Запрос хи-табло", "Лучшие результаты (при входе с разрешения)", "Запрос хи-табло сверху {0} баллов", "Запрос о приложении хи-табло, запуская 'на хи-счет 'для каждого хи-баллов получил.", "RequestHiscores");

AddStringParam("Разрешения", "Запрашиваемые разрешения, разделенных запятой. E.g. \"public_profile,publish_actions,user_games_activity\".");
AddAction(12, 0, "Авторизоваться", "Facebook", "Авторизоваться (разрешения: <i>{0}</i>)", "Вход пользователя в приложение, так что их детали могут быть доступны.", "LogIn2");

//////////////////////////////////////////////////////////////
// Expressions
AddExpression(0, ef_return_string, "Get full name", "Facebook", "FullName", "Get the user's full name, if they are logged in.");
AddExpression(1, ef_return_string, "Get first name", "Facebook", "FirstName", "Get the user's first name, if they are logged in.");
AddExpression(2, ef_return_string, "Get last name", "Facebook", "LastName", "Get the user's last name, if they are logged in.");

AddExpression(3, ef_return_number, "Get score", "Scores (when logged in with permission)", "Score", "Get the score, when in a 'on user top score' or 'on hi-score' event.");
AddExpression(5, ef_return_string, "Get hi-score name", "Scores (when logged in with permission)", "HiscoreName", "Get the name of the user with hi-score, when in an 'on hi-score' event.");
AddExpression(6, ef_return_number, "Get hi-score rank", "Scores (when logged in with permission)", "HiscoreRank", "Get the rank of the hi-score, when in an 'on hi-score' event.");

AddExpression(7, ef_return_number, "Get user ID", "Facebook", "UserID", "Get the user's ID, which is different even for users with the same name.");

AddExpression(8, ef_return_number, "Get hi-score user ID", "Scores (when logged in with permission)", "HiscoreUserID", "Get the user ID of the user with hi-score, when in an 'on hi-score' event.");

//////////////////////////////////////////////////////////////
ACESDone();

// Property grid properties for this plugin
var property_list = [
	new cr.Property(ept_text,		"App ID",		"",			"ID приложения Facebook дает вам после создания приложения."),
	new cr.Property(ept_text,		"App secret",	"",			"Секретная преложение Facebook дает вам после создания приложения. Только необходимо для представления результатов!")
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
}

// Called by the IDE after all initialization on this instance has been completed
IDEInstance.prototype.OnCreate = function()
{
}

// Called by the IDE after a property has been changed
IDEInstance.prototype.OnPropertyChanged = function(property_name)
{
}
	
// Called by the IDE to draw this instance in the editor
IDEInstance.prototype.Draw = function(renderer)
{
}

// Called by the IDE when the renderer has been released (ie. editor closed)
// All handles to renderer-created resources (fonts, textures etc) must be dropped.
// Don't worry about releasing them - the renderer will free them - just null out references.
IDEInstance.prototype.OnRendererReleased = function()
{
}
