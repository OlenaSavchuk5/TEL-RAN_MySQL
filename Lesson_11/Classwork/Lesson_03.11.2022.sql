-- ДЗ:
use group_35_36_1;

-- 7) Создать представление, которое содержит всех мужчин

create view v_students_m as
select 
	*
from students
where gender = 'M';

select * from v_students_m;

-- 8) Создать представление, которое содержит всех женщин

create view v_students_f as
select 
	*
from students
where gender = 'F';

select * from v_students_f;

-- 10) Увеличить всем учащимся оценку в 10 раз

set sql_safe_updates = 0;

alter table students
modify column avg_mark numeric(3, 1);

alter table students
drop check students_chk_1;

update students
set avg_mark = avg_mark * 10;

select * from students;

-- 11) Поменяйте у Олега Петрова фамилию на Сидоров

update students
set lastname = 'Сидоров'
where firstname = 'Олег' 
and lastname = 'Петров';

-- 12) Для всех учеников, у которых оценка не больше 31 увеличить на 10

update students
set avg_mark = avg_mark + 10
where avg_mark <= 31;



-- Объединение таблиц

-- UNION / UNION ALL - "вертикальное" объединение
-- пример из песочницы

select customer_id from customers
union
select order_id from orders
union
select shipping_id from shippings;


-- JOIN (INNER, LEFT, RIGHT) - "горизонтальное" объединение
-- пример из песочницы

select
	t1.first_name,
    t1.last_name,
    t2.item
from customers t1
left join orders t2
on t1.customer_id = t2.customer_id
where t1.last_name = 'Reinhardt';

-- ЗАДАЧИ ИЗ ПЕСОЧНИЦЫ (https://www.programiz.com/sql/online-compiler/)

-- Вывести имя, фамилию, название товара, цену товара и статус доставки только у тех, у кого есть заказ

select
	t1.first_name,
    t1.last_name,
    t2.item,
    t2.amount,
    t3.status
from customers t1
inner join orders t2
on t1.customer_id = t2.customer_id
inner join shippings t3
on t2.customer_id = t3.customer;

-- Вывести имена и фамилии всех клиентов (вне зависимости от того, есть у них заказ или нет), название товара и цену товара (если есть)

select
	t1.first_name,
    t1.last_name,
    t2.item,
    t2.amount
from customers t1
left join orders t2
on t1.customer_id = t2.customer_id;


-- ПРАКТИЧЕСКИЕ ЗАДАЧИ

use hr;

-- 1. Вывести имя и фамилию сотрудника и название его департамента

select * from employees;
select * from departments;

select
	t1.first_name,
    t1.last_name,
    t2.department_name
from employees t1
left join departments t2
on t1.department_id = t2.department_id;

-- 2. Вывести имя и фамилию сотрудника и название его департамента только тех сотрудников, которые работают в IT, Treasury или IT Support

select
	t1.first_name,
    t1.last_name,
    t2.department_name
from employees t1
inner join departments t2
on t1.department_id = t2.department_id
where t2.department_name in ('IT', 'Treasury', 'IT Support');

-- 3. Вывести названия департаментов, в которых никто не работает

select
	t1.department_name
from departments t1
left join employees t2
on t1.department_id = t2.department_id
where t2.employee_id is null;


-- ДЗ:
-- 1) Вывести имя, фамилию и город сотрудников, которые работают в Seattle или Toronto
-- 2) Выведите названия департаментов, в которых менеджеры зарабатывают больше 10000
-- 3) Вывести имя и фамилию сотрудника и имя и фамилию его менеджера * (self join)
-- 4) Вывести job_id тех сотрудников, которые зарабатывают больше своего менеджера * (self join)








