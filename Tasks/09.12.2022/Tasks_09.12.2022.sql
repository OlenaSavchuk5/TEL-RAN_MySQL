use hr;
select max(salary) from employees;

-- Найти сотрудников, у которых максимальная зп в компании.

select
    *
from employees
where salary = (
	select max(salary) from employees
);    


-- Найти сотрудников с максимальной зп в каждом департаменте
-- 1. найти максимальную зп в каждом департаменте

select
    department_id,
    max(salary) as max_salary
from employees
group by department_id;

select
  t1.first_name,
  t1.last_name,
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
and t1.salary = t2.max_salary;

select * from departments;
select * from employees;

-- Найти сотрудников с максимальной зп в их job_id

select
  t1.first_name,
  t1.last_name,
  t2.max_salary
from employees t1
inner join (
	select
		job_id,
		max(salary) as max_salary
	from employees
	group by job_id
) t2
on t1.job_id = t2.job_id
and t1.salary = t2.max_salary;


select
    count(*) as cnt_1,
    count(commission_pct) as cnt_2,
    count(distinct commission_pct) as cnt_3
from employees;    


-- Найти количество сотрудников в каждом департаменте

select
    department_id,
    count(*) as employee_cnt
from employees
group by department_id;

-- Вывести название департаментов и кол-во сотрудников в них.

select
	t1.department_name,
    t2.employee_cnt
from departments t1
inner join (
	select
		department_id,
		count(*) as employee_cnt
	from employees
group by department_id
) t2
on t1.department_id = t2.department_id;


-- Вывести название департаментов, в которых меньше 10 сотрудников

select
	t1.department_name,
    t2.employee_cnt
from departments t1
inner join (
	select
		department_id,
		count(*) as employee_cnt
	from employees
    group by department_id
    having count(*) < 10
) t2
on t1.department_id = t2.department_id;
