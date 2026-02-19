-- Поиск аномалий и группировка
-- tv и other всего 3 и 2 продажи соответсвтенно.
-- mobile	232679
-- desktop	58170
-- tablet	1180
SELECT 
	device_type_canonical,
	count(*) AS total
FROM afisha.purchases p
GROUP BY p.device_type_canonical 
ORDER BY total DESC

-- На какие типы мероприятий чаще всего ходят
-- концерты	115634
-- театр	67744
-- другое	66109
-- спорт	22006
-- стендап	13424
-- выставки	4873
-- ёлки	2006
-- фильм	238
SELECT 
	e.event_type_main,
	count(order_id) AS total
FROM afisha.purchases p
JOIN afisha.events e USING(event_id)
GROUP BY e.event_type_main 
ORDER BY total DESC

-- Какой валютой чаще всего платят
-- rub	286961
-- kzt	5073
SELECT 
	p.currency_code,
	count(order_id) AS total
FROM afisha.purchases p
GROUP BY p.currency_code
ORDER BY total DESC

-- Самые популярные фильмы по возрастным ограничениям
-- 16	78864
-- 12	62861
-- 0	61731
-- 6	52403
-- 18	36175
SELECT 
	age_limit,
	count(*) AS total
FROM afisha.purchases p
GROUP BY p.age_limit 
ORDER BY total DESC