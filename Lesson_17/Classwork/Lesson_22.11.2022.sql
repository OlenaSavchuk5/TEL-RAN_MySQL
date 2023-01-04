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

-- Найти среднюю зарплату
select
	avg(salary)
from employees;

select
	first_name,
    last_name,
    salary
from employees
where salary < (
	select
		avg(salary)
	from employees
)
order by salary desc;




-- ПОДЗАПРОСЫ

-- Найти покупателей, у которых возраст меньше среднего (среди всех покупателей)

/* select
	avg(age) as avg_age
from customers; */

select
	*
from customers
where age < (
  select
      avg(age) as avg_age
  from customers
);

-- Найти покупателей, чей возраст равен минимальному

select
	*
from customers
where age = (
  select
      min(age) as min_age
  from customers
);



-- БАЗА HR
-- 1. Найти сотрудников, у которых наибольшая зарплата в их департаменте

-- Найти максимальную зарплату в каждом департаменте

select
	department_id,
	max(salary)
from employees
group by department_id;

select
	t1.first_name,
    t1.last_name,
    t1.salary,
    t1.department_id,
    t2.max_salary
from employees t1
inner join (
	select
		department_id,
		max(salary) as max_salary
	from employees
	group by department_id
) t2
on t1.department_id = t2.department_id
where t1.salary = t2.max_salary;


SELECT 
	department_id,
	first_name,
    last_name,
    MAX(salary) as max_salary
FROM employees
GROUP BY department_id
having department_id is not null;



-- Найти названия департаментов (department_name), в которых больше 10 сотрудников

select
	department_id
from employees
group by department_id
having count(*) > 10;

select
	t1.department_name
from departments t1
	inner join (
		select
		department_id
	from employees
	group by department_id
	having count(*) > 10
) t2
on t1.department_id = t2.department_id;

select 
	t1.department_name
from employees t2
inner join departments t1
on t1.department_id = t2.department_id
group by t1.department_name
having count(*) > 10;


-- ДЗ:
-- 1. Вывести название отделов с кол-вом сотрудников больше среднего
-- 2. Найти департамент с наибольшим кол-вом сотрудников 

