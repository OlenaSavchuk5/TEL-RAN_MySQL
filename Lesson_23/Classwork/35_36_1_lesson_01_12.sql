-- Задачи из sql-ex.ru

-- 14

select
	t1.class,
	t1.name,
	t2.country
from ships t1
inner join classes t2
on t1.class = t2.class
where t2.numGuns >= 10;

-- 15

select
	hd
from pc
group by hd
having count(*) >= 2;

-- 16

select distinct
	t1.model,
	t2.model,
	t2.speed,
	t2.ram
from pc t1
inner join pc t2
on t1.ram = t2.ram
where t1.speed = t2.speed
and t1.model > t2.model;

-- 17

select distinct
	'Laptop' as type,
	model,
	speed
from laptop
where speed < (select min(speed) from pc);

-- 18

select distinct
	t2.maker,
	t1.price
from printer t1
inner join product t2
on t1.model = t2.model
where t1.color = 'y'
and t1.price = (
	select
		min(price)
	from printer
	where color = 'y'
);

-- 19

select
	t2.maker,
	avg(t1.screen) as avg_screen
from laptop t1
inner join product t2
on t1.model = t2.model
group by t2.maker;


-- 20

select
	maker,
	count(*) as cnt
from product
where type = 'pc'
group by maker
having count(*) >= 3;


-- 21

select
	t2.maker,
	max(t1.price) as max_price
from pc t1
inner join product t2
on t1.model = t2.model
group by t2.maker;


-- CASE

-- 1. Найти сумму возрастов тех, кто старше 25

select
	sum(age)
from customers
where age >= 25;


select
	sum(
    	case
      		when age < 25 then 0
      		else age
      	end
    ) as sum_age
from customers;

-- 2. Найти сумму amount всех заказов, у которых amount <= 400

select
	sum(
    	case
      		when amount > 400 then 0
      		else amount
      	end
    ) as sum_amount
from orders;


-- 3. Найти среднее значение amount всех заказов, у которых amount >= 400

-- 4266.66666
-- 2560 XXXX

select
	avg(
    	case
      		when amount < 400 then null
      		else amount
      	end
    ) as avg_amount
from orders;


-- 4. В БД HR найти департаменты, в которых есть сотрудники, зарабатывающие больше 10000. В результате нужно вывести два поля - department_id и поле result (1, 0). 1 выводится в случае, если в департаменте есть такие сотрудники, 0 - если их нет

use hr;
select
	department_id,
    max(
		case
			when salary >= 10000 then 1
            else 0
        end
    ) as result
from employees
where department_id is not null
group by department_id;

/*
60 (1, 0, 0, 0, 0) // 1
70 (1, 1, 1, 1) // 1
80 (0, 0, 0) // 0
90 (0, 0, 1, 1) // 1
*/


-- 5. В БД HR найти департаменты, в которых ВСЕ сотрудники зарабатывают больше 10000. В результате нужно вывести два поля - department_id и поле result (1, 0). 1 выводится в случае, если в департаменте все зарабатывают больше 10 тыс, 0 - если не все

select
	department_id,
    min(
		case
			when salary >= 10000 then 1
            else 0
        end
    ) as result
from employees
where department_id is not null
group by department_id;

/*
60 (1, 0, 0, 0, 0) // 0
70 (1, 1, 1, 1) // 1
80 (0, 0, 0) // 0
90 (0, 0, 1, 1) // 0
*/


-- ДЗ
-- 1. Задачи с sql-ex.ru (22-25)
-- 2. В БД HR найти департаменты, в которых ВСЕ сотрудники зарабатывают больше 10000. В результате нужно вывести два поля - department_name и поле result (1, 0). 1 выводится в случае, если в департаменте все зарабатывают больше 10 тыс, 0 - если не все




