-- ДЗ
-- 1. Найти департаменты, в которых больше 10 сотрудников

use hr;

select
	department_id
from employees
group by department_id
having count(*) > 10;


select
	t1.department_name,
    t2.department_id
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
	department_name
from departments
where department_id in (
	select
		department_id
	from employees
	group by department_id
	having count(*) > 10
);

-- 2. Вывести название отделов с кол-вом сотрудников больше среднего

-- найти кол-во сотрудников по department_id

select
	department_id,
    count(*) as cnt
from employees
group by department_id;

-- среднее значение

select
	avg(cnt)
from (
	select
		department_id,
		count(*) as cnt
	from employees
	group by department_id
) t1;

-- департаменты (id), в которых работает количество сотрудников больше среднего

select
	department_id
from employees
group by department_id
having count(*) > (
	select
	avg(cnt)
	from (
		select
			department_id,
			count(*) as cnt
		from employees
		group by department_id
	) t1
);

-- имена департаментов, соответствующие найденным id

select
	department_name
from departments
where department_id in (
	select
		department_id
	from employees
	group by department_id
	having count(*) > (
		select
			avg(cnt)
		from (
			select
				department_id,
				count(*) as cnt
			from employees
			group by department_id
		) t1
	)
);


-- 3. Найти департамент с наибольшим кол-вом сотрудников 

-- найти кол-во сотрудников по department_id

select
	department_id,
    count(*) as cnt
from employees
group by department_id;

-- максимальное кол-во сотрудников среди департаментов

select
	max(cnt) as max_cnt
from (
	select
		department_id,
		count(*) as cnt
	from employees
	group by department_id
) t1;

-- айди департаментов с указанным кол-ом сотрудников

select
	department_id
from employees
group by department_id
having count(*) = (
	select
		max(cnt) as max_cnt
	from (
		select
			department_id,
			count(*) as cnt
		from employees
		group by department_id
	) t1
);

-- подставляем название департамента под найденный айди

select
	department_name
from departments
where department_id in (
	select
		department_id
	from employees
	group by department_id
	having count(*) = (
		select
			max(cnt) as max_cnt
		from (
			select
				department_id,
				count(*) as cnt
			from employees
			group by department_id
		) t1
	)
);


-- ЗАДАЧИ НА ПОВТОРЕНИЕ ИЗ ПЕСОЧНИЦЫ (https://www.programiz.com/sql/online-compiler/)

-- 1. Найти покупателей, чей возраст равен максимальному

select
	first_name,
    last_name
from customers
where age = (select max(age)from customers);


-- 2. Найти общую сумму, потраченную на каждый товар

select
	item,
	sum(amount) as sum_amount
from orders
group by item;

-- 3. Найти средний чек (amount) у каждого покупателя. Вывести имя, фамилию покупателя и средний чек

-- находим средний чек у каждого customer_id

select
	customer_id,
	avg(amount) as avg_amount
from orders
group by customer_id;

-- под найденные customer_id подставить имя и фамилию из таблицы customers

select
	t1.first_name,
    t1.last_name,
    t2.avg_amount
from customers t1
inner join (
  select
      customer_id,
      avg(amount) as avg_amount
  from orders
  group by customer_id
) t2
on t1.customer_id = t2.customer_id;


-- Найти средний возраст покупателей из UK

select
	country,
    avg(age) as avg_age
from customers
where country = 'UK';

-- Найти страны, в которых средний возраст покупателей больше или равен 25

select
	country,
    avg(age) as avg_age
from customers
group by country
having avg(age) >= 25;


-- Найти покупателей, у которых средний amount больше или равен 400. Вывести имя, фамилию покупателя  и средний amount

select
	t1.first_name,
    t1.last_name,
    t2.avg_amount
from customers t1
inner join (
  select
      customer_id,
      avg(amount) as avg_amount
  from orders
  group by customer_id
  having avg_amount >= 400
) t2
on t1.customer_id = t2.customer_id;






