use hr;

-- 1) найти максимальную зарплату сотрудников

select * from countries;
select * from departments;
select * from employees;
select * from jobs;
select * from locations;
select * from regoins;

select 
   max(salary)
from employees;   


-- 2) найти сотрудников, у которых зарплата больше средней

select 
 first_name,
 last_name,
 salary
from employees
where salary > (
  select
    avg(salary)
  from employees  
);

-- 3) найти кол-во сотрудников в каждом департаменте. В результатае выведите id департамента и кол-во сотрудников

select 
	department_id,
	count(*) as ctn
from employees
where department_id is not null
group by department_id;

select
	count(*) as total_count,
    count(commission_pct) as not_null_count,
    count(distinct commission_pct) as distinct_count
from employees;    


select 
  count(1),
  count(*)
from employees;  


-- 1. среднее кол-во сотрудников в департаментах
-- 2. кол-во сотрудников в каждом департаменте

select 
	department_id,
	count(*) as ctn
from employees
group by department_id;
    

-- 2.0) найти среднюю зп среди сотрудников

select
 avg(cnt)
from (
	select 
      count(*) as cnt
    from employees
    where departments_id is not null
    group by department_id
) t1
;

-- Вывести название отделов с кол-вом сотрудников больше среднего

select
   department_name
from departments
where department_id in (
	select 
      department_id
    from employees
    where department_id is not null
    group by department_id
    having count(*) > (
			select
              avg(ctn)
            from (
              select 
                 count(*) as ctn
              from employees
              where department_id is not null
              group by department_id
            )  t1
    )
) ;  

select
  t1.department_name,
  count(*)
from departments t1
inner join employees t2
on t1.department_id = t2.department_id
group by t1.department_name
having count(*) > (
	select
       avg(count)
    from (
		select
           count(*) as count
        from employees 
        where department_id is not null
        group by department_id
    )  t3
);  

 