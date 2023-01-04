-- ДЗ в песочнице
-- 1. Средний возраст покупателей из UK

select
	country,
	avg(age) as avg_age_UK
from customers
where country = 'UK';

-- 2. Средний возраст покупателей из UK и USA (в разбивке по странам)

select
	country,
    avg(age) as avg_age
from customers
where country in ('USA', 'UK')
group by country;

select
	country,
    avg(age) as avg_age
from customers
group by country
having country in ('USA', 'UK');

-- 3. Найти страны, в которых средний возраст покупателей больше или равен 25

select
	country,
    avg(age) as avg_age
from customers
group by country
having avg(age) >= 25;

-- 4. Найти тех покупателей, у которых средний amount больше или равен 400. Вывести имя, фамилию покупателя и средний amount

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
on t1.customer_id = t2.customer_id
where t2.avg_amount >= 400;


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


-- CASE

-- 1. Найти сумму возрастов всех, кто старше 25

select
	sum(age) as sum_age
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

-- 2. Найти среднее значение amount всех заказов, у которых amount >= 400

select
	avg(
    	case
      		when amount < 400 then null
      		else amount
      	end
    ) as avg_amount
from orders;

-- 3. Найти общую сумму amount всех заказов, у которых amount <= 400


select
	sum(
    	case
      		when amount > 400 then null
      		else amount
      	end
    ) as sum_amount
from orders;


-- 4. Перейти в БД HR
use hr;

-- 5. Найти департаменты, в которых есть работники, зарабатывающие больше 10000. В результате выборки формируется 2 поля - department_id и поле со значением 1 или 0

select
	department_id,
    max(
		case
			when salary >= 10000 then 1
            else 0
        end
    ) as salary_field
from employees
group by department_id
having department_id is not null;

/*
max()
60 (1, 0, 0) // 1
70 (1, 1, 1, 1) // 1
80 (0, 0, 0, 0, 0, 0, 0) // 0
90 (0, 1, 0, 1, 1) // 1

min()
60 (1, 0, 0) // 0
70 (1, 1, 1, 1) // 1
80 (0, 0, 0, 0, 0, 0, 0) // 0
90 (0, 1, 0, 1, 1) // 0
*/

-- 6. Найти департаменты, в которых все работники зарабатывают больше 10000. В результате выборки формируется 2 поля - department_id и поле со значением 1 или 0

select
	department_id,
    min(
		case
			when salary < 10000 then 0
            else 1
        end
    ) as salary_field
from employees
group by department_id
having department_id is not null;

-- 7. Найти департаменты, в которых все работники зарабатывают больше 10000. В результате выборки формируется 2 поля - department_name и поле со значением 1 или 0

select
	t1.department_name,
    t2.salary_field
from departments t1
inner join (
	select
		department_id,
		min(
			case
				when salary < 10000 then 0
				else 1
			end
		) as salary_field
	from employees
	group by department_id
) t2
on t1.department_id = t2.department_id;


