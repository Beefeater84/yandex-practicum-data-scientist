2026-03-06 22:15
tags: #SQL 

**Оконными** (англ. window functions) называют функции, которые выполняют вычисления по набору строк, которые определённым образом связаны. В отличие от обычных агрегирующих функций, которые группируют строки и возвращают один результат для каждой группы, оконные функции сохраняют строки и добавляют вычисленное значение к каждой строке в результате.

```SQL

SELECT столбец1,
       столбец2,
       <агрегирующая_функция>(column_name) OVER () AS новое_значение
FROM table;


```
## Виды оконных функций
- Агрегирующие функции
- Функции ранжирования
- Функции смещения
- Аналитические функции

### Агрегирующие функции
По сути простые математические операции. Вычисление среднего рейтинга по годам, вычисление куммулятивной суммы и тому подобное.

Тут можно использовать все наши стандартные агрегирующие функции: `SUM()`, `AVG()`, `COUNT()`, `MAX()` и `MIN()`,


```SQL
-- Если внутри OVER ничего не указано - то окном будет вся таблица
SELECT user_id,
       event_dt,
       revenue,
       SUM(revenue) OVER () AS total_revenue
       MIN(SUM(revenue)) OVER () AS min_total_revenue
FROM online_store.orders;


-- PARTITION BY как GROUP BY добавляет по каким полям мы считаем эфукнкции
<агрегирующая_функция> OVER (PARTITION BY <столбец1>[, <столбец2>, ...])


SELECT i.item_id,
       i.category,
       i.price,
       -- PARTITION BY позволяет вычислить среднюю стоимость товаров каждой категории
       ROUND(AVG(i.price) OVER (PARTITION BY i.category), 1) AS avg_category_price,
       -- PARTITION BY позволяет посчитать количество товаров каждой категории
       COUNT(i.item_id) OVER (PARTITION BY i.category) AS category_order_count
FROM tools_shop.items AS i
JOIN tools_shop.order_x_item AS o ON i.item_id = o.item_id
JOIN tools_shop.orders AS ord ON o.order_id = ord.order_id;

```


### ORDER BY в оконных функция

ORDER BY внутри оконной функции не сортирует, а определяет порядок выполнения.
Например если поставить ORDER BY  по дате и считать сумму - то в таблице будет Сумма до текущей даты.

Если внутри OVER указать PARTITION BY, то ORDER BY выполнит функцию только внутри сортировки

```SQL

<агрегирующая_функция> OVER (ORDER BY <столбец1> [ASC|DESC] [, <столбец2> ...])


-- Почему-то мне сложно это принять - поэтому запишу.
-- Мы можем считать сумму выручки - по дате, по региону, по пользователю
SUM(revenue) OVER (ORDER BY event_dt ASC) AS cumulative_revenue

```

*Особенность* Оконные функции нельзя фильтровать в WHERE, потому что они считаются уже после того как таблица была построена.

```SQL

-- Лайвхак как отфильтровать сессии, длинна которых больше средней
-- Мы составляем подзапрос и потом получаем данные из этого подзапроса и фильтруем полученные данные

SELECT user_id,
       session_duration,
       avg_session_duration
FROM
  (SELECT user_id,
          session_duration,
          AVG(session_duration) OVER () AS avg_session_duration
   FROM online_store.sessions) AS subquery
WHERE session_duration > avg_session_duration;


-- PARTITION BY c датой
-- Выручка за день
SUM(revenue) OVER (PARTITION BY DATE_TRUNC('day', event_dt))

-- PARTITION BY со многими столбцами
-- Сумма портаченная покупателем в каждой категории
SUM(i.price) OVER (PARTITION BY o.user_id, i.category) AS total_spent_per_user_category

-- Математические функции
SELECT category,
         item_name,
         price,
         AVG(price) OVER (PARTITION BY category) AS avg_category_price,
         -- Разница средней цены по категории с текущей ценой
         price - AVG(price) OVER (PARTITION BY category) AS price_difference
FROM tools_shop.items
ORDER BY category, item_name;   

```

```SQL
-- PARTION BY и ORDER BY
<оконная_функция> OVER (
    PARTITION BY <столбец1>[, <столбец2>, ...] 
    ORDER BY <столбец3> [ASC|DESC] [, <столбец4> ...]
    )

```

### Функции ранжирования

Присваивают строкам определенный УНИКАЛЬНЫЙ номер. Можно расставить ранг пользователям в зависимости от количества заказов

```SQL
-- Ранжирование согласно позиции в базе данных, или сортировки в ORDER BY
ROW_NUMBER() 

-- функция `ROW_NUMBER()` пронумеровала записи в зависимости от их исходного порядка в таблице. Если результат запроса будет отсортирован по условию в секции `ORDER BY` основного запроса, то функция `ROW_NUMBER()` всё равно пронумерует записи, исходя из их исходного порядка в таблице
SELECT 
    *,
    -- Оконная функция, добавляющая ранг каждой строке:
    ROW_NUMBER() OVER() AS row_num
FROM online_store.orders
ORDER BY revenue DESC
LIMIT 10;


-- Если добавить ORDER BY, то тогда будет показан не номер в таблице, а порядок в Order BY
SELECT *, 
-- Оконная функция, добавляющая ранг каждой строке с учётом сортировки данных: 
ROW_NUMBER() OVER(ORDER BY revenue DESC) AS row_num 
FROM online_store.orders 
ORDER BY row_num 
LIMIT 10;

```

```SQL 
-- ROW_NUMBER()  присваивает номер от 1 до последнего. Но если нам надо проранжировать и записям с одинаковыми значениями присвоить одинаковый ранк ( например по количеству покупок ) используем
-- RANK() и DENSE_RANK()
RANK() -- Если видит 2 одинаковых значения - присваивает одинаковый номер, и пропускает следующий

-- Если RANK() без заполеннного OVER(ORDER BY), то она не знает по какому признаку ранжировать и присвоит всем 1

DENSE_RANK() -- Ен проопускает следующий номер

```


```SQL
-- Она разделяет записи на одинаковое количество рангов
-- Аргумент количество рангов или групп обязательный
-- NTILE пытается сделать группы одинаковыми, но если не получается - то обрезает последнюю

NTILE(<количество групп>) OVER()

```

### Функции смешения

Функции позволяют получить доступ к данным из предыдущей или следующей ячейки. Так можно сравнить текущую выручку со следующей. 

```SQL

LAG() -- Значение из предыдущей строки
LEAD() -- Значение из следующей строки
 
LAG(column, offset, default) OVER (PARTITION BY partition_column ORDER BY order_column)
LEAD(column, offset, default) OVER (PARTITION BY partition_column ORDER BY order_column)

-- column - столюец, значение которого надо вернуть
-- offset - смещение, по умолчанию равно 1
-- default - если смещение вышло за границу таблицы, то подставится это значение. По умолчанию NULL

-- Особенности
-- ORDER BY - ОБЯЗАТЕЛЕН. 
-- В значении Default - всегда такой же тип, как и у столбца
-- Вычитая одно из другого - можно найти и разницу во времени

SELECT 
	user_id, event_dt, revenue, 
	LAG(revenue) OVER (PARTITION BY user_id ORDER BY event_dt) AS previous_revenue FROM online_store.orders;
	
-- Математические операции
-- 1) Использование ROUND
-- 2) revenue - LAG(revenue, 1) Разница между текущим и прошлым значением
-- 3) LEAD(revenue, 1) OVER (PARTITION BY user_id ORDER BY event_dt) - revenue - Изменение выручки относительно следующего дня 
SELECT 
	user_id, event_dt, revenue, 
	ROUND(
		revenue - LAG(revenue, 1) 
		OVER (PARTITION BY user_id ORDER BY event_dt)
	, 2) 
		AS revenue_change_previous, 
	ROUND(LEAD(revenue, 1) 
		OVER (PARTITION BY user_id ORDER BY event_dt) - revenue, 2) 
		AS revenue_change_next 
FROM online_store.orders;

```


```SQL
-- Найти первое и последнее значение в наборе данных

FIRST_VALUE()
LAST_VALUE()

FIRST_VALUE(column) OVER (PARTITION BY partition_column ORDER BY order_column)
LAST_VALUE(column) OVER (PARTITION BY partition_column ORDER BY order_column)

-- С FIRST_VALUE() все хорошо, а вот с LAST_VALUE какая-то особенность
-- ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_order_dt - вот этот код нужен чтобы она корректно работала, пока оставим его как есть
SELECT user_id,
       event_dt,
       revenue,
       LAST_VALUE(event_dt) OVER (PARTITION BY user_id ORDER BY event_dt 
       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_order_dt -- Необходимый для работы LAST_VALUE() код
FROM online_store.orders;

```
### Аналитические функции

Аналитические функции предоставляют дополнительные возможности для анализа данных. 

Аналитическими оконными функциями также называют функции для расчёта суммы, среднего и других сводных показателей. Отличие этих функций от обычных в том, что они проводят расчёты не по всем элементам набора, а более сложным способом.

## Неочевидные нюансы

```SQL

-- В ORDER BY можно производить действия с полями
-- Тут мы посчитали пользовательский ранг в зависимости от количества покупок
-- Поскольку COUNT агрегирующая фнукция - то она добавлена в GROUP BY
-- По сути это помогает избежать дополнительного CTE и сделать запрос короче

SELECT user_id, 
-- Оконная функция, ранжирующая строки по порядку с учётом значения в строке 
-- без пропусков в интервале рангов: 
DENSE_RANK() OVER(ORDER BY COUNT(revenue) DESC) AS users_rank 
FROM online_store.orders 
GROUP BY user_id 
ORDER BY users_rank, user_id 
LIMIT 5;
```

