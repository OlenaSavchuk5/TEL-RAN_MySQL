-- 1. Выведите названия департаментов, в которых менеджеры зарабатывают больше 10000

use hr;

select
  t1.department_name,
  t2.salary
from departments t1
left join employees t2
on t1.manager_id = t2.employee_id
where t2.salary > 10000;

-- 2. Вывести имя и фамилию сотрудника и имя и фамилию его менеджера*

select * from employees;

select
	t1.first_name,
    t1.last_name,
    t2.first_name as manager_firstname,
    t2.last_name as manager_lastname
from employees t1
inner join employees t2
on t1.manager_id = t2.employee_id;

-- 3. Вывести job_id тех сотрудников, которые зарабатывают больше своего менеджера *

select distinct
	t1.job_id
from employees t1
inner join employees t2
on t1.manager_id = t2.employee_id
where t1.salary > t2.salary;

-- АГРЕГАЦИЯ
-- Количество записей (не null)


select
	count(*) as customers_count
from customers;
​
-- Максимальное значение
​
select
	max(age) as max_age
from customers;
​
-- Минимальное значение
​
select
	min(age) as min_age
from customers;
​
-- Сумма значений
​
select
	sum(age) as sum_age
from customers;
​
-- Среднее значение
​
select
	avg(age) as avg_age
from customers;

-- ПРАКТИЧЕСКИЕ ЗАДАЧКИ
​
-- Найти самую высокую зарплату

select
	max(salary) as max_salary
from employees;

-- Найти количество сотрудников

select
    count(*) as employees_cnt
from employees;

-- ПОДЗАПРОСЫ
​
-- Найти имя и фамилию сотрудника с самой высокой зарплатой

select
	first_name,
    last_name,
    salary
from employees
where salary = (
    select
        max(salary) as max_salary
    from employees
);
​
-- Найти сотрудников (имя, фамилию), у которых зарплата меньше средней

select
	first_name,
    last_name
from employees
where salary < (
         select
            avg(salary)
         from employees
);

-- Найти количество сотрудников в каждом департаменте (department_id, count)

select
   count(*) as departments_ctn
from employees  
group by department_id;

select * from employees;

-- Найти количество сотрудников в каждом департаменте (department_name, count)

select 
   t1.department_name,
   count(*) as employees_ctn
from departments t1
left join employees t2
on t1.department_id = t2.department_id
group by t1.department_name; 

-- Найти количество сотрудников у каждого менеджера (manager_id, count)

select
   manager_id,
   count(*) as employees_count
from employees
where manager_id is not null
group by manager_id;

-- Найти количество сотрудников у каждого менеджера (имя и фамилия менеджера, count)

select
    t1.manager_id,
    t2.first_name,
    t2.last_name,
    count(*) as employees_count
from employees t1
inner join employees t2
on t1.manager_id = t2.employee_id
group by t1.manager_id;

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
​
​
-- Найти сотрудников, у которых наибольшая зарплата в их департаменте
​
-- Наибольшая зарплата в кажлом департаменте

select 
   department_id,
   max(salary)
from employees
where department_id is not null
group by department_id;   

select
   t1.first_name,
   t1.last_name,
   t1.salary
from employees t1
inner join (
    select 
       department_id,
       max(salary) as max_salary
    from employees
    group by department_id
    ) t2
on t1.department_id = t2.department_id
where t1.salary = max_salary;    