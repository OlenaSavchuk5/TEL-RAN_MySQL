-- ДЗ:
-- Найдите компетенции, которых нет ни у одного преподавателя

use university;

select
	t1.title
from competencies t1
left join teachers2competencies t2
on t1.id = t2.competencies_id
where competencies_id is null;

-- Выведите название курса и имя старосты

select * from courses;

select 
	t1.title,
    t2.name
from courses t1
inner join students t2
on t1.headman_id = t2.id;

-- Выведите имя студента и имена старост, которые есть на курсах, которые он проходит

-- 1. студент - курс
-- 2. курс - старостой
-- 3. староста - студент

select 
		t1.name as student_name,
        t3.title,
        t4.name as headman_name
from students t1
inner join students2courses t2
on t1.id = t2.student_id
inner join courses t3
on t2.course_id = t3.id
inner join students t4
on t3.headman_id = t4.id;



-- АГРЕГАЦИЯ

-- Нахождение количества не null строк

select
	count(*) as customers_cnt
from customers;

-- Нахождение максимального значения

select
	max(age) as max_age
from customers;

-- Нахождение минимального значения

select
	min(age) as min_age
from customers;

-- Нахождение суммы значений

select
	sum(age) as sum_age
from customers;

-- Нахождение среднего значения 

select
	avg(age) as avg_age
from customers;



-- ПОДЗАПРОСЫ

-- Найти людей, которые младше среднего возраста


select
	first_name,
    last_name,
    age
from customers
where age < (
	select
		avg(age) as avg_age
	from customers
);

-- Найти средний возраст покупателей из USA

select 
       avg(age) as avg_age
from customers
where country = 'USA';

-- Найти средний возраст покупателей из USA и UK

select 
	country,
	avg(age) as avg_age
from Customers
where country in ('USA', 'UK')
group by country;


-- Найти средний возраст покупателей из USA и UK (having)

select 
	country,
	avg(age) as avg_age
from Customers
group by country
having country in ('USA', 'UK');


-- ПРАКТИКА

use hr;

-- 1. Найти самую высокую зарплату среди сотрудников

select * from employees;

select
	max(salary) as max_salary
from employees;

-- 2. Найти общее количество сотрудников

select
	count(*) as employees_cnt
from employees;

-- 3. Вывести имена людей, которые получают самую маленькую зарплату

select
	first_name,
    last_name
from employees
where salary = (
	select
		min(salary)
	from employees
);

-- 4. Найти количество сотрудников в каждом департаменте. Вывести department_id и employees_cnt

select
	department_id,
	count(*) as employees_cnt
from employees
group by department_id;

-- 5. Найти количество сотрудников в каждом департаменте. Вывести название департамента и employees_cnt

select
	t1.department_name,
	count(*) as employees_cnt
from departments t1
inner join employees t2
on t1.department_id = t2.department_id
group by t1.department_name;


-- 6. Найти кол-во сотрудников у каждого менеджера. Вывести manager_id и employees_cnt

select
	manager_id,
	count(*) as employees_cnt
from employees
group by manager_id;

-- 7. Найти кол-во сотрудников у каждого менеджера. Вывести имя и фамилию менеджера и employees_cnt

select
	t2.first_name,
    t2.last_name,
    count(*) as employees_cnt
from employees t1
inner join employees t2
on t1.manager_id = t2.employee_id
group by t2.first_name, t2.last_name;
-- group by t1.manager_id

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

SET sql_mode=(SELECT CONCAT(@@sql_mode, ',ONLY_FULL_GROUP_BY'));

-- 8. Найти сотрудников, у которых наибольшая зарплата в их департаменте
-- Найти максимальную зарплату в каждом департаменте

select
	department_id,
    max(salary) as max_salary
from employees
group by department_id;

-- Под найденную зарплату подставить соответствующего сотрудника

select
	t1.first_name,
    t1.last_name
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

-- ДЗ
-- Найти департаменты, в которых больше 10 сотрудников
-- Вывести название отделов с кол-вом сотрудников больше среднего
-- Найти департамент с наибольшим кол-вом сотрудников 

