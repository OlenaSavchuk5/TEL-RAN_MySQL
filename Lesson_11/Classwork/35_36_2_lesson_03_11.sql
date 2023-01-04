-- Примеры из песочницы (https://www.programiz.com/sql/online-compiler/)
-- Вывести имя, фамилию и товар всех клиентов

select
	t1.first_name,
    t1.last_name,
    t2.item
from customers t1
left join orders t2
on t1.customer_id = t2.customer_id;

-- Вывести имя, фамилию и товар только тех клиентов, у которых есть заказ

select
	t1.first_name,
    t1.last_name,
    t2.item
from customers t1
inner join orders t2
on t1.customer_id = t2.customer_id;

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


-- Вывести имена и фамилии всех клиентов (вне зависимости от того, есть у них заказ или нет), название и цену товара (если есть)

select
	t1.first_name,
    t1.last_name,
    t2.item,
    t2.amount
from customers t1
left join orders t2
on t1.customer_id = t2.customer_id;


-- ПРАКТИКА 
use hr;

-- 1. Вывести имя и фамилию сотрудника и название его департамента

select * from Employees;

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
left join departments t2
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






