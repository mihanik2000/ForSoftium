function GetPluginSettings()
{
	return {
		"name":			"Мультиплеер",			// as appears in 'insert object' dialog, can be changed as long as "id" stays the same
		"id":			"Multiplayer",			// this is used to identify this plugin and is saved to the project; never change it
		"version":		"1.0",					// (float in x.y format) Plugin version - C2 shows compatibility warnings based on this
		"description":	"Создание в реальном времени многопользовательской онлайн-игры с использованием каналов WebRTC данных.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/174/multiplayer",
		"category":		"Сеть",				// Prefer to re-use existing categories, but you can set anything here
		"type":			"object",				// either "world" (appears in layout and is drawn), else "object"
		"rotatable":	false,					// only used when "type" is "world".  Enables an angle property on the object.
		"dependency":	"c2mp-net.js;c2mp-peer.js;c2mp.js;waker.js",
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
						
AddCondition(0, cf_trigger | cf_deprecated, "Список серверов получен", "Сигнальный", "Список серверов получен", "Срабатывает после 'списка серверов запроса' успешно завершается.", "OnServerList");

AddCondition(1, cf_trigger, "В случае ошибки", "Сигнальный", "В случае ошибки", "Срабатывает, если произошла ошибка со списком серверов или сигнализации сервера.", "OnSignallingError");

AddCondition(2, cf_trigger, "Подключено", "Сигнальный", "Подключено", "Срабатывает при успешном подключении к сигнальному серверу.", "OnSignallingConnected");

AddCondition(3, cf_trigger, "Отключено", "Сигнальный", "Отключено", "Срабатывает при отключении от сигнальному серверу.", "OnSignallingDisconnected");

AddCondition(4, cf_trigger, "Войдя в систему", "Сигнальный", "Войдя в систему", "Срабатывает при успешной регистрации на сигнальном сервере.", "OnSignallingLoggedIn");

AddCondition(5, cf_trigger, "Подключено к комнате", "Сигнальный", "Подключено к комнате", "Срабатывает после успешного присоединения к комнате.", "OnSignallingJoinedRoom");

AddCondition(6, cf_trigger, "Выход из комнаты", "Сигнальный", "Выход из комнаты", "Срабатывает после успешного выхода из комнаты.", "OnSignallingLeftRoom");

AddCondition(7, cf_none, "Подключен", "Сигнальный", "Подключен к сигнальному серверу", "Правда, если в данный момент подключен к серверу сигнализации.", "SignallingIsConnected");

AddCondition(8, cf_none, "Вошел в систему", "Сигнальный", "Вошел в систему сигнальный сервер", "Правда, если в настоящее время вошли в систему на сигнальный сервер.", "SignallingIsLoggedIn");

AddCondition(9, cf_none, "Есть в комнате", "Сигнальный", "Есть в комнате", "Правда, если в настоящее время в комнате на сигнальный сервер.", "SignallingIsInRoom");

AddCondition(10, cf_none, "Является ли хост", "Комната", "Является ли хост", "Правда, если хозяин текущей комнате.", "IsHost");

AddCondition(11, cf_trigger, "Пеер подключен", "Комната", "Пеер подключен", "Срабатывает при подключении к пиру (либо хоста или пир присоединения к хост).", "OnPeerConnected");

AddCondition(12, cf_none, "Поддержка мультиплеера", "Сигнальный", "Поддержка мультиплеера", "Правда, если текущий браузер поддерживает многопользовательские игры.", "IsSupported");

AddCondition(13, cf_trigger, "Пеер отсоединен", "Комната", "Пеер отсоединен", "Срабатывает при отключении от пира (либо от хоста или пира, покидающего хоста).", "OnPeerDisconnected");

AddCondition(14, cf_trigger, "Если выгнали", "Комната", "Если выгнали", "Срабатывает, когда выгнали из комнаты.", "OnSignallingKicked");

AddStringParam("Тег", "Тег для идентификации типа сообщения.");
AddCondition(15, cf_trigger, "Пеер сообщение", "Комната", "Пеер сообщение <i>{0}</i>", "Срабатывает при получении сообщения с определенным тегом от пира.", "OnPeerMessage");

AddCondition(16, cf_trigger, "Любое сообщение пира", "Комната", "Любое сообщение пира", "Срабатывает при получении любого сообщения от пира.", "OnAnyPeerMessage");

AddCondition(17, cf_trigger, "Oбновление клиента", "Комната: Пеер", "Oбновление клиента", "Срабатывает при отправке нового состояния клиента на хост.", "OnClientUpdate");

AddCondition(18, cf_trigger, "Список глобальной игры", "Сигнальный", "Список глобальной игры", "Срабатывает после того, как 'Запрос игры списке экземпляров', когда список был получен от сервера.", "OnGameInstanceList");

AddCondition(19, cf_none, "Готов для ввода", "Комната: Пеер", "Готов для ввода", "Правда, когда готов к отправке вход на хост. Не перемещайте местного игрока, пока это не верно.", "IsReadyForInput");

AddCmpParam("Сравнение", "Как сравнить количество пирров");
AddNumberParam("Количество", "Количество пееров, для сравнения.");
AddCondition(20, cf_none, "Сравнить количество пеера", "Комната", "Количество Пеер {0} {1}", "Сравните количество пирров в настоящее время в комнате.", "ComparePeerCount");

AddCondition(21, cf_trigger, "Список комнаты", "Сигнальный", "Список комнаты получил", "Срабатывает после того, как 'Запрос списка комнаты', когда список был получен от сервера.", "OnRoomList");

////////////////////////////////////////
// Actions

// AddAction(id,				// any positive integer to uniquely identify this action
//			 flags,				// (see docs) af_none, af_deprecated
//			 list_name,			// appears in event wizard list
//			 category,			// category in event wizard list
//			 display_str,		// as appears in event sheet - use {0}, {1} for parameters and also <b></b>, <i></i>
//			 description,		// appears in event wizard dialog when selected
//			 script_name);		// corresponding runtime function name

AddStringParam("URL-адрес списка", "URL-адрес извлекаемого списка серверов.", "\"http://www.scirra.com/multiplayer/serverlist.json\"");
AddAction(0, af_none | af_deprecated, "Список запросов сервера", "Сигнальный", "Список запросов сервера из <b>{0}</b>", "Запросить список сигнальных серверов, которые могут быть соединены.", "RequestServerList");

AddStringParam("Сервер", "URL-адрес сигнального сервера, к которому требуется подключиться.", "\"wss://multiplayer.scirra.com\"");
AddAction(1, af_none, "Подключить", "Сигнальный", "Подключение к сигнальному серверу <b>{0}</b>", "Подключитесь к сигнальному серверу, чтобы он смог присоединиться к комнатам.", "SignallingConnect");

AddAction(2, af_none, "Отключить", "Сигнальный", "Отключение от сигнального сервера", "Отключитесь от текущего сигнального сервера.", "SignallingDisconnect");

AddStringParam("ICE сервер", "Пользовательский ICE-сервер, например. STUN или TURN, чтобы установить соединение.", "\"stun:\"");
AddStringParam("Имя пользователя (необязательно)", "Если сервер включен, то имя пользователя будет использоваться с этим сервером.");
AddStringParam("Учетные данные (необязательно)", "Если сервер TURN, то учетные данные для использования с этим сервером.");
AddAction(3, af_none, "Добавить сервер ICE", "Сигнальный", "Добавить сервер ICE <b>{0}</b> (имя пользователя <i>{1}</i>, учетные данные <i>{2}</i>", "Добавьте еще один ICE-сервер, чтобы установить соединение. Несколько значений по умолчанию встроены.", "AddICEServer");

AddStringParam("Псевдоним", "Требуемый псевдоним для использования на сервере. Сервер может назначить другой псевдоним, если он сделан.");
AddAction(4, af_none, "Войти", "Сигнальный", "Вход с псевдонимом <b>{0}</b>", "После подключения Войдите на сигнальный сервер с помощью псевдонима.", "SignallingLogin");

AddStringParam("Игра", "Строка, однозначно идентифицирующая эту игру на сервере. Чтобы обеспечить уникальность, включите имя пользователя или вашей компании, e.g. \"MyStudio-Asteroids\" instead of just \"Asteroids\".", "\"MyCompany-MyGame\"");
AddStringParam("Экземпляр", "Строка, идентифицирующая экземпляр игры, на случай, если вы хотите запустить отдельные экземпляры.", "\"по умолчанию\"");
AddStringParam("Комната", "Имя комнаты для запроса на соединение.");
AddNumberParam("Макс Пееров", "Максимальное число пееров, которые могут присоединиться к этой комнате. Используется только значение хоста. Оставьте значение 0 для неограниченного.");
AddAction(5, af_none, "Войти в комнату", "Сигнальный", "Войти в комнату <b>{2}</b> для игры <i>{0}</i> экземпляр <i>{1}</i> (макс пееров: <i>{3}</i>)", "Войдя в систему, присоединитесь к комнате для встречи с другими пеерами.", "SignallingJoinRoom");

AddAction(6, af_none, "Покинуть комнату", "Сигнальный", "Покинуть комнату", "Запрос на выход из текущего помещения на сигнальном сервере. Пееры не затрагиваются.", "SignallingLeaveRoom");

AddAction(7, af_none, "Отключить", "Комната", "Отключиться от комнаты", "Отключитесь от одноранговых узлов в текущей комнате, а также оставьте помещение на сигнальном сервере.", "DisconnectRoom");

AddStringParam("ID Пеера", "ID пеера, которому отправляется сообщение. Оставьте пустым для отправки в хост.");
AddStringParam("Тег", "Тег для идентификации этого типа сообщения.");
AddStringParam("Сообщение", "Отправляемые данные сообщения.");
AddComboParamOption("Надежный заказ");
AddComboParamOption("Надежный неупорядоченный");
AddComboParamOption("Ненадежный");
AddComboParam("Режим", "Режим передачи для отправки этого сообщения.");
AddAction(8, af_none, "Отправить сообщение", "Комната", "Отправить на пеер <i>{0}</i> тег <i>{1}</i> сообщение <b>{2}</b> (режим <i>{3}</i>)", "Отправка сообщения определенному пееру.", "SendPeerMessage");

AddStringParam("Из ID", "При ретрансляции однорангового сообщения создается сообщение с идентификатором пеера. Оставьте поле пустым, чтобы указать из хоста.");
AddStringParam("Тег", "Тег для идентификации этого типа сообщения.");
AddStringParam("Сообщение", "Отправляемые данные сообщения.");
AddComboParamOption("Надежный заказ");
AddComboParamOption("Надежный неупорядоченный");
AddComboParamOption("Ненадежный");
AddComboParam("Режим", "Режим передачи для отправки этого сообщения.");
AddAction(9, af_none, "Широковещательная рассылка", "Комната: Хост", "Тег вещания <i>{1}</i> сообщение <b>{2}</b> (из <i>{0}</i>, режим <i>{3}</i>)", "Отправьте сообщение от хоста всем коллегам в комнате.", "HostBroadcastMessage");

AddNumberParam("Задержка", "Введите задержку в секундах для имитации. Отправленные и полученные сообщения будут искусственно отложены.", "0.1");
AddNumberParam("PDV", "Введите отклонение задержки пакета в секундах для имитации. Отправленные и полученные сообщения будут искусственно отложены.", "0.03");
AddNumberParam("Потеря пакетов", "Введите процент потери пакета для имитации от 0 до 1 (например, 0,05 для 5%). Отправленные и полученные сообщения будут искусственно пропущены или отложены.", "0.05");
AddAction(10, af_none, "Имитация задержки", "Комната", "Имитация задержки <i>{0}</i> секунды с отклонением <i>{1}</i> и потеря пакетов <i>{2}</i>", "Моделирование задержки и потери пакетов при отправке и получении сообщений. Полезно для тестирования производительности при задержке локало.", "SimulateLatency");

AddObjectParam("Объект", "Тип объекта для синхронизации по сети.");
AddComboParamOption("Нечего");
AddComboParamOption("Только положение");
AddComboParamOption("Только угол");
AddComboParamOption("Положение и угол");
AddComboParam("Данные", "Выберите, следует ли синхронизировать положение и/или угол объекта.");
AddComboParamOption("Высокое (двойное, 8 байт)");
AddComboParamOption("Обычный (плавающий, 4 байта)");
AddComboParamOption("Низкий (Int16, 2 байта)");
AddComboParam("Точность", "Выберите точность вышеуказанных данных для синхронизации. Для повышения точности требуется больше пропускной способности.", 1);
AddComboParamOption("Обычная пропускная способность (непредсказуемая)");
AddComboParamOption("Низкая пропускная способность (с высокой степенью предсказуемости)");
AddComboParamOption("Очень низкая пропускная способность (по существу, статическая)");
AddComboParam("Пропускная способность", "Выберите параметр пропускной способности для данного объекта. Выбирайте только 'низкий'для высокопредсказуемого движения (например, линейная постоянная скорость).");
AddAction(11, af_none, "Синхронизировать объект", "Комната", "Синхронизировать {0} (с <b>{1}</b>, точность <i>{2}</i> на <i>{3}</i>)", "Автоматическая синхронизация типа объекта по сети.", "SyncObject");

AddObjectParam("Объект", "Тип объекта, который уже синхронизирован. Выбранная переменная экземпляра также будет синхронизирована.");
AddObjectInstanceVarParam("Переменная экземпляра", "Выберите переменную экземпляра в вышеуказанном объекте для синхронизации.");
AddComboParamOption("Высокое (двойное, 8 байт)");
AddComboParamOption("Обычный (плавающий, 4 байта)");
AddComboParamOption("Низкий (int16, 2 байта)");
AddComboParamOption("Очень низкая (uint8, 1 байт)");
AddComboParam("Точность", "Выбор точности значения для синхронизации.", 1);
AddComboParamOption("Нечего");
AddComboParamOption("Линейный");
AddComboParamOption("Угловатый");
AddComboParam("Интерполяция", "Выберите интерполяцию для использования клиентами между полученными значениями.");
AddStringParam("Тег значения клиента", "Если это значение соответствует входному значению клиента, тег для значения. Это позволяет узлу синхронизировать значение между одноранговыми узлами с меньшим задержкой.");
AddAction(12, af_none, "Синх переменной экземпляра", "Комната", "Синх {0} переменной <b>{1}</b> (точности <i>{2}</i>, интерполяция: <i>{3}</i>, тег значения клиента: <i>{4}</i>)", "Добавьте переменную экземпляра синхронизированного объекта, чтобы также синхронизироваться по сети.", "SyncObjectInstanceVar");

AddObjectParam("Объект", "Объект, связываемый с одноранговым элементом. Для каждого подключенного однорангового узла должен быть ровно один объект.");
AddStringParam("ID Пеера", "ID пеера, с которым связывается выбранный объект.");
AddAction(13, af_none, "Связать объект с пеерам", "Комната", "Связать {0} с пеером <i>{1}</i>", "Указывает объект, представляющий подключенный узел.", "AssociateObjectWithPeer");

AddStringParam("Тег", "Тег, идентифицирующий входное значение клиента для установки. Он должен быть добавлен ранее.");
AddNumberParam("Значение", "Число, представляющее состояние входа клиента.");
AddAction(14, af_none, "Установить состояние клиента", "Комната: Пеер", "Установить состояния ввода клиента <i>{0}</i> с значением <b>{1}</b>", "Установите состояние входа клиента для пеера, чтобы указать узлу их элементы управления.", "SetClientState");

AddStringParam("Тег", "Тег для идентификации входного значения клиента.");
AddComboParamOption("Высокое (двойное, 8 байт)");
AddComboParamOption("Обычный (плавающий, 4 байта)");
AddComboParamOption("Низкий (Int16, 2 байта)");
AddComboParamOption("Очень низкая (uint8, 1 байт)");
AddComboParam("Точность", "Выберите точность входного значения клиента.", 1);
AddComboParamOption("Нечего");
AddComboParamOption("Линейный");
AddComboParamOption("Угловатый");
AddComboParam("Интерполяция", "Выберите интерполяцию для хоста, который будет использоваться между значениями.");
AddAction(15, af_none, "Добав входное знач клиента", "Комната", "Добавить тег входного значения клиента <b>{0}</b>, точность <i>{1}</i>, интерполяция <i>{2}</i>", "Добавьте значение для отправки на хост, представляющий состояние входа клиента.", "AddClientInputValue");

AddObjectParam("Объект", "Объект, представляющий локальный проигрыватель для включения прогнозирования локального ввода.");
AddAction(16, af_none, "Включить прогн. лок. ввода", "Комната: Пеер", "Включить прогнозирование локального ввода для {0}", "Включите прогнозирование локального ввода для объекта, представляющего локальный проигрыватель.", "InputPredictObject");

AddStringParam("Игра", "Игра на сервере для вывода списка экземпляров.");
AddAction(17, af_none, "Запрос списка экземп игр", "Сигнальный", "Запрос игры <b>{0}</b> списка экземпляров", "Запросить список экземпляров игр, находящихся в настоящее время на сервере.", "SignallingRequestGameInstanceList");

AddComboParamOption("Интернет (30 Гц обновлений, 80МС буфер)");
AddComboParamOption("LAN (60 Гц обновления, 40мс буфер)");
AddComboParam("Профиль", "Используемый профиль полосы пропускания. Не используйте сетевой режим через Интернет. Однако режим Интернета по-прежнему подходит для локальных сетей.");
AddAction(18, af_none, "Настр проф пропуск способности", "Комната", "Установить профиль пропускной способности <b>{0}</b>", "Перед присоединением к комнате установите в Интернете или LAN режим, чтобы адаптировать использование сети.", "SetBandwidthProfile");

AddStringParam("Игра", "Строка, однозначно идентифицирующая эту игру на сервере. Чтобы обеспечить уникальность, включите имя пользователя или вашей компании, e.g. \"MyStudio-Asteroids\" instead of just \"Asteroids\".", "\"MyCompany-MyGame\"");
AddStringParam("Экземпляр", "Строка, идентифицирующая экземпляр игры, на случай, если вы хотите запустить отдельные экземпляры.", "\"по умолчанию\"");
AddStringParam("Первая комната", "Имя первой комнаты для запроса на соединение. Если комната заполнена, последующие комнаты будут проверены (\"комната\", \"комната2\", \"комната3\"...).");
AddNumberParam("Макс Пееров", "Число пееров в комнате. После заполнения, более поздние пееры будут отправлены в следующую комнату.", "2");
AddComboParamOption("блокировать при заполнении");
AddComboParamOption("не блокировать");
AddComboParam("Блокировка", "Блокировка комнаты предотвращает повторное соединение других пееров даже после того, как другие пееры отменяются.");
AddAction(19, af_none, "Комната авто соединения", "Сигнальный", "Авто присоединение в комнату <b>{2}</b> для игры <i>{0}</i> экземпляр <i>{1}</i> (макс пееров: <i>{3}</i>, {4})", "Присоединяйтесь к первой комнате, которая не заполнена.", "SignallingAutoJoinRoom");

AddStringParam("Игра", "Игра на сервере для вывода списка комнат.");
AddStringParam("Экземпляр", "Экземпляр игры на сервере для вывода списка комнат.");
AddComboParamOption("все");
AddComboParamOption("разблокировано");
AddComboParamOption("доступный");
AddComboParam("Фильтр", "При необходимости отфильтруйте возвращенные комнаты их состоянием.");
AddAction(20, af_none, "Запрос списка комнат", "Сигнальный", "Запрос игры <b>{0}</b> экземпляр <b>{1}</b> список комнат (<i>{2}</i>)", "Запросите список комнат в экземпляре игры, который в настоящее время находится на сервере.", "SignallingRequestRoomList");

AddStringParam("Пеер ID", "ID пира для принудительного удаления. Работает только в случае хоста.");
AddStringParam("Причина", "Строка причины, по которой следует дать толчок (необязательно).");
AddAction(21, af_none, "Кик пеер", "Комната: Хост", "Кик пеера <i>{0}</i> (причина: <i>{1}</i>)", "Принудительное удаление пеера из комнаты при размещении.", "KickPeer");

////////////////////////////////////////
// Expressions

// AddExpression(id,			// any positive integer to uniquely identify this expression
//				 flags,			// (see docs) ef_none, ef_deprecated, ef_return_number, ef_return_string,
//								// ef_return_any, ef_variadic_parameters (one return flag must be specified)
//				 list_name,		// currently ignored, but set as if appeared in event wizard
//				 category,		// category in expressions panel
//				 exp_name,		// the expression name after the dot, e.g. "foo" for "myobject.foo" - also the runtime function name
//				 description);	// description in expressions panel

AddExpression(0, ef_return_number | ef_deprecated, "", "Signalling", "ServerListCount", "The number of servers in a received server list.");

AddNumberParam("Index", "Index of server in list");
AddExpression(1, ef_return_string | ef_deprecated, "", "Signalling", "ServerListURLAt", "The URL of the Nth received signalling server.");

AddNumberParam("Index", "Index of server in list");
AddExpression(2, ef_return_string | ef_deprecated, "", "Signalling", "ServerListNameAt", "The name of the Nth received signalling server.");

AddNumberParam("Index", "Index of server in list");
AddExpression(3, ef_return_string | ef_deprecated, "", "Signalling", "ServerListOperatorAt", "The operator of the Nth received signalling server.");

AddNumberParam("Index", "Index of server in list");
AddExpression(4, ef_return_string | ef_deprecated, "", "Signalling", "ServerListWebsiteAt", "The operator's website for the Nth received signalling server.");

AddExpression(5, ef_return_string, "", "Signalling", "SignallingURL", "The URL of the current signalling server.");
AddExpression(6, ef_return_string, "", "Signalling", "SignallingVersion", "The version of the current signalling server.");
AddExpression(7, ef_return_string, "", "Signalling", "SignallingName", "The name of the current signalling server.");
AddExpression(8, ef_return_string, "", "Signalling", "SignallingOperator", "The operator of the current signalling server.");
AddExpression(9, ef_return_string, "", "Signalling", "SignallingMOTD", "The 'message of the day' for the current signalling server.");

AddExpression(10, ef_return_string, "", "Signalling", "MyAlias", "The alias for the current user.");
AddExpression(11, ef_return_string, "", "Signalling", "CurrentGame", "The current game name joined.");
AddExpression(12, ef_return_string, "", "Signalling", "CurrentInstance", "The current game instance joined.");
AddExpression(13, ef_return_string, "", "Signalling", "CurrentRoom", "The current room joined.");

AddExpression(14, ef_return_string, "", "Signalling", "ErrorMessage", "In 'on signalling error', the error message.");

AddExpression(15, ef_return_string, "", "Signalling", "MyID", "The ID for the current user.");
AddExpression(16, ef_return_string, "", "Room", "PeerID", "The ID of relevant peer in a trigger.");
AddExpression(17, ef_return_string, "", "Room", "PeerAlias", "The alias of relevant peer in a trigger.");
AddExpression(18, ef_return_string, "", "Room", "HostID", "The ID of the room host.");
AddExpression(19, ef_return_string, "", "Room", "HostAlias", "The alias of the room host.");

AddExpression(20, ef_return_string, "", "Room", "Message", "The message received in a message trigger.");
AddExpression(21, ef_return_string, "", "Room", "Tag", "The tag of the message received in a message trigger.");
AddExpression(22, ef_return_string, "", "Room", "FromID", "The ID of the user the message is from in a message trigger.");
AddExpression(23, ef_return_string, "", "Room", "FromAlias", "The alias of the user the message is from in a message trigger.");

AddStringParam("id", "Peer ID");
AddExpression(24, ef_return_string, "", "Room", "PeerAliasFromID", "Get a peer's alias for a given peer ID.");

AddStringParam("id", "Peer ID");
AddExpression(25, ef_return_number, "", "Room", "PeerLatency", "Get the latency (ping time) for a peer.");

AddStringParam("id", "Peer ID");
AddExpression(26, ef_return_number, "", "Room", "PeerPDV", "Get the packet delay variation for a peer.");

AddExpression(27, ef_return_number, "", "Statistics", "StatOutboundCount", "Number of outbound messages per second.");
AddExpression(28, ef_return_number, "", "Statistics", "StatOutboundBandwidth", "Uploaded payload bytes per second.");
AddExpression(29, ef_return_number, "", "Statistics", "StatInboundCount", "Number of inbound messages per second.");
AddExpression(30, ef_return_number, "", "Statistics", "StatInboundBandwidth", "Downloaded payload bytes per second.");

AddStringParam("id", "Peer ID");
AddStringParam("tag", "Client value tag");
AddExpression(31, ef_return_number, "", "Room: Host", "PeerState", "When host, get the client input state of a peer.");

AddExpression(33, ef_return_number, "", "Statistics", "ClientXError", "Client-side input prediction X error from host, for debugging.");
AddExpression(34, ef_return_number, "", "Statistics", "ClientYError", "Client-side input prediction Y error from host, for debugging.");

AddExpression(35, ef_return_number, "", "Statistics", "HostX", "Host X position for debugging input prediction.");
AddExpression(36, ef_return_number, "", "Statistics", "HostY", "Host Y position for debugging input prediction.");

AddExpression(37, ef_return_number, "", "Room", "PeerCount", "The number of connected peers in the current room.");

AddExpression(38, ef_return_number, "", "Listings", "ListInstanceCount", "The number of game instances available.");

AddNumberParam("Index", "Index");
AddExpression(39, ef_return_string, "", "Listings", "ListInstanceName", "The name of a game instance at an index.");

AddNumberParam("Index", "Index");
AddExpression(40, ef_return_number, "", "Listings", "ListInstancePeerCount", "The total number of peers in a game instance at an index.");

AddExpression(41, ef_return_string, "", "Room", "LeaveReason", "In 'On peer disconnected', the leave reason if known.");

AddStringParam("movingPeerID", "Peer ID to move");
AddStringParam("fromPeerID", "Peer ID to compensate for");
AddExpression(42, ef_return_number, "", "Room: Host", "LagCompensateX", "The X position of a moving peer as it appears to another peer.");

AddStringParam("movingPeerID", "Peer ID to move");
AddStringParam("fromPeerID", "Peer ID to compensate for");
AddExpression(43, ef_return_number, "", "Room: Host", "LagCompensateY", "The Y position of a moving peer as it appears to another peer.");

AddStringParam("movingPeerID", "Peer ID to move");
AddStringParam("fromPeerID", "Peer ID to compensate for");
AddExpression(44, ef_return_number, "", "Room: Host", "LagCompensateAngle", "The angle of a moving peer as it appears to another peer.");

AddNumberParam("Index", "Peer index");
AddExpression(45, ef_return_string, "", "Room", "PeerIDAt", "The ID of the nth connected peer in the room.");

AddNumberParam("Index", "Peer index");
AddExpression(46, ef_return_string, "", "Room", "PeerAliasAt", "The alias of the nth connected peer in the room.");

AddExpression(47, ef_return_number, "", "Listings", "ListRoomCount", "The number of rooms returned.");

AddNumberParam("Index", "Index");
AddExpression(48, ef_return_string, "", "Listings", "ListRoomName", "The name of a game instance at an index.");

AddNumberParam("Index", "Index");
AddExpression(49, ef_return_number, "", "Listings", "ListRoomPeerCount", "The total number of peers in a room at an index.");

AddNumberParam("Index", "Index");
AddExpression(50, ef_return_number, "", "Listings", "ListRoomMaxPeerCount", "The maximum number of peers for a room at an index.");

AddNumberParam("Index", "Index");
AddExpression(51, ef_return_string, "", "Listings", "ListRoomState", "The room state at an index (\"available\", \"locked\" or \"full\").");

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
	//new cr.Property(ept_integer, 	"My property",		77,		"An example property.")
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