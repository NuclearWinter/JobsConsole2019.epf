﻿&НаКлиенте
Перем Расписание;

&НаКлиенте
Процедура ОК(Команда)
	Если ЗаписатьРегламентноеЗадание(Расписание) Тогда
		Закрыть(РегламентноеЗаданиеИД);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьРасписаниеНажатие(Элемент)
	Диалог = Новый ДиалогРасписанияРегламентногоЗадания(Расписание);
	
	ОписаниеОповещенияОЗакрытии = Новый ОписаниеОповещения("ДиалогРасписанияРегламентногоЗаданияОткрытьЗавершение", ЭтаФорма);
	
	Диалог.Показать(ОписаниеОповещенияОЗакрытии);
КонецПроцедуры

&НаКлиенте
Процедура ДиалогРасписанияРегламентногоЗаданияОткрытьЗавершение(РасписаниеРезультат, ДополнительныеПараметры) Экспорт
	Если РасписаниеРезультат <> Неопределено Тогда
		Расписание = РасписаниеРезультат;
		Элементы.НадписьРасписание.Заголовок = "Выполнять: " + Строка(Расписание);
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Для Каждого Метаданное из Метаданные.РегламентныеЗадания Цикл
		Элементы.МетаданныеВыбор.СписокВыбора.Добавить(Метаданное.Имя, Метаданное.Представление());
	КонецЦикла;
	
	Попытка
		ПользователиИБ = ПользователиИнформационнойБазы.ПолучитьПользователей();
	Исключение
		Сообщить("Ошибка при получении списка пользователей информационной базы: " + ОписаниеОшибки());
		Пользователи = Неопределено;
	КонецПопытки;
	
	Если ПользователиИБ <> Неопределено Тогда
		
		Для Каждого Пользователь из ПользователиИБ Цикл
			Элементы.ПользователиВыбор.СписокВыбора.Добавить(Пользователь.Имя, Пользователь.ПолноеИмя);
		КонецЦикла;
	
	КонецЕсли;

	мВозможностьИзменятьМетаданные = Истина;
	
	РегламентноеЗаданиеИД = Параметры.ИдентификаторЗадания;
	РегламентноеЗадание = РеквизитФормыВЗначение("ОбработкаОбъект").ПолучитьОбъектРегламентногоЗадания(РегламентноеЗаданиеИД);
	Если РегламентноеЗадание <> Неопределено Тогда
		
		МетаданныеВыбор = РегламентноеЗадание.Метаданные.Имя;
		
		мВозможностьИзменятьМетаданные = Ложь;
		Наименование = РегламентноеЗадание.Наименование;
		Ключ = РегламентноеЗадание.Ключ;
		Использование = РегламентноеЗадание.Использование;
		ПользователиВыбор = РегламентноеЗадание.ИмяПользователя;
		КоличествоПовторовПриАварийномЗавершении = РегламентноеЗадание.КоличествоПовторовПриАварийномЗавершении;
		ИнтервалПовтораПриАварийномЗавершении = РегламентноеЗадание.ИнтервалПовтораПриАварийномЗавершении;
		
		Расписание = РегламентноеЗадание.Расписание;
		
		// Добавлены параметры
		Для Каждого Параметр Из РегламентноеЗадание.Параметры Цикл
			НоваяСтрока = ПараметрыЗадания.Добавить();
			НоваяСтрока.НомерСтроки = ПараметрыЗадания.Индекс(НоваяСтрока)+1;
			НоваяСтрока.Значение = Параметр;
			МассивТипов = Новый Массив;
			МассивТипов.Добавить(ТипЗнч(Параметр));
			НоваяСтрока.Тип = Новый ОписаниеТипов(МассивТипов);
		КонецЦикла;
		
	Иначе
		Расписание = Новый РасписаниеРегламентногоЗадания;
	КонецЕсли;
	
	Элементы.МетаданныеВыбор.Доступность = мВозможностьИзменятьМетаданные;
	Элементы.НадписьРасписание.Заголовок = "Выполнять: " + Строка(Расписание);

КонецПроцедуры

&НаСервере
Функция ЗаписатьРегламентноеЗадание(Расписание)
	Попытка
		
		Если МетаданныеВыбор = Неопределено ИЛИ МетаданныеВыбор = "" Тогда
			ВызватьИсключение("Не выбраны метаданные регламентного задания.");
		КонецЕсли;
		
		РегламентноеЗадание = РеквизитФормыВЗначение("ОбработкаОбъект").ПолучитьОбъектРегламентногоЗадания(РегламентноеЗаданиеИД);
		
		Если РегламентноеЗадание = Неопределено Тогда
			РегламентноеЗадание = РегламентныеЗадания.СоздатьРегламентноеЗадание(МетаданныеВыбор);
			РегламентноеЗаданиеИД = РегламентноеЗадание.УникальныйИдентификатор;
		КонецЕсли;
		
		РегламентноеЗадание.Наименование = Наименование;
		РегламентноеЗадание.Ключ = Ключ;
		РегламентноеЗадание.Использование = Использование;
		РегламентноеЗадание.ИмяПользователя = ПользователиВыбор;
		РегламентноеЗадание.КоличествоПовторовПриАварийномЗавершении = КоличествоПовторовПриАварийномЗавершении;
		РегламентноеЗадание.ИнтервалПовтораПриАварийномЗавершении = ИнтервалПовтораПриАварийномЗавершении;
		РегламентноеЗадание.Расписание = Расписание;
		
		// Добавлены параметры регламентного задания
		Если ПараметрыЗадания.Количество() Тогда
			РегламентноеЗадание.Параметры = ПараметрыЗадания.Выгрузить().ВыгрузитьКолонку("Значение");
		Иначе
			РегламентноеЗадание.Параметры = Новый Массив;
		КонецЕсли;
		
		РегламентноеЗадание.Записать();
	Исключение	
		
		Сообщить("Ошибка: " + ОписаниеОшибки(), СтатусСообщения.Внимание);
		Возврат Ложь;
	КонецПопытки;
	
	Возврат Истина;
КонецФункции

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Расписание = ПолучитьРасписаниеРегламентногоЗадания(РегламентноеЗаданиеИД);
КонецПроцедуры

&НаСервере
Функция ПолучитьРасписаниеРегламентногоЗадания(УникальныйНомерЗадания) Экспорт
	ОбъектЗадания = РеквизитФормыВЗначение("ОбработкаОбъект").ПолучитьОбъектРегламентногоЗадания(УникальныйНомерЗадания);
	Если ОбъектЗадания = Неопределено Тогда
		Возврат Новый РасписаниеРегламентногоЗадания;
	КонецЕсли;
	
	Возврат ОбъектЗадания.Расписание;
КонецФункции