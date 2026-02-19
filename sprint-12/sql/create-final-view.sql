/*
Задача 1. Расчёт времени с момента предыдущего заказа

Основные данные содержатся в таблицах purchases и events. Таблица с покупками поможет получить данные о пользователях сервиса, а таблица с событиями — зафиксировать тип мероприятия и регион его проведения.
При выгрузке используйте только заказы, совершённые с мобильных и десктопных устройств. С других типов устройств заказов было совершено слишком мало, поэтому можно их не учитывать.
Исключите из данных заказы билетов на фильмы, так как по ним недостаточно данных.

В итоговой таблице должно присутствовать дополнительное поле — days_since_prev. Оно показывает, сколько дней, прошло между предыдущей и текущей покупками пользователя. Если у пользователя только одна покупка, в этом поле должно быть значение NULL.
Рассчитайте значения поля days_since_prev, используя таблицу purchases. Добавьте их к остальным полям в таблице. Рассчитанные значения должны быть целочисленными.

Добавьте дополнительное условие фильтрации: исключите заказы на фильмы — для этого используйте поле event_type_main.

Отсортируйте итоговую таблицу по user_id в порядке возрастания и оставьте только первые 10 строк. При расчётах используйте только дату заказа — поле created_dt_msk.
Отфильтруйте из таблицы данные о заказах, сделанных с редких типов устройств. В неё должна войти только информация о покупках с мобильных или десктопных устройств.

*/
-- Напишите ваш запрос ниже

SELECT
	user_id,
	device_type_canonical,
	order_id,
	created_dt_msk as order_dt,
	created_ts_msk as order_ts,
	currency_code,
	revenue,
	tickets_count,
	-- Count number of days since last order. 
	-- The result must be a numeric
	EXTRACT(DAY FROM created_dt_msk - LAG(created_dt_msk) OVER (PARTITION BY user_id ORDER BY created_dt_msk)) AS days_since_prev,
	event_id,
	event_name_code AS event_name,
	event_type_main,
	service_name,
	region_name,
	city_name
FROM afisha.purchases p
JOIN afisha.events e USING(event_id)
JOIN afisha.city c USING(city_id)
JOIN afisha.regions r USING(region_id)
WHERE (device_type_canonical IN ('mobile', 'desktop')) AND (event_type_main != 'фильм')
ORDER BY user_id 
LIMIT 10;

