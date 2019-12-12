﻿&НаКлиенте
Перем мУдаляемаяКолонка;
&НаКлиенте
Перем мИмяДоИзменения;
&НаКлиенте
Перем мСохранять;

&НаСервере
Процедура ВывестиТЗнаФормуПрограммно(тзВывода,ИмяТабПоля,ИмяЭФТабПоля)
		
	эфТабПоле = Элементы[ИмяЭФТабПоля];
	добРеквизиты = Новый Массив;
	Для каждого колонка Из тзВывода.Колонки Цикл
		требуемыйТип = колонка.ТипЗначения;
		Если требуемыйТип.СодержитТип(Тип("Тип")) ИЛИ требуемыйТип.СодержитТип(Тип("МоментВремени")) Тогда
			требуемыйТип = Новый ОписаниеТипов();	
		КонецЕсли;
		новКолонка = Новый РеквизитФормы(колонка.Имя,требуемыйТип,ИмяТабПоля);	
		добРеквизиты.Добавить(новКолонка);
	КонецЦикла;
	удалРеквизиты = Новый Массив;
	Для каждого реквизитТабПоля Из ПолучитьРеквизиты(ИмяТабПоля) Цикл
		удалРеквизиты.Добавить(реквизитТабПоля.Путь+"."+реквизитТабПоля.Имя);	
	КонецЦикла;
	ИзменитьРеквизиты(добРеквизиты,удалРеквизиты);
	ЗначениеВРеквизитФормы(тзВывода,ИмяТабПоля);	
	
	индУдаления = эфТабПоле.ПодчиненныеЭлементы.Количество()-1;
	Пока индУдаления>=0 Цикл
		Элементы.Удалить(эфТабПоле.ПодчиненныеЭлементы[индУдаления]);
		индУдаления = индУдаления-1;
	КонецЦикла;
	Для Каждого Колонка Из тзВывода.Колонки Цикл
		Если Найти(Колонка.Имя,"__СлужебныйРасшифровка__")<>0 Тогда
			Продолжить;
		КонецЕсли;
	  	НовыйЭлемент = Элементы.Добавить(ИмяТабПоля+"_" + Колонка.Имя, Тип("ПолеФормы"), эфТабПоле);
	  	НовыйЭлемент.Вид = ВидПоляФормы.ПолеВвода;
	  	НовыйЭлемент.ПутьКДанным = ИмяТабПоля+"." + Колонка.Имя;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция ОбработатьТЗПередВыводом(пТаблица)
	
	Для каждого колонка ИЗ пТаблица.Колонки Цикл
		Если колонка.ТипЗначения.СодержитТип(Тип("ТаблицаЗначений")) ИЛИ колонка.ТипЗначения.СодержитТип(Тип("ХранилищеЗначения")) Тогда
			индКолонки = пТаблица.Колонки.Индекс(колонка);
			имяКолонки = колонка.Имя;
			имяКолонкиРасшифровки = имяКолонки+"__СлужебныйРасшифровка__";
			пТаблица.Колонки.Добавить(имяКолонкиРасшифровки,Новый ОписаниеТипов("Строка"));
			массивПредставлений = Новый Массив;
			Для каждого строкаТЗ Из пТаблица Цикл
				тзРезультат = строкаТЗ[имяКолонки];
				Если ТипЗнч(тзРезультат) = Тип("ТаблицаЗначений") Тогда
					//адрес = ПоместитьВоВременноеХранилище(тзРезультат,Новый УникальныйИдентификатор());
					адрес = ПоместитьВоВременноеХранилище(тзРезультат,УникальныйИдентификатор);
					строкаТЗ[имяКолонкиРасшифровки] = адрес;
					массивПредставлений.Добавить("ТаблицаЗначений("+тзРезультат.Количество()+")");
				ИначеЕсли ТипЗнч(тзРезультат) = Тип("ХранилищеЗначения") Тогда
					значениеХЗ = тзРезультат.Получить();
					//адрес = ПоместитьВоВременноеХранилище(значениеХЗ,Новый УникальныйИдентификатор());
					адрес = ПоместитьВоВременноеХранилище(значениеХЗ,УникальныйИдентификатор);
					строкаТЗ[имяКолонкиРасшифровки] = адрес;
					массивПредставлений.Добавить("ХранилищеЗначения("+ТипЗнч(значениеХЗ)+")");
				Иначе
					массивПредставлений.Добавить("");
					строкаТЗ[имяКолонкиРасшифровки] = строкаТЗ[имяКолонки];
				КонецЕсли;
			КонецЦикла;
			пТаблица.Колонки.Удалить(колонка);
			пТаблица.Колонки.Вставить(индКолонки,имяКолонки,Новый ОписаниеТипов("Строка"),имяКолонки);
			пТаблица.ЗагрузитьКолонку(массивПредставлений, имяКолонки);
		КонецЕсли;
	КонецЦикла;
		
КонецФункции

&НаСервере
Функция ПолучитьЗначениеХЗ(адрес)
	Если Не ЗначениеЗаполнено(адрес) Тогда
		Возврат адрес;
	КонецЕсли;	
	хз = ПолучитьИзВременногоХранилища(адрес);
	Если ТипЗнч(хз) = Тип("ТаблицаЗначений") Тогда
		Возврат "ТаблицаЗначений";  
	ИначеЕсли ТипЗнч(хз)<>Тип("ХранилищеЗначения") Тогда
		Возврат хз;	
	КонецЕсли;
	содержимое = хз.Получить();
	Если ТипЗнч(содержимое) = Тип("ТаблицаЗначений") Тогда
		ПоместитьВоВременноеХранилище(содержимое,адрес);
		содержимое = "ТаблицаЗначений";
	КонецЕсли;
	Возврат содержимое;
КонецФункции

&НаКлиенте
Процедура ВложеннаяТаблицаВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если НЕ РежимРедактирования Тогда
		//СтандартнаяОбработка = Ложь;
		//ТекущаяСтрока = ВложеннаяТаблица.НайтиПоИдентификатору(ВыбраннаяСтрока);
		//имяРеквизита = Сред(Поле.Имя,СтрДлина(Элемент.Имя)+2);
		//СодержимоеЯчейки = ТекущаяСтрока[имяРеквизита];
		//ПоказатьЗначение(,СодержимоеЯчейки);
		СтандартнаяОбработка = Ложь;
		ТекущаяСтрока = ВложеннаяТаблица.НайтиПоИдентификатору(ВыбраннаяСтрока);
		имяРеквизита = Сред(Поле.Имя,СтрДлина(Элемент.Имя)+2);
		СодержимоеЯчейки = ТекущаяСтрока[имяРеквизита];
		адрес = "";
		Попытка
			адрес = ТекущаяСтрока[имяРеквизита+"__СлужебныйРасшифровка__"];
		Исключение
		КонецПопытки;
		Попытка
			имяТаблицы = ТекущаяСтрока.НаименованиеТаблицы;
		Исключение
			номерСтроки = ВложеннаяТаблица.Индекс(ТекущаяСтрока);
			имяТаблицы = имяРеквизита + ", строка " + Формат(номерСтроки+1,"ЧГ=0");
		КонецПопытки;
		
		Если ЗначениеЗаполнено(адрес) Тогда
			СодержимоеЯчейки = ПолучитьЗначениеХЗ(адрес);
		КонецЕсли;
		
		Если СодержимоеЯчейки = "ТаблицаЗначений" И ЗначениеЗаполнено(адрес) Тогда 
			ФормаВложеннойТаблицы = ПолучитьФорму("ВнешняяОбработка.УниформальнаяКонсольЗапросов.Форма.ФормаВложеннойТаблицыУпр",Неопределено, ЭтаФорма, Истина);
			ФормаВложеннойТаблицы.Заголовок = Заголовок+": "+имяТаблицы;
			ФормаВложеннойТаблицы.АдресТаблицы = адрес;
			ФормаВложеннойТаблицы.Открыть();                 
		Иначе
			ПоказатьЗначение(,СодержимоеЯчейки);
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ПриОткрытииНаСервере()
	тзДанные = ПолучитьИзВременногоХранилища(АдресТаблицы);
	ОбработатьТЗПередВыводом(тзДанные);
	ВывестиТЗнаФормуПрограммно(тзДанные,"ВложеннаяТаблица","ВложеннаяТаблица");
	Если РежимРедактирования Тогда
		Для каждого колонка Из тзДанные.Колонки Цикл
			новСтрока = КолонкиТаблицы.Добавить();
			новСтрока.Имя = колонка.Имя;
			новСтрока.ТипЗначения = колонка.ТипЗначения;
		КонецЦикла;		
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	ПриОткрытииНаСервере();

	Элементы.КолонкиТаблицы.Видимость = РежимРедактирования;
	Элементы.ВложеннаяТаблица.ТолькоПросмотр = НЕ РежимРедактирования;
	мСохранять = РежимРедактирования;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	Если мСохранять Тогда
		ПриЗакрытииНаСервере();
		соотвТаблицПараметров = ПолучитьИзВременногоХранилища(ВладелецФормы.уфПредставленияТаблицПараметров);	
		представление = "ТаблицаЗначений("+ВложеннаяТаблица.Количество()+")";	
		соотвТаблицПараметров.Вставить(АдресТаблицы,представление);
		ПоместитьВоВременноеХранилище(соотвТаблицПараметров,ВладелецФормы.уфПредставленияТаблицПараметров);
		Оповестить("ОбновлениеТаблицыВПараметрах",Новый Структура("Представление,Значение",представление,АдресТаблицы));
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПриЗакрытииНаСервере()
	Если РежимРедактирования Тогда
		тзДанные = РеквизитФормыВЗначение("ВложеннаяТаблица");
		ПоместитьВоВременноеХранилище(тзДанные,АдресТаблицы);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура КолонкиТаблицыПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	Если ОтменаРедактирования Тогда
		Возврат;
	КонецЕсли;
	текСтрока = Элементы.КолонкиТаблицы.ТекущиеДанные;
	действие = ?(НоваяСтрока,"Добавить","Изменить");
	ИзменитьКолонкуНаСервере(мИмяДоИзменения,текСтрока.Имя,текСтрока.ТипЗначения,действие);
	
КонецПроцедуры

&НаСервере
Процедура ИзменитьКолонкуНаСервере(пИмяКолонки,пНовоеИмяКолонки = "",пТипЗначения = Неопределено,Действие = "Изменить")
	тзДанные = РеквизитФормыВЗначение("ВложеннаяТаблица");
	Если Действие = "Добавить" Тогда
		тзДанные.Колонки.Добавить(пНовоеИмяКолонки,пТипЗначения);			
	ИначеЕсли Действие = "Изменить" Тогда
		колонкаТЗ = тзДанные.Колонки.Найти(пИмяКолонки);
		Если пИмяКолонки<>пНовоеИмяКолонки Тогда
			колонкаТЗ.Имя = пНовоеИмяКолонки;
			колонкаТЗ.Заголовок = пНовоеИмяКолонки;			
		КонецЕсли;
		Если колонкаТЗ.ТипЗначения<>пТипЗначения Тогда
			служКолонка = тзДанные.Колонки.Добавить("__СлужебнаяКолонкаДляИзмененияТипаЗначения",пТипЗначения);
			тзДанные.ЗагрузитьКолонку(тзДанные.ВыгрузитьКолонку(колонкаТЗ),служКолонка);
			тзДанные.Колонки.Удалить(колонкаТЗ);
			служКолонка.Имя = пНовоеИмяКолонки;
		КонецЕсли;
	ИначеЕсли Действие = "Удалить" Тогда
		тзДанные.Колонки.Удалить(пИмяКолонки);
	КонецЕсли;
	ВывестиТЗнаФормуПрограммно(тзДанные,"ВложеннаяТаблица","ВложеннаяТаблица");
КонецПроцедуры

&НаКлиенте
Процедура КолонкиТаблицыПослеУдаления(Элемент)
	ИзменитьКолонкуНаСервере(мУдаляемаяКолонка,,,"Удалить");
КонецПроцедуры

&НаКлиенте
Процедура КолонкиТаблицыПередУдалением(Элемент, Отказ)
	текСтрока = Элементы.КолонкиТаблицы.ТекущиеДанные;
	мУдаляемаяКолонка = текСтрока.Имя;
КонецПроцедуры

&НаКлиенте
Процедура КолонкиТаблицыПередНачаломИзменения(Элемент, Отказ)
	текСтрока = Элементы.КолонкиТаблицы.ТекущиеДанные;
	мИмяДоИзменения = текСтрока.Имя;
КонецПроцедуры

&НаКлиенте
Процедура КолонкиТаблицыПередОкончаниемРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования, Отказ)
	текСтрока = Элементы.КолонкиТаблицы.ТекущиеДанные;
	Если НЕ ОтменаРедактирования И ПустаяСтрока(текСтрока.Имя) Тогда
		Отказ = Истина;	
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	Если ИмяСобытия = "УдалениеТаблицЗначенийВПараметрах" Тогда
		Если Параметр.Найти(АдресТаблицы)<>Неопределено Тогда
			мСохранять = Ложь;
			Закрыть();	
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры
