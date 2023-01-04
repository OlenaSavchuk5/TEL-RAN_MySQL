-- АГРЕГАЦИЯ

-- Найти количество не null строк

select
	count(*) as customers_cnt
from customers;

-- Найти максимальное значение 

select
	max(age) as max_age
from customers;

-- Найти минимальное значение 

select
	min(age) as min_age
from customers;

-- Найти сумму значений

select
	sum(age) as sum_age
from customers;

-- Найти среднее значение

select
	avg(age) as avg_age
from customers;


-- Найти средний возраст покупателей в разбивке по странам
select
	country,
	avg(age) as avg_age
from customers
group by country;


-- Найти средний возраст покупателей в USA

select
	country,
	avg(age) as avg_age
from customers
where country = 'USA';

-- Найти средний возраст покупателей в UK и USA

select
	country,
	avg(age) as avg_age
from customers
where country in ('USA', 'UK')
group by country;


-- Найти средний возраст покупателей в UK и USA

select
	country,
	avg(age) as avg_age
from customers
group by country
having country in ('USA', 'UK');


use hr;
select * from employees;
-- 1. Найти самую высокую зарплату в компании

select 
	max(salary) as max_salary
from employees;

-- 2. Найти количество сотрудников в компании

select
	count(*) as employees_cnt
from employees;

-- 3. Найти количество сотрудников в каждом департаменте. Вывести поля department_id и employees_cnt

select
	department_id,
	count(*) as employees_cnt
from employees
group by department_id;

-- 4. Найти количество сотрудников в каждом департаменте. Вывести поля department_name и employees_cnt

select
	t2.department_name,
    count(*) as employees_cnt
from employees t1
inner join departments t2
on t1.department_id = t2.department_id
group by t2.department_name;


-- ДЗ:
-- 1. Найти количество сотрудников у каждого менеджера. Вывести поля manager_id и employees_cnt

use hr;

select
	manager_id,
	count(*) as employees_cnt
from employees
where manager_id is not null
group by manager_id;

select
	manager_id,
	count(*) as employees_cnt
from employees
group by manager_id
having manager_id is not null;

-- 2. Найти количество сотрудников у каждого менеджера. Вывести поля first_name, last_name и employees_cnt

select
	t2.first_name,
    t2.last_name,
    count(*) as employees_cnt
from employees t1
inner join employees t2
on t1.manager_id = t2.employee_id
group by t1.manager_id;

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

select * from employees;

select
	*
from employees t1
inner join employees t2
on t1.manager_id = t2.employee_id;


-- 3. Разобраться в подзапросах. Найти сотрудников, у которых зарплата меньше средней. *





