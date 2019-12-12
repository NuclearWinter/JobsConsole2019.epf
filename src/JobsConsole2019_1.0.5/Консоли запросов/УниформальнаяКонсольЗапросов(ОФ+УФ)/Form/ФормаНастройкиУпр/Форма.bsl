﻿
&НаКлиенте
Процедура вУправлениеДиалогом()

	Элементы.ИнтервалАвтосохранения.Доступность = ФрмИспользоватьАвтосохранение;

КонецПроцедуры // УправлениеДиалогом()

&НаСервере
Процедура ОКнаСервере()
	
	Объект.ИспользоватьАвтосохранение = ФрмИспользоватьАвтосохранение;
	Объект.ИнтервалАвтосохранения 				= ФрмИнтервалАвтосохранения;
	Объект.ИспользоватьБэкапЗапросов 			= ФрмИспользоватьБэкапЗапросов;
	Объект.ИспользоватьТолькоВыделеннуюОбласть 	= ФрмИспользоватьтолькоВыделеннуюОбласть;
	Объект.ИспользоватьСжатиеФайлов_УФ 			= ФрмИспользоватьСжатиеФайлов_УФ;
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	ОбработкаОбъект.моСохранитьНастройки();
	
КонецПроцедуры

//======================================= Обработка событий ==========================================

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Параметры.Тест = 2;
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	ОбработкаОбъект.моВосстановитьНастройки();
	ЗначениеВРеквизитФормы(ОбработкаОбъект,"Объект");
	ФрмИспользоватьАвтосохранение          	= Объект.ИспользоватьАвтосохранение;
	ФрмИнтервалАвтосохранения              	= Объект.ИнтервалАвтосохранения;
	ФрмИспользоватьБэкапЗапросов           	= Объект.ИспользоватьБэкапЗапросов;
    ФрмИспользоватьтолькоВыделеннуюОбласть 	= Объект.ИспользоватьТолькоВыделеннуюОбласть;
	ФрмИспользоватьСжатиеФайлов_УФ 			= Объект.ИспользоватьСжатиеФайлов_УФ;

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	вУправлениеДиалогом();
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьАвтосохранениеПриИзменении(Элемент)
	
	Если Не ФрмИспользоватьАвтосохранение Тогда
		ФрмИнтервалАвтосохранения = 0;
	КонецЕсли;
	вУправлениеДиалогом();

КонецПроцедуры

&НаКлиенте
Процедура ОК(Команда)
	
	ОКнаСервере();
	Закрыть(Истина);

КонецПроцедуры
