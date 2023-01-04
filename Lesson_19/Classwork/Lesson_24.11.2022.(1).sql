-- ДЗ:
-- 1. Вывести название отделов с кол-вом сотрудников больше среднего

-- найти количество сотрудников в каждом департаменте (по department_id)

select
	department_id,
	count(*) as cnt
from employees
group by department_id
having department_id is not null;

-- среднее значение 

select
	avg(cnt) as avg_cnt
from (
	select
		department_id,
		count(*) as cnt
	from employees
	group by department_id
	having department_id is not null
) t1;

-- вывести department_id тех департаментов с кол-ом сотрудников больше среднего

select
	department_id
from employees
group by department_id
having count(*) > (
	select
		avg(cnt) as avg_cnt
	from (
		select
			department_id,
			count(*) as cnt
		from employees
		group by department_id
		having department_id is not null
	) t1
);

-- подставить под найденные department_id название департамента

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
			avg(cnt) as avg_cnt
		from (
			select
				department_id,
				count(*) as cnt
			from employees
			group by department_id
			having department_id is not null
		) t1
	)
);



-- 2. Найти департамент с наибольшим кол-вом сотрудников 


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
			having department_id is not null
		) t1
	)
);


-- ЗАДАЧИ ИЗ ПЕСОЧНИЦЫ (https://www.programiz.com/sql/online-compiler/)

-- Найти имена и фамилии покупателей, чей возраст равен максимальному

select
	first_name,
    last_name
from customers
where age = (
  select
      max(age)
  from customers
);


-- Найти общую сумму, затраченную на каждый товар

select
	item,
	sum(amount) as sum_amount
from orders
group by item;


-- Найти средний чек (amount) у каждого покупателя. Вывести имя, фамилию покупателя и средний чек

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


-- ДЗ в песочнице
-- 1. Средний возраст покупателей из UK
-- 2. Средний возраст покупателей из UK и USA (в разбивке по странам)
-- 3. Найти страны, в которых средний возраст покупателей больше или равен 25
-- 4. Найти тех покупателей, у которых средний amount больше или равен 400. Вывести имя, фамилию покупателя и средний amount



