﻿//TODO
//1. Совместимость с типовой консолью запросов
//2. Выполнение кода для ТЗ и других полей с расшифровкой в результате запросов
//3. Загрузка ТЗ в параметрах из Excel
//4. Копипаст в формах не примитивных типов


Процедура моВосстановитьНастройки() Экспорт
	ПрефиксНастроек = Метаданные().Имя+"_";
	ИспользоватьАвтосохранение 				= ХранилищеНастроекДанныхФорм.Загрузить(ПрефиксНастроек,"ИспользоватьАвтосохранение");
	ИнтервалАвтосохранения     				= ХранилищеНастроекДанныхФорм.Загрузить(ПрефиксНастроек,"ИнтервалАвтосохранения");
	ИспользоватьБэкапЗапросов  				= ХранилищеНастроекДанныхФорм.Загрузить(ПрефиксНастроек,"ИспользоватьБэкапЗапросов");
	ИспользоватьТолькоВыделеннуюОбласть  	= ХранилищеНастроекДанныхФорм.Загрузить(ПрефиксНастроек,"ИспользоватьТолькоВыделеннуюОбласть");
	ИспользоватьСжатиеФайлов_УФ  			= ХранилищеНастроекДанныхФорм.Загрузить(ПрефиксНастроек,"ИспользоватьСжатиеФайлов_УФ");
	РежимПодсветки_УФ  						= ХранилищеНастроекДанныхФорм.Загрузить(ПрефиксНастроек,"РежимПодсветки_УФ");
КонецПроцедуры

Процедура моСохранитьНастройки() Экспорт
	ХранилищеНастроекДанныхФорм.Сохранить(ПрефиксНастроек,"ИспользоватьАвтосохранение",ИспользоватьАвтосохранение);
	ХранилищеНастроекДанныхФорм.Сохранить(ПрефиксНастроек,"ИнтервалАвтосохранения",ИнтервалАвтосохранения);
	ХранилищеНастроекДанныхФорм.Сохранить(ПрефиксНастроек,"ИспользоватьБэкапЗапросов",ИспользоватьБэкапЗапросов);
	ХранилищеНастроекДанныхФорм.Сохранить(ПрефиксНастроек,"ИспользоватьТолькоВыделеннуюОбласть",ИспользоватьТолькоВыделеннуюОбласть);
	ХранилищеНастроекДанныхФорм.Сохранить(ПрефиксНастроек,"ИспользоватьСжатиеФайлов_УФ",ИспользоватьСжатиеФайлов_УФ);
	ХранилищеНастроекДанныхФорм.Сохранить(ПрефиксНастроек,"РежимПодсветки_УФ",РежимПодсветки_УФ);
КонецПроцедуры

Процедура моВосстановитьИмяФайла() Экспорт
	ИмяФайла    = ХранилищеНастроекДанныхФорм.Загрузить(ПрефиксНастроек,"ИмяФайла");
	ИмяПути     = ХранилищеНастроекДанныхФорм.Загрузить(ПрефиксНастроек,"ИмяПути");
КонецПроцедуры

Процедура моСохранитьИмяФайла() Экспорт
	ХранилищеНастроекДанныхФорм.Сохранить(ПрефиксНастроек,"ИмяФайла",ИмяФайла);
	ХранилищеНастроекДанныхФорм.Сохранить(ПрефиксНастроек,"ИмяПути",ИмяПути);
КонецПроцедуры
