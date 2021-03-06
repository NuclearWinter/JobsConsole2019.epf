﻿Перем мТипДанных;
Перем мПримитивныеТипы;
Перем мСпециальныеТипы;

Процедура ТаблицаДанныхПередНачаломИзменения(Элемент, Отказ)
	Отказ = истина;
КонецПроцедуры

Процедура ПередОткрытием(Отказ, СтандартнаяОбработка)
	
	ТипЗначенияДанных = ТипЗнч(Данные);
	Если ТипЗначенияДанных = Тип("Массив") Тогда
		Отказ = не ПоказатьМассив();
	ИначеЕсли ТипЗначенияДанных = Тип("Структура") Тогда
		Отказ = не ПоказатьСтруктуру();
	ИначеЕсли ТипЗначенияДанных = Тип("Соответствие") Тогда
		Отказ = не ПоказатьСоответствие();
	ИначеЕсли ТипЗначенияДанных = Тип("СписокЗначений") Тогда
		Отказ = не ПоказатьСписокЗначений();
	ИначеЕсли ТипЗначенияДанных = Тип("ДеревоЗначений") Тогда
		Отказ = не ПоказатьДеревоЗначений();
	ИначеЕсли ТипЗначенияДанных = Тип("ТаблицаЗначений") Тогда
		Отказ = не ПоказатьТаблицуЗначений();
	Иначе
		ОткрытьЗначение(Данные);
		Отказ = истина;
	КонецЕсли;
	
КонецПроцедуры

Функция ПоказатьМассив()
	Если Данные.Количество() = 0 Тогда
		Возврат ложь;
	КонецЕсли;
	
	мТипДанных = "Массив";
	Заголовок = мТипДанных + ": " + ДанныеИмя;
	
	ТаблицаДанных.Колонки.Добавить("Индекс");
	ТаблицаДанных.Колонки.Добавить("Значение");
	ТаблицаДанных.Колонки.Добавить("ТипЗначения");
	
	Для Инд = 0 по Данные.ВГраница() Цикл
		Элем = Данные[Инд];
		НоваяСтрока = ТаблицаДанных.Добавить();
		НоваяСтрока.Индекс = Инд;
		НоваяСтрока.Значение = Элем;
		НоваяСтрока.ТипЗначения = Строка(ТипЗнч(Элем));
	КонецЦикла;
	
	ЭлементыФормы.ТаблицаДанных.СоздатьКолонки();
	
	Возврат истина;
КонецФункции

Функция ПоказатьСтруктуру()
	Если Данные.Количество() = 0 Тогда
		Возврат ложь;
	КонецЕсли;
	
	мТипДанных = "Структура";
	Заголовок = мТипДанных + ": " + ДанныеИмя;
	
	ТаблицаДанных.Колонки.Добавить("Ключ");
	ТаблицаДанных.Колонки.Добавить("Значение");
	ТаблицаДанных.Колонки.Добавить("ТипЗначения");
	
	Для каждого Элем из Данные Цикл
		НоваяСтрока = ТаблицаДанных.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Элем);
		НоваяСтрока.ТипЗначения = Строка(ТипЗнч(Элем.Значение));
	КонецЦикла;
	
	ЭлементыФормы.ТаблицаДанных.СоздатьКолонки();
	
	Возврат истина;
КонецФункции

Функция ПоказатьСоответствие()
	Если Данные.Количество() = 0 Тогда
		Возврат ложь;
	КонецЕсли;
	
	мТипДанных = "Соответствие";
	Заголовок = мТипДанных + ": " + ДанныеИмя;
	
	ТаблицаДанных.Колонки.Добавить("Ключ");
	ТаблицаДанных.Колонки.Добавить("Значение");
	ТаблицаДанных.Колонки.Добавить("ТипЗначения");
	
	Для каждого Элем из Данные Цикл
		НоваяСтрока = ТаблицаДанных.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Элем);
		НоваяСтрока.ТипЗначения = Строка(ТипЗнч(Элем.Значение));
	КонецЦикла;
	
	ЭлементыФормы.ТаблицаДанных.СоздатьКолонки();
	
	Возврат истина;
КонецФункции

Функция ПоказатьСписокЗначений()
	Если Данные.Количество() = 0 Тогда
		Возврат ложь;
	КонецЕсли;
	
	мТипДанных = "СписокЗначений";
	Заголовок = мТипДанных + ": " + ДанныеИмя;
	
	ТаблицаДанных.Колонки.Добавить("Значение");
	ТаблицаДанных.Колонки.Добавить("Пометка", новый ОписаниеТипов("Булево"));
	ТаблицаДанных.Колонки.Добавить("Представление");
	ТаблицаДанных.Колонки.Добавить("ТипЗначения");
	
	Для каждого Элем из Данные Цикл
		НоваяСтрока = ТаблицаДанных.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Элем);
		НоваяСтрока.ТипЗначения = Строка(ТипЗнч(Элем.Значение));
	КонецЦикла;
	
	ЭлементыФормы.ТаблицаДанных.СоздатьКолонки();
	
	Возврат истина;
КонецФункции

Функция ПоказатьДеревоЗначений()
	
	мТипДанных = "ДеревоЗначений";
	Заголовок = мТипДанных + ": " + ДанныеИмя;
	
	ДеревоЗначений = Данные;
	ЭлементыФормы.ТаблицаДанных.Данные = "ДеревоЗначений";
	ЭлементыФормы.ТаблицаДанных.СоздатьКолонки();
	
	Возврат истина;
КонецФункции

Функция ПоказатьТаблицуЗначений()
	
	мТипДанных = "ТаблицаЗначений";
	Заголовок = мТипДанных + ": " + ДанныеИмя;
	
	ТаблицаДанных = Данные;
	ЭлементыФормы.ТаблицаДанных.СоздатьКолонки();
	
	Возврат истина;
КонецФункции

Процедура ТаблицаДанныхВыбор(Элемент, ВыбраннаяСтрока, Колонка, СтандартнаяОбработка)
	
	Если мТипДанных = "Массив" Тогда
		Значение = ВыбраннаяСтрока["Значение"];
	ИначеЕсли мТипДанных = "Структура" Тогда
		Значение = ВыбраннаяСтрока["Значение"];
	ИначеЕсли мТипДанных = "СписокЗначений" Тогда
		Значение = ВыбраннаяСтрока["Значение"];
	Иначе
		Значение = ВыбраннаяСтрока[Колонка.Имя];
	КонецЕсли;
	
	Если ТипЗнч(Значение) = Тип("ХранилищеЗначения") Тогда
		Значение = Значение.Получить();
	КонецЕсли;
	
	Если Значение <> Неопределено Тогда
		ТипЗначения = ТипЗнч(Значение);
		
		Если мСпециальныеТипы.Найти(ТипЗначения) <> Неопределено Тогда
			Форма = ПолучитьФорму("ФормаОтображенияДанных", ЭтаФорма, Элемент);
			Форма.Данные = Значение;
			Если мТипДанных = "Массив" Тогда
				Форма.ДанныеИмя = "Элемент массива";
			ИначеЕсли мТипДанных = "Структура" Тогда
				Форма.ДанныеИмя = ВыбраннаяСтрока.Ключ;
			ИначеЕсли мТипДанных = "Соответствие" Тогда
				Форма.ДанныеИмя = "Элемент соответствия";
			ИначеЕсли мТипДанных = "СписокЗначений" Тогда
				Форма.ДанныеИмя = ВыбраннаяСтрока.Представление;
			ИначеЕсли мТипДанных = "ТаблицаЗначений" Тогда
				Форма.ДанныеИмя = Колонка.Имя;
			Иначе
				Возврат;
			КонецЕсли;
			Форма.Открыть();
		ИначеЕсли мПримитивныеТипы.Найти(ТипЗначения) = Неопределено Тогда
			ОткрытьЗначение(Значение);
		КонецЕсли;
		
	КонецЕсли;
КонецПроцедуры

мПримитивныеТипы = новый Массив;
мПримитивныеТипы.Добавить(Тип("Дата"));
мПримитивныеТипы.Добавить(Тип("Число"));
мПримитивныеТипы.Добавить(Тип("Булево"));
мПримитивныеТипы.Добавить(Тип("Строка"));

мСпециальныеТипы = новый Массив;
мСпециальныеТипы.Добавить(Тип("Массив"));
мСпециальныеТипы.Добавить(Тип("Структура"));
мСпециальныеТипы.Добавить(Тип("Соответствие"));
мСпециальныеТипы.Добавить(Тип("СписокЗначений"));
мСпециальныеТипы.Добавить(Тип("ДеревоЗначений"));
мСпециальныеТипы.Добавить(Тип("ТаблицаЗначений"));
