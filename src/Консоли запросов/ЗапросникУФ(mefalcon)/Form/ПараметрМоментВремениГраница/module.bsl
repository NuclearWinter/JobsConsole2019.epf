﻿
Процедура КнопкаСохранитьНажатие(Элемент)
	
	СтруктураВозврата = Новый Структура("МоментВремениДата,МоментВремениСсылка,ГраницаВид,ГраницаЗначение,Режим");
	
	ЗаполнитьЗначенияСвойств(СтруктураВозврата,ЭтаФорма);
	
	Закрыть(СтруктураВозврата);
	
КонецПроцедуры

Процедура МоментВремениСсылкаПриИзменении(Элемент)
	
	Если ЗначениеЗаполнено(МоментВремениСсылка) Тогда
		МоментВремениДата = МоментВремениСсылка.Дата;
	КонецЕсли; 
	
КонецПроцедуры

Процедура УправлениеДиалогом()

	Если Режим = "МоментВремени" Тогда
		
		ЭлементыФормы.ПанельСтраниц.ТекущаяСтраница = ЭлементыФормы.ПанельСтраниц.Страницы.МоментВремени;
		
		Заголовок = "Момент времени";
		
	Иначе	
		
		ЭлементыФормы.ПанельСтраниц.ТекущаяСтраница = ЭлементыФормы.ПанельСтраниц.Страницы.Граница;
		
		Заголовок = "Граница";
		
	КонецЕсли; 

КонецПроцедуры //УправлениеДиалогом

Процедура ПриОткрытии()
	
	Если Режим = "Граница" Тогда
		
		Если ПустаяСтрока(ГраницаВид) Тогда
			
			ГраницаВид = "Включая";
			
		КонецЕсли; 
		
	КонецЕсли; 
	
	УправлениеДиалогом();
	
КонецПроцедуры

Процедура РежимПриИзменении(Элемент)
	
	//очистка ненужных параметров
	
	Если Режим = "МоментВремени" Тогда
		
		ГраницаВидСравнения = "";
		ГраницаЗначение = Неопределено;
		
	Иначе	
		
		МоментВремениДата = Дата(1,1,1);
		МоментВремениСсылка = Неопределено;
		
	КонецЕсли; 
	
	УправлениеДиалогом();
	
КонецПроцедуры
