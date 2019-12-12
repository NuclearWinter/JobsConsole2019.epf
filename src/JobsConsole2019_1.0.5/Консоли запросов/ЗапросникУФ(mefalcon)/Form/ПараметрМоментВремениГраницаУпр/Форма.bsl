﻿
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ТекДанные = ВладелецФормы.ПараметрыЗапроса.НайтиПоИдентификатору(ВладелецФормы.Элементы.ПараметрыЗапроса.ТекущаяСтрока);
	Если ЗначениеЗаполнено(ТекДанные.МоментВремениСсылка) Тогда
		МоментВремениГраница = 0;
	Иначе	
		
		МоментВремениГраница = 1;
	КонецЕсли; 
	Ссылка = ТекДанные.МоментВремениСсылка;
	Дата = ТекДанные.МоментВремениДата;
	Если ТекДанные.ГраницаВид = "Исключая" Тогда
		ВидГраницы = 1;
	КонецЕсли;
	ГраницаЗначение = ТекДанные.ГраницаЗначение;
	ОбновитьВидимостьЭлементов();
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьВидимостьЭлементов()
	ЭтоМомент = МоментВремениГраница = 0;
	Элементы.ГраницаЗначение.Видимость = НЕ ЭтоМомент;
	Элементы.ВидГраницы.Видимость = НЕ ЭтоМомент;
	Элементы.Ссылка.Видимость = ЭтоМомент;
	Элементы.Дата.Видимость = ЭтоМомент;
КонецПроцедуры // ОбновитьВидимостьЭлементов()


&НаКлиенте
Процедура Сохранить(Команда)
	ТекДанные = ВладелецФормы.ПараметрыЗапроса.НайтиПоИдентификатору(ВладелецФормы.Элементы.ПараметрыЗапроса.ТекущаяСтрока);	
	ЭтоМомент = МоментВремениГраница = 0;
	Если ЭтоМомент Тогда
		ТекДанные.МоментВремениСсылка = Ссылка;
		ТекДанные.МоментВремениДата = Дата;
		ТекДанные.ГраницаВид = "";
		ТекДанные.ГраницаЗначение = Неопределено;
		ТекДанные.ЗначениеПараметра = "Момент времени: " + СокрЛП(ТекДанные.МоментВремениСсылка) + ", дата " + СокрЛП(ТекДанные.МоментВремениДата);
	Иначе
		ТекДанные.МоментВремениСсылка = Неопределено;
		ТекДанные.МоментВремениДата = '00010101';
		Если ВидГраницы=1 Тогда
			ТекДанные.ГраницаВид = "Исключая"
		Иначе
			ТекДанные.ГраницаВид = "Включая"
		КонецЕсли;
		ТекДанные.ГраницаЗначение = ГраницаЗначение;
		ТекДанные.ЗначениеПараметра = "Граница: " + СокрЛП(ТекДанные.ГраницаЗначение) + ",  " + СокрЛП(ТекДанные.ГраницаВид);
	КонецЕсли;
	
	Закрыть();
КонецПроцедуры


&НаКлиенте
Процедура МоментВремениГраницаПриИзменении(Элемент)
	ОбновитьВидимостьЭлементов();
КонецПроцедуры


&НаКлиенте
Процедура СсылкаПриИзменении(Элемент)
	Если ЗначениеЗаполнено(Ссылка) Тогда
		Дата = ПолучитьДатуНаСервере(Ссылка);
	КонецЕсли; 

КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьДатуНаСервере(Док)
	Возврат Док.Дата;
КонецФункции // ПолучитьДатуНаСервере()

