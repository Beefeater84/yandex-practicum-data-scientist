-- Знакомство с таблицами
-- Пропусков нет
-- Объем данных 292034
-- user_count 22000
-- event_count 22484
SELECT 
	count(*) AS total,
	count(order_id) AS order_count,
	count(DISTINCT(user_id)) AS user_count,
	count(DISTINCT(event_id)) AS event_count
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
-- Уникальных имен 15287
SELECT 
	count(event_id) AS event_total,
	count(DISTINCT event_name_code) AS event_name_code_dist
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

-- У каждого оргазиатора разнкое количество заказов
-- от 122 до 1
SELECT 
	count(event_id) OVER (PARTITION BY organizers) AS events_count
FROM "afisha".events p
ORDER BY events_count 
LIMIT 1;

-- Dates ---------------
-- С какого по какое число представлены данные
-- Данные с 2024-06-01 по 2024-10-31
SELECT 
	MIN(created_dt_msk) AS date_min,
	MAX(p.created_dt_msk) AS date_max
FROM afisha.purchases p 

-- Оценка влияния сезонности
-- 2024-06-01 00:00:00.000	34840
-- 2024-07-01 00:00:00.000	41112
-- 2024-08-01 00:00:00.000	45217
-- 2024-09-01 00:00:00.000	70265
-- 2024-10-01 00:00:00.000	100600
SELECT 
	DATE_TRUNC('month', created_dt_msk) AS month_start,
    COUNT(*) AS total
FROM afisha.purchases p 
GROUP BY month_start;

-- Оценка пропусков - их нет
SELECT
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(order_id)               AS order_id_nulls,
    COUNT(*) - COUNT(total)                  AS total_nulls,
    COUNT(*) - COUNT(tickets_count)          AS tickets_count_nulls,
    COUNT(*) - COUNT(service_name)           AS service_name_nulls,
    COUNT(*) - COUNT(revenue)                AS revenue_nulls,
    COUNT(*) - COUNT(device_type_canonical)  AS device_type_nulls,
    COUNT(*) - COUNT(currency_code)          AS currency_code_nulls,
    COUNT(*) - COUNT(age_limit)              AS age_limit_nulls,
    COUNT(*) - COUNT(cinema_circuit)         AS cinema_circuit_nulls,
    COUNT(*) - COUNT(event_id)               AS event_id_nulls,
    COUNT(*) - COUNT(created_ts_msk)         AS created_ts_msk_nulls,
    COUNT(*) - COUNT(created_dt_msk)         AS created_dt_msk_nulls,
    COUNT(*) - COUNT(user_id)                AS user_id_nulls
FROM afisha.purchases p ;


-- EXPLORE REVENUE ----
-- Максимальная сумма ревеню 86000
-- Есть отрицательные значения
SELECT 
	min(p.revenue) AS revenue_min,
	ROUND(max(p.revenue)::numeric, 2) AS revenue_max,
	ROUND(avg(p.revenue)::numeric, 2) AS revenue_avg
FROM afisha.purchases p 

-- Важно помнить - что суммы не нормализованны и они в разных валютах
-- kzt	4995.31
-- rub	547.57
SELECT 
	currency_code,
	ROUND(avg(p.revenue)::numeric, 2) AS revenue_avg
FROM afisha.purchases p 
GROUP BY currency_code;

---- LOOK UP City / regions
-- 353 города
SELECT 
	count(city_id) AS city_total
FROM "afisha".city c;

SELECT 
	count(r.region_id ) AS region_total
FROM "afisha".regions r ;
