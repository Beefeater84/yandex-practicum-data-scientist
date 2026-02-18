-- Знакомство с таблицами
-- Пропусков нет
-- Объем данных 292034
SELECT 
	count(*) AS total,
	count(order_id) AS order_count,
	count(user_id) AS user_count,
	count(event_id) AS event_count
FROM "afisha".purchases p;


-- Общий осмотр типов данных
-- Типы данных соответствуют информации
-- age_limit - если нет ограничения, то стоит 0
-- cinema_circuit - если не в кинотеатре стоит нет
SELECT 
	*
FROM "afisha".purchases p 
LIMIT 10;

-- Проверка категориальных
-- В cinema_circuit помимо нет - есть еще "Другое"
SELECT 
	DISTINCT(p.currency_code)
FROM "afisha".purchases p;

SELECT 
	DISTINCT(p.device_type_canonical)
FROM "afisha".purchases p;

SELECT 
	DISTINCT(p.cinema_circuit)
FROM "afisha".purchases p;

------------------------------- EVENTS -----------------------------------------

-- Уникальных event_id 22484
SELECT 
	count(event_id) AS event_total
FROM "afisha".events p;

-- Проверка типов
SELECT 
	*
FROM "afisha".events p
LIMIT 10;

-- Категориальные данных
-- event_type_description - выглядит как повторы: спортивное мероприятие и спорт, ёлка и снегурочка, но поскольку само мероприятие для нас неизвестно, то установить это невозможно.
-- p.event_type_main - видимо это после специально создано, чтобы сгруппировать мероптиятия в более общий список 
SELECT 
	DISTINCT(p.event_type_description )
FROM "afisha".events p;

SELECT 
	DISTINCT(p.event_type_main )
FROM "afisha".events p;


SELECT 
	*
FROM "afisha".events p
WHERE p.event_type_description IN('спортивное мероприятие', 'спорт')
LIMIT 30;

-- Dates ---------------
-- С какого по какое число представлены данные
-- Данные с 2024-06-01 по 2024-10-31
SELECT 
	MIN(created_dt_msk) AS date_min,
	MAX(p.created_dt_msk) AS date_max
FROM afisha.purchases p 

-- Оценка влияния сезонности


