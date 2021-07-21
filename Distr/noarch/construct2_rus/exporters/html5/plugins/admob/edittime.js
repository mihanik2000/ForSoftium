/* Copyright (c) 2014 Intel Corporation. All rights reserved.
* Use of this source code is governed by a MIT-style license that can be
* found in the LICENSE file.
*/

function GetPluginSettings()
{
	return {
		"name":			"Admob Ads",
		"id":			"admob",
		"version":		"1.0",
		"description":	"AdMob объявления для Intel® XDK.",
		"author":		"Scirra",
		"help url":		"http://www.scirra.com/manual/184/admob",
		"category":		"Монетизация",
		"type":			"object",			// appears in layout
		"rotatable":	false,
		"flags":		pf_singleglobal
	};
};

AddCondition(0, 0, "Показать рекламный баннер", "Объявления", "Показать рекламный баннер", "Правда, если в данный момент отображается рекламный баннер.", "IsShowingBanner");

AddCondition(1, 0, "Показывает интерстициальную", "Объявления", "Показывает интерстициальную", "Правда, если в данный момент отображается полноэкранное объявление.", "IsShowingInterstitial");

//AddCondition(1, cf_trigger, "On banner presented", "Объявления", "On banner presented", "Triggered when a banner ad displayed on the screen.", "OnBannerPresented");

AddCondition(2, cf_trigger, "Интерстициальный получен", "Объявления", "Интерстициальный получен", "Срабатывает, когда предварительно загруженным интерстициальный получен и готов к показу.", "OnInterstitialReceived");

AddCondition(3, cf_trigger, "Интерстициальный представлены", "Объявления", "OИнтерстициальный представлены", "Срабатывает, когда интерстициальный отображается на экране.", "OnInterstitialPresented");

AddCondition(4, cf_trigger, "Интерстициальный удален с поля", "Объявления", "Интерстициальный удален с поля", "Срабатывает, когда интерстициальный покидает поле.", "OnInterstitialDismissed");

AddCondition(5, cf_trigger, "Рекламный баннер получен", "Объявления", "Рекламный баннер получен", "Срабатывает, когда предварительно загруженным рекламный баннер получен и готов к показу.", "OnBannerAdReceived");

// Actions
AddComboParamOption("Верхний левый");
AddComboParamOption("Верхняя центральная");
AddComboParamOption("Верхний правый");
AddComboParamOption("Левый");
AddComboParamOption("Центр");
AddComboParamOption("Право");
AddComboParamOption("Нижняя левая");
AddComboParamOption("Нижняя центральная");
AddComboParamOption("Внизу справа");
AddComboParam("Позиция", "Где отображать объявления.", 1);
AddComboParamOption("Смарт-баннер (авто-размер, рекомендуется)");
AddComboParamOption("Баннер");
AddComboParamOption("Средний прямоугольник");
AddComboParamOption("Полный баннер");
AddComboParamOption("Лидер доска");
AddComboParamOption("Небоскреб");
AddComboParam("Размер", "Размер объявлений для отображения.");
AddAction(0, 0, "Показать объявление баннера", "Объявления", "Показать объявление баннера в положении <i>{0}</i> размер <i>{1}</i>", "Показать рекламный баннер на экране в то время как игра запущена.", "ShowBanner");

AddAction(1, af_deprecated, "Авто-шоу интерстициальной", "Объявления", "Авто-шоу интерстициальной", "Загрузите полноэкранное объявление, скрывающую запущенной игре и показать его, когда будете готовы.", "AutoShowInterstitial");

AddAction(2, 0, "Скрыть рекламный баннер", "Объявления", "Скрыть рекламный баннер", "Скрыть любой показ рекламного баннера в настоящее время.", "HideBanner");

AddAction(3, 0, "Предварительная загрузка интерстициальной", "Объявления", "Предварительная загрузка интерстициальной", "Предварительно загрузить полноэкранное объявление в фоновом режиме, и триггер 'Интерстициальный получен', когда будете готовы.", "PreloadInterstitial");

AddAction(4, 0, "Показать интерстициальную", "Объявления", "Показать интерстициальную", "Покажите предварительно загруженным полноэкранное объявление, как только он будет готов.", "ShowInterstitial");

AddAction(5, af_deprecated, "Обновить интерстициальную", "Объявления", "Обновить интерстициальную", "Перезагрузка в настоящее время показывая полноэкранное объявление.", "ReloadInterstitial");

AddAction(6, 0, "Перезагрузить рекламный баннер", "Объявления", "Перезагрузить рекламный баннер", "Перезагрузка в настоящее время показывая рекламный баннер.", "ReloadBanner");

AddAction(7, 0, "Предварительная загрузка рекламного баннера", "Объявления", "Предварительная загрузка рекламного баннера", "Предварительно загрузить рекламный баннер в фоновом режиме, и триггер 'Рекламный баннер получен', когда будете готовы.", "PreloadBanner");

ACESDone();

// Property grid properties for this plugin
var property_list = [
	new cr.Property(ept_combo,	"Overlap",					"Yes",		"Независимо от того, чтобы перекрывать знамя над областью просмотра или сворачивать окно просмотра, чтобы освободить место для баннера.", "No|Yes"),
	new cr.Property(ept_combo,	"Test mode",				"True",		"Показать тестовые объявления.", "False|True"),
	
	new cr.Property(ept_section, "Android", "",	"Ad unit IDs for Android."),
	new cr.Property(ept_text,	"Banner ID (Android)",		"",			"Идентификатор рекламного блока от admob.com для рекламного баннера."),
	new cr.Property(ept_text,	"Interstitial ID (Android)", "",		"Идентификатор рекламного блока от admob.com для полноэкранной рекламы."),
	
	new cr.Property(ept_section, "iOS", "",	"Рекламный блок ИД для IOS."),
	new cr.Property(ept_text,	"Banner ID (iOS)",			"",			"Идентификатор рекламного блока от admob.com для рекламного баннера."),
	new cr.Property(ept_text,	"Interstitial ID (iOS)",	"",			"Идентификатор рекламного блока от admob.com для полноэкранной рекламы."),
	
	new cr.Property(ept_section, "Windows Phone", "",	"Идентификаторы рекламных блоков для Windows Phone."),
	new cr.Property(ept_text,	"Banner ID (WP8)",			"",			"Идентификатор рекламного блока от admob.com для рекламного баннера."),
	new cr.Property(ept_text,	"Interstitial ID (WP8)",	"",			"Идентификатор рекламного блока от admob.com для полноэкранной рекламы.")
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
	this.just_inserted = false;
};

IDEInstance.prototype.OnCreate = function()
{
};

IDEInstance.prototype.OnInserted = function()
{
};

IDEInstance.prototype.OnDoubleClicked = function()
{
};

// Called by the IDE after a property has been changed
IDEInstance.prototype.OnPropertyChanged = function(property_name)
{
};

IDEInstance.prototype.OnRendererInit = function(renderer)
{
};

// Called to draw self in the editor
IDEInstance.prototype.Draw = function(renderer)
{
};

IDEInstance.prototype.OnRendererReleased = function(renderer)
{
};