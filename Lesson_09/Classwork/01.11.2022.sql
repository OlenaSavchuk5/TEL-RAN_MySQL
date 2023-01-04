
-- ОБЪЕДИНЕНИЕ ТАБЛИЦ 

-- UNION (уникальные значения) / UNION ALL (все значения) - вертикальное объединение
-- JOIN (INNER, LEFT, RIGHT) - горизонтальное объединение

-- INNER JOIN - возвращает только те строки, где есть совпадение;

-- LEFT JOIN - добавляет все строки основной таблицы;

-- RIGHT JOIN - возвращает все записи из первой таблицы и добавляет записи, 
-- 				которые имеют соответствия из левой таблицы;

-- пример из песочницы (https://www.programiz.com/sql/online-compiler/)
select
	t1.first_name,
    t1.last_name,
    t2.item,
    t3.status
from customers t1
inner join orders t2
on t1.customer_id = t2.customer_id
inner join shippings t3
on t2.customer_id = t3.customer