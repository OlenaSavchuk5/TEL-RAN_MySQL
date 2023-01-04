-- ДЗ:
/*
6) выборки

- найти учеников, у которых оценка больше 4
- найти учеников, у которых не входит в диапазон от 3 до 4
- найти учеников, у которых имя начинается на И
- найти учеников, у которых оценка 2.2 или 3.1 или 4.7 
*/

use group_35_36_2;
show tables;

select
	*
from students
where avg_mark > 4;

select
	*
from students
where avg_mark not between 3 and 4;

select
	*
from students
where firstname like 'и%';

select
	*
from students
where avg_mark in (2.2, 3.1, 4.7);

select
	*
from students
where avg_mark = 2.2 or avg_mark = 3.1 or avg_mark = 4.7;

-- 7)  Найти набор уникальных оценок

select distinct
	avg_mark
from students;

-- 8)  Увеличить всем учащимся оценку в 10 раз

alter table students
modify column avg_mark numeric(3, 1);

alter table students
drop check students_chk_1;

set sql_safe_updates = 0;

update students
set avg_mark = avg_mark * 10;

select * from students;

-- 9) Поменяйте у Олега Петрова фамилию на Сидоров

update students
set lastname = 'Сидоров'
where firstname = 'Олег'
and lastname = 'Петров';

-- 10) Для всех учеников, у которых оценка не больше 31 увеличить на 10

update students
set avg_mark = avg_mark + 10
where avg_mark <= 31;


-- ОБЪЕДИНЕНИЕ ТАБЛИЦ
-- UNION / UNION ALL - "вертикальное" объединение

-- Пример синтаксиса
select customer_id from customers
union all
select order_id from orders
union all
select shipping_id from shippings;


-- JOIN (INNER, LEFT, RIGHT) - "горизонтальное" объединение

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
on t2.customer_id = t3.customer;
